defmodule Basis.Source do
  @moduledoc """
  Source identity and section packet construction.

  This module is deliberately limited to source topology. It does not label
  pivots, gaps, couplings, or any other semantic reducer records.
  """

  def read!(path) do
    text = File.read!(path)

    %{
      path: path,
      hash: sha256(text),
      line_count: text |> String.split("\n") |> length(),
      text: text,
      sections: sections(text)
    }
  end

  def preview(path) do
    source = read!(path)

    %{
      run_id: nil,
      mode: "reducer",
      status: "preview",
      provider: "Preview",
      started_at: nil,
      updated_at: nil,
      source: Map.take(source, [:path, :hash, :line_count]),
      target_projections: [],
      reasoning_effort: "low",
      implementation_target: nil,
      section_limit: length(source.sections),
      max_concurrency: 10,
      branch_count: 3,
      max_depth: 4,
      focused_branch: nil,
      steering_notes: [],
      rejected_paths: [],
      counts: %{
        events: 0,
        sections: 0,
        jobs: 0,
        queued: 0,
        running: 0,
        completed: 0,
        failed: 0,
        stopped: 0,
        codex_threads: 0,
        active_codex_turns: 0,
        records: 0,
        questions: 0
      },
      sections: Enum.map(source.sections, &Map.delete(&1, :text)),
      document_sections: source.sections,
      jobs: [],
      context_packets: [],
      streams: %{},
      results: [],
      proposed_records: [],
      questions: [],
      imaginer: nil,
      interventions: [],
      events: []
    }
  end

  def sections(text) do
    lines = String.split(text, "\n", trim: false)

    headings =
      lines
      |> Enum.with_index(1)
      |> Enum.filter(fn {line, _line_number} -> heading?(line) end)

    heading_ranges =
      headings
      |> Enum.with_index()
      |> Enum.map(fn {{line, line_number}, index} ->
        next = Enum.at(headings, index + 1)
        end_line = if next, do: elem(next, 1) - 1, else: length(lines)

        {line_number, end_line, title_for(line)}
      end)

    ranges =
      if heading_ranges == [] do
        [{1, length(lines), "Document"}]
      else
        heading_ranges
      end

    ranges
    |> Enum.with_index(1)
    |> Enum.map(fn {{start_line, end_line, title}, index} ->
      text =
        lines
        |> Enum.slice((start_line - 1)..(end_line - 1))
        |> Enum.join("\n")

      %{
        id: "section-#{String.pad_leading(to_string(index), 3, "0")}",
        title: title,
        start_line: start_line,
        end_line: end_line,
        text: text
      }
    end)
  end

  defp heading?(line) do
    trimmed = String.trim_leading(line)
    String.starts_with?(trimmed, "# ") or String.starts_with?(trimmed, "## ")
  end

  defp title_for(line) do
    line
    |> String.trim()
    |> String.trim_leading("#")
    |> String.trim()
    |> case do
      "" -> "Untitled Section"
      title -> title
    end
  end

  defp sha256(text) do
    :crypto.hash(:sha256, text)
    |> Base.encode16(case: :lower)
  end
end
