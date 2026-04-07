import re
from collections import defaultdict
from pathlib import Path

RAW_PATH = Path("raw.txt")
CREATE_PATH = Path("create.sql")
DROP_PATH = Path("drop.sql")

START_RE = re.compile(
    r"^\s*(IF\s+OBJECT_ID|DROP\s+TABLE|CREATE\s+TABLE|INSERT\s+INTO|SELECT\s+\*\s+FROM)\b",
    re.IGNORECASE,
)
CREATE_RE = re.compile(r"^\s*CREATE\s+TABLE\s+([\[\]\w]+)", re.IGNORECASE)
INSERT_RE = re.compile(r"^\s*INSERT\s+INTO\s+([\[\]\w]+)", re.IGNORECASE)
SELECT_RE = re.compile(r"^\s*SELECT\s+\*\s+FROM\s+([\[\]\w]+)", re.IGNORECASE)
REF_RE = re.compile(r"\bREFERENCES\s+([\[\]\w]+)", re.IGNORECASE)
SMART_MAP = str.maketrans(
    {
        "\u2018": "'",
        "\u2019": "'",
        "\u201c": '"',
        "\u201d": '"',
        "\u00a0": " ",
    }
)


def main():
    text = RAW_PATH.read_text(encoding="utf-8").translate(SMART_MAP)
    statements, tail_comments = parse_statements(text.splitlines())
    preamble, bundles, raw_order = build_bundles(statements)
    create_order = topo_sort(bundles, raw_order)
    write_file(CREATE_PATH, render_create(preamble, bundles, create_order, tail_comments))
    write_file(DROP_PATH, render_drop(create_order))
    count = sum(1 for table in create_order if bundles[table]["has_create"])
    print(f"Generated {CREATE_PATH} and {DROP_PATH} for {count} tables.")


def parse_statements(lines):
    statements = []
    comments = []
    index = 0
    while index < len(lines):
        line = lines[index].rstrip()
        if not line.strip():
            comments.append("")
            index += 1
            continue
        if START_RE.match(line):
            block = [clean_sql_line(line)]
            index += 1
            while index < len(lines):
                next_line = lines[index].rstrip()
                if not next_line.strip():
                    block.append("")
                    index += 1
                    continue
                if START_RE.match(next_line):
                    break
                block.append(clean_sql_line(next_line))
                index += 1
                if ";" in next_line:
                    break
            statements.append(make_statement(comments, block))
            comments = []
            continue
        comments.append(to_comment(line))
        index += 1
    return statements, trim_comments(comments)


def make_statement(comments, block):
    text = "\n".join(trim_blank_lines(block)).strip()
    kind, table = classify_statement(text)
    return {"comments": trim_comments(comments), "kind": kind, "table": table, "text": text}


def classify_statement(text):
    for kind, regex in (("create", CREATE_RE), ("insert", INSERT_RE), ("select", SELECT_RE)):
        match = regex.match(text)
        if match:
            return kind, clean_name(match.group(1))
    if text.upper().startswith("IF OBJECT_ID") or text.upper().startswith("DROP TABLE"):
        return "drop", ""
    return "other", ""


def build_bundles(statements):
    bundles = {}
    raw_order = []
    carry = []
    preamble = []
    for statement in statements:
        if statement["kind"] == "drop":
            carry.extend(statement["comments"])
            continue
        comments = trim_comments(carry + statement["comments"])
        carry = []
        if not statement["table"]:
            preamble.extend(comments + [statement["text"], ""])
            continue
        bundle = bundles.setdefault(
            statement["table"], {"parts": [], "refs": set(), "has_create": False}
        )
        if statement["table"] not in raw_order:
            raw_order.append(statement["table"])
        bundle["parts"].append(render_part(comments, statement["text"]))
        if statement["kind"] == "create":
            bundle["has_create"] = True
            bundle["refs"] = {ref for ref in find_refs(statement["text"]) if ref != statement["table"]}
    preamble = trim_comments(preamble + carry)
    return preamble, bundles, raw_order


def topo_sort(bundles, raw_order):
    deps = {}
    dependents = defaultdict(set)
    for table in raw_order:
        refs = {ref for ref in bundles[table]["refs"] if ref in bundles and bundles[ref]["has_create"]}
        deps[table] = refs
        for ref in refs:
            dependents[ref].add(table)
    ready = [table for table in raw_order if not deps[table]]
    order = []
    while ready:
        table = ready.pop(0)
        order.append(table)
        for child in raw_order:
            if child not in dependents[table]:
                continue
            deps[child].discard(table)
            if not deps[child] and child not in order and child not in ready:
                ready.append(child)
    for table in raw_order:
        if table not in order:
            order.append(table)
    return order


def render_create(preamble, bundles, create_order, tail_comments):
    parts = []
    if preamble:
        parts.append("\n".join(preamble))
    for table in create_order:
        bundle = bundles[table]
        if not bundle["has_create"]:
            continue
        parts.extend(bundle["parts"])
    if tail_comments:
        parts.append("\n".join(tail_comments))
    return "\n\n".join(part for part in parts if part).strip() + "\n"


def render_drop(create_order):
    lines = []
    for table in reversed(create_order):
        lines.append(f"IF OBJECT_ID('{table}', 'U') IS NOT NULL")
        lines.append(f"DROP TABLE {table};")
        lines.append("")
    return "\n".join(lines).strip() + "\n"


def render_part(comments, text):
    if not comments:
        return text
    return "\n".join(comments + ["", text]).strip()


def find_refs(text):
    return [clean_name(match) for match in REF_RE.findall(text)]


def clean_sql_line(line):
    stripped = line.strip()
    if stripped.startswith(("–", "—")):
        return to_comment(stripped)
    return line.translate(SMART_MAP).rstrip()


def to_comment(line):
    stripped = line.translate(SMART_MAP).strip()
    if not stripped:
        return ""
    if stripped.startswith("--"):
        return stripped
    if stripped.startswith(("–", "—")):
        return "-- " + stripped[1:].strip()
    if stripped.startswith(("/*", "*/", "*")):
        return stripped
    return "-- " + stripped


def clean_name(name):
    return name.strip().strip("[]")


def trim_blank_lines(lines):
    while lines and not lines[0]:
        lines.pop(0)
    while lines and not lines[-1]:
        lines.pop()
    return lines


def trim_comments(lines):
    cleaned = []
    gap = False
    for line in lines:
        if not line:
            if cleaned:
                gap = True
            continue
        if gap:
            cleaned.append("")
            gap = False
        cleaned.append(line)
    return cleaned


def write_file(path, content):
    path.write_text(content, encoding="utf-8")


main()
