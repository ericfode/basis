# Bad Style Spec: Scattered Edge Cases `ls-lite`

Create `solution.mjs`, a Node.js ES module command. It runs as:

```sh
node solution.mjs [options] [file...]
```

Use Node filesystem APIs directly. No packages. No `child_process`, shell,
`ls`, `find`, or external command delegation.

## Main Behavior

The command lists directory contents and file operands. The output format is one
entry per line. Sort displayed names by Unicode code point ascending. If `-r` is
selected, reverse each sorted list after sorting.

Supported options are `-1`, `-a`, `-A`, `-d`, `-F`, `-R`, and `-r`. Grouped
short options are accepted, so `-aF` means `-a -F`. `-1` is also the default.

## Names

A hidden name begins with `.`. Directory listings omit hidden names by default.
`-a` includes hidden names and synthetic `.` and `..`. `-A` includes hidden
names but excludes synthetic `.` and `..`.

## Types

With `-F`, append `/` for directories, `@` for symbolic links, `*` for regular
files with any executable bit, and no suffix for other regular files. Use
`lstat` for symbolic links.

## Operands

If no operands are supplied, list the current working directory. If one file or
symlink operand is supplied, print that operand path. If one directory operand is
supplied without `-d`, print the directory entries. If `-d` is supplied, print
directory operands themselves rather than their contents.

For multiple operands, print non-directory operands first, then directory
operands. Sort each partition by operand string and apply `-r` inside each
partition. Directory operands print as blocks:

```text
<operand>:
<entries>
```

## Recursion

`-R` recursively prints child directory blocks for listed directories. Each child
block is preceded by a blank line and a `<path>:` header. Child directories are
visited in the same sorted order as displayed entries.

## Errors

Missing operands are not listed. Continue processing later operands, set final
exit status to `1`, and write:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Unsupported options exit `2`, write no stdout, and write:

```text
ls-lite: usage
```

## Output Exclusions

Do not colorize output. Do not print permissions, owners, sizes, timestamps,
inode numbers, or totals.

## Late Notes That Still Count

- Explicit operands are always printed even if their names begin with `.`.
- No directory header is printed when there are no operands.
- No directory header is printed for a single non-recursive directory operand.
- If multiple operands include any printed non-directory operand before a
  directory block, print a blank line before the first directory block.
- Print a blank line between directory blocks.
- When `-d` is present, do not create directory blocks at all; print all operand
  paths in sorted order.
- Recursive mode is ignored for file operands and for `-d`.
- Recursive traversal excludes `.` and `..`.
- Hidden child directories are traversed only when included by `-a` or `-A`.
- Do not recurse into symbolic links.
- When `-F` is active, remove the suffix before using a displayed directory name
  to decide recursive traversal order.
- Every stdout entry and every stderr diagnostic ends with `\n`.
- If nothing should be printed, stdout is empty.
