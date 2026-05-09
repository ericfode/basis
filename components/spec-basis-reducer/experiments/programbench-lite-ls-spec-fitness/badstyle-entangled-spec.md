# Bad Style Spec: Entangled `ls-lite`

Build `solution.mjs`, a Node.js ES module CLI invoked as
`node solution.mjs [options] [file...]`. Do not use external packages and do not
delegate to `ls`, `find`, shells, `child_process`, or external programs.

The program lists files and directory contents in a deterministic one-entry-per
line format while also handling grouped short options `-1`, `-a`, `-A`, `-d`,
`-F`, `-R`, and `-r`; anything else is a usage error that exits `2`, emits no
stdout, and writes exactly `ls-lite: usage\n` to stderr. The default is the same
as `-1`. Every displayed list is sorted by Unicode code point ascending, never
locale collation, and `-r` reverses each already-sorted list independently.

Hidden names, operands, file types, and recursion interact as one contract:
directory listings normally omit names beginning with `.`, `-a` includes hidden
names plus synthetic `.` and `..`, `-A` includes hidden names but not synthetic
`.` or `..`, and explicit operands are displayed even if their names begin with
`.`. With `-F`, append `/` to directories, `@` to symbolic links, `*` to regular
files with any executable bit, and nothing to other regular files; classify
symbolic links with `lstat` and do not follow them for this indicator.

No operands means list the current working directory as though `.` had been
chosen, but with no directory header. A single regular-file or symlink operand
prints the operand path itself, with any `-F` suffix. A single directory operand
without `-d` and without `-R` prints only its entries, no header; with `-R` and
without `-d`, it prints an initial `<operand>:` header before those entries; with
`-d`, it prints the operand path itself with any suffix.

Multiple operands are sorted and partitioned at the same time: non-directory
operands, including symlinks, come before directory operands; each partition is
sorted by operand string, then reversed if `-r` is active. Print non-directory
operands one per line. Then print directory blocks. If any non-directory operand
was printed, place one blank line before the first directory block. Place one
blank line between directory blocks. A directory block is exactly:

```text
<operand>:
<entries>
```

When `-d` is present, there are no directory blocks; all operands are printed as
operand paths in sorted order, with `-r` applied after sorting and with `-F`
suffixes when requested.

Recursive `-R` only affects directory operands that are being listed as
directories; it is ignored for file operands and for `-d`. For each listed
recursive directory operand, print its headed normal listing, then recursively
print child directory blocks for child directories that are not `.` or `..`.
Each child block is
preceded by a blank line and a `<path>:` header. Child directories are traversed
in the same sorted order as displayed entries after removing `-F` suffixes.
Hidden child directories are traversed only when they are included by `-a` or
`-A`. Never recurse into symbolic links.

If an operand does not exist, print no listing for that operand, continue with
other operands, set the final exit status to `1`, and write exactly:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Every stdout entry and every stderr diagnostic ends with `\n`; empty output is
allowed. Do not print colors, permissions, owners, sizes, timestamps, inode
numbers, or totals.
