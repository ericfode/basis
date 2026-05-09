# Bad Style Spec: Cross-Reference Maze `ls-lite`

Implement the command described by this document as `solution.mjs`, an ES module
CLI invoked by `node solution.mjs [options] [file...]`. The implementation must
use Node filesystem APIs directly and must not use external packages, external
commands, shells, `child_process`, `ls`, or `find`.

## 1. Vocabulary

1.1. A "target" means an operand path supplied after options.

1.2. A "shown item" means one stdout line before its trailing newline.

1.3. A "directory view" means the sorted contents of a directory after applying
the visibility rule in section 3 and suffix rule in section 4.

1.4. A hidden name begins with `.`.

## 2. Option Contract

2.1. Supported options are `-1`, `-a`, `-A`, `-d`, `-F`, `-R`, and `-r`.

2.2. Short options may be grouped. See 2.1 for the option set.

2.3. `-1` is the default display shape.

2.4. Any unsupported option follows 8.2.

## 3. Visibility

3.1. Directory views omit hidden names unless 3.2 or 3.3 applies.

3.2. With `-a`, directory views include hidden names and synthetic `.` and `..`.

3.3. With `-A`, directory views include hidden names but not synthetic `.` or
`..`.

3.4. Section 3 does not filter explicit targets. Explicit targets are printed
even when hidden.

## 4. Suffixes

4.1. Section 4 applies only when `-F` is selected.

4.2. Append `/` for directories.

4.3. Append `@` for symbolic links.

4.4. Append `*` for regular files with any executable bit set.

4.5. Other regular files have no suffix.

4.6. Symbolic links are classified with `lstat` and are not followed for suffix
selection.

## 5. Ordering

5.1. Sort names and target strings by Unicode code point ascending.

5.2. Do not use locale collation.

5.3. If `-r` is selected, reverse each list after 5.1.

5.4. Multiple-target partition ordering is specified in 7.4 and 7.5.

## 6. No Target And Single Target

6.1. If there are no targets, list the current working directory as a directory
view and do not print a header.

6.2. A single file or symbolic-link target prints the target string itself, plus
the suffix from section 4 if applicable.

6.3. A single directory target without `-d` and without `-R` prints only the
directory view and does not print a header.

6.3a. A single directory target without `-d` and with `-R` prints an initial
`<target>:` header before its directory view, then follows section 9.

6.4. A single directory target with `-d` follows 7.6.

## 7. Multiple Targets

7.1. Non-directory targets include regular files and symbolic links.

7.2. Directory targets are directories after `lstat` classification.

7.3. If `-d` is selected, do not partition into directory blocks; follow 7.6.

7.4. Without `-d`, sort non-directory targets by target string, apply 5.3, and
print them before directories.

7.5. Without `-d`, sort directory targets by target string, apply 5.3, and print
each as a block:

```text
<target>:
<entries>
```

7.6. With `-d`, all targets are printed as target strings in sorted order, with
5.3 and section 4 applied.

7.7. If a non-directory target was printed before the first directory block,
print a blank line before that first block.

7.8. Print a blank line between directory blocks.

## 8. Errors

8.1. A missing target prints no listing for that target, does not stop later
targets, sets final exit status to `1`, and writes exactly:

```text
ls-lite: cannot access '<operand>': No such file or directory
```

Use the original operand text in place of `<operand>`.

8.2. A usage error exits `2`, writes no stdout, and writes exactly
`ls-lite: usage\n`.

## 9. Recursive Rule

9.1. `-R` applies only to directory targets being listed as directories.

9.2. `-R` is ignored for file targets and for `-d`.

9.3. For each listed recursive target directory, print its header and normal
directory view, then child directory blocks.

9.4. Each child directory block is preceded by a blank line and a `<path>:`
header.

9.5. Child directories are traversed in the same sorted order as displayed
entries, after removing suffixes from section 4.

9.6. Child directories named `.` or `..` are never traversed.

9.7. Hidden child directories are traversed only when included by 3.2 or 3.3.

9.8. Symbolic links are never recursive descent targets.

## 10. Output Boundary

10.1. Every stdout entry ends with `\n`.

10.2. Every stderr diagnostic ends with `\n`.

10.3. Empty stdout is valid.

10.4. Do not print colors, permissions, owners, sizes, timestamps, inode numbers,
or totals.
