const $ = (s, root = document) => root.querySelector(s)
const START_RE = /^\s*(IF\s+OBJECT_ID|DROP\s+TABLE|CREATE\s+TABLE|INSERT\s+INTO|SELECT\s+\*\s+FROM)\b/i
const CREATE_RE = /^\s*CREATE\s+TABLE\s+([\[\]\w]+)/i
const INSERT_RE = /^\s*INSERT\s+INTO\s+([\[\]\w]+)/i
const SELECT_RE = /^\s*SELECT\s+\*\s+FROM\s+([\[\]\w]+)/i
const REF_RE = /\bREFERENCES\s+([\[\]\w]+)/gi
const HEADER_RE = /^(?=.*[A-Z])[A-Z0-9][A-Z0-9_ /&-]*$/
const HEADER_SKIP_RE = /^(VALUES)$/i
const SMART_RE = /[\u2018\u2019\u201c\u201d\u00a0]/g
const SMART_MAP = { "\u2018": "'", "\u2019": "'", "\u201c": '"', "\u201d": '"', "\u00a0": " " }
const state = { createUrl: "", dropUrl: "", refreshUrl: "" }

function convertText(raw) {
  const text = normalize(raw)
  if (!text.trim()) {
    return { createSql: "", dropSql: "", refreshSql: "", tableCount: 0 }
  }
  const { statements, tailComments } = parseStatements(text)
  const { preamble, bundles, rawOrder } = buildBundles(statements)
  const createOrder = topoSort(bundles, rawOrder)
  const createSql = renderCreate(preamble, bundles, createOrder, tailComments)
  const dropSql = renderDrop(createOrder, bundles)
  const refreshSql = renderRefresh(dropSql, createSql)
  const tableCount = createOrder.filter(name => bundles[name].hasCreate).length
  return { createSql, dropSql, refreshSql, tableCount }
}

function convert(raw) {
  const { createSql, dropSql, refreshSql, tableCount } = convertText(raw)
  if (!tableCount) {
    clearOutput("No input loaded")
    return
  }
  createPreviewEl.textContent = createSql
  dropPreviewEl.textContent = dropSql
  refreshPreviewEl.textContent = refreshSql
  setDownload(createDownloadEl, "create.sql", createSql, "createUrl")
  setDownload(dropDownloadEl, "drop.sql", dropSql, "dropUrl")
  setDownload(refreshDownloadEl, "refresh.sql", refreshSql, "refreshUrl")
  summaryEl.textContent = `${tableCount} tables ready`
  setMessage(`create.sql ${createSql.length} chars | drop.sql ${dropSql.length} chars | refresh.sql ${refreshSql.length} chars`)
}

async function loadSample() {
  try {
    const response = await fetch("raw.txt")
    if (!response.ok) throw new Error()
    sourceEl.value = await response.text()
    convert(sourceEl.value)
    setMessage("Loaded raw.txt")
  } catch {
    setMessage("Paste text or open raw.txt manually")
  }
}

function parseStatements(text) {
  const lines = text.split(/\r?\n/)
  const statements = []
  const comments = []
  for (let i = 0; i < lines.length;) {
    const line = lines[i].replace(/\s+$/, "")
    if (!line.trim()) {
      if (comments.length) comments.push("")
      i += 1
      continue
    }
    if (!START_RE.test(line)) {
      if (isSqlComment(line) || isHeader(line)) comments.push(toComment(line))
      i += 1
      continue
    }
    const block = [cleanSqlLine(line)]
    i += 1
    if (line.includes(";")) {
      statements.push(makeStatement(comments.splice(0), block))
      continue
    }
    while (i < lines.length) {
      const nextLine = lines[i].replace(/\s+$/, "")
      if (!nextLine.trim()) {
        block.push("")
        i += 1
        continue
      }
      if (START_RE.test(nextLine)) break
      block.push(cleanSqlLine(nextLine))
      i += 1
      if (nextLine.includes(";")) break
    }
    statements.push(makeStatement(comments.splice(0), block))
  }
  return { statements, tailComments: trimLines(comments) }
}

function makeStatement(comments, block) {
  const text = trimBlock(block).join("\n").trim()
  const [kind, table] = classify(text)
  return { comments: trimLines(comments), kind, table, text }
}

function classify(text) {
  for (const [kind, regex] of [["create", CREATE_RE], ["insert", INSERT_RE], ["select", SELECT_RE]]) {
    const match = text.match(regex)
    if (match) return [kind, cleanName(match[1])]
  }
  if (/^\s*(IF\s+OBJECT_ID|DROP\s+TABLE)/i.test(text)) return ["drop", ""]
  return ["other", ""]
}

