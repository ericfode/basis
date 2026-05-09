# Good Spec: Ticket Priority Fitness Function

Purpose: build a deterministic ticket-ranking function that turns a set of
incoming work tickets into a reviewable priority queue.

Target projection: executable JavaScript module.

Export exactly:

```js
export function rankTickets(tickets, nowIso) {}
```

Input:

- `tickets`: array of ticket objects.
- `nowIso`: ISO date string used as the current date for due-date scoring.

Each ticket has:

- `id`: non-empty string
- `impact`: integer from 1 to 5
- `urgency`: integer from 1 to 5
- `effort`: integer from 1 to 5
- `customerTier`: one of `free`, `pro`, `enterprise`
- `security`: boolean
- `blocked`: boolean
- `due`: ISO date string or `null`

Output:

Return a new array. Do not mutate the input tickets or nested ticket objects.
Each returned item MUST be a new object:

```js
{
  id: string,
  score: number,
  band: "now" | "next" | "later" | "blocked",
  reasons: string[]
}
```

Scoring:

Start with:

```text
score = impact * 3 + urgency * 2 - effort
```

Then apply modifiers:

- `enterprise`: add 5
- `pro`: add 2
- `free`: add 0
- `security: true`: add 8
- `blocked: true`: subtract 20
- if `due` is before `nowIso`: add 6
- if `due` is the same calendar date as `nowIso`: add 3
- if `due` is null or after `nowIso`: add 0

Band:

- if `blocked` is true, band is `blocked`
- else if score is at least 22, band is `now`
- else if score is at least 14, band is `next`
- else band is `later`

Ordering:

Sort returned items by:

1. band order: `now`, `next`, `later`, `blocked`
2. higher score first
3. security tickets before non-security tickets
4. earlier non-null due date before later or null due date
5. lexical `id` ascending

Reasons:

Each returned item MUST include concise reasons:

- always include `impact:<n>`, `urgency:<n>`, and `effort:<n>`
- include `tier:<customerTier>`
- include `security` when `security` is true
- include `blocked` when `blocked` is true
- include `overdue` when due is before `nowIso`
- include `due_today` when due is the same calendar date as `nowIso`

Validation:

Throw a `TypeError` if:

- `tickets` is not an array
- `nowIso` is not a valid date string
- any ticket has an invalid or missing field

No external packages are allowed.
