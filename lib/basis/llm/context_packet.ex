defmodule Basis.LLM.ContextPacket do
  @moduledoc """
  Explicit context passed to one LLM lens job.

  Context packets are part of the reducer contract. A lens may only claim
  authority over the source excerpt, prior summaries, targets, and instructions
  named here.
  """

  defstruct [
    :id,
    :run_id,
    :job_id,
    :kind,
    :lens_role,
    :source_path,
    :source_hash,
    :section_id,
    :section_title,
    :source_range,
    :target_projections,
    :prompt,
    :source_excerpt,
    :prior_result_refs,
    :excluded_context,
    :world_id,
    :parent_world_id,
    :candidate_path_id,
    :branch_id,
    :depth,
    :search_role,
    :agent_bias_profile,
    :repository_refs,
    :prior_world_refs,
    :expected_output_schema,
    :context_hash,
    :budget
  ]

  def new(attrs) do
    packet =
      struct!(__MODULE__,
        id: attrs.id,
        run_id: attrs.run_id,
        job_id: attrs.job_id,
        kind: attrs.kind,
        lens_role: attrs.lens_role,
        source_path: attrs.source_path,
        source_hash: attrs.source_hash,
        section_id: Map.get(attrs, :section_id),
        section_title: Map.get(attrs, :section_title),
        source_range: Map.get(attrs, :source_range),
        target_projections: attrs.target_projections,
        prompt: attrs.prompt,
        source_excerpt: attrs.source_excerpt,
        prior_result_refs: Map.get(attrs, :prior_result_refs, []),
        excluded_context: Map.get(attrs, :excluded_context, []),
        world_id: Map.get(attrs, :world_id),
        parent_world_id: Map.get(attrs, :parent_world_id),
        candidate_path_id: Map.get(attrs, :candidate_path_id),
        branch_id: Map.get(attrs, :branch_id),
        depth: Map.get(attrs, :depth),
        search_role: Map.get(attrs, :search_role),
        agent_bias_profile: Map.get(attrs, :agent_bias_profile),
        repository_refs: Map.get(attrs, :repository_refs, []),
        prior_world_refs: Map.get(attrs, :prior_world_refs, []),
        expected_output_schema: Map.get(attrs, :expected_output_schema),
        context_hash: nil,
        budget: Map.get(attrs, :budget, %{})
      )

    %{packet | context_hash: hash(packet)}
  end

  defp hash(packet) do
    packet
    |> Map.from_struct()
    |> Map.delete(:context_hash)
    |> Basis.Json.encode!()
    |> then(&:crypto.hash(:sha256, &1))
    |> Base.encode16(case: :lower)
  end
end
