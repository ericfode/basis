import { pathToFileURL } from "node:url";

const DAY = 24 * 60 * 60 * 1000;

const CASES = [
  {
    name: "scores and orders mixed queue",
    now: "2026-05-07T12:00:00Z",
    tickets: [
      ticket("SEC-1", 3, 5, 2, "pro", true, false, "2026-05-09T00:00:00Z"),
      ticket("ENT-OVERDUE", 4, 4, 3, "enterprise", false, false, "2026-05-06T00:00:00Z"),
      ticket("BLOCKED-HIGH", 5, 5, 1, "enterprise", true, true, "2026-05-06T00:00:00Z"),
      ticket("SMALL", 1, 2, 1, "free", false, false, null),
      ticket("TODAY", 2, 4, 2, "pro", false, false, "2026-05-07T03:00:00Z")
    ]
  },
  {
    name: "tie breakers",
    now: "2026-05-07T12:00:00Z",
    tickets: [
      ticket("B", 3, 3, 2, "pro", false, false, "2026-05-12T00:00:00Z"),
      ticket("A", 3, 3, 2, "pro", false, false, "2026-05-12T00:00:00Z"),
      ticket("SEC", 2, 3, 5, "pro", true, false, null),
      ticket("DUE-SOON", 3, 3, 2, "pro", false, false, "2026-05-08T00:00:00Z")
    ]
  }
];

const INVALID_TICKET = {
  id: "BAD",
  impact: 6,
  urgency: 2,
  effort: 1,
  customerTier: "enterprise",
  security: false,
  blocked: false,
  due: null
};

async function main() {
  const files = process.argv.slice(2);
  if (!files.length) {
    console.error("Usage: node evaluator.mjs <solution.mjs>...");
    process.exit(2);
  }

  const results = [];
  for (const file of files) {
    results.push(await evaluateFile(file));
  }

  console.log(JSON.stringify({ results, summary: summarize(results) }, null, 2));
}

async function evaluateFile(file) {
  const vector = {
    interface: 0,
    scoring: 0,
    ordering: 0,
    reasons: 0,
    validation: 0,
    purity: 0
  };
  const failures = [];

  let rankTickets;
  try {
    const mod = await import(pathToFileURL(file).href + `?t=${Date.now()}-${Math.random()}`);
    rankTickets = mod.rankTickets;
    if (typeof rankTickets === "function") vector.interface = 1;
    else failures.push("missing rankTickets export");
  } catch (error) {
    failures.push(`import failed: ${error.message}`);
    return finish(file, vector, failures);
  }

  if (typeof rankTickets !== "function") return finish(file, vector, failures);

  let scoringPoints = 0;
  let orderingPoints = 0;
  let reasonPoints = 0;
  let purityPoints = 0;

  for (const testCase of CASES) {
    const input = clone(testCase.tickets);
    const before = JSON.stringify(input);
    let actual;

    try {
      actual = rankTickets(input, testCase.now);
    } catch (error) {
      failures.push(`${testCase.name}: threw ${error.message}`);
      continue;
    }

    const expected = expectedRank(testCase.tickets, testCase.now);
    if (JSON.stringify(input) === before) purityPoints += 1;
    else failures.push(`${testCase.name}: mutated input`);

    if (Array.isArray(actual) && actual.length === expected.length) {
      const actualById = new Map(actual.map(item => [item?.id, item]));
      const expectedById = new Map(expected.map(item => [item.id, item]));

      let allScores = true;
      let allReasons = true;
      for (const [id, expectedItem] of expectedById) {
        const actualItem = actualById.get(id);
        if (!actualItem || actualItem.score !== expectedItem.score || actualItem.band !== expectedItem.band) {
          allScores = false;
        }
        if (!actualItem || !containsReasons(actualItem.reasons, expectedItem.reasons)) {
          allReasons = false;
        }
      }
      if (allScores) scoringPoints += 1;
      else failures.push(`${testCase.name}: scores or bands differ`);

      if (actual.map(item => item.id).join("|") === expected.map(item => item.id).join("|")) {
        orderingPoints += 1;
      } else {
        failures.push(`${testCase.name}: ordering differs`);
      }

      if (allReasons) reasonPoints += 1;
      else failures.push(`${testCase.name}: reasons incomplete`);
    } else {
      failures.push(`${testCase.name}: output shape mismatch`);
    }
  }

  vector.scoring = scoringPoints / CASES.length;
  vector.ordering = orderingPoints / CASES.length;
  vector.reasons = reasonPoints / CASES.length;
  vector.purity = purityPoints / CASES.length;

  try {
    rankTickets([INVALID_TICKET], "2026-05-07T12:00:00Z");
    failures.push("invalid ticket did not throw");
  } catch (error) {
    if (error instanceof TypeError) vector.validation += 0.5;
    else failures.push("invalid ticket threw non-TypeError");
  }

  try {
    rankTickets([], "not-a-date");
    failures.push("invalid nowIso did not throw");
  } catch (error) {
    if (error instanceof TypeError) vector.validation += 0.5;
    else failures.push("invalid nowIso threw non-TypeError");
  }

  return finish(file, vector, failures);
}

