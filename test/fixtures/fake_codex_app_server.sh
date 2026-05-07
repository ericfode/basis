#!/bin/sh
count=0

while IFS= read -r line; do
  count=$((count + 1))

  case "$count" in
    1)
      printf '%s\n' '{"fields":{"message":"structured diagnostic before initialize"},"level":"WARN"}'
      printf '%s\n' '{"id":1,"result":{}}'
      ;;
    2)
      :
      ;;
    3)
      printf '%s\n' '{"id":2,"result":{"thread":{"id":"thread-live-smoke"}}}'
      ;;
    4)
      printf '%s\n' '{"fields":{"message":"structured diagnostic before turn"},"level":"WARN"}'
      printf '%s\n' '{"id":3,"result":{"turn":{"id":"turn-live-smoke"}}}'
      printf '%s\n' '{"method":"item/reasoning/summaryTextDelta","params":{"threadId":"thread-live-smoke","turnId":"turn-live-smoke","delta":"Checking visible tool flow."}}'
      printf '%s\n' '{"method":"item/tool/call","id":60,"params":{"threadId":"thread-live-smoke","turnId":"turn-live-smoke","callId":"call-thought","tool":"basis_show_thought","arguments":{"title":"Check","body":"The lens is publishing a visible reducer note."}}}'
      ;;
    5)
      printf '%s\n' '{"method":"item/tool/call","id":61,"params":{"threadId":"thread-live-smoke","turnId":"turn-live-smoke","callId":"call-mermaid","tool":"basis_show_mermaid","arguments":{"title":"Visible flow","source":"graph TD\n  A{Visible note?} -->|yes| B[Render thought]\n  B --> C[Render Mermaid]","source_anchor":{"section_id":"section-001","start_line":1,"end_line":8,"quote":"Spec Basis Reducer Component Specification"}}}}'
      ;;
    6)
      printf '%s\n' '{"method":"item/tool/call","id":62,"params":{"threadId":"thread-live-smoke","turnId":"turn-live-smoke","callId":"call-delegate","tool":"basis_delegate_lens","arguments":{"role":"diagram_lens","task":"Check whether a small diagram would clarify this section.","why":"The parent reducer lens should stay focused on semantic reduction.","handoff":"Return only the diagram recommendation and any caveat."}}}'
      ;;
    7)
      printf '%s\n' '{"method":"item/agentMessage/delta","params":{"threadId":"thread-live-smoke","turnId":"turn-live-smoke","delta":"```mermaid\n graph TD\n   A{Decoder brace} --> B[Still parse final JSON]\n```\n{\"summary\":\"live smoke ok\",\"findings\":[],\"proposed_records\":[],\"questions\":[],\"confidence\":1.0}"}}'
      printf '%s\n' '{"method":"turn/completed","params":{"threadId":"thread-live-smoke","turn":{"id":"turn-live-smoke","items":[{"type":"agentMessage","text":"```mermaid\n graph TD\n   A{Decoder brace} --> B[Still parse final JSON]\n```\n{\"summary\":\"live smoke ok\",\"findings\":[],\"proposed_records\":[],\"questions\":[],\"confidence\":1.0}"}]}}}'
      ;;
    8)
      printf '%s\n' '{"id":4,"result":{"thread":{"turns":[{"id":"turn-live-smoke","items":[{"type":"agentMessage","text":"{\"summary\":\"live smoke ok\",\"findings\":[],\"proposed_records\":[],\"questions\":[],\"confidence\":1.0}"}]}]}}}'
      exit 0
      ;;
  esac
done
