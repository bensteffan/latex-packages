\def\filedate{2023/10/09}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-lecturenotes}[\filedate\space Version \fileversion\space by Ben Steffan]

\RequirePackage{etoolbox}

\newtoggle{bstf@notes@english}
\toggletrue{bstf@notes@english}

\newtoggle{bstf@notes@wip}

\DeclareOption{german}{\togglefalse{bstf@notes@english}}
\DeclareOption{english}{\toggletrue{bstf@notes@english}}

\DeclareOption{topology}{\PassOptionsToPackage{topology}{bsteffan-math}}

\DeclareOption{wip}{\toggletrue{bstf@notes@wip}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartctl}}
\ProcessOptions\relax

\LoadClass{scrartcl}
\KOMAoptions{
	toc = bibliography, % bibliography listed as ToC item
	index = totoc, % index listed as ToC item
	fontsize = 12pt,
	BCOR = 0pt, % not intended for printing, so no binding correction
	DIV = calc, % set this to calc so we can recalculate it after loading the fonts
}

% we make use of this for page heads and for note columns, see below
\RequirePackage{scrlayer-scrpage}
\KOMAoptions{
	headsepline = 0.7pt, % the standard 0.4pt hairline looks too flimsy with this class
}

\RequirePackage{scrlayer-notecolumn}

\setkomafont{disposition}{\normalfont\normalcolor\bfseries}

% color setup
\RequirePackage{xcolor}

% we define five base colors which we then use to specify "named colors" for certain elements below
\definecolor{col01}{HTML}{311bc3} % violet
\definecolor{col02}{HTML}{0b91f0} % light blue
\definecolor{col03}{HTML}{39bf00} % green
\definecolor{col04}{HTML}{f66a00} % orange
\definecolor{col05}{HTML}{e30008} % red

\colorlet{highlightcol}{col05}
\colorlet{linkcol}{col04}
\colorlet{citecol}{col01}

\colorlet{definitioncol}{col03}
\colorlet{exercisecol}{col02}
\colorlet{theoremcol}{col05}

\def\bstf@notes@langstring{\iftoggle{bstf@notes@english}{english}{german}}