function finish(file, vector, failures) {
  const total =
    vector.interface * 0.15 +
    vector.scoring * 0.25 +
    vector.ordering * 0.2 +
    vector.reasons * 0.15 +
    vector.validation * 0.15 +
    vector.purity * 0.1;

  return {
    file,
    vector,
    total: Number(total.toFixed(4)),
    failures
  };
}

function summarize(results) {
  const groups = new Map();
  for (const result of results) {
    const condition = result.file.includes("/good-") ? "good" : result.file.includes("/bad-") ? "bad" : "unknown";
    if (!groups.has(condition)) groups.set(condition, []);
    groups.get(condition).push(result.total);
  }

  return Object.fromEntries([...groups].map(([condition, totals]) => {
    const sorted = [...totals].sort((a, b) => a - b);
    const mean = totals.reduce((sum, value) => sum + value, 0) / totals.length;
    return [condition, {
      n: totals.length,
      mean: Number(mean.toFixed(4)),
      median: sorted[Math.floor(sorted.length / 2)] ?? null,
      min: sorted[0] ?? null,
      max: sorted[sorted.length - 1] ?? null
    }];
  }));
}

function expectedRank(tickets, nowIso) {
  return tickets.map(original => {
    const score = expectedScore(original, nowIso);
    return {
      id: original.id,
      score,
      band: expectedBand(original, score),
      reasons: expectedReasons(original, nowIso)
    };
  }).sort((a, b) => compareExpected(a, b, tickets));
}

function expectedScore(ticketValue, nowIso) {
  let score = ticketValue.impact * 3 + ticketValue.urgency * 2 - ticketValue.effort;
  score += ticketValue.customerTier === "enterprise" ? 5 : ticketValue.customerTier === "pro" ? 2 : 0;
  if (ticketValue.security) score += 8;
  if (ticketValue.blocked) score -= 20;
  if (isBeforeDay(ticketValue.due, nowIso)) score += 6;
  else if (isSameDay(ticketValue.due, nowIso)) score += 3;
  return score;
}

function expectedBand(ticketValue, score) {
  if (ticketValue.blocked) return "blocked";
  if (score >= 22) return "now";
  if (score >= 14) return "next";
  return "later";
}

function expectedReasons(ticketValue, nowIso) {
  const reasons = [
    `impact:${ticketValue.impact}`,
    `urgency:${ticketValue.urgency}`,
    `effort:${ticketValue.effort}`,
    `tier:${ticketValue.customerTier}`
  ];
  if (ticketValue.security) reasons.push("security");
  if (ticketValue.blocked) reasons.push("blocked");
  if (isBeforeDay(ticketValue.due, nowIso)) reasons.push("overdue");
  if (isSameDay(ticketValue.due, nowIso)) reasons.push("due_today");
  return reasons;
}

function compareExpected(a, b, originals) {
  const originalById = new Map(originals.map(item => [item.id, item]));
  const bandOrder = { now: 0, next: 1, later: 2, blocked: 3 };
  const bandDelta = bandOrder[a.band] - bandOrder[b.band];
  if (bandDelta !== 0) return bandDelta;
  if (b.score !== a.score) return b.score - a.score;
  if (originalById.get(a.id).security !== originalById.get(b.id).security) {
    return originalById.get(a.id).security ? -1 : 1;
  }
  const dueDelta = dueSortValue(originalById.get(a.id).due) - dueSortValue(originalById.get(b.id).due);
  if (dueDelta !== 0) return dueDelta;
  return a.id.localeCompare(b.id);
}

function ticket(id, impact, urgency, effort, customerTier, security, blocked, due) {
  return { id, impact, urgency, effort, customerTier, security, blocked, due };
}

function dueSortValue(due) {
  return due ? Date.parse(due) : Number.POSITIVE_INFINITY;
}

function isBeforeDay(due, nowIso) {
  if (!due) return false;
  return dayStart(due) < dayStart(nowIso);
}

function isSameDay(due, nowIso) {
  if (!due) return false;
  return dayStart(due) === dayStart(nowIso);
}

function dayStart(value) {
  const date = new Date(value);
  return Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate()) / DAY;
}

function containsReasons(actual, expected) {
  if (!Array.isArray(actual)) return false;
  return expected.every(reason => actual.includes(reason));
}

function clone(value) {
  return JSON.parse(JSON.stringify(value));
}

main().catch(error => {
  console.error(error);
  process.exit(1);
});
