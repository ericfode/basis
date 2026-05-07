defmodule Basis.LLM.CodexProvider do
  @moduledoc """
  Backward-compatible name for the Codex app-server provider.
  """

  defdelegate complete(packet), to: Basis.LLM.AppServerProvider
  defdelegate complete(packet, emit), to: Basis.LLM.AppServerProvider
end
