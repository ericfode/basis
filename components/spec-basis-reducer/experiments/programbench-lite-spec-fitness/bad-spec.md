# Bad Spec: `cfgtool`

Purpose: rebuild a small command-line configuration inspection utility from its
observable behavior.

You may run the black-box reference executable:

```sh
/private/tmp/basis-programbench-lite/oracle/cfgtool
```

Do not inspect the reference executable source. Implement a replacement Node.js
ES module CLI.

Create `solution.mjs`. It will be run like:

```sh
node solution.mjs <command> [arguments...] [--format text|json] [--strict] [file]
```

The program reads a simple config file from a file path or from stdin.

It should support:

- `get PATH`
- `list [SECTION]`
- `summary`

Configs have sections, keys, values, comments, and blank lines. The utility
should handle normal whitespace and duplicates in a reasonable way. It should
support text and JSON output. It should report missing keys or sections and
should have a strict mode for bad config lines.

No external packages are allowed.
