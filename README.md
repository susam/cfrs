CFRS[]
======

CFRS[] (CFRS Brackets) is an extremely minimal drawing language that
consists of only six simple commands:

- `C`: Change colour.
- `F`: Move forward by one cell and paint the new cell.
- `R`: Rotate right (clockwise) by 45°.
- `S`: Sleep for 20 ms.
- `[`: Begin a repeatable block and continue executing subsequent code.
- `]`: Repeat current repeatable block once more and exit the block.

Note that `]` goes back to the beginning of the current repeatable
block, repeats it once more, and exits the block.  Thus a block
bounded by `[` and `]` behaves like a loop that runs twice before the
block exits.  See sections [Commands](#commands) and [Loops](#loops)
for more details about this.

[![Screenshot of CFRS Brackets Colour Bars][IMG0]][DEMO0]

**[See Demo][DEMO0]**

**[Draw Now][DRAW1]**


Contents
--------

* [Introduction](#introduction)
* [Implementation](#implementation)
* [Get Started](#get-started)
* [Demos](#demos)
* [Canvas](#canvas)
* [Turtle](#turtle)
* [Commands](#commands)
* [Loops](#loops)
* [Code Normalisation and Validation](#code-normalisation-and-validation)
* [Distributable Links](#distributable-links)
* [License](#license)
* [Support](#support)
* [More](#more)


Introduction
------------

CFRS[] is inspired by the educational programming language Logo and
the esoteric programming language P′′ (P double prime).  Inspired by
Logo, CFRS[] has a virtual turtle that moves around on a graphical
canvas and paints the canvas as it moves.  Inspired by P′′, it has an
extremely small set of commands.  CFRS[] is intentionally meant to be
hard to write in and hard to read.

This project introduces the CFRS[] language and provides a web-based
implementation using HTML5 Canvas and JavaScript.


Implementation
--------------

The current stable version of a CFRS[] implementation is available at
the following links:

* [susam.net/cfrs.html][DRAW1]
* [susam.github.io/cfrs.html][DRAW2]

A testing version with recent bug fixes is available here:

* [susam.github.io/cfrs/cfrs.html][DRAW3]

[DRAW1]: https://susam.net/cfrs.html
[DRAW2]: https://susam.github.io/cfrs.html
[DRAW3]: https://susam.github.io/cfrs/cfrs.html

[DEMO0]: https://susam.net/cfrs.html#0
[DEMO3]: https://susam.net/cfrs.html#3

[IMG0]: https://susam.github.io/blob/img/cfrs/cfrs-0.1.0-bars.png
[IMG3]: https://susam.github.io/blob/img/cfrs/cfrs-0.1.0-rings.png


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

The following code draws a vertical column of 64 cells:

```
[[[[[FF]]]]]
```

The following code draws a vertical column of 64 cells *gradually*.
The `S` command causes the execution to sleep for 20 ms in each
iteration of the innermost block.

```
[[[[[FFS]]]]]
```

The maximum code length supported is 256 bytes.


Demos
-----

The implementation in this project comes with a small collection of
demos.  Type any digit between `0` and `5` to see the corresponding
demo.  Typing a digit may require an external keyboard.  If there is
no external keyboard available, append `#` and a digit to the page URL
with an on-screen keyboard.  For example, the URL
<https://susam.net/cfrs.html#3> shows demo number 3.

[![Screenshot of CFRS Brackets Demo 3][IMG3]][DEMO3]

Here are direct links to demos currently available:
[#0](https://susam.net/cfrs.html#0),
[#1](https://susam.net/cfrs.html#1),
[#2](https://susam.net/cfrs.html#2),
[#3](https://susam.net/cfrs.html#3),
[#4](https://susam.net/cfrs.html#4), and
[#5](https://susam.net/cfrs.html#5).

If you have an interesting demo that fits in 64 bytes of code, please
[create an issue][ISSUES] and share it.  If the demo looks very
interesting, it may be included in the above list of available demos.


Canvas
------

The drawing canvas is divided into a grid of 256x256 cells.  There are
256 rows with 256 cells in each row.  Initially, all 65536 cells of
the canvas are painted black.

The rows are numbered 0, 1, 2, etc.  Similarly, the columns are
numbered 0, 1, 2, etc. too.  The cell at the top-left corner is at row
0 and column 0.  The cell at the bottom-right corner is at row 255 and
column 255.


Turtle
------

The CFRS[] commands are described in terms of the movement of an
invisible virtual turtle and changes in its properties.  The turtle
has three properties:

- Location: The cell where the turtle is currently situated.
- Heading: The direction for the turtle's next movement if it moves.
- Colour: The colour to be used for painting the next cell.

Its current location, heading, and colour are determined by its
initial properties and the preceding commands.  The initial properties
of the turtle are as follows:

- Location: Row 127 and column 127.
- Heading: North (up).
- Colour: White.


Commands
--------

This section describes all five commands of CFRS[] in detail.


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


### S

The `S` command makes the turtle sleep for 20 ms.  When the evaluator
encounters `S`, it pauses for 20 ms before resuming with the
evaluation of the remainder of the code.


### [

The `[` command marks the beginning of a repeatable block.  It does
not change the properties of the turtle.  This is a control flow
command that only introduces a new repeatable block without producing
any visual side effects.  Execution of the remaining code that comes
after `[` continues as usual.


### ]

The `]` command marks the end of a repeatable block.  When the
evaluator reads `]`, it jumps back to the beginning of the current
repeatable block, repeats it once more, and exits the block.  As a
result, when the code evaluator enters a block marked with `[`, the
block is executed twice before the evaluator leaves the end of the
block marked with `]`.


Loops
-----

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

The inner block executes `FFF` twice.  The outer block repeats the
inner block twice.  As a result, the inner block is repeated four
times and the turtle moves forward by 12 cells.

The following command moves the turtle 64 times *gradually*.  The
turtle sleeps for 20 ms after each movement.

```
[[[[[[FS]]]]]]
```


Code Normalisation and Validation
---------------------------------

The reference implementation performs the following two normalisation
steps (in the given order) on the input code before executing the
code:

- Lowercase letters are converted to uppercase.
- Any character in the input code that does not match a valid CFRS[]
  command is removed.

The reference implementation generates errors when the following conditions are met:

- A closing square bracket (`]`) is encountered that does not have a
  corresponding open square bracket (`[`).
- The length of the code exceeds 256 characters.

When an error is generated, the entire canvas is painted red and the
execution halts immediately.


Distributable Links
-------------------

The reference implementation provides distributable links when the
input code is 64 bytes or less in length.  Note that the
implementation allows code up to a maximum length of 256 bytes.
However, no distributable link is generated when the code length
exceeds 64 bytes.  Thus code that does not exceed 64 bytes in length
has a special status in the reference implementation.

The distributable link encodes the input code and appends it as a URL
fragment to the address of the current page.  Copy the URL with the
encoded input code embedded in it from the address bar of the web
browser in order to share it with others.  When the recipient of the
URL opens it with their web browser, the implementation reads the code
embedded in the URL, expands it, and executes it.


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

[ISSUES]: https://github.com/susam/cfrs/issues


More
----

See [Andromeda Invaders](https://github.com/susam/invaders), a
1980s-arcade-style game written using HTML5, Canvas, and Web Audio.

See [FXYT](https://github.com/susam/fxyt), a tiny canvas colouring
language with stack-based commands.

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
- Run: git tag $VERSION -m "CFRS[] $VERSION"
- Run: git push origin main $VERSION
-->
