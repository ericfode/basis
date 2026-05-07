defmodule Basis.Web.Server do
  @moduledoc """
  Dependency-free local HTTP/SSE server for the live Basis search console.
  """

  use GenServer

  require Logger

  @default_port 8767

  def start_link(opts) do
    port = Keyword.get(opts, :port, @default_port)
    GenServer.start_link(__MODULE__, port, name: __MODULE__)
  end

  @impl true
  def init(port) do
    {:ok, listen} =
      :gen_tcp.listen(port, [
        :binary,
        packet: :raw,
        active: false,
        reuseaddr: true
      ])

    send(self(), :accept)
    Logger.info("Basis live search UI listening on http://127.0.0.1:#{port}/ui/index.html")
    {:ok, %{listen: listen, port: port}}
  end

  @impl true
  def handle_info(:accept, state) do
    {:ok, socket} = :gen_tcp.accept(state.listen)
    Task.start(fn -> handle_socket(socket) end)
    send(self(), :accept)
    {:noreply, state}
  end

  defp handle_socket(socket) do
    with {:ok, request} <- read_request(socket) do
      dispatch(socket, request)
    else
      _ -> :gen_tcp.close(socket)
    end
  end

  defp read_request(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0, 10_000)
    {head, rest} = split_head(data)
    [request_line | header_lines] = String.split(head, "\r\n", trim: true)
    [method, target, _version] = String.split(request_line, " ", parts: 3)

    headers =
      Map.new(header_lines, fn line ->
        [key, value] = String.split(line, ":", parts: 2)
        {String.downcase(String.trim(key)), String.trim(value)}
      end)

    content_length =
      headers
      |> Map.get("content-length", "0")
      |> String.to_integer()

    body = read_body(socket, rest, content_length)

    {:ok, %{method: method, target: target, headers: headers, body: body}}
  end

  defp split_head(data) do
    case :binary.match(data, "\r\n\r\n") do
      {index, 4} ->
        {binary_part(data, 0, index), binary_part(data, index + 4, byte_size(data) - index - 4)}

      :nomatch ->
        {data, ""}
    end
  end

  defp read_body(_socket, rest, content_length) when byte_size(rest) >= content_length do
    binary_part(rest, 0, content_length)
  end

  defp read_body(socket, rest, content_length) do
    needed = content_length - byte_size(rest)
    {:ok, more} = :gen_tcp.recv(socket, needed, 10_000)
    rest <> more
  end

  defp dispatch(socket, %{method: "GET", target: "/"}) do
    respond(socket, 302, "text/plain", "redirect", [{"location", "/ui/index.html"}])
  end

  defp dispatch(socket, %{method: "GET", target: "/health"}) do
    json(socket, 200, %{ok: true})
  end

  defp dispatch(socket, %{method: "GET", target: "/api/run"}) do
    json(socket, 200, Basis.Run.Server.snapshot())
  end

  defp dispatch(socket, %{method: "GET", target: "/api/events"}) do
    sse(socket)
  end

  defp dispatch(socket, %{method: "POST", target: "/api/start", body: body}) do
    body
    |> decode_body()
    |> Basis.Run.Server.start_run()
    |> then(&json(socket, 200, &1))
  end

  defp dispatch(socket, %{method: "POST", target: "/api/actions", body: body}) do
    body
    |> decode_body()
    |> Basis.Run.Server.action()
    |> then(&json(socket, 200, &1))
  end

  defp dispatch(socket, %{method: "GET", target: target}) do
    path = target |> URI.parse() |> Map.fetch!(:path)

    if String.starts_with?(path, "/ui/") do
      serve_static(socket, path)
    else
      json(socket, 404, %{error: "not_found"})
    end
  end

  defp dispatch(socket, _request), do: json(socket, 405, %{error: "method_not_allowed"})

  defp sse(socket) do
    headers = [
      {"content-type", "text/event-stream"},
      {"cache-control", "no-cache"},
      {"connection", "keep-alive"},
      {"access-control-allow-origin", "*"}
    ]

    :gen_tcp.send(socket, response_head(200, headers))
    snapshot = Basis.Run.Server.subscribe()
    send_sse(socket, "snapshot", snapshot)
    sse_loop(socket)
  end

  defp sse_loop(socket) do
    receive do
      {:basis_run_event, event} ->
        case send_sse(socket, "event", event) do
          :ok -> sse_loop(socket)
          _ -> :gen_tcp.close(socket)
        end
    after
      15_000 ->
        case :gen_tcp.send(socket, ": keepalive\n\n") do
          :ok -> sse_loop(socket)
          _ -> :gen_tcp.close(socket)
        end
    end
  end

  defp send_sse(socket, event, payload) do
    data = Basis.Json.encode!(payload)
    :gen_tcp.send(socket, "event: #{event}\ndata: #{data}\n\n")
  end

  defp serve_static(socket, path) do
    relative = String.replace_prefix(path, "/ui/", "")
    base = Path.expand("components/spec-basis-reducer/ui", File.cwd!())
    file = Path.expand(relative, base)

    cond do
      not String.starts_with?(file, base) ->
        json(socket, 403, %{error: "forbidden"})

      File.regular?(file) ->
        respond(socket, 200, content_type(file), File.read!(file), [{"cache-control", "no-cache"}])

      true ->
        json(socket, 404, %{error: "not_found"})
    end
  end

  defp json(socket, status, payload) do
    respond(socket, status, "application/json", Basis.Json.encode!(payload))
  end

  defp respond(socket, status, content_type, body, extra_headers \\ []) do
    headers =
      [
        {"content-type", content_type},
        {"content-length", byte_size(body)},
        {"access-control-allow-origin", "*"},
        {"connection", "close"}
      ] ++ extra_headers

    :gen_tcp.send(socket, response_head(status, headers) <> body)
    :gen_tcp.close(socket)
  end

  defp response_head(status, headers) do
    reason = %{
      200 => "OK",
      302 => "Found",
      403 => "Forbidden",
      404 => "Not Found",
      405 => "Method Not Allowed"
    }

    rendered =
      headers
      |> Enum.map(fn {key, value} -> "#{key}: #{value}\r\n" end)
      |> Enum.join()

    "HTTP/1.1 #{status} #{Map.fetch!(reason, status)}\r\n#{rendered}\r\n"
  end

  defp content_type(path) do
    case Path.extname(path) do
      ".html" -> "text/html; charset=utf-8"
      ".js" -> "text/javascript; charset=utf-8"
      ".css" -> "text/css; charset=utf-8"
      _ -> "application/octet-stream"
    end
  end

  defp decode_body(""), do: %{}
  defp decode_body(body), do: Basis.Json.decode!(body)
end
