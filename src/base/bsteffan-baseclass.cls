\def\filedate{2025/02/27}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-baseclass}[\filedate\space Version \fileversion\space by Ben Steffan]

\RequirePackage{etoolbox}
\RequirePackage{xkeyval}

\newcommand{\bstf@class}{}

\newtoggle{bstf@base@english}
\toggletrue{bstf@base@english}

\newtoggle{bstf@base@topology}
\newtoggle{bstf@base@algebra}

\newtoggle{bstf@base@index}
\newtoggle{bstf@base@listofsymbols}

\DeclareOptionX{class}[scrartcl]{\renewcommand{\bstf@class}{#1}}
\ExecuteOptionsX{class = scrartcl}

\DeclareOptionX{german}{\togglefalse{bstf@base@english}}
\DeclareOptionX{english}{\toggletrue{bstf@base@english}}

\DeclareOptionX{topology}{\toggletrue{bstf@base@topology}}
\DeclareOptionX{algebra}{\toggletrue{bstf@base@algebra}}

\DeclareOptionX{index}{\toggletrue{bstf@base@index}}
\DeclareOptionX{listofsymbols}{\toggletrue{bstf@base@listofsymbols}}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{\bstf@class}}
\ProcessOptionsX\relax

\ifstrempty{\bstf@class}{%
	\ClassError{bsteffan-baseclass}{No class specified.}
}{}

\newcommand{\bstf@base@langstring}{\iftoggle{bstf@base@english}{english}{german}}

\LoadClass{\bstf@class}

\KOMAoptions{
	toc = bibliography, % bibliography listed as ToC item
	index = totoc, % index listed as ToC item
	fontsize = 12pt,
	BCOR = 0pt, % not intended for printing, so no binding correction
	DIV = calc, % set this to calc so we can recalculate it after loading the fonts
}

\RequirePackage{polyglossia}
\setdefaultlanguage{\bstf@base@langstring}
\setmainlanguage{\bstf@base@langstring}

\RequirePackage[
    backend = biber,
    bibencoding = utf-8,
    safeinputenc,
    bibwarn = true,
    style = alphabetic,
]{biblatex}

\RequirePackage{xcolor}

% we define five base colors which we then use to specify "named colors" for certain elements below
\definecolor{bstfcol01}{HTML}{311bc3} % violet
\definecolor{bstfcol02}{HTML}{0b91f0} % light blue
\definecolor{bstfcol03}{HTML}{39bf00} % green
\definecolor{bstfcol04}{HTML}{fa6300} % orange
\definecolor{bstfcol05}{HTML}{e30008} % red

\colorlet{bstfhighlightcol}{bstfcol05}
\colorlet{bstflinkcol}{bstfcol04}
\colorlet{bstfcitecol}{bstfcol01}

\RequirePackage{hyperref}
% (copied from https://tex.stackexchange.com/a/117959)
%
% This actually adds a new key `footnotecolor` for hypersetup whose value
% defaults to "black". That's overkill for this use case (we just want footnote
% marks to note be colored with `linkcolor` but to remain black), but I don't
% understand the below code well enough (partly because hyperref doesn't really
% document its internals very well) to figure out how to get to the point
% directly.
\def\@footnotecolor{black}
\define@key{Hyp}{footnotecolor}{%
	\HyColor@HyperrefColor{#1}\@footnotecolor%
}
\patchcmd{\@footnotemark}{\hyper@linkstart{link}}{\hyper@linkstart{footnote}}{}{}

\hypersetup{
	linktoc = all,
	colorlinks = true,
	linkcolor = bstflinkcol,
	citecolor = bstfcitecol,
}

\RequirePackage[\bstf@base@langstring]{datetime2}

\RequirePackage{enumitem}

\newlist{alphanumerate}{enumerate}{5}
\setlist[alphanumerate]{
	label = (\alph*), 
	ref = {\alph*},
	before = {\let\item\customitem}
}

\let\realitem\item
\NewDocumentCommand{\customitem}{o}{
	\IfNoValueTF{#1}
		{\realitem}
		{\phantomsection\protected@edef\cref@currentlabel{[alphanumeratei][1][0]{#1}}\realitem[(#1)]}
}

\RequirePackage{fontspec}
\RequirePackage{microtype}

\RequirePackage[style = \bstf@base@langstring]{csquotes}

% note that this package should be loaded before unicode-math
\RequirePackage[\bstf@base@langstring]{bsteffan-math}
\RequirePackage{bsteffan-basediagrams}

% unicode-math and mathtools clash due to redefinitions; this is (presumably)
% harmless and we just silence the warning
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}

\iftoggle{bstf@base@index}{
	\RequirePackage{imakeidx}
	\makeindex[intoc]

	\NewDocumentCommand{\defineterm}{om}{%
		\emph{#2}%
		\index{\IfNoValueTF{#1}{#2}{#1}}%
	}
}{}

\iftoggle{bstf@base@listofsymbols}{
	\RequirePackage[refpage, intoc]{nomencl}

	\renewcommand{\nomname}{List of Symbols}
	\makenomenclature

	\NewDocumentCommand{\definesymbol}{omm}{%
		#2%
		\IfNoValueTF{#1}%
			{\nomenclature{#2}{#3}}%
			{\nomenclature{#1}{#3}}%
	}
}{}

% make sure to load cleveref as late as possible but before it is being used for the first time
\RequirePackage[capitalise, noabbrev]{cleveref}
\let\lref\labelcref
\crefname{enumi}{point}{points}
\crefname{alphanumeratei}{point}{points}

\RequirePackage[\bstf@base@langstring]{bsteffan-basethms}

\setmainfont{XITS}
\setmathfont{XITS Math}
\setsansfont{Fira Sans}

% recalculate type area to adjust to the line length of the font
\KOMAoptions{DIV = last}

\AtBeginDocument{%
	\frenchspacing
}
