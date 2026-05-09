# Bad Spec: Ticket Priority Fitness Function

Purpose: build a useful ticket-ranking function that turns incoming work into a
priority queue.

Target projection: executable JavaScript module.

Export exactly:

```js
export function rankTickets(tickets, nowIso) {}
```

Input tickets have an `id`, rough impact, urgency, effort, customer tier,
security flag, blocked flag, and maybe a due date.

Return a list of ranked ticket summaries with an id, some kind of score, a broad
priority band, and reasons.

Important things should come first. Security and important customers should
matter. Blocked work should not crowd out actionable work. Due dates should be
considered. The result should be readable and predictable.

Do not overcomplicate it. No external packages.
