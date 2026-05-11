defmodule Basis.LLM.AppServerProviderTest do
  use ExUnit.Case, async: false

  test "keeps app-server warning logs as stream events and starts outside repo root" do
    tmp_root =
      Path.join(
        System.tmp_dir!(),
        "basis-app-server-provider-test-#{System.unique_integer([:positive])}"
      )

    File.mkdir_p!(tmp_root)

    script_path = Path.join(tmp_root, "fake_app_server.exs")
    capture_path = Path.join(tmp_root, "thread-cwd.txt")
    starts_root = Path.join(tmp_root, "starts")

    File.write!(script_path, fake_app_server_script())
    File.chmod!(script_path, 0o755)

    with_env(
      %{
        "BASIS_CODEX_APP_SERVER_COMMAND" => "elixir #{script_path}",
        "BASIS_CODEX_START_ROOT" => starts_root,
        "FAKE_APP_SERVER_CAPTURE" => capture_path
      },
      fn ->
        packet =
          Basis.LLM.ContextPacket.new(%{
            id: "ctx-test",
            run_id: "run-test",
            job_id: "job-test",
            kind: "imaginer_decision_mining",
            lens_role: "decision_mining_lens",
            source_path: "components/implementation-imaginer/spec.md",
            source_hash: "hash",
            source_range: "1-3",
            target_projections: ["implementation_plan"],
            prompt: "Return JSON only.",
            source_excerpt: "source"
          })

        assert {:ok, result} =
                 Basis.LLM.AppServerProvider.complete(packet, fn event ->
                   send(self(), {:provider_event, event})
                 end)

        assert result.summary == "adapter survived warning"
        assert result.build_shape["title"] == "Fake build shape"
        assert [%{"title" => "warning tolerated"}] = result.proposed_records

        thread_cwd = File.read!(capture_path)
        refute Path.expand(thread_cwd) == File.cwd!()
        assert String.starts_with?(Path.expand(thread_cwd), Path.expand(starts_root))

        events = drain_events([])
        assert Enum.any?(events, &(&1.summary == "WARN: benign plugin warning"))
      end
    )
  end

  defp fake_app_server_script do
    """
    emit = fn payload ->
      payload
      |> :json.encode()
      |> IO.iodata_to_binary()
      |> IO.puts()
    end

    assistant_json =
      ~s({"summary":"adapter survived warning","findings":[],"build_shape":{"title":"Fake build shape","source":"fake root thread","boundary":"proposal state","nodes":[{"id":"source","title":"Source","body":"source","kind":"source"},{"id":"claim","title":"Claim","body":"claim","kind":"claim"}],"edges":[{"from":"source","to":"claim","label":"supports"}],"support":[]},"proposed_records":[{"title":"warning tolerated"}],"questions":[],"confidence":0.8})

    loop = fn loop ->
      case IO.read(:stdio, :line) do
        :eof ->
          :ok

        {:error, _reason} ->
          :ok

        line ->
          message = :json.decode(line)

          case message do
            %{"id" => 1, "method" => "initialize"} ->
              emit.(%{"id" => 1, "result" => %{}})

            %{"method" => "initialized"} ->
              :ok

            %{"id" => 2, "method" => "thread/start", "params" => params} ->
              File.write!(System.fetch_env!("FAKE_APP_SERVER_CAPTURE"), params["cwd"])
              emit.(%{"id" => 2, "result" => %{"thread" => %{"id" => "thread-test"}}})

            %{"id" => 3, "method" => "turn/start"} ->
              emit.(%{"id" => 3, "result" => %{"turn" => %{"id" => "turn-test"}}})

              emit.(%{
                "fields" => %{
                  "message" => "benign plugin warning",
                  "path" => "/tmp/plugin.json"
                },
                "level" => "WARN",
                "target" => "fake"
              })

              emit.(%{
                "method" => "item/agentMessage/delta",
                "params" => %{"delta" => assistant_json}
              })

              emit.(%{
                "method" => "turn/completed",
                "params" => %{
                  "turn" => %{
                    "id" => "turn-test",
                    "items" => [%{"type" => "agentMessage", "text" => assistant_json}]
                  }
                }
              })

            %{"id" => 4, "method" => "thread/read"} ->
              emit.(%{
                "id" => 4,
                "result" => %{
                  "thread" => %{
                    "turns" => [
                      %{
                        "id" => "turn-test",
                        "items" => [%{"type" => "agentMessage", "text" => assistant_json}]
                      }
                    ]
                  }
                }
              })

            _ ->
              :ok
          end

          loop.(loop)
      end
    end

    loop.(loop)
    """
  end

  defp drain_events(events) do
    receive do
      {:provider_event, event} -> drain_events([event | events])
    after
      0 -> Enum.reverse(events)
    end
  end

  defp with_env(env, fun) do
    previous = Map.new(env, fn {key, _value} -> {key, System.get_env(key)} end)

    Enum.each(env, fn {key, value} -> System.put_env(key, value) end)

    try do
      fun.()
    after
      Enum.each(previous, fn
        {key, nil} -> System.delete_env(key)
        {key, value} -> System.put_env(key, value)
      end)
    end
  end
end
