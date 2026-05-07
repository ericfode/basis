defmodule Basis.LLM.StreamCollector do
  @moduledoc """
  Collectable used by `System.cmd/3` to emit provider output while preserving
  the final console text.
  """

  defstruct emit: nil,
            mapper: nil,
            pending: "",
            chunks: []

  def push(%__MODULE__{} = collector, data) do
    buffer = collector.pending <> data
    {lines, pending} = split_lines(buffer)

    Enum.each(lines, fn line ->
      collector.emit.(collector.mapper.(line))
    end)

    %{collector | pending: pending, chunks: [data | collector.chunks]}
  end

  def finish(%__MODULE__{} = collector) do
    if collector.pending != "" do
      collector.emit.(collector.mapper.(collector.pending))
    end

    collector.chunks
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp split_lines(buffer) do
    parts = String.split(buffer, "\n")

    case parts do
      [] -> {[], ""}
      [_single] -> {[], buffer}
      _ -> {Enum.drop(parts, -1), List.last(parts)}
    end
  end
end

defimpl Collectable, for: Basis.LLM.StreamCollector do
  def into(collector) do
    collector_fun = fn
      state, {:cont, data} -> Basis.LLM.StreamCollector.push(state, data)
      state, :done -> Basis.LLM.StreamCollector.finish(state)
      _state, :halt -> :ok
    end

    {collector, collector_fun}
  end
end
