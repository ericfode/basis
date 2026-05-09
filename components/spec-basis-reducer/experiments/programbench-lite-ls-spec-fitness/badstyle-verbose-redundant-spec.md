# Bad Style Spec: Verbose Redundant `ls-lite`

The task is to produce a Node.js ES module command named `solution.mjs`. The
command is not a wrapper. It is not a shell script. It must not use external
packages. It must not use the host `ls` program. It must not use `find`. It must
not use a shell. It must not use `child_process` or any external program. It
must inspect the filesystem with Node APIs.

The invocation is always:

```sh
node solution.mjs [options] [file...]
```

The program lists files and directory contents. The display shape is one entry
per line. That means each printed entry is followed by a newline. The default
display shape is also one entry per line, so `-1` is supported but does not
change the shape.

The supported options are exactly `-1`, `-a`, `-A`, `-d`, `-F`, `-R`, and `-r`.
The same supported options may appear as grouped short options. For example,
`-aF` has the same meaning as `-a -F`. No other options are supported.
Unsupported options are usage errors. A usage error exits with status `2`,
prints no stdout, and writes exactly `ls-lite: usage\n` to stderr.

All ordinary lists are sorted. Sorting means Unicode code point ascending.
Sorting does not mean locale collation. Sorting does not mean platform default
directory order. After a list has been sorted, `-r` reverses that list. If there
are several independent lists, each list is reversed independently after sorting.

A hidden name is a name that begins with `.`. Without `-a` or `-A`, directory
listings do not include hidden names. With `-a`, directory listings include
hidden names and also synthetic entries `.` and `..`. With `-A`, directory
listings include hidden names but do not include synthetic `.` and `..`.
Explicit operands are different from directory entries: if the user explicitly
supplies a hidden operand, print it even though hidden names are normally hidden
inside directory listings.

The `-F` option adds type indicators. Directories receive `/`. Symbolic links
receive `@`. Regular files with any executable bit receive `*`. Other regular
files receive no suffix. Symbolic links are classified with `lstat`; do not
follow a symbolic link merely to choose its indicator.

If no file operands are supplied, list the current working directory. Treat this
like listing `.`, but do not print a directory header. If a single operand is a
regular file or a symbolic link, print the operand path itself, with any `-F`
indicator. If a single operand is a directory and both `-d` and `-R` are absent,
print its entries only and do not print a directory header. If a single operand
is a directory and `-R` is present while `-d` is absent, print the initial
directory as a headed directory block using `<operand>:` before its entries. If
a single operand is a directory and `-d` is present, print the operand path
itself, with any `-F` indicator.

Multiple operands have a particular order. First separate non-directory
operands, including symbolic links, from directory operands. Sort the
non-directory operands by operand string. Sort the directory operands by operand
string. If `-r` is present, reverse each partition after sorting. Print the
non-directory operands first, one per line. Then print directory operands as
directory blocks.

A directory block is a header line followed by entries:

```text
<operand>:
<entries>
```

If one or more non-directory operands were printed before the first directory
block, print a blank line before the first directory block. Print a blank line
between directory blocks. When `-d` is present, do not use directory blocks at
all. With `-d`, print all operands themselves in sorted order, reversed if `-r`
is present, and apply `-F` indicators if requested.

The `-R` option is recursive. It affects directory operands that are actually
being listed as directories. It does not affect file operands. It does not affect
anything when `-d` is present. For each listed recursive directory, first print
that directory's headed ordinary listing. Then print child directory blocks.
Each child directory block is preceded by a blank line and a `<path>:` header. Traverse
child directories in the same sorted order as displayed entries after removing
any `-F` suffix. Do not traverse `.` or `..`. Traverse hidden child directories
only when hidden child directories are included by `-a` or `-A`. Do not recurse
into symbolic links.

If an operand does not exist, do not print a listing for that operand. Continue
with other operands. The final exit status is `1` if any operand was missing.
For each missing operand, write exactly:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Every stderr diagnostic ends with a newline. Every stdout entry ends with a
newline. If there is nothing to print, stdout is empty. The program never prints
colors, permissions, owners, sizes, timestamps, inode numbers, or totals.
