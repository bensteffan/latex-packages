# LaTeX Classes and Packages

This repository contains LaTeX styles and document classes I use to write mathy things. In particular, there are:
 - `math/bsteffan-math.sty` providing the package `bsteffan-math` which contains many math definitions and aliases and loads most of the relevant packages. It is designed to be used with `unicode-math`.
 - `sheet/bsteffan-exsheet.cls` providing the class `bsteffan-exsheet` which I use to typeset solutions to exercise sheets as they are commonly given in math classes.
 - `sheet/bsteffan-sheetthms.sty` providing the package `bsteffan-sheetthms` which contains theorem and proof environment definitions as I commonly use them on exercise sheets.
 - `sheet/bsteffan-sheetdiagrams.sty` providing the package `bsteffan-sheetdiagrams` containing `tikz` setup for exercise sheet solutions.
 - `exam/bsteffan-examsol.cls` providing the class `bsteffan-examsol` which I use to typeset solutions to exams.
 - `exam/bsteffan-examthms.cls` providing the package `bsteffan-examthms` which contains theorems and proof environment definitions as I use them for exam solutions.
 - `breakout/bsteffan-mathbreakout.cls` providing the class `bsteffan-mathbreakout` containing setup for standalone math breakouts.
 - `breakout/bsteffan-breakoutthms.sty` providing the package `bsteffan-breakoutthms` containing theorem and proof environments for `bsteffan-mathbreakout`.
 - `notes/bsteffan-lecturenotes.cls` providing the class `bsteffan-lecturenotes` which I use to typeset lecture notes.

## Building / Using
If you want to use this, download it locally (as a subrepo, say) and drop it into whatevery project you are working on, ensuring that that directory is among the project's `TEXINPUTS`.

However, since these classes are tailored to my specific needs, highly unstable (i.e. most commited changes are breaking changes in one way or another), and at times idiosyncratic I recommend taking whatever bits and pieces are useful to you and dropping them in your own classes or packages.

## License
This project is licensed under the MIT license.
