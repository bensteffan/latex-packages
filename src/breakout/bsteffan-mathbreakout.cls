\def\filedate{2023/05/09}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-mathbreakout}[\filedate\space Version \fileversion\space by Ben Steffan]

\newif\ifbsteffan@mathbreakout@english\bsteffan@mathbreakout@englishtrue
\DeclareOption{german}{\bsteffan@mathbreakout@englishfalse}
\DeclareOption{english}{\bsteffan@mathbreakout@englishtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{standalone}}
\ProcessOptions\relax

\def\bsteffan@mathbreakout@langstring{\ifbsteffan@mathbreakout@english english\else german\fi}

\LoadClass[class = scrartcl, varwidth = true, border = 20pt]{standalone}

\usepackage{polyglossia}
\setdefaultlanguage{\bsteffan@mathbreakout@langstring}
\setmainlanguage{\bsteffan@mathbreakout@langstring}

\usepackage{enumitem}
\usepackage{fontspec}

\usepackage[style = \bsteffan@mathbreakout@langstring]{csquotes}

% note that this package should be loaded before unicode-math
\usepackage[\bsteffan@mathbreakout@langstring]{bsteffan-math}
\usepackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}

\usepackage[\bsteffan@mathbreakout@langstring]{bsteffan-breakoutthms}

\setmainfont[Ligatures = TeX]{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}
\setsansfont{Fira Sans}

% For whatever reason Gyre Pagella does not have \setminus, so we have to hack one in.
\AtBeginDocument{%
	\renewcommand{\setminus}{\mathbin{\backslash}}
}

\frenchspacing
