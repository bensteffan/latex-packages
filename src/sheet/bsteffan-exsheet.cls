\def\filedate{2023/09/19}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-exsheet}[\filedate\space Version \fileversion\space by Ben Steffan]

\newif\ifbsteffan@sheet@english\bsteffan@sheet@englishtrue

\DeclareOption{german}{\bsteffan@sheet@englishfalse}
\DeclareOption{english}{\bsteffan@sheet@englishtrue}

\DeclareOption{topology}{\PassOptionsToPackage{topology}{bsteffan-math}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartctl}}
\ProcessOptions\relax

\LoadClass{scrartcl}

\def\bsteffan@sheet@langstring{\ifbsteffan@sheet@english english\else german\fi}

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

\newcaptionname{english}{\sheetw}{Sheet}
\newcaptionname{german, ngerman}{\sheetw}{Blatt}
\newcaptionname{english}{\duew}{Due}
\newcaptionname{german, ngerman}{\duew}{Abzugeben am}

\RequirePackage{tabularx}
\RequirePackage{pbox}

\renewcommand*{\maketitle}{{%
    \noindent\large
    \renewcommand*{\arraystretch}{1.25}
	\setlength{\arrayrulewidth}{1pt}
    \begin{tabularx}{.99\textwidth}{@{}X|l}
		{\usekomafont{title}\@course} &{\usekomafont{subtitle}\sheetw:} \\
		\pbox{.33\textwidth}{\usekomafont{author}\@author} & {\duew:} \\
		\usekomafont{date}\@date & \usekomafont{date}\@duedate
    \end{tabularx}
	\vspace{2ex}
	\hrule width \hsize height 1.5pt
	\vspace{1ex}
}}

\RequirePackage{polyglossia}
\setdefaultlanguage{\bsteffan@sheet@langstring}
\setmainlanguage{\bsteffan@sheet@langstring}

\RequirePackage[linktoc = all, hidelinks]{hyperref}

\RequirePackage[\bsteffan@sheet@langstring]{datetime2}

\RequirePackage{enumitem}

\RequirePackage{fontspec}
\RequirePackage{microtype}

\RequirePackage[style = \bsteffan@sheet@langstring]{csquotes}

% note that this package should be loaded before unicode-math
\RequirePackage[\bsteffan@sheet@langstring]{bsteffan-math}
\RequirePackage[\bsteffan@sheet@langstring]{bsteffan-sheetthms}

% unicode-math and mathtools clash due to redefinitions; this is (presumably) harmless and we just silence the warning
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}

\setmainfont[Ligatures = TeX]{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}
\setsansfont{Fira Sans}

% For whatever reason Gyre Pagella does not have \setminus, so we have to hack one in.
\AtBeginDocument{%
	\renewcommand{\setminus}{\mathbin{\backslash}}
}

\RequirePackage[\bsteffan@sheet@langstring]{bsteffan-sheetdiagrams}

% opinionated setup
\frenchspacing
