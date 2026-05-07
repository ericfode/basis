defmodule Mix.Tasks.Basis.Server do
  @moduledoc "Runs the live Basis search UI server."

  use Mix.Task

  @shortdoc "Runs the live search UI"

  @impl true
  def run(args) do
    Mix.Task.run("app.start")
    {opts, _rest, _invalid} = OptionParser.parse(args, switches: [port: :integer])
    port = Keyword.get(opts, :port, env_port())
    {:ok, _pid} = Basis.Web.Server.start_link(port: port)
    Process.sleep(:infinity)
  end

  defp env_port do
    case System.get_env("BASIS_PORT") do
      nil -> 8767
      value -> String.to_integer(value)
    end
  end
end
