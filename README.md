# Exercise Sheet Class

This repository contains LaTeX styles and document classes I use to write mathy things. In particular, there are:
 - `math/bsteffan-math.sty` providing the package `bsteffan-math` which contains many math definitions and aliases and loads most of the relevant packages. It is designed to be used with `unicode-math`.
 - `sheet/bsteffan-exsheet.cls` providing the class `bsteffan-exsheet` which I use to typeset solutions to exercise sheets as they are commonly given in math classes.
 - `sheet/bsteffan-sheetthms.sty` providing the package `bsteffan-sheetthms` which contains theorem and proof environment definitions as I commonly use them on exercise sheets.
 - `sheet/bsteffan-sheetdiagrams.sty` providing the package `bsteffan-sheetdiagrams` containing `tikz` setup for exercise sheet solutions.

## Building / Using
The envisaged use case is to add this as a subrepo to whatever document you're writing, run `make` and then make sure that the resulting `build` directory is in the `TEXINPUTS` path of the main project.
