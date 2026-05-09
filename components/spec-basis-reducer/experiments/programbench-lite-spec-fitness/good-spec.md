# Good Spec: `cfgtool`

Purpose: rebuild a small command-line configuration inspection utility from its
observable behavior.

You may run the black-box reference executable:

```sh
/private/tmp/basis-programbench-lite/oracle/cfgtool
```

Do not inspect the reference executable source. Implement a replacement Node.js
ES module CLI.

Create `solution.mjs`. It will be run as:

```sh
node solution.mjs <command> [arguments...] [--format text|json] [--strict] [file]
```

If `file` is omitted, read the config document from stdin. If `file` is present,
read that file as UTF-8.

## Commands

### `get PATH`

`PATH` is `section.key`.

Text output on success:

```text
<value>
```

JSON output on success:

```json
{"path":"section.key","value":"<value>"}
```

If missing, exit `1`, write no stdout, and write:

```text
cfgtool: missing key <PATH>
```

### `list [SECTION]`

Without `SECTION`, list every key as full paths sorted lexicographically:

```text
section.key=value
```

With `SECTION`, list only that section's keys sorted lexicographically:

```text
key=value
```

JSON output without section is an array of objects:

```json
[{"path":"section.key","value":"<value>"}]
```

JSON output with section is:

```json
[{"key":"key","value":"<value>"}]
```

If the requested section has no keys, exit `1`, write no stdout, and write:

```text
cfgtool: missing section <SECTION>
```

### `summary`

Text output:

```text
sections:<count>
keys:<count>
duplicates:<count>
```

JSON output:

```json
{"sections":1,"keys":2,"duplicates":0}
```

`sections` counts sections that contain at least one final key. The implicit
section before any header is named `default` and counts only when it contains a
key. `keys` counts final unique keys. `duplicates` counts overwritten key
assignments.

## Config Grammar

- Blank lines are ignored.
- Lines whose first non-space character is `#` are ignored.
- A section header is `[name]`; trim whitespace around `name`; names are
  case-sensitive and must be non-empty.
- A key-value line is `key = value`; trim whitespace around key and value.
- Keys are case-sensitive and must be non-empty.
- Key-value lines before a section belong to `default`.
- If a value begins and ends with the same quote character, either single quote
  or double quote, remove the outer quotes. No escape processing is required.
- In unquoted values, an inline comment begins at `#` only when the `#` is
  preceded by whitespace. Trim the value again after removing that comment.
- Duplicate assignments to the same `section.key` use the last value and
  increment the duplicate count.

## Errors

Unknown commands, invalid options, missing command arguments, unreadable files,
or invalid `--format` values are usage errors. Exit `2`, write no stdout, and
write:

```text
cfgtool: usage
```

Malformed config lines are ignored by default.

With `--strict`, the first malformed config line exits `2`, writes no stdout,
and writes:

```text
cfgtool: invalid line <line-number>: <original-line>
```

No external packages are allowed.