\def\@course{\ClassError{bsteffan-lecturenotes}{No \noexpand\course given}{Use \noexpand\course{<coursename>} to set the course.}}
\DeclareRobustCommand*{\course}[1]{\gdef\@course{#1}}

\def\@lecturer{\ClassError{bsteffan-lecturenotes}{No \noexpand\lecturer given}{Use \lecturer{<name>} to set the name of the lecturer.}}
\def\@lecturertitle{}
\DeclareRobustCommand*{\lecturer}[2][]{
	\gdef\@lecturer{#2}
	\gdef\@lecturertitle{%
		\iftoggle{bstf@notes@english}%
			{Lecturer}%
			{\ifstrempty{#1}%
				{Dozent}%
				{Dozentin}}%
	}%
}

\newtoggle{bstf@notes@printassistant}

\def\@assistant{}
\def\@assistanttitle{}
\DeclareRobustCommand*{\assistant}[2][]{
	\toggletrue{bstf@notes@printassistant}
	\gdef\@assistant{#2}
	\gdef\@assistanttitle{
		\iftoggle{bstf@notes@english}%
			{Assistant}%
			{\ifstrempty{#1}%
				{Assistent}%
				{Assistentin}}%
	}%
}

\renewcommand*{\maketitle}{%
	\begin{titlepage}
		\begin{center}
			\vskip 4em
			{\usekomafont{title}\huge \@course \par}
			\ifstrempty{\@subtitle}{}{%
				\vskip 1.1em 
				{\usekomafont{title}\Large \@subtitle \par}
				\vskip 0.5em % without this extra space the balance looks terribly off
			}
			\vskip 4em
			\@lecturertitle \\
			{\usekomafont{author} \@lecturer \par}
			\iftoggle{bstf@notes@printassistant}{%
				\vskip 2em
				\@assistanttitle \\
				{\usekomafont{author} \@assistant \par}
			}{}
			\vskip 2em
			\iftoggle{bstf@notes@english}{Notes by}{Mitschrift von} \\
			{\usekomafont{author} \@author \par}
			\vfill
			\iftoggle{bstf@notes@english}{Compiled on }{Kompiliert am } \today
			\iftoggle{bstf@notes@wip}{\\[1.5ex] \strong{\textsf{\textcolor{col05}{Work in progress! Unfinished document!}}}}{}
		\end{center}
	\end{titlepage}
}

\RequirePackage{polyglossia}
\setdefaultlanguage{\bstf@notes@langstring}
\setmainlanguage{\bstf@notes@langstring}

\RequirePackage[
    backend = biber,
    bibencoding = utf-8,
    safeinputenc,
    bibwarn = true,
    style = alphabetic,
	backref = true,
]{biblatex}

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
	linkcolor = linkcol,
	citecolor = citecol,
}

\RequirePackage[\bstf@notes@langstring]{datetime2}

\RequirePackage{enumitem}

\RequirePackage{fontspec}
\RequirePackage{microtype}

\RequirePackage[style = \bstf@notes@langstring]{csquotes}

% note that this package should be loaded before unicode-math
\RequirePackage[\bstf@notes@langstring]{bsteffan-math}
\RequirePackage[\bstf@notes@langstring]{bsteffan-notethms}

% unicode-math and mathtools clash due to redefinitions; this is (presumably)
% harmless and we just silence the warning
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}

\setmainfont[Ligatures = TeX]{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}
\setsansfont{Fira Sans}

% recalculate type area to adjust to the line length of the font
\KOMAoptions{DIV = last}

% For whatever reason Gyre Pagella does not have \setminus, so we have to "hack" one in.
\AtBeginDocument{%
	\renewcommand{\setminus}{\mathbin{\backslash}}
}

\RequirePackage[\bstf@notes@langstring]{bsteffan-notediagrams}

% treat all spaces as equal, as opposed to two-spaces-after-sentence-terminator
% American style
\frenchspacing

% Facilities to track lecture to which lecture (as in "sitting") content belongs.
%
% \lecture[Number]{Date} puts a block in the margin with date and lecture
% number. A counter `lecture` is also maintained and used as source for the
% lecture number if the optional argument is omitted. References to all
% lectures are saved in a ToC that can be printed with `\listoflectures`. The
% text layout in the block is controlled by the font element `lectureblock`,
% and the block itself is set in an mdframed environment also named
% `lectureblock`, which can be redefined at will.
\newmdenv[
	topline = false,
	rightline = false,
	bottomline = false,
	linewidth = 0.9pt,
	innertopmargin = 1pt,
	innerbottommargin = 1pt,
	innerleftmargin = 0.6em,
	linecolor = black,
]{lectureblock}

\newkomafont{lectureblock}{\sffamily\footnotesize}

\newcommand{\bstf@notes@marginblock}[1]{%
	\begin{lectureblock}
		\usekomafont{lectureblock}%
		\begin{tabular}{@{}l@{}}
			#1
		\end{tabular}%
	\end{lectureblock}%
}

\newcommand*{\bstf@withkomafont}[2]{%
	{\usekomafont{#1} #2}%
}

\DeclareNewTOC[
	type = lecture,
	types = lectures,
	owner = lecturenotes,
	listname = Lectures,
	tocentrystyle = tocline,
	tocentrylevel = 1,
	tocentryindent = 0pt,
	tocentrybeforeskip = 0.5em plus 1pt, % experimental value; no skip looks horribly crammed while the 1em skip scrartcl uses for section entries looks too spacious
	tocentryentryformat = \bstf@withkomafont{disposition}, % essentially "format like section level entries in the ToC"
]{lolec}

\newcounter{lecture}

\newcommand*{\lecture}[2][]{%
	\stepcounter{lecture}%
	\makenote{\protecting{\bstf@notes@marginblock{%
		Lecture \ifstrempty{#1}{\thelecture}{#1} \\
		#2
	}}}%
	\addxcontentsline{lolec}{lecture}{Lecture \ifstrempty{#1}{\thelecture}{#1} (#2)}%
}

\RequirePackage{imakeidx}
\makeindex

% set up running heads
\pagestyle{scrheadings}

\setkomafont{pageheadfoot}{\normalfont}

% TODO figure out how to have the lecture number as a mark in the center
\automark[section]{section}
\ihead{\headmark}
\chead{}
\ohead{\@course}
