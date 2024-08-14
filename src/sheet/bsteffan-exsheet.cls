\def\filedate{2024/08/14}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-exsheet}[\filedate\space Version \fileversion\space by Ben Steffan]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bsteffan-baseclass}}
\ProcessOptions\relax

\LoadClass[nocolor]{bsteffan-baseclass}

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
		{\usekomafont{title}\@course} &{\usekomafont{subtitle}\sheetw: \@sheetnumber} \\
		\pbox{.33\textwidth}{\usekomafont{author}\@author} & {\duew:} \\
		\usekomafont{date}\@date & \usekomafont{date}\@duedate
    \end{tabularx}
	\vspace{2ex}
	\hrule width \hsize height 1.5pt
	\vspace{1ex}
}}
