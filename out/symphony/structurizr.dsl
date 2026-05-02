workspace "Spec Gym: Symphony Service Specification" "Architecture projection generated from a prose claim lattice." {
  model {
    reviewer = person "Spec reviewer" "Explores bad-idea pressure and implementation topology."

    specSystem = softwareSystem "Symphony Service Specification" "System shape inferred from the claim lattice." {
      c1 = container "Reads WORKFLOW.md." "component · component-3-1-main-components-reads-workflow-md" "Claim lattice node"
      c2 = container "Parses YAML front matter and prompt body." "component · component-3-1-main-components-parses-yaml-front-matter-and-prompt-body" "Claim lattice node"
      c3 = container "Returns {config, prompttemplate}." "component · component-3-1-main-components-returns-config-prompttemplate" "Claim lattice node"
      c4 = container "Exposes typed getters for workflow config values." "component · component-3-1-main-components-exposes-typed-getters-for-workflow-config-values" "Claim lattice node"
      c5 = container "Applies defaults and environment variable indirection." "component · component-3-1-main-components-applies-defaults-and-environment-variable-indirection" "Claim lattice node"
      c6 = container "Performs validation used by the orchestrator before dispatch." "component · component-3-1-main-components-performs-validation-used-by-the-orchestrator-before-dispatch" "Claim lattice node"
      c7 = container "Fetches candidate issues in active states." "component · component-3-1-main-components-fetches-candidate-issues-in-active-states" "Claim lattice node"
      c8 = container "Fetches current states for specific issue IDs (reconciliation)." "component · component-3-1-main-components-fetches-current-states-for-specific-issue-ids-reconciliation" "Claim lattice node"
      c9 = container "Fetches terminal-state issues during startup cleanup." "component · component-3-1-main-components-fetches-terminal-state-issues-during-startup-cleanup" "Claim lattice node"
      c10 = container "Normalizes tracker payloads into a stable issue model." "component · component-3-1-main-components-normalizes-tracker-payloads-into-a-stable-issue-model" "Claim lattice node"
      c11 = container "Owns the poll tick." "component · component-3-1-main-components-owns-the-poll-tick" "Claim lattice node"
      c12 = container "Owns the in-memory runtime state." "component · component-3-1-main-components-owns-the-in-memory-runtime-state" "Claim lattice node"
      c13 = container "Decides which issues to dispatch, retry, stop, or release." "component · component-3-1-main-components-decides-which-issues-to-dispatch-retry-stop-or-release" "Claim lattice node"
      c14 = container "Tracks session metrics and retry queue state." "component · component-3-1-main-components-tracks-session-metrics-and-retry-queue-state" "Claim lattice node"
      c15 = container "Maps issue identifiers to workspace paths." "component · component-3-1-main-components-maps-issue-identifiers-to-workspace-paths" "Claim lattice node"
      c16 = container "Ensures per-issue workspace directories exist." "component · component-3-1-main-components-ensures-per-issue-workspace-directories-exist" "Claim lattice node"
      c17 = container "Runs workspace lifecycle hooks." "component · component-3-1-main-components-runs-workspace-lifecycle-hooks" "Claim lattice node"
      c18 = container "Cleans workspaces for terminal issues." "component · component-3-1-main-components-cleans-workspaces-for-terminal-issues" "Claim lattice node"
      c19 = container "Creates workspace." "component · component-3-1-main-components-creates-workspace" "Claim lattice node"
      c20 = container "Builds prompt from issue + workflow template." "component · component-3-1-main-components-builds-prompt-from-issue-workflow-template" "Claim lattice node"
      c21 = container "Launches the coding agent app-server client." "component · component-3-1-main-components-launches-the-coding-agent-app-server-client" "Claim lattice node"
      c22 = container "Streams agent updates back to the orchestrator." "component · component-3-1-main-components-streams-agent-updates-back-to-the-orchestrator" "Claim lattice node"
      c23 = container "Status Surface (OPTIONAL)" "component · component-3-1-main-components-status-surface-optional" "Claim lattice node"
      c24 = container "Presents human-readable runtime status (for example terminal output, dashboard, or ot..." "component · component-3-1-main-components-presents-human-readable-runtime-status-for-example-terminal-output-dashboard-or-" "Claim lattice node"
      c25 = container "Emits structured runtime logs to one or more configured sinks." "component · component-3-1-main-components-emits-structured-runtime-logs-to-one-or-more-configured-sinks" "Claim lattice node"
    }

    reviewer -> specSystem "reviews and elaborates"
  }

  views {
    systemContext specSystem "SystemContext" {
      include *
      autoLayout
    }

    container specSystem "Containers" {
      include *
      autoLayout
    }

    theme default
  }
}
