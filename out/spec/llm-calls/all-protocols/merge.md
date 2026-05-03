You are merging partial LLM outputs for Spec Gym projection `all-protocols`: All Protocols.

Projection instructions:
# All Protocols

Extract every protocol, transport, API boundary, client-server contract, and
wire-format obligation implied by the spec.

The projection should preserve explicit protocol names, source anchors, and
open questions where the protocol is implied but not specified.

Final output contract:
- Format: json
- Path: projections/all-protocols.json
- Types: protocol

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- all-protocols-call-001.json / all-protocols-call-001.md
- all-protocols-call-002.json / all-protocols-call-002.md
- all-protocols-call-003.json / all-protocols-call-003.md
- all-protocols-call-004.json / all-protocols-call-004.md
