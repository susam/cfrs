CFR[]
=====

CFR[] (CFR Brackets) is an extremely minimal drawing language that
conists of only five simple commands:

- `C`: Colour change.
- `F`: Forward move by one cell.
- `R`: Rotate right (clockwise) by 1/8th of a full turn.
- `[`: Begin block.
- `]`: Repeat current block.

[![Screenshot of CFR Brackets Colour Bars][IMG0]][DEMO0]

**[See Demo][DEMO0]**

**[Draw Now][DRAW1]**


Contents
--------

* [Introduction](#introduction)
* [Implementation](#implementation)
* [Get Started](#get-started)
* [Demos](#demos)
* [Canvas](#canvas)
* [Invisible Virtual Turtle](#invisible-virtual-turtle)
* [Commands](#commands)
* [Repeatable Block Examples](#repeatable-block-examples)
* [Code Normalisation and Validation](#code-normalisation-and-validation)
* [Out of Scope](#out-of-scope)
* [License](#license)
* [Support](#support)
* [More](#more)


Introduction
------------

CFR[] is inspired by the educational programming language Logo and the
esoteric programming language P′′ (P double prime).  Inspired by Logo,
CFR[] has a virtual turtle that moves around on a graphical canvas and
paints the canvas as it moves.  Inspired by P′′, it has an extremely
small set of commands.  CFR[] is intentionally meant to be hard to
write in and hard to read.

This project introduces the CFR[] language and provides a web-based
implementation using HTML5 Canvas and JavaScript.


Implementation
--------------

The current stable version of a CFR[] implementation is available at
the following links:

* [susam.net/cfr.html][DRAW1]
* [susam.github.io/cfr.html][DRAW2]

A testing version with recent bug fixes is available here:

* [susam.github.io/cfr/cfr.html][DRAW3]

[DRAW1]: https://susam.net/cfr.html
[DRAW2]: https://susam.github.io/cfr.html
[DRAW3]: https://susam.github.io/cfr/cfr.html

[DEMO0]: https://susam.net/cfr.html#0
[DEMO3]: https://susam.net/cfr.html#3

[IMG0]: https://susam.github.io/blob/img/cfr/cfr-demo0-0.1.0.png
[IMG3]: https://susam.github.io/blob/img/cfr/cfr-demo3-0.1.0.png


Get Started
-----------

Enter the following code in the input field to draw a vertical column
consisting of 16 cells:

```
FFFFFFFFFFFFFFFF
```

However, using the block commands, this can be shortened to the
following code:

```
[[[FF]]]
```

Here is a slightly more involved code that draws a colourful octagon
where each side of the octagon consists of 16 cells.

```
[[[[[[[FF]]]]RCC]]]
```

The maximum code length supported is 256 bytes.


Demos
-----

The implementation in this project comes with a small collection of
demos.  Type any digit between `0` and `7` to see the corresponding
demo.  Typing a digit may require an external keyboard.  If there is
no external keyboard available, append `#` and a digit to the page URL
with an on-screen keyboard.  For example, the URL
<https://susam.net/cfr.html#3> shows demo number 3.

[![Screenshot of CFR Brackets Demo 3][IMG3]][DEMO3]

Here are direct links to demos currently available:
[#0](https://susam.net/cfr.html#0),
[#1](https://susam.net/cfr.html#1),
[#2](https://susam.net/cfr.html#2),
[#3](https://susam.net/cfr.html#3),
[#4](https://susam.net/cfr.html#4),
[#5](https://susam.net/cfr.html#5),
[#6](https://susam.net/cfr.html#6), and
[#7](https://susam.net/cfr.html#7).

If you have an interesting demo that fits in 64 bytes of code, please
[create an issue][ISSUES] and share it.  If the demo looks very
interesting, it may be included to the above list of available demos.


Canvas
------

The drawing canvas is divided into a grid of 256x256 cells.  There are
256 rows with 256 cells in each row.  Initially, all 65536 cells of
the canvas are painted black.

The rows are numbered 0, 1, 2, etc.  Similarly, the columns are
numbered 0, 1, 2, etc. too.  The cell at the top-left corner is at row
0 and column 0.  The cell at the bottom-right corner is at row 255 and
column 255.


Invisible Virtual Turtle
------------------------

The CFR[] commands are described in terms of movement of a virtual
turtle and changes in its properties.  The virtual turtle is always
invisible.  It has three properties:

- Location: The cell where the turtle is currently situated.
- Heading: The direction for the turtle's next movement if it moves.
- Colour: The colour to be used for painting the next cell.

The current location, heading, and colour of the turtle are determined
by the initial properties and the preceding commands.  The initial
properties of the turtle are as follows:

- Location: Row 127 and column 127.
- Heading: North (up).
- Colour: White.


Commands
--------

This section describes all five commands of CFR[] in detail.


### C

The `C` command changes the colour used to paint the next cell.  A
total of 8 colours are supported.  They are:

- Black
- Blue
- Green
- Cyan
- Red
- Magenta
- Yellow
- White

The initial colour is white.  Each `C` command changes the drawing
colour to the next one in the above list.  When the current drawing
colour is white, `C` changes the drawing colour to black, i.e., the
drawing colour *wraps around* to black.

The following code draws four cells in white (the initial colour),
then four cells in black, and finally four cells in blue.

```
FFFFCFFFFCFFFF
```

The first `C` in the code above changes the drawing colour from white
to black.  The second `C` changes it from black to blue.  Note that
the canvas background is black in colour, so the four cells drawn in
black are going to be invisible on the black background.


### F

The `F` command moves the virtual turtle forward by one cell and
paints the cell it moves to with the current drawing colour.  The
direction of movement is determined by the current heading of the
turtle.  Each `F` command moves the turtle by exactly one cell and
paints the entire cell it has moved to.  This is true for diagonal
movements too.  For example, if the turtle moves in the northeast
direction, it moves from the current cell diagonally to the next cell
that is touching the top-right corner of the current cell.  It then
paints that new cell it has moved to.

When the turtle is at the edge of the canvas and the next command
moves the turtle beyond the edge, the turtle simply wraps around to
the opposite edge of the canvas, i.e., the turtle reenters the canvas
from the opposite edge.


### R

The `R` command changes the heading of the turtle by rotating it by
1/8th of a complete turn.  The initial heading is north (up).  The
following command rotates the turtle three times so that its heading
changes to southeast and then paints 4 cells diagonally:

```
RRRFFFF
```


### [

The `[` command marks the beginning of a repeatable block.  It does
not change the properties of the turtle.  This is a control flow
command that only introduces a new repeatable block without producing
any visual side effects.


### ]

The `]` command marks the end of the current repeatable block and
repeats that block exactly once.  As a result, when the code evaluator
enters a block marked with `[`, the block is executed twice before the
evaluator leaves the end of the block marked with `]`.


Repeatable Block Examples
-------------------------

The following code moves the turtle twice and then rotates it once:

```
[F]R
```

The opening square bracket (`[`) marks the beginning of a block.  Then
`F` is executed as usual thereby moving the turtle forward once.  Then
the closing square bracket (`]`) repeats the current block thereby
executing the `F` inside the block once more.  Finally the evaluator
moves ahead to `R` and rotates the turtle once.  Note that the
evaluator leaves a block after the block has been repeated twice.

The following code moves the turtle 6 times:

```
[FFF]
```

The following command moves the turtle 12 times.

```
[[FFF]]
```

The inner block executes `FFF` twice.  The outer block repeats the
inner block twice.  As a result, the inner block is repeated four
times and the turtle moves forward by 12 cells.


Code Normalisation and Validation
---------------------------------

The reference implementation performs the following two normalisation
steps (in the given order) on the input code before executing the
code:

- Lowercase letters are converted to uppercase.
- Any character in the input code that does not match a valid CFR[]
  command is removed.

The reference implementation generates errors when the following conditions are met:

- A closing square bracket (`]`) is encountered that does not have a
  corresponding open square bracket (`[`).
- The length of the code exceeds 256 characters.

When an error is generated, the entire canvas is painted red and the
execution halts immediately.


Out of Scope
------------

This web-based implementation of CFR[] is not going to support
rendering arbitrary CFR[] code embedded in the URL, say, as a fragment
identifier.  Such features often lead to misuse.  A possible misuse
could be someone sending direct links to this implementation with
cleverly crafted code embedded in the link such that it draws an
offensive or illegitimate text or picture on the canvas.  Such an
image appearing on the web browsers of unsuspecting users simply by
clicking a link to this implementation could lead to regulatory
issues.  That is why rendering of arbitrary code embedded in URLs is
never going to be supported.  See the post [Against URL-Based Content
Rendering][rendering-post] for more thoughts about this.

Only a curated list of demos can be linked to directly.  See section
[Demos](#demos) for more details about it.

[rendering-post]: https://susam.net/maze/against-url-based-content-rendering.html


License
-------

This is free and open source software.  You can use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of it,
under the terms of the MIT License.  See [LICENSE.md][L] for details.

This software is provided "AS IS", WITHOUT WARRANTY OF ANY KIND,
express or implied. See [LICENSE.md][L] for details.

[L]: LICENSE.md


Support
-------

To report bugs or ask questions, [create issues][ISSUES].

[ISSUES]: https://github.com/susam/cfr/issues


More
----

See [Andromeda Invaders](https://github.com/susam/invaders), a
1980s-arcade-style game written using HTML5, Canvas, and Web Audio.

See [PC Face](https://github.com/susam/pcface), a collection of bitmap
arrays for rendering CP437 glyphs using IBM PC OEM fonts.

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
- Run: git tag $VERSION -m "CFR Brackets $VERSION"
- Run: git push origin main $VERSION
- Create a new release on GitHub.
-->
