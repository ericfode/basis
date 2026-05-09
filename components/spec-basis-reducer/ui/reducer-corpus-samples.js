export const CORPUS_SAMPLES = [
  {
    label: "Basis.Reduce reducer spec",
    dossier: "basis::components/spec-basis-reducer",
    docType: "component_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/spec.md",
    whyGood: "Defines reducer authority, proposal state, provenance, record classes, projection targets, and explicit acceptance boundaries."
  },
  {
    label: "Implementation Imaginer spec",
    dossier: "basis::components/implementation-imaginer",
    docType: "component_good_spec",
    quality: "good_spec",
    path: "components/implementation-imaginer/spec.md",
    whyGood: "Names the implementation search state, worker lenses, decision records, validation gates, and non-acceptance boundaries."
  },
  {
    label: "Basis core spec",
    dossier: "basis::core",
    docType: "system_good_spec",
    quality: "good_spec",
    path: "spec.md",
    whyGood: "Sets the repository-level contract for Basis state, projections, provenance, and adapter boundaries."
  },
  {
    label: "LS-Lite behavior spec",
    dossier: "basis::experiments/programbench-lite-ls",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/programbench-lite-ls-spec-fitness/good-spec.md",
    whyGood: "Specifies a bounded ls-compatible CLI with operands, flags, ordering, errors, recursion, and hidden behavioral checks."
  },
  {
    label: "Early Redis compatible server spec",
    dossier: "basis::experiments/early-redis",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/early-redis-spec-fitness/specs/good-early-redis.md",
    whyGood: "Defines a buildable Redis-compatible TCP server with protocol parsing, command semantics, persistence limits, and error behavior."
  },
  {
    label: "CFGTool contract spec",
    dossier: "basis::experiments/programbench-lite-cfgtool",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/programbench-lite-spec-fitness/good-spec.md",
    whyGood: "Covers CLI parsing, file formats, merge semantics, validation behavior, and deterministic output requirements."
  },
  {
    label: "UXN byte core spec",
    dossier: "basis::experiments/uxn-vm-ladder",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/uxn-vm-spec-ladder/specs/l1-good-byte-core.md",
    whyGood: "Introduces a focused VM slice with explicit byte memory, stacks, opcodes, halt behavior, and observable test hooks."
  },
  {
    label: "UXN addressing modes spec",
    dossier: "basis::experiments/uxn-vm-ladder",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/uxn-vm-spec-ladder/specs/l2-good-modes.md",
    whyGood: "Separates opcode mode bits, stack effects, literal behavior, and return-stack semantics into independently testable obligations."
  },
  {
    label: "UXN memory-control spec",
    dossier: "basis::experiments/uxn-vm-ladder",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/uxn-vm-spec-ladder/specs/l3-good-memory-control.md",
    whyGood: "Defines memory access, control flow, failure cases, and deterministic state transitions without hiding policy in prose."
  },
  {
    label: "UXN devices spec",
    dossier: "basis::experiments/uxn-vm-ladder",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/uxn-vm-spec-ladder/specs/l4-good-devices.md",
    whyGood: "Adds device behavior as a bounded projection layer with explicit port semantics and host interaction boundaries."
  },
  {
    label: "Varvara program smoke spec",
    dossier: "basis::experiments/uxn-vm-ladder",
    docType: "evaluation_good_spec",
    quality: "good_spec",
    path: "components/spec-basis-reducer/experiments/uxn-vm-spec-ladder/specs/l5-good-varvara-program-smoke.md",
    whyGood: "Specifies end-to-end program behavior over the VM surface while keeping IO and acceptance criteria concrete."
  }
];
