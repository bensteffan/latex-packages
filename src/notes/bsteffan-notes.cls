\def\filedate{2024/08/15}
\def\fileversion{0.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsteffan-notes}[\filedate\space Version \fileversion\space by Ben Steffan]

\RequirePackage{etoolbox}

\newtoggle{bstf@notes@wip}

\DeclareOption{wip}{\toggletrue{bstf@notes@wip}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bsteffan-baseclass}}
\ProcessOptions\relax

\LoadClass[index, listofsymbols]{bsteffan-baseclass}

\RequirePackage{scrlayer-scrpage}
\KOMAoptions{
	headsepline = 0.7pt, % the standard 0.4pt hairline looks too flimsy with this class
}

\renewcommand*{\maketitle}{%
	\begin{titlepage}
		\begin{center}
			{\usekomafont{title}\huge \@title \par}
			\ifstrempty{\@subtitle}{}{%
				\vskip 1.1em 
				{\usekomafont{title}\Large \@subtitle \par}
				\vskip 0.5em % without this extra space the balance looks terribly off
			}
			\vskip 4em
			{\usekomafont{author} \@author \par}
			\vskip 1em
			{\usekomafont{date} \@date \par}
			\vfill
			\iftoggle{bstf@notes@wip}{\\[1.5ex] \strong{\textsf{\textcolor{bstfcol05}{Work in progress! Unfinished document!}}}}{}
		\end{center}
	\end{titlepage}
}

% set up running heads
\pagestyle{scrheadings}

\setkomafont{pageheadfoot}{\normalfont}

\automark[section]{section}
\ihead{\headmark}
\chead{}
\ohead{\@title}
