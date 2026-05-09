# Bad Spec: `ls-lite`

Purpose: rebuild a small version of the Unix `ls` command.

Create a Node.js ES module CLI named `solution.mjs`. It will be invoked as:

```sh
node solution.mjs [options] [file...]
```

The program should list files and directories in a normal `ls`-like way.

It should support common options such as showing hidden files, listing
directories themselves, adding file-type indicators, recursive listing, reverse
order, and one-entry-per-line output.

It should handle multiple paths, missing files, symlinks, executables, and
reasonable errors. Try to make it predictable and close to familiar Unix `ls`
behavior.

Do not use external packages.
