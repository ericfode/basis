const CORPUS_ROOT = "/Users/ericfode/src/spec-dataset-evolution-corpus";

export const CORPUS_SAMPLES = [
  {
    label: "Basis.Reduce reducer spec",
    dossier: "basis::components/spec-basis-reducer",
    docType: "component_spec",
    path: "components/spec-basis-reducer/spec.md"
  },
  {
    label: "Implementation Imaginer spec",
    dossier: "basis::components/implementation-imaginer@codex/add-implementation-imagination",
    docType: "component_spec",
    path: "/Users/ericfode/.codex/worktrees/b8d0/basis/components/implementation-imaginer/spec.md"
  },
  {
    label: "Basis core spec",
    dossier: "basis::core",
    docType: "system_spec",
    path: "spec.md"
  },
  {
    label: "Open Service Broker API",
    dossier: "SPEC-REPO-01::cloudfoundry/servicebroker",
    docType: "technical_spec",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-01/cloudfoundry__servicebroker/spec.md`
  },
  {
    label: "Compose Specification",
    dossier: "SPEC-REPO-01::compose-spec/compose-spec",
    docType: "technical_spec",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-01/compose-spec__compose-spec/spec.md`
  },
  {
    label: "HCL Native Syntax",
    dossier: "SPEC-REPO-01::hashicorp/hcl",
    docType: "technical_spec",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-01/hashicorp__hcl/hclsyntax/spec.md`
  },
  {
    label: "OCI Runtime Spec",
    dossier: "SPEC-REPO-01::opencontainers/runtime-spec",
    docType: "technical_spec",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-01/opencontainers__runtime-spec/spec.md`
  },
  {
    label: "MCP Tools",
    dossier: "SPEC-REPO-08::modelcontextprotocol/modelcontextprotocol",
    docType: "technical_spec",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-08/modelcontextprotocol__modelcontextprotocol/docs/specification/draft/server/tools.mdx`
  },
  {
    label: "Codex Thread Store Proto",
    dossier: "SPEC-REPO-08::openai/codex",
    docType: "api_contract",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-08/openai__codex/codex-rs/thread-store/src/remote/proto/codex.thread_store.v1.proto`
  },
  {
    label: "Spec Explorer Review Flow",
    dossier: "SPEC-REPO-04::eitatech/gatomia-vscode",
    docType: "exact_spec_md",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-04/eitatech__gatomia-vscode/specs/007-spec-review-flow/spec.md`
  },
  {
    label: "Bureau CLI Foundation",
    dossier: "SPEC-REPO-04::fancy-bread/bureau",
    docType: "exact_spec_md",
    path: `${CORPUS_ROOT}/corpus/by_repo/SPEC-REPO-04/fancy-bread__bureau/specs/001-autonomous-runtime-core/spec.md`
  }
];
