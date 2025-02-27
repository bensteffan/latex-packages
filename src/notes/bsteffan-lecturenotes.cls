\def\filedate{2024/08/15}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-lecturenotes}[\filedate\space Version \fileversion\space by Ben Steffan]

\RequirePackage{etoolbox}

\newtoggle{bstf@lecturenotes@wip}

\DeclareOption{wip}{\toggletrue{bstf@lecturenotes@wip}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bsteffan-baseclass}}
\ProcessOptions\relax

\LoadClass[index]{bsteffan-baseclass}

% we make use of this for page heads and for note columns, see below
\RequirePackage{scrlayer-scrpage}
\KOMAoptions{
	headsepline = 0.7pt, % the standard 0.4pt hairline looks too flimsy with this class
}

\RequirePackage{scrlayer-notecolumn}

\setkomafont{disposition}{\normalfont\normalcolor\bfseries}

\def\@course{\ClassError{bsteffan-lecturenotes}{No \noexpand\course given}{Use \noexpand\course{<coursename>} to set the course.}}
\DeclareRobustCommand*{\course}[1]{\gdef\@course{#1}}

\def\@lecturer{\ClassError{bsteffan-lecturenotes}{No \noexpand\lecturer given}{Use \lecturer{<name>} to set the name of the lecturer.}}
\def\@lecturertitle{}
\DeclareRobustCommand*{\lecturer}[2][]{
	\gdef\@lecturer{#2}
	\gdef\@lecturertitle{%
		\iftoggle{bstf@base@english}%
			{Lecturer}%
			{\ifstrempty{#1}%
				{Dozent}%
				{Dozentin}}%
	}%
}

\newtoggle{bstf@lecturenotes@printassistant}

\def\@assistant{}
\def\@assistanttitle{}
\DeclareRobustCommand*{\assistant}[2][]{
	\toggletrue{bstf@lecturenotes@printassistant}
	\gdef\@assistant{#2}
	\gdef\@assistanttitle{
		\iftoggle{bstf@base@english}%
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
			\iftoggle{bstf@lecturenotes@printassistant}{%
				\vskip 2em
				\@assistanttitle \\
				{\usekomafont{author} \@assistant \par}
			}{}
			\vskip 2em
			\iftoggle{bstf@base@english}{Notes by}{Mitschrift von} \\
			{\usekomafont{author} \@author \par}
			\vfill
			\iftoggle{bstf@base@english}{Compiled on }{Kompiliert am } \today
			\iftoggle{bstf@lecturenotes@wip}{\\[1.5ex] \strong{\textsf{\textcolor{bstfcol05}{Work in progress! Unfinished document!}}}}{}
		\end{center}
	\end{titlepage}
}

% Facilities to track lecture to which lecture (as in "sitting") content belongs.
%
% \lecture[Number]{Date} puts a block in the margin with date and lecture
% number. A counter `lecture` is also maintained and used as source for the
% lecture number if the optional argument is omitted. References to all
% lectures are saved in a ToC that can be printed with `\listoflectures`. The
% text layout in the block is controlled by the font element `lectureblock`,
% and the block itself is set in an mdframed environment also named
% `lectureblock`, which can be redefined at will.
\RequirePackage{mdframed}
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

\newcommand{\bstf@lecturenotes@marginblock}[1]{%
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
	\makenote{\protecting{\bstf@lecturenotes@marginblock{%
		Lecture \ifstrempty{#1}{\thelecture}{#1} \\
		#2
	}}}%
	\addxcontentsline{lolec}{lecture}{Lecture \ifstrempty{#1}{\thelecture}{#1} (#2)}%
}

% set up running heads
\pagestyle{scrheadings}

\setkomafont{pageheadfoot}{\normalfont}

% TODO figure out how to have the lecture number as a mark in the center
\automark[section]{section}
\ihead{\headmark}
\chead{}
\ohead{\@course}
