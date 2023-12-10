\def\filedate{2023/11/27}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-mathbreakout}[\filedate\space Version \fileversion\space by Ben Steffan]

\RequirePackage{etoolbox}

\newtoggle{bstf@mathbreakout@english}
\toggletrue{bstf@mathbreakout@english}

\DeclareOption{german}{\togglefalse{bstf@mathbreakout@english}}
\DeclareOption{english}{\toggletrue{bstf@mathbreakout@english}}

\DeclareOption{topology}{\PassOptionsToPackage{topology}{bsteffan-math}}

\DeclareOption{algebra}{\PassOptionsToPackage{algebra}{bsteffan-math}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{standalone}}
\ProcessOptions\relax

\def\bsteffan@mathbreakout@langstring{\iftoggle{bstf@mathbreakout@english}{english}{german}}

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
