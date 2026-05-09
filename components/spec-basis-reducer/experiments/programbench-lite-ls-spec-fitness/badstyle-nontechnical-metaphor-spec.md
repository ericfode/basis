# Bad Style Spec: Non-Technical Metaphor `ls-lite`

Make a small file-cabinet narrator called `solution.mjs`. It is run with:

```sh
node solution.mjs [options] [file...]
```

The narrator opens drawers, names what is inside, and writes one name per line.
It must do the work itself with Node filesystem APIs. It must not ask the real
`ls`, `find`, a shell, `child_process`, or any external program to do the job,
and it must not use external packages.

The supported knobs are `-1`, `-a`, `-A`, `-d`, `-F`, `-R`, and `-r`. Knobs may
be stuck together, so `-aF` is the same as `-a -F`. `-1` is the ordinary voice:
one thing per line. Unknown knobs are not tolerated; they exit `2`, say nothing
on stdout, and write `ls-lite: usage\n` to stderr.

Names are placed in a plain dictionary order that is not local or cultural:
Unicode code point ascending. If `-r` is present, flip each already-arranged
row.

Small private labels begin with `.`. A drawer listing normally hides private
labels. With `-a`, show private labels and also show the pretend entries `.`
and `..`. With `-A`, show private labels but not those two pretend entries.
When a user points directly at a private item, still show it.

When `-F` is used, put a badge after names: `/` after drawers/directories, `@`
after symbolic links, `*` after regular files that have any executable bit, and
nothing after ordinary regular files. Use `lstat` so a symbolic link is badged
as the link itself.

If the user points at nothing, open the current drawer and list its contents
without a heading. If the user points at one ordinary file or symbolic link,
print the pointed-at path itself. If the user points at one directory, open it
and list its contents with no heading only when `-R` and `-d` are both absent.
With `-R`, the first opened directory also gets a `<path>:` heading. With `-d`,
print the directory path itself.

When the user points at several things, first sort the pointed-at strings and
then keep files and symbolic links before directories. Reverse each group if
`-r` is present. Print the file/link paths first. Then print each directory as a
headed drawer:

```text
<path>:
<entries>
```

If file/link paths were printed before the first headed drawer, leave one blank
line before that first drawer. Leave one blank line between headed drawers. If
`-d` is present, do not open drawers at all; just print every pointed-at path in
sorted order, reversed when `-r` asks, with badges when `-F` asks.

With `-R`, a directory that is being opened keeps opening child directories
after its own headed listing. Each child drawer gets a blank line and a
`<path>:` heading. Visit child directories in the same sorted order as the displayed
entries, ignoring any badge suffix. Do not descend into `.` or `..`. Private
child directories are visited only when `-a` or `-A` made them visible. Symbolic
links are never opened recursively.

If a pointed-at path is missing, skip its listing, continue with later paths,
exit finally with status `1`, and write exactly:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Use the original missing operand text in the quoted place.

Every stdout item and stderr message ends with `\n`; printing nothing is allowed.
Do not add colors, permissions, owners, sizes, timestamps, inode numbers, or
totals.
