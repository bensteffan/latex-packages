\def\filedate{2023/04/10}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-exsheet}[\filedate\space Version \fileversion\space by Ben Steffan]

\newif\ifbsteffan@sheet@english\bsteffan@sheet@englishtrue
\DeclareOption{german}{\bsteffan@sheet@englishfalse}
\DeclareOption{english}{\bsteffan@sheet@englishtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\LoadClass{scrartcl}

\setkomafont{title}{\bfseries\sffamily}
\setkomafont{subtitle}{\bfseries\sffamily}
\setkomafont{author}{\normalfont}
\setkomafont{date}{\normalfont}

\def\@course{\ClassError{bsteffan-exsheet}{No \noexpand\course given}{Use \noexpand\course{<coursename>} to set the course name.}}%
\DeclareRobustCommand*{\course}[1]{\gdef\@course{#1}}
\def\@duedate{\ClassError{bsteffan-exsheet}{No \noexpand\duedate given}{Use \noexpand\duedate{<date>} to set the due date.}}%
\DeclareRobustCommand*{\duedate}[1]{\gdef\@duedate{#1}}
\def\@sheetnumber{\ClassError{bsteffan-exsheet}{No \noexpand\sheetnumber given}{Use \noexpand\sheetnumber{<num>} to set the current sheetnumber.}}%
\DeclareRobustCommand*{\sheetnumber}[1]{\gdef\@sheetnumber{#1}}

\renewcommand*{\maketitle}{%
	\thispagestyle{plain}
	{\makebox[0pt][l]{\usekomafont{author}\@author}\hfill\makebox[0pt][r]{\usekomafont{date}\@date}\par}
	\vspace{0.5em}
	{\centering\usekomafont{title}\@course\par}
	{\centering\usekomafont{subtitle}\@sheetnumber\par}
	\vspace{2em}
	\hrule
	\addvspace{2em}
}

\usepackage{tabularx}
\usepackage{pbox}

\renewcommand*{\maketitle}{{%
    \noindent\large
    \renewcommand*{\arraystretch}{1.25}
	\setlength{\arrayrulewidth}{1pt}
    \begin{tabularx}{.99\textwidth}{@{}X|l}
		{\usekomafont{title}\@course} &{\usekomafont{subtitle}\ifbsteffan@sheet@english Sheet \else Blatt \fi \@sheetnumber} \\
		\pbox{.33\textwidth}{\usekomafont{author}\@author} & {\ifbsteffan@sheet@english Due: \else Abzugeben am: \fi} \\
		\usekomafont{date}\@date & \usekomafont{date}\@duedate
    \end{tabularx}
	\vspace{2ex}
	\hrule width \hsize height 1.5pt
	\vspace{1ex}
}}

\usepackage{polyglossia}
\setdefaultlanguage{\ifbsteffan@sheet@english english\else german\fi}
\setmainlanguage{\ifbsteffan@sheet@english english\else german\fi}

\usepackage[\ifbsteffan@sheet@english english\else german\fi]{datetime2}

\usepackage{fontspec}
\usepackage{microtype}

\usepackage[style = \ifbsteffan@sheet@english british\else ngerman\fi]{csquotes}

% note that this package should be loaded before unicode-math
\usepackage[\ifbsteffan@sheet@english english\else german\fi]{bsteffan-math}

% unicode-math and mathtools clash due to redefinitions; this is (presumably) harmless and we just silence the warning
\usepackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}

\setmainfont[Ligatures = TeX]{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}
\setsansfont{Fira Sans}

% opinionated setup
\frenchspacing
