# Suboptimal V2 Spec: `ls-lite`

Purpose: implement a small `ls` clone. It should feel like the familiar utility
people use to inspect files.

Create `solution.mjs`, a Node.js ES module CLI:

```sh
node solution.mjs [options] [file...]
```

Do not use external packages.

The output is intentionally simple: one visible name per line. There are no
permissions, owners, groups, byte sizes, timestamps, inode numbers, color codes,
or `total` lines.

The implementation should not call out to another command. It should inspect the
filesystem itself.

## Basic Examples

If a directory contains:

```text
Beta.txt
alpha.txt
dir
```

then listing it prints:

```text
Beta.txt
alpha.txt
dir
```

The order in examples is not locale order. Treat names as raw strings and sort
by their character code sequence. Reverse mode flips the displayed order.

If no path is supplied, act on the current directory. If a file path is supplied,
print the path. If a directory path is supplied, normally print its contents.

Directory operands can also be printed as themselves. That is what `-d` does.

## Options, In The Usual Short Form

These short options are in scope: `-1`, `-a`, `-A`, `-d`, `-F`, `-R`, and `-r`.
Grouped options such as `-aF` are still just the same options.

`-1` means one entry per line. It is also the only output layout this task uses.

`-r` reverses sorted output. It does not change what is included.

`-a` is the "all" form. It includes hidden names. When listing a directory it
also includes the conventional `.` and `..` entries.

`-A` is almost the same, but does not include those two conventional entries.

Explicit operands should be printed even when their names start with `.`.

## File Type Marks

When `-F` is present:

- directories visibly end in `/`
- symbolic links visibly end in `@`
- executable regular files visibly end in `*`
- ordinary files have no mark

Symbolic links should be classified as links, not followed first.

## Several Operands

Several operands are allowed. Files are shown before directory contents. Directory
contents should have headers when headers are needed to keep the output readable.
Use the operand text as the header.

Example:

```text
file.txt

src:
main.js
```

Separate directory blocks with a blank line. If files came first, separate the
first directory block from those files with a blank line.

When `-d` is active, this block behavior is not needed because directories are
shown as operands.

## Recursion

`-R` lists subdirectories after the current directory. A child block uses its path
as the header.

Do not recurse into symbolic links.

The dot entries are never recursion targets. Hidden child directories are only
recursion targets when hidden entries are being displayed.

For a directory operand, recursive output starts with a header for that operand.

Example:

```text
src:
main.js
sub

src/sub:
leaf.js
```

## Diagnostics

If a requested operand does not exist, keep going with the other operands, but
return a failing status at the end. The diagnostic text is:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Bad options are usage errors. They print:

```text
ls-lite: usage
```

Missing-file failures use exit status `1`. Usage failures use exit status `2`.
