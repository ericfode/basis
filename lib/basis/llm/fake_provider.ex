defmodule Basis.LLM.FakeProvider do
  @moduledoc false

  def complete(packet), do: complete(packet, fn _event -> :ok end)

  def complete(%Basis.LLM.ContextPacket{} = packet, emit) do
    thread_id = "fake-thread-#{packet.job_id}"
    turn_id = "fake-turn-#{packet.job_id}"

    emit.(%{
      type: "thread/started",
      provider: "fake_app_server",
      at: Basis.Run.Clock.now(),
      thread_id: thread_id,
      turn_id: nil,
      summary: "Created fake app-server thread.",
      raw:
        Basis.Json.encode!(%{
          "method" => "thread/started",
          "params" => %{"thread" => %{"id" => thread_id}}
        })
    })

    emit.(%{
      type: "turn/started",
      provider: "fake_app_server",
      at: Basis.Run.Clock.now(),
      thread_id: thread_id,
      turn_id: turn_id,
      summary: "Started fake app-server turn.",
      raw:
        Basis.Json.encode!(%{
          "method" => "turn/started",
          "params" => %{"threadId" => thread_id, "turn" => %{"id" => turn_id}}
        })
    })

    Process.sleep(10)

    emit.(%{
      type: "item/agentMessage/delta",
      provider: "fake_app_server",
      at: Basis.Run.Clock.now(),
      thread_id: thread_id,
      turn_id: turn_id,
      summary: "Fake model delta.",
      raw:
        Basis.Json.encode!(%{
          "method" => "item/agentMessage/delta",
          "params" => %{
            "threadId" => thread_id,
            "turnId" => turn_id,
            "delta" => "Fake model delta."
          }
        })
    })

    {:ok,
     %{
       provider: "fake_app_server",
       provider_status: "completed",
       started_at: Basis.Run.Clock.now(),
       completed_at: Basis.Run.Clock.now(),
       raw_text:
         ~s({"summary":"Fake #{packet.lens_role} result.","findings":[],"proposed_records":[],"questions":[],"confidence":1.0}),
       console_excerpt: "",
       codex_thread_id: thread_id,
       codex_thread_url: "codex://threads/#{thread_id}",
       codex_turn_id: turn_id,
       summary: "Fake #{packet.lens_role} result.",
       findings: [],
       proposed_records: [],
       questions: [],
       confidence: 1.0
     }}
  end
end
