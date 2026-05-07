defmodule Basis.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Basis.LLM.TaskSupervisor},
      Basis.Run.Server
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Basis.Supervisor)
  end
end
