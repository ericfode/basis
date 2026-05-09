# Good Spec: `ls-lite`

Purpose: rebuild a bounded, deterministic subset of the Unix `ls` command.

Background: `ls` is a widely implemented utility whose stable purpose is to list
directory contents and file operands. This task uses a POSIX-like subset with
fully specified output so it can be tested portably.

You may run the host `ls` command for intuition, but your implementation MUST
NOT delegate to `ls`, `find`, shell commands, `child_process`, or any external
program. Use Node.js filesystem APIs directly.

Create a Node.js ES module CLI named `solution.mjs`. It will be invoked as:

```sh
node solution.mjs [options] [file...]
```

No external packages are allowed.

## Options

Supported options:

- `-1`: one entry per line. This is also the default.
- `-a`: include hidden names and include synthetic `.` and `..` entries for
  directory listings.
- `-A`: include hidden names but exclude synthetic `.` and `..`.
- `-d`: list directory operands themselves instead of their contents.
- `-F`: append file-type indicators.
- `-R`: recursively list subdirectories.
- `-r`: reverse each sorted list.

Short options may be grouped. `-aF` is equivalent to `-a -F`.

Unsupported options are usage errors.

## Sorting

Sort names by Unicode code point ascending. Do not use locale collation.

When `-r` is present, reverse each sorted list after sorting.

## Hidden Names

A hidden name begins with `.`.

By default, directory listings omit hidden names.

With `-a`, directory listings include `.` and `..` plus hidden names.

With `-A`, directory listings include hidden names but not `.` or `..`.

Explicit operands are always listed even if they begin with `.`.

## File-Type Indicators For `-F`

Append:

- `/` for directories
- `@` for symbolic links
- `*` for regular files with any executable bit set
- no suffix for other regular files

Use `lstat` to classify symbolic links. Do not follow symlinks for the indicator.

## No Operands

If no file operands are supplied, list the current working directory as if `.` had
been supplied, but do not print a directory header.

## Single Operand

If the operand names a regular file or symlink, print the operand path itself,
with any `-F` indicator.

If the operand names a directory:

- without `-d`, print that directory's entries, one per line
- with `-d`, print the operand path itself, with any `-F` indicator

Do not print a directory header for a single non-recursive directory operand.

## Multiple Operands

Partition operands into:

1. non-directory operands, including symlinks
2. directory operands

Within each partition, sort by operand string. Apply `-r` independently to each
partition.

Print non-directory operands first, one per line.

Then print each directory operand. If any non-directory operand was printed
before a directory, print a blank line before the first directory block. Print a
blank line between directory blocks.

Each directory block has this form:

```text
<operand>:
<entries>
```

When `-d` is present, do not create directory blocks; all operands are printed as
operand paths in sorted order.

## Recursive `-R`

Recursive listing applies only to directory operands that are being listed as
directories. It is ignored for file operands and for `-d`.

For each listed directory:

1. print that directory's normal listing
2. recursively list child directories that are not `.` or `..`
3. child directory blocks are preceded by a blank line and a header:

```text
<path>:
<entries>
```

Child directories are traversed in the same sorted order as displayed entries,
after removing `-F` suffixes.

Hidden child directories are traversed only when they are included by `-a` or
`-A`.

Do not recurse into symbolic links.

## Errors

If any operand does not exist:

- write no listing for that operand
- set final exit status to `1`
- write this diagnostic to stderr:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Continue processing other operands.

Usage errors exit `2`, write no stdout, and write:

```text
ls-lite: usage
```

## Output Rules

- stdout entries end with `\n`.
- stderr diagnostics end with `\n`.
- If there is nothing to print, stdout is empty.
- Do not colorize output.
- Do not print permissions, owners, sizes, timestamps, inode numbers, or totals.
