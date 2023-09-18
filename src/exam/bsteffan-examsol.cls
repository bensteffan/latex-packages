\def\filedate{2023/09/18}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-examsol}[\filedate\space Version \fileversion\space by Ben Steffan]

\newif\ifbsteffan@examsol@english\bsteffan@examsol@englishtrue
\DeclareOption{german}{\bsteffan@examsol@englishfalse}
\DeclareOption{english}{\bsteffan@examsol@englishtrue}

\PassOptionsToPackage{topology}{bsteffan-math}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartctl}}
\ProcessOptions\relax

\LoadClass{scrartcl}

\def\bsteffan@examsol@langstring{\ifbsteffan@examsol@english english\else german\fi}

\setkomafont{title}{\bfseries\sffamily}
\setkomafont{subtitle}{\bfseries\sffamily}
\setkomafont{author}{\normalfont}
\setkomafont{date}{\normalfont}

\def\@course{\ClassError{bsteffan-examsol}{No \noexpand\course given}{Use \noexpand\course{<coursename>} to set the course name.}}%
\DeclareRobustCommand*{\course}[1]{\gdef\@course{#1}}
\def\@examiner{\ClassError{bsteffan-examsol}{No \noexpand\examiner given}{Use \noexpand\examiner{<examiner>} to set the examiner name.}}%
\DeclareRobustCommand*{\examiner}[1]{\gdef\@examiner{#1}}
\def\@date{\ClassError{bsteffan-examsol}{No \noexpand\date given}{Use \noexpand\date{<date>} to set the exam date.}}%
\DeclareRobustCommand*{\date}[1]{\gdef\@date{#1}}
\def\@examnumber{1}%
\DeclareRobustCommand*{\examnumber}[1]{\gdef\@examnumber{#1}}
\def\@author{\ClassError{bsteffan-examsol}{No \noexpand\author given}{Use \noexpand\author{<author>} to set the document author.}}%
\DeclareRobustCommand*{\author}[1]{\gdef\@author{#1}}

\RequirePackage{tabularx}
\RequirePackage{pbox}

\renewcommand*{\maketitle}{{%
	\noindent\large
    \renewcommand*{\arraystretch}{1.25}
	\setlength{\arrayrulewidth}{1pt}
    \begin{tabularx}{.99\textwidth}{@{}X|l}
		{\usekomafont{title}\@course} &{\usekomafont{subtitle}\@examnumber. \ifbsteffan@examsol@english Exam \else Klausur \fi} \\
		\pbox{.33\textwidth}{\usekomafont{author}\ifbsteffan@examsol@english Examiner: \else Prüfer: \fi \@examiner} & {\ifbsteffan@examsol@english Date: \else Datum: \fi} \\
		{\usekomafont{author}\ifbsteffan@examsol@english Solution by: \else Lösung von: \fi \@author} &\usekomafont{date}\@date
    \end{tabularx}
	\vspace{2ex}
	\hrule width \hsize height 1.5pt
	\vspace{1ex}
}}

\RequirePackage{polyglossia}
\setdefaultlanguage{\bsteffan@examsol@langstring}
\setmainlanguage{\bsteffan@examsol@langstring}

\RequirePackage[linktoc = all, hidelinks]{hyperref}

\RequirePackage[\bsteffan@examsol@langstring]{datetime2}

\RequirePackage{enumitem}

\RequirePackage{fontspec}
\RequirePackage{microtype}

\RequirePackage[style = \bsteffan@examsol@langstring]{csquotes}

% note that this package should be loaded before unicode-math
\RequirePackage[\bsteffan@examsol@langstring]{bsteffan-math}
\RequirePackage[\bsteffan@examsol@langstring]{bsteffan-examthms}

% unicode-math and mathtools clash due to redefinitions; this is (presumably) harmless and we just silence the warning
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}

\setmainfont[Ligatures = TeX]{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}
\setsansfont{Fira Sans}

% For whatever reason Gyre Pagella does not have \setminus, so we have to hack one in.
\AtBeginDocument{%
	\renewcommand{\setminus}{\mathbin{\backslash}}
}

% opinionated setup
\frenchspacing
