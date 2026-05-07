defmodule Basis.LLM.StreamTool do
  @moduledoc """
  Parser for model-emitted visible stream tool calls.

  Primary tool calls arrive from the Codex app-server `dynamicTools` protocol as
  `item/tool/call` requests. Legacy line-delimited `BASIS_STREAM` text is still
  parsed as a compatibility fallback for archived fixtures.
  """

  @prefix "BASIS_STREAM"
  @delegate_tools MapSet.new([
                    "delegate",
                    "delegate_lens",
                    "spawn_delegate",
                    "basis_delegate_lens"
                  ])

  def extract(%{raw: raw} = stream) do
    extract_raw(raw) ++ extract(Map.get(stream, :summary))
  end

  def extract(%{"raw" => raw} = stream) do
    extract_raw(raw) ++ extract(Map.get(stream, "summary"))
  end

  def extract(%{summary: summary}), do: extract(summary)
  def extract(%{"summary" => summary}), do: extract(summary)
  def extract(nil), do: []

  def extract(text) when is_binary(text) do
    text
    |> String.split(~r/\R/)
    |> Enum.flat_map(&parse_line/1)
  end

  def extract(_other), do: []

  def delegate?(tool), do: MapSet.member?(@delegate_tools, tool_name(tool))

  def tool_name(tool) when is_map(tool) do
    tool
    |> Map.get("tool", Map.get(tool, :tool, ""))
    |> to_string()
    |> String.downcase()
    |> String.replace("-", "_")
  end

  def tool_name(_tool), do: ""

  def delegate_role(tool) do
    role =
      tool
      |> field("role")
      |> empty_to_nil()
      |> Kernel.||(field(tool, "lens_role"))
      |> empty_to_nil()
      |> Kernel.||("visible_delegate_lens")

    role
    |> to_string()
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9_]+/, "_")
    |> String.trim("_")
    |> case do
      "" -> "visible_delegate_lens"
      value -> String.slice(value, 0, 64)
    end
  end

  def title(tool) do
    field(tool, "title") ||
      field(tool, "task") ||
      field(tool, "body") ||
      field(tool, "message") ||
      tool_name(tool)
  end

  def compact(tool) when is_map(tool) do
    allowed = [
      "tool",
      "title",
      "body",
      "message",
      "source",
      "source_anchor",
      "source_range",
      "section_id",
      "start_line",
      "end_line",
      "quote",
      "role",
      "lens_role",
      "task",
      "why",
      "handoff",
      "call_id",
      "turn_id",
      "thread_id"
    ]

    Map.take(tool, allowed)
  end

  def compact(other), do: %{"tool" => to_string(other)}

  defp parse_line(line) do
    trimmed = String.trim(line)

    if String.starts_with?(trimmed, @prefix) do
      trimmed
      |> String.replace_prefix(@prefix, "")
      |> String.trim()
      |> decode_tool()
    else
      []
    end
  end

  defp extract_raw(raw) when is_binary(raw) do
    case Basis.Json.decode!(raw) do
      %{"method" => "item/tool/call", "params" => params} when is_map(params) ->
        [tool_from_params(params)]

      _other ->
        []
    end
  rescue
    _ -> []
  end

  defp extract_raw(_raw), do: []

  defp tool_from_params(%{"tool" => name, "arguments" => arguments} = params)
       when is_map(arguments) do
    arguments
    |> Map.put("tool", tool_name(%{"tool" => name}))
    |> Map.put("call_id", Map.get(params, "callId"))
    |> Map.put("turn_id", Map.get(params, "turnId"))
    |> Map.put("thread_id", Map.get(params, "threadId"))
  end

  defp tool_from_params(%{"tool" => name} = params) do
    %{
      "tool" => tool_name(%{"tool" => name}),
      "call_id" => Map.get(params, "callId"),
      "turn_id" => Map.get(params, "turnId"),
      "thread_id" => Map.get(params, "threadId")
    }
  end

  defp decode_tool(json) do
    case Basis.Json.decode!(json) do
      tool when is_map(tool) ->
        [Map.put(tool, "tool", tool_name(tool))]

      _other ->
        []
    end
  rescue
    _ -> []
  end

  defp field(tool, key) when is_map(tool),
    do: Map.get(tool, key) || Map.get(tool, String.to_atom(key))

  defp field(_tool, _key), do: nil

  defp empty_to_nil(value) when is_binary(value),
    do: if(String.trim(value) == "", do: nil, else: value)

  defp empty_to_nil(value), do: value
end
