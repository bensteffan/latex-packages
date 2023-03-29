\def\filedate{2023/03/30}
\def\fileversion{0.0}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-exsheet}[\filedate\space Version \fileversion\space by Ben Steffan]

\RequirePackage{scrbase}

\newif\ifbsteffan@sheet@english\bsteffan@sheet@englishtrue
\DeclareOption{german}{\bsteffan@sheet@englishfalse}
\DeclareOption{english}{\bsteffan@sheet@englishtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\LoadClass{scrartcl}

\def\@course{\ClassError{bsteffan-exsheet}{No \noexpand\course given}{Use \noexpand\course{<coursename>} to set the course name.}}%
\DeclareRobustCommand*{\course}[1]{\gdef\@course{#1}}
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

% font
\usepackage{fontspec}
\usepackage{unicode-math}

\setmainfont[Ligatures = TeX]{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}
\setsansfont{Fira Sans}

% opinionated setup
\frenchspacing
