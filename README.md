CFR[]
=====

CFR[] (CFR Brackets) is an extremely minimal drawing language that
consists of only five simple commands:

- `C`: Change colour.
- `F`: Move forward by one cell and paint the new cell.
- `R`: Rotate right (clockwise) by 45°.
- `[`: Begin a repeatable block and continue executing subsequent code.
- `]`: Repeat current repeatable block once more and exit the block.

Note that `]` goes back to the beginning of the current repeatable
block, repeats it once more, and exits the block.  Thus a block
bounded by `[` and `]` behaves like a loop that runs twice before the
block exits.

CFR[] is a strict subset of CFRS[].  CFRS[] has an additional command
named `S` which can be used to make the turtle sleep for a short
duration.  CFR[] does not have the `S` command.  This is the only
difference between CFR[] and CFRS[].  Therefore, for a complete
description of CFR[], see [CFRS[]](https://github.com/susam/cfrs)
instead but disregard any information pertaining to the `S` command.

To play with CFR[], go to
[susam.net/cfr.html](https://susam.net/cfr.html).

To play with CFRS[], go to
[susam.net/cfrs.html](https://susam.net/cfrs.html).

<!--
Release Checklist
-----------------

- Update version in package.json.
- Update version in HTML (1 place).
- Update copyright in HTML (1 place).
- Update copyright in LICENSE.md.
- Disable logging.
- Update CHANGES.md.
- Run: npm run lint
- Run: git status; git add -p
- Run: VERSION=<VERSION>
- Run: git commit -em "Set version to $VERSION"
- Run: git tag $VERSION -m "CFR[] $VERSION"
- Run: git push origin main $VERSION
-->
