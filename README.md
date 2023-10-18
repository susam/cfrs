CFR[]
=====

CFR[] (CFR Brackets) is an extremely minimal drawing language that
conists of only five simple commands:

- `C`: Colour change.
- `F`: Forward move by one cell.
- `R`: Rotate right (clockwise) by 1/8th of a turn.
- `[`: Begin block.
- `]`: Repeat current block.

**[See Demo][DEMO0]**

**[Draw Now][DRAW1]**


Contents
--------

* [Introduction](#introduction)
* [Draw](#draw)
* [Get Started](#get-started)
* [Demos](#demos)
* [Commands](#commands)
* [Out of Scope](#out-of-scope)
* [License](#license)
* [Support](#support)
* [More](#more)


Introduction
------------

CFR[] is inspired by the educational programming language Logo and the
esoteric programming language P′′ (P double prime).  Inspired by Logo,
CFR[] has a virtual turtle that moves around on a canvas of 256x256
cells and paints the cells on which it moves.  Inspired by P′′, it has
an extremely limited set of commands.  CFR[] is intentionally meant to
be hard to write in and hard to read.

This project introduces the CFR[] language and provides a web-based
implementation using HTML5 Canvas and JavaScript.


Draw
----

The current stable version of a CFR[] implementation is available at
the following links:

* [susam.net/cfr.html][DRAW1]
* [susam.github.io/cfr.html][DRAW2]

A testing version with recent bug fixes is available here:

* [susam.github.io/cfr/cfr.html][DRAW3]

[DEMO0]: https://susam.net/cfr.html#0
[DRAW1]: https://susam.net/cfr.html
[DRAW2]: https://susam.github.io/cfr.html
[DRAW3]: https://susam.github.io/cfr/cfr.html


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
demos.  Type any digit between `0` and `7` to see a corresponding
demo.  Typing a digit may require an external keyboard.  If there is
no external keyboard available, append `#` and an integer to the page
URL with an on-screen keyboard.  For example, the URL
<https://susam.net/cfr.html#3> shows demo number 3.

Here are direct links to demos currently available:
[#0](https://susam.net/cfr.html#0),
[#1](https://susam.net/cfr.html#1),
[#2](https://susam.net/cfr.html#2),
[#3](https://susam.net/cfr.html#3),
[#4](https://susam.net/cfr.html#4),
[#5](https://susam.net/cfr.html#5),
[#6](https://susam.net/cfr.html#6),
[#7](https://susam.net/cfr.html#7).

If you have an interesting demos that fit in 64 bytes of code, please
[create issues][ISSUES] and share them.  If the demo looks remarkable,
it may be included to the above list of available demos.


Commands
--------

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

The initial colour is always white.  Each `C` command changes the
drawing colour to the next one in the above list.  When the current
drawing colour is white, `C` changes the drawing colour to black,
i.e., the drawing colour *wraps around* to black.

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
paints the cell it moves to with the current drawing colour.

The virtual turtle is invisible.  Its current position and heading
(direction of movement) is determined by the preceding commands.

The drawing canvas is divided into a grid of 256x256 cells.  Number
the rows of cells on the canvas 0, 1, 2, etc. and we similarly number
the columns of cells 0, 1, 2, etc., so that the cell at the
bottom-right corner is at row 255 and column 255.  Then the initial
position of the turtle is 127, 127.  If we enter `F` as the very first
command, the turtle moves up by one cell and paints the cell at row
126 and column 127.

The initial heading is north (up).  The heading can be altered with
the `R` command explained in the next section.

Each `F` command moves the turtle by one cell only.  This is true for
diagonal movements too.  For example, if the turtle moves in the
northeast direction, it moves from the current cell diagonally to the
next cell at the top-right corner of the current cell and then paints
that cell with the current drawing colour.  Since the `F` command
always moves the turtle by a whole cell vertically, horizontally, or
diagonally, when we draw "lines" by repeating the `F` command, a
diagonal line consisting of a certain number of cells is going to look
longer than a vertical or horizontal line with the same number of
cells.

When the turtle is at the edge of a canvas and the next command moves
the turtle beyond the edge of the canvas, the turtle simply wraps
around to the opposite edge of the canvas, i.e., the turtle reenters
the canvas from the opposite edge.


### R

The `R` command changes the heading of the turtle by rotating it by
1/8th of a complete turn.  The initial heading is north (up).  The
following command rotates the turtle three times so that its heading
is southeast and then paints 4 cells diagonally:

```
RRRFFFF
```


### [

The `[` command begins a repeatable block.


### ]

The `]` command repeats the current repeatable block once.  As a
result, when the code evaluator enters a block marked with `[`, the
block is executed twice before the evaluator leaves the end of the
block marked with `]`.

For example, the following code moves the turtle twice and then
rotates it once:

```
[F]R
```

The opening square bracket (`[`) marks the beginning of a block.  Then
`F` is executed as usual thus moving the turtle forward once.  Then
the closing square bracket (`]`) repeats the current block thereby
executing the `F` inside the block once more.  Finally the evaluator
moves ahead to `R` and rotates the turtle once.  Note that the
evaluator leaves a block after the block has been repeated twice.

The following command moves the turtle 6 times.

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


Out of Scope
------------

This web-based implementation of CFR[] is not going to support
rendering complete CFR[] code embedded in the URL, say, as a fragment
identifier.  Such features often leads to misuse.  A possible misuse
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
- Run: git tag $VERSION -m "CFR $VERSION"
- Run: git push origin main $VERSION
- Create a new release on GitHub.
-->

<!--
[[[[[[[[[[[[[[[[F]]]]]]]]RFRRRRRRR]]]]]C]]]
-->
