export function renderSpecDocument(section, anchors = []) {
  const lines = String(section.text || "").split("\n");
  const blocks = [];
  let index = 0;

  while (index < lines.length) {
    const line = lines[index];
    const lineNumber = Number(section.start_line) + index;

    if (isBlank(line)) {
      index += 1;
      continue;
    }

    if (isFence(line)) {
      const language = fenceLanguage(line);
      const block = [];
      index += 1;

      while (index < lines.length) {
        const current = lines[index];
        if (isFence(current)) {
          index += 1;
          break;
        }

        const currentLine = Number(section.start_line) + index;
        block.push(lineSpan(section, current, currentLine, anchors, "source-line-block source-code-line", { inline: false }));
        index += 1;
      }

      blocks.push(`
        <figure class="spec-code-block">
          ${language ? `<figcaption>${escapeHtml(language)}</figcaption>` : ""}
          <pre class="spec-code">${block.join("\n") || " "}</pre>
        </figure>
      `);
      continue;
    }

    const heading = parseHeading(line);
    if (heading) {
      const level = Math.min(heading.level + 1, 5);
      blocks.push(`<h${level} class="spec-heading">${lineSpan(section, heading.text, lineNumber, anchors, "source-line-block")}</h${level}>`);
      index += 1;
      continue;
    }

    if (isRule(line)) {
      blocks.push(`<div class="spec-rule">${lineSpan(section, "", lineNumber, anchors, "source-line-block")}</div>`);
      index += 1;
      continue;
    }

    if (isTableLine(line)) {
      const rows = [];
      while (index < lines.length && isTableLine(lines[index])) {
        const current = lines[index];
        const currentLine = Number(section.start_line) + index;
        if (!isTableSeparator(current)) {
          rows.push(renderTableRow(section, current, currentLine, anchors));
        }
        index += 1;
      }
      blocks.push(`<div class="spec-table" role="table">${rows.join("")}</div>`);
      continue;
    }

    const list = parseListItem(line);
    if (list) {
      const tag = list.ordered ? "ol" : "ul";
      const items = [];
      while (index < lines.length) {
        const current = parseListItem(lines[index]);
        if (!current || current.ordered !== list.ordered) break;
        const currentLine = Number(section.start_line) + index;
        items.push(`<li>${lineSpan(section, current.text, currentLine, anchors)}</li>`);
        index += 1;
      }
      blocks.push(`<${tag} class="spec-list">${items.join("")}</${tag}>`);
      continue;
    }

    if (isBlockquote(line)) {
      const quote = [];
      while (index < lines.length && isBlockquote(lines[index])) {
        const current = lines[index].replace(/^\s*>\s?/, "");
        const currentLine = Number(section.start_line) + index;
        quote.push(lineSpan(section, current, currentLine, anchors));
        index += 1;
      }
      blocks.push(`<blockquote class="spec-quote">${quote.join(" ")}</blockquote>`);
      continue;
    }

    const paragraph = [];
    while (index < lines.length && isParagraphLine(lines[index])) {
      const current = lines[index];
      const currentLine = Number(section.start_line) + index;
      paragraph.push(lineSpan(section, current.trim(), currentLine, anchors));
      index += 1;
    }
    blocks.push(`<p class="spec-paragraph">${paragraph.join(" ")}</p>`);
  }

  return `<div class="source-document">${blocks.join("")}</div>`;
}

function lineSpan(section, line, lineNumber, anchors, className = "", options = {}) {
  const matchingAnchors = anchors.filter(item => lineMatchesAnchor(section, line, lineNumber, item));
  const anchor = matchingAnchors[0];
  const text = options.inline === false ? escapeHtml(line || " ") : renderInline(line || " ");
  return `
    <span class="source-line ${className}" data-line="${lineNumber}" data-projected="${anchor ? "true" : "false"}">
      <button class="line-marker" type="button" data-section-id="${escapeAttr(section.id)}" data-line="${lineNumber}" data-source-text="${escapeAttr(line || "")}" aria-label="Give feedback on line ${lineNumber}">${lineNumber}</button>
      <span class="source-line-text">${text}</span>
    </span>
    ${renderLineImpacts(matchingAnchors)}
  `;
}

function renderLineImpacts(anchors) {
  const impacts = anchors
    .filter(anchor => anchor.kind === "feedback" || anchor.kind === "choice_preview")
    .slice(-2);
  if (!impacts.length) return "";

  return impacts.map(anchor => `
    <span class="line-impact" data-impact-kind="${escapeAttr(anchor.kind || "feedback")}" role="status">
      <strong>${escapeHtml(anchor.title || "Intent guidance applied")}</strong>
      <span>${escapeHtml(anchor.body || "Recorded source-anchored guidance and queued a refinement lens.")}</span>
    </span>
  `).join("");
}

function renderTableRow(section, line, lineNumber, anchors) {
  const cells = line
    .trim()
    .replace(/^\|/, "")
    .replace(/\|$/, "")
    .split("|")
    .map(cell => cell.trim());
  return `<div class="spec-table-row">${cells.map(cell => `<div class="spec-table-cell">${lineSpan(section, cell, lineNumber, anchors)}</div>`).join("")}</div>`;
}

function renderInline(value) {
  let text = escapeHtml(value);
  text = text.replace(/`([^`]+)`/g, "<code>$1</code>");
  text = text.replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>");
  text = text.replace(/\*([^*]+)\*/g, "<em>$1</em>");
  text = text.replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2">$1</a>');
  return text;
}

function lineMatchesAnchor(section, line, lineNumber, anchor) {
  if (anchor.start_line && anchor.end_line) {
    return lineNumber >= anchor.start_line && lineNumber <= anchor.end_line;
  }

  const quote = String(anchor.quote || "").trim();
  if (!quote) return false;
  const normalizedLine = String(line || "").trim();
  return normalizedLine && (quote.includes(normalizedLine) || normalizedLine.includes(quote));
}

function parseHeading(line) {
  const match = line.match(/^(#{1,6})\s+(.+)$/);
  if (!match) return null;
  return { level: match[1].length, text: match[2].trim() };
}

function parseListItem(line) {
  const unordered = line.match(/^\s*[-*+]\s+(.+)$/);
  if (unordered) return { ordered: false, text: unordered[1] };
  const ordered = line.match(/^\s*\d+[.)]\s+(.+)$/);
  if (ordered) return { ordered: true, text: ordered[1] };
  return null;
}

function isParagraphLine(line) {
  return !isBlank(line) &&
    !parseHeading(line) &&
    !parseListItem(line) &&
    !isFence(line) &&
    !isRule(line) &&
    !isTableLine(line) &&
    !isBlockquote(line);
}

function isBlank(line) {
  return !String(line || "").trim();
}

function isFence(line) {
  return /^\s*```/.test(line);
}

function fenceLanguage(line) {
  return String(line || "").replace(/^\s*```/, "").trim();
}

function isRule(line) {
  return /^\s*[-*_]{3,}\s*$/.test(line);
}

function isTableLine(line) {
  return /^\s*\|.+\|\s*$/.test(line);
}

function isTableSeparator(line) {
  return /^\s*\|?\s*:?-{3,}:?\s*(\|\s*:?-{3,}:?\s*)+\|?\s*$/.test(line);
}

function isBlockquote(line) {
  return /^\s*>/.test(line);
}

function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

function escapeAttr(value) {
  return escapeHtml(value).replaceAll("'", "&#39;");
}