function buildBundles(statements) {
  const bundles = {}
  const rawOrder = []
  const carry = []
  const preamble = []
  for (const statement of statements) {
    if (statement.kind === "drop") {
      carry.push(...statement.comments)
      continue
    }
    const comments = trimLines([...carry, ...statement.comments])
    carry.length = 0
    if (!statement.table) {
      preamble.push(...comments, statement.text, "")
      continue
    }
    if (!bundles[statement.table]) {
      bundles[statement.table] = { parts: [], refs: new Set(), hasCreate: false }
      rawOrder.push(statement.table)
    }
    bundles[statement.table].parts.push(renderPart(comments, statement.text))
    if (statement.kind === "create") {
      bundles[statement.table].hasCreate = true
      bundles[statement.table].refs = new Set(findRefs(statement.text).filter(ref => ref !== statement.table))
    }
  }
  preamble.push(...carry)
  return { preamble: trimLines(preamble), bundles, rawOrder }
}

function topoSort(bundles, rawOrder) {
  const deps = {}
  const dependents = {}
  for (const table of rawOrder) {
    deps[table] = [...bundles[table].refs].filter(ref => bundles[ref]?.hasCreate)
    for (const ref of deps[table]) {
      if (!dependents[ref]) dependents[ref] = []
      dependents[ref].push(table)
    }
  }
  const ready = rawOrder.filter(table => deps[table].length === 0)
  const order = []
  while (ready.length) {
    const table = ready.shift()
    order.push(table)
    for (const child of dependents[table] || []) {
      deps[child] = deps[child].filter(ref => ref !== table)
      if (deps[child].length === 0 && !order.includes(child) && !ready.includes(child)) ready.push(child)
    }
  }
  for (const table of rawOrder) if (!order.includes(table)) order.push(table)
  return order
}

function renderCreate(preamble, bundles, createOrder, tailComments) {
  const parts = []
  if (preamble.length) parts.push(preamble.join("\n"))
  for (const table of createOrder) {
    if (!bundles[table].hasCreate) continue
    parts.push(...bundles[table].parts)
  }
  if (tailComments.length) parts.push(tailComments.join("\n"))
  return `${parts.filter(Boolean).join("\n\n").trim()}\n`
}

function renderDrop(createOrder, bundles) {
  const names = createOrder.filter(table => bundles[table].hasCreate)
  const lines = []
  lines.push(...renderFkDrop(names))
  for (const table of [...names].reverse()) {
    lines.push(`IF OBJECT_ID('${table}', 'U') IS NOT NULL`)
    lines.push(`DROP TABLE ${table};`)
    lines.push("")
  }
  return `${lines.join("\n").trim()}\n`
}

function renderFkDrop(names) {
  if (!names.length) return []
  const list = names.map(name => `(N'${escapeSql(name)}')`).join(", ")
  return [
    "DECLARE @sql NVARCHAR(MAX) = N'';",
    `DECLARE @targets TABLE (name SYSNAME PRIMARY KEY); INSERT INTO @targets (name) VALUES ${list};`,
    "SELECT @sql += N'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(fk.parent_object_id)) + N'.' + QUOTENAME(OBJECT_NAME(fk.parent_object_id)) +",
    "    N' DROP CONSTRAINT ' + QUOTENAME(fk.name) + N';' + CHAR(10)",
    "FROM sys.foreign_keys fk",
    "WHERE EXISTS (SELECT 1 FROM @targets t WHERE t.name = OBJECT_NAME(fk.parent_object_id) OR t.name = OBJECT_NAME(fk.referenced_object_id));",
    "IF @sql <> N'' EXEC sp_executesql @sql;",
    ""
  ]
}

function renderRefresh(dropSql, createSql) {
  return `${dropSql.trim()}\n\n${createSql.trim()}\n`
}

function renderPart(comments, text) {
  return comments.length ? [...comments, "", text].join("\n").trim() : text
}

function findRefs(text) {
  return [...text.matchAll(REF_RE)].map(match => cleanName(match[1]))
}

function cleanSqlLine(line) {
  const stripped = line.trim()
  if (START_RE.test(stripped)) return normalize(line).replace(/\s+$/, "")
  return isSqlComment(stripped) ? toComment(stripped) : normalize(line).replace(/\s+$/, "")
}

function isSqlComment(line) {
  const stripped = normalize(line).trim()
  return stripped.startsWith("--") || stripped.startsWith("/*") || stripped.startsWith("*/") || stripped.startsWith("*") || stripped.startsWith("–") || stripped.startsWith("—")
}

function isHeader(line) {
  const text = normalize(line).trim()
  return !HEADER_SKIP_RE.test(text) && HEADER_RE.test(text)
}

