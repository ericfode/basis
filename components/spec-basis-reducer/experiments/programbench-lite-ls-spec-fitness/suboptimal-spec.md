# Suboptimal Spec: `ls-lite`

Purpose: implement a small, portable subset of `ls`.

This spec is technically correct but intentionally relies on familiar `ls`
conventions instead of spelling out every behavior.

Create a Node.js ES module CLI named `solution.mjs`. It is invoked as:

```sh
node solution.mjs [options] [file...]
```

Do not use external packages.

The program lists directory contents. If no path is supplied, list the current
directory. If a path names a file, list that file. If a path names a directory,
list the directory's contents unless directory-as-file mode is requested.

Support these options:

- `-1`: print one entry per line
- `-a`: include hidden entries, including the conventional dot entries
- `-A`: include hidden entries except the conventional dot entries
- `-d`: show directory operands themselves
- `-F`: append conventional file-type suffixes
- `-R`: recursively list subdirectories
- `-r`: reverse sort order

Option groups such as `-aF` should work.

Names should be sorted in a deterministic alphabetic order. Hidden files are
normally omitted unless requested. Explicit hidden operands should still be
shown. Multiple operands should be handled in the usual `ls` style, with files
before directory listings and readable directory headers when needed.

For `-F`, directories should be visibly marked, executables should be marked,
and symlinks should be marked. Do not follow symlinks when deciding the marker.

For recursive output, show each directory and then its subdirectories. Avoid
recursing into symlinks.

Missing files should produce a diagnostic and a non-zero exit status, but should
not prevent other valid operands from being listed. Invalid options should be
usage errors.

Output should be plain text, without colors, permissions, owners, sizes,
timestamps, inode numbers, or totals.