function toComment(line) {
  const stripped = normalize(line).trim()
  if (!stripped) return ""
  if (stripped.startsWith("--") || stripped.startsWith("/*") || stripped.startsWith("*/") || stripped.startsWith("*")) return stripped
  if (stripped.startsWith("–") || stripped.startsWith("—")) return `-- ${stripped.slice(1).trim()}`
  return `-- ${stripped}`
}

function cleanName(name) {
  return name.trim().replace(/^\[|\]$/g, "")
}

function trimBlock(lines) {
  const copy = [...lines]
  while (copy[0] === "") copy.shift()
  while (copy.at(-1) === "") copy.pop()
  return copy
}

function trimLines(lines) {
  const cleaned = []
  let gap = false
  for (const line of lines) {
    if (!line) {
      if (cleaned.length) gap = true
      continue
    }
    if (gap) cleaned.push("")
    gap = false
    cleaned.push(line)
  }
  return cleaned
}

function normalize(text) {
  return text.replace(SMART_RE, char => SMART_MAP[char] || char)
}

function escapeSql(text) {
  return text.replace(/'/g, "''")
}

function setDownload(link, name, text, key) {
  if (state[key]) URL.revokeObjectURL(state[key])
  state[key] = URL.createObjectURL(new Blob([text], { type: "text/sql;charset=utf-8" }))
  link.href = state[key]
  link.download = name
  link.classList.remove("disabled")
}

function clearAll() {
  sourceEl.value = ""
  clearOutput("No input loaded")
  setMessage("")
}

function clearOutput(summary) {
  summaryEl.textContent = summary
  createPreviewEl.textContent = "Preview will appear here."
  dropPreviewEl.textContent = "Preview will appear here."
  refreshPreviewEl.textContent = "Preview will appear here."
  resetDownload(createDownloadEl, "createUrl")
  resetDownload(dropDownloadEl, "dropUrl")
  resetDownload(refreshDownloadEl, "refreshUrl")
  createDownloadEl.classList.add("disabled")
  dropDownloadEl.classList.add("disabled")
  refreshDownloadEl.classList.add("disabled")
}

function setMessage(text) {
  messageEl.textContent = text
}

function resetDownload(link, key) {
  if (state[key]) URL.revokeObjectURL(state[key])
  state[key] = ""
  link.removeAttribute("href")
}

function isSelectAll(event) {
  return (event.ctrlKey || event.metaKey) && !event.altKey && event.key.toLowerCase() === "a"
}

function findPreview(node) {
  const el = node?.nodeType === 1 ? node : node?.parentElement
  return el?.closest?.("pre[id$='-preview']") || null
}

function getSelectedPreview() {
  const active = findPreview(document.activeElement)
  if (active) return active
  const selection = window.getSelection()
  if (!selection.rangeCount) return null
  return findPreview(selection.anchorNode) || findPreview(selection.focusNode) || findPreview(selection.getRangeAt(0).commonAncestorContainer)
}

function handleSelectAll(event) {
  if (!isSelectAll(event)) return
  const previewEl = getSelectedPreview()
  if (!previewEl) return
  event.preventDefault()
  const range = document.createRange()
  const selection = window.getSelection()
  range.selectNodeContents(previewEl)
  selection.removeAllRanges()
  selection.addRange(range)
}

let sourceEl
let summaryEl
let messageEl
let createPreviewEl
let dropPreviewEl
let refreshPreviewEl
let createDownloadEl
let dropDownloadEl
let refreshDownloadEl

if (typeof document !== "undefined") {
  sourceEl = $("#source")
  summaryEl = $("#summary")
  messageEl = $("#message")
  createPreviewEl = $("#create-preview")
  dropPreviewEl = $("#drop-preview")
  refreshPreviewEl = $("#refresh-preview")
  createDownloadEl = $("#download-create")
  dropDownloadEl = $("#download-drop")
  refreshDownloadEl = $("#download-refresh")
  createPreviewEl.tabIndex = 0
  dropPreviewEl.tabIndex = 0
  refreshPreviewEl.tabIndex = 0

  $("#convert").addEventListener("click", () => convert(sourceEl.value))
  $("#clear").addEventListener("click", clearAll)
  $("#load-sample").addEventListener("click", loadSample)
  $("#file-input").addEventListener("change", async event => {
    const [file] = event.target.files
    if (!file) return
    sourceEl.value = await file.text()
    convert(sourceEl.value)
    setMessage(`Loaded ${file.name}`)
  })
  document.addEventListener("keydown", handleSelectAll)

  loadSample()
}

if (typeof module !== "undefined") module.exports = { convertText }
