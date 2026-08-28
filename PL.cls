% PL.cls
% Copyright 2016 Guido Vanden Wyngaerd
% Copyright 2026 Philosophical Logic editorial team
%
% This file is a modified version of glossa.cls from Glossalatex:
% https://github.com/guidovw/Glossalatex
%
% This derived work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, version 1.3 or later.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This derived work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this derived work is the Philosophical Logic
% editorial team. Contact: editorial@philosophical-logic.org. The original
% Glossa work is maintained by Guido Vanden Wyngaerd; the original
% maintainer does not provide support for this derived work.
%
% This derived work consists of the files
% PL.cls
% PL.bst
% PL-template.tex
%
% The files of this derived work are based on the Glossa style files, which
% are themselves derived from the Semantics & Pragmatics style files by Kai
% von Fintel, Christopher Potts, and Chung-chieh Shan.
% Licensing and modification details: LICENSE.md.

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{PL}[2026/07/26 v1.0.0 Submission class for Philosophical Logic]

% OUTLINE OF THIS CLASS FILE
%   option declarations
%   required packages
%   metadata
%   page dimensions
%   title
%   running headers
%   frontmatter
%   sectioning
%   footnotes
%   backmatter
%   other environments
%   useful macros

%=====================================================================
%======================== option declarations ========================

% Philosophical Logic uses double-anonymous review.  Consequently the
% author-facing class is anonymous unless the accepted option is given.
% The public conditional lets a manuscript keep accepted-version material
% (author details, acknowledgements, and similar material) in one source file:
%
%   \ifPLaccepted ... \fi
\newif\ifPLaccepted
\PLacceptedfalse
\newif\ifPL@acceptedrequested
\newif\ifPL@anonymousrequested

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\newcommand{\@sizeoption@err}{\ClassError{PL}
  {Cannot use size option \CurrentOption}
  {Philosophical Logic style requires (and automatically loads) 11pt text}}

\DeclareOption{10pt}{\@sizeoption@err}
\DeclareOption{12pt}{\@sizeoption@err}
\DeclareOption{9pt}{\@sizeoption@err}

\DeclareOption{accepted}{\PLacceptedtrue\PL@acceptedrequestedtrue}
\DeclareOption{anonymous}{\PLacceptedfalse\PL@anonymousrequestedtrue}

\newcommand{\PL@removedoption}[2]{%
  \ClassError{PL}{The `#1' option is no longer supported}{#2}}
\DeclareOption{final}{\PL@removedoption{final}{PL.cls is an author-submission
  class. OLH production creates the publication PDF and XML.}}
\DeclareOption{biblatex}{\PL@removedoption{biblatex}{Use the class's natbib
  setup and PL.bst. Do not load biblatex.}}
\DeclareOption{linguex}{\PL@removedoption{linguex}{Load the linguistic-example
  package required by the manuscript directly.}}
\DeclareOption{lucida}{\PL@removedoption{lucida}{PL.cls now uses fonts supplied
  with standard TeX installations.}}
\DeclareOption{brill}{\PL@removedoption{brill}{PL.cls now uses fonts supplied
  with standard TeX installations.}}
\DeclareOption{charis}{\PL@removedoption{charis}{PL.cls now uses fonts supplied
  with standard TeX installations.}}
\DeclareOption{times}{\PL@removedoption{times}{Font selection is now controlled
  by PL.cls; no font option is needed.}}
\DeclareOption{cm}{\PL@removedoption{cm}{Font selection is now controlled by
  PL.cls; no font option is needed.}}

\ProcessOptions\relax
\ifPL@acceptedrequested
  \ifPL@anonymousrequested
    \ClassError{PL}{Conflicting author-mode options}
      {Do not combine `accepted' and `anonymous'. Use no mode option for
       anonymous review, or use only `accepted' after acceptance.}%
  \fi
\fi
\LoadClass[11pt,twoside]{article}

% Strong widow and orphan control

\clubpenalty10000
\widowpenalty10000

%=====================================================================
%========================= required packages =========================
\RequirePackage{iftex}
\RequirePackage[leqno,tbtags]{amsmath}
% Load amsthm before newtxmath so their shared \openbox definition is resolved
% in the supported order. Re-loading amsthm in a manuscript remains harmless.
\RequirePackage{amsthm}
% Glossa supplies the standard AMS symbols at class level. Load them before
% newtxmath or unicode-math so a manuscript may also request amssymb harmlessly.
\RequirePackage{amssymb}

% TeX Gyre Termes, TeX Gyre Heros, and STIX Two Math are part of ordinary
% TeX Live and MiKTeX installations. pdfLaTeX uses the Type 1 text fonts with
% newtx mathematics; XeLaTeX and LuaLaTeX use OpenType fonts.
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{tgtermes}
  \RequirePackage[scale=0.92]{tgheros}
  \RequirePackage{newtxmath}

  % Supply the standard ToUnicode maps recommended by newtx for searchable
  % and copyable pdfLaTeX output. Current LaTeX loads the core map itself;
  % retaining the explicit input also supports the older format accepted by
  % this class.
  \InputIfFileExists{glyphtounicode.tex}{}{%
    \ClassWarningNoLine{PL}{Missing glyphtounicode.tex; PDF text extraction
      may be incomplete}}%
  \InputIfFileExists{glyphtounicode-cmr.tex}{}{%
    \ClassWarningNoLine{PL}{Missing glyphtounicode-cmr.tex; install the
      `pdfx' package for complete PDF math extraction}}%
  \InputIfFileExists{glyphtounicode-ntx.tex}{}{%
    \ClassWarningNoLine{PL}{Missing glyphtounicode-ntx.tex; install the
      `pdfx' package for complete newtx math extraction}}%
  \pdfgentounicode=1
\else
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
  % Select by TeX-distribution filenames, rather than relying on an operating
  % system font cache that may not index the fonts shipped inside TeX Live.
  \setmainfont{texgyretermes}[
    Extension=.otf,
    UprightFont=*-regular,
    ItalicFont=*-italic,
    BoldFont=*-bold,
    BoldItalicFont=*-bolditalic]
  \setsansfont{texgyreheros}[
    Extension=.otf,
    UprightFont=*-regular,
    ItalicFont=*-italic,
    BoldFont=*-bold,
    BoldItalicFont=*-bolditalic,
    Scale=0.92]
  \RequirePackage{unicode-math}
  % STIX Two is Times-like and has substantially broader mathematical-symbol
  % coverage than TeX Gyre Termes Math, which is important for logic papers.
  \setmathfont{STIXTwoMath-Regular.otf}[Scale=MatchUppercase]

  % amssymb defines several traditional names as aliases before unicode-math
  % installs the corresponding OpenType symbols. Re-establish the usual
  % AMS/STIX aliases after unicode-math completes its begin-document setup.
  \newcommand{\PL@unicodealiases}{%
    \let\square\mdlgwhtsquare
    \let\Box\square
    \let\blacksquare\mdlgblksquare
    \let\lozenge\mdlgwhtlozenge
    \let\Diamond\lozenge
    \protected\def\blacklozenge{\mathord{\mdlgblklozenge}}%
    \let\leadsto\rightsquigarrow
    \let\llbracket\lBrack
    \let\rrbracket\rBrack
  }
  \AtBeginDocument{\PL@unicodealiases}
\fi

% Semantic brackets are supplied by the selected math setup on most
% installations.  Retain a portable fallback for minimal installations.
\@ifundefined{llbracket}{%
  \newcommand{\llbracket}{\ensuremath{\left[\!\left[}}%
  \newcommand{\rrbracket}{\ensuremath{\right]\!\right]}}%
}{}

\RequirePackage{xspace}
% Use microtypographic margin handling when it is available, without making a
% nonessential package a hard installation requirement.
\IfFileExists{microtype.sty}{%
  \RequirePackage[final,protrusion={true,compatibility}]{microtype}
}{}
\RequirePackage[hyphens]{url}

% PL.bst is the journal's sole supported bibliography style.
\RequirePackage{natbib}
\bibpunct[: ]{(}{)}{; }{a}{}{;~}
\newcommand{\BIBand}{\&}
\setlength{\bibsep}{0pt}
\setlength{\bibhang}{0.25in}
\bibliographystyle{PL}
\newcommand{\posscitet}[1]{\citeauthor{#1}'s (\citeyear{#1})}
\newcommand{\posscitealt}[1]{\citeauthor{#1}'s \citeyear{#1}}
\newcommand{\possciteauthor}[1]{\citeauthor{#1}'s}
\newcommand{\pgposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~#2)}
\newcommand{\secposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~$\S$#2)}
\newcommand{\pgcitealt}[2]{\citealt{#1}:~#2}
\newcommand{\seccitealt}[2]{\citealt{#1}:~$\S$#2}
\newcommand{\pgcitep}[2]{(\citealt{#1}:~#2)}
\newcommand{\seccitep}[2]{(\citealt{#1}:~$\S$#2)}
\newcommand{\pgcitet}[2]{\citeauthor{#1} (\citeyear{#1}:~#2)}
\newcommand{\seccitet}[2]{\citeauthor{#1} (\citeyear{#1}:~$\S$#2)}

\RequirePackage{xcolor}
\definecolor{splinkcolor}{rgb}{.0,.2,.4}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\RequirePackage[font=sf,labelfont=bf,labelsep=colon,
  justification=raggedright,singlelinecheck=false]{caption}
\RequirePackage{booktabs}
% hyperref is intentionally loaded after the class's other packages.  Authors
% may load subcaption (and cleveref, if desired) after the class.
\RequirePackage[colorlinks,breaklinks,
                linkcolor=splinkcolor,
                urlcolor=splinkcolor,
                citecolor=splinkcolor,
                filecolor=splinkcolor,
                plainpages=false,
                pdfpagelabels,
                bookmarks=true,
                bookmarksopen=true,
                bookmarksnumbered=true,
                pdfencoding=auto,
                psdextra,
                pdfdisplaydoctitle=true,
                pdfstartview=FitH]{hyperref}
\providecommand{\doi}[1]{\url{https://doi.org/#1}}
\urlstyle{rm}

%=====================================================================
%============================= metadata ==============================

\def\PL@pdfauthor{}
\newcommand{\pdfauthor}[1]{%
  \ifPLaccepted\gdef\PL@pdfauthor{#1}\else\gdef\PL@pdfauthor{}\fi}
\def\PL@pdftitle{}
\newcommand{\pdftitle}[1]{\gdef\PL@pdftitle{#1}}
\def\PL@pdfkeywords{}
\newcommand{\pdfkeywords}[1]{\gdef\PL@pdfkeywords{#1}}

\AtBeginDocument{%
  \ifx\PL@pdftitle\@empty\gdef\PL@pdftitle{\@title}\fi
  \ifPLaccepted\else\gdef\PL@pdfauthor{}\fi
  \hypersetup{%
    pdfauthor={\PL@pdfauthor},
    pdftitle={\PL@pdftitle},
    pdfkeywords={\PL@pdfkeywords},
    pdfsubject={Submission to Philosophical Logic},
    pdfcreator={LaTeX with PL.cls},
    pdflang={en-US}}%
}

%=====================================================================
%========================== page dimensions ==========================

% Vertical.
\paperheight=297mm
\topmargin=-13mm   %
\headheight=5mm    % head: 30mm (margin + head + sep = 0.46cm); latex adds 1in)
\headsep=17.6mm   %
\topskip=0.1in     % included in the textheight
\textheight=237mm  % (297mm - 60mm)
\footskip=0.46cm   % foot: 30mm total (1.0in leftover)
\parskip=0pt

% Horizontal.
\paperwidth=210mm
\textwidth=150mm % (210mm - 60mm)
\oddsidemargin=0.46cm  % put at 3cm margins (3cm - 1in = 0.46cm)
\evensidemargin=0.46cm % put at 3cm margins (3cm - 1in = 0.46cm)
\raggedbottom % constant spacing in the text; cost is a ragged bottom
\parindent=0.1in
\leftmargini=0.5in
\@ifundefined{mathindent}{}{\mathindent=0.5in\relax}%

%=====================================================================
%============================== title ================================

% Formats individual <name--institute> pairs inside \author.
\newcommand{\spauthor}[1]%
{\begin{minipage}[t]{16pc}\centering
        % Prevent an unreliable hyperlink from a title-note mark inside this
        % minipage. The note itself remains visible, and ordinary footnote
        % links remain available elsewhere in the manuscript.
        \let\PL@titlethanks\thanks
        \renewcommand{\thanks}[1]{%
          {\NoHyper\PL@titlethanks{##1}\endNoHyper}}%
        #1%
 \end{minipage}\hspace{.5pc plus1pc}%
 \ignorespaces
}

\def\@shorttitle{}
\def\@shortauthor{}
% Preserve Glossa's behavior: only an explicit optional title is suitable for
% a running head. The full title may contain \thanks or formatting commands.
\renewcommand*{\title}[2][]{%
  \gdef\@shorttitle{#1}%
  \gdef\@title{#2}}
% Likewise, Glossa uses only an explicit optional author for the running head.
% The full author block may contain \thanks, affiliations, and email addresses.
\renewcommand*{\author}[2][]{%
  \ifPLaccepted
    \gdef\@shortauthor{#1}%
    \gdef\@author{#2}%
  \else
    % Do not retain author-identifying material in anonymous mode.
    \gdef\@author{}%
    \gdef\@shortauthor{}%
  \fi}

% Adapted from JMLR.
\renewcommand{\maketitle}{%
  \par
  \begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \@maketitle
  \ifPLaccepted\@thanks\fi
  \setcounter{footnote}{0}
  \endgroup
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}
  \let\thanks\relax%
}

% From salt.cls.
\newskip\onelineskip
\onelineskip=\baselineskip
\advance\onelineskip by0pt plus 4pt minus 2pt

\def\@maketitle{%
  \vbox{\sffamily\hsize\textwidth%
    \linewidth\hsize%
    \centering
    \vskip\onelineskip
    \LARGE\@title\@@par
    \normalsize
    \def\institute{\textit}%
    \newcommand{\AND}{\ignorespaces}%
    \ifPLaccepted
      \let\par\@empty
      \@author
      \lineskiplimit\onelineskip
      \lineskip\onelineskip
      \@@par
    \fi
  }%
  \global\everypar{\everypar{}\vskip 3.5ex}
}

%=====================================================================
%========================== running headers ==========================

\newcommand{\headerfontsize}{\footnotesize}

% Simple submission running heads.  Anonymous output never contains an author
% name; OLH's typesetter supplies all publication running heads and footers.
\def\ps@PLheadings{%
  \let\@mkboth\@gobbletwo%
  \def\@oddhead{{\headerfontsize\sffamily\@shorttitle}\hfill
    {\headerfontsize\sffamily\thepage}}%
  \def\@oddfoot{}%
  \def\@evenhead{{\headerfontsize\sffamily\thepage}\hfill
    {\headerfontsize\sffamily
      \ifPLaccepted\@shortauthor\else\@shorttitle\fi}}%
  \def\@evenfoot{}%
}
\pagestyle{PLheadings}
\AtBeginDocument{\thispagestyle{plain}}

%=====================================================================
%=========================== frontmatter =============================

% The spacing specs (arg 2 of \list) are the same for the mshistory, abstract, and keywords environments, except that the abstract is indented somewhat.

% Single parameter determines the left and right margin size.
\newcommand{\frontmatterspacing}[1]{%
  \small
  \topsep 10\p@ \@plus4\p@   \@minus6\p@ % from size12.clo
  \advance\topsep by3.5ex plus -1ex minus -.2ex
  \setlength{\listparindent}{0em}
  \setlength{\itemindent}{0em}
  \setlength{\leftmargin}{#1}
  \setlength{\rightmargin}{\leftmargin}
  \setlength{\parskip}{0em}
}

\newenvironment{mshistory}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax}%
{\endlist}

\renewenvironment{abstract}%
{\sffamily\list{}{\frontmatterspacing{0.25in}}%
\item\relax\textbf{\abstractname} }%
{\endlist}

\newenvironment{keywords}%
{\sffamily\list{}{\frontmatterspacing{0em}}%
\item\relax\textbf{Keywords:}}%
{\endlist}

%=====================================================================
%============================ sectioning =============================

\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

\renewcommand{\section}{\@startsection{section}{1}{0pt}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\Large\sffamily\bfseries}}

\renewcommand{\subsection}{\@startsection{subsection}{2}{0pt}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\large\sffamily\bfseries}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0pt}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\normalsize\sffamily\bfseries}}

\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalsize\sffamily\bfseries}}

\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalsize\sffamily\it}}

% General formatting --- for punctuating section headings.
\renewcommand{\@seccntformat}[1]{\@nameuse{the#1}\hspace{1em}}

%=====================================================================
%============================ footnotes ==============================

\renewcommand{\@makefntext}[1]{%
  \parindent=0.25in
  \noindent \hbox to \z@{\hss{\textsuperscript{\@thefnmark}} \hfil}#1}

%=====================================================================
%============================ backmatter =============================

% Author addresses are accepted-version material. In anonymous mode the
% environment is processed in a discarded box, so an accidentally retained
% address block cannot appear in the review PDF.
\ifPLaccepted
  \newenvironment{addresses}%
  {\@@par
   \let\par\@empty
   \addvspace{3.25ex}%
   \noindent
   \small
   \newenvironment{address}%
     {\begin{minipage}[t]{19pc}\raggedright}%
     {\end{minipage}\hspace{.15pc plus1pc}}%
   \ignorespaces}%
  {\lineskiplimit 1pc
   \lineskip 1pc
   \@@par}
\else
  \newenvironment{addresses}%
  {\begingroup
   \newenvironment{address}{}{}%
   \setbox\z@\vbox\bgroup}%
  {\egroup\endgroup}
\fi

%=====================================================================
%======================== other environments =========================

% enumerate labeling that won't conflict with standard ex. numbers.
\renewcommand{\theenumi}{\roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii.}

% list spacing ought to satisfy \itemsep + \parsep < \topsep + \parskip
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@  \@plus2\p@ \@minus\p@
            \topsep 10\p@ \@plus4\p@ \@minus\p@
            \itemsep4\p@  \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi

%=====================================================================
%=========================== useful macros ===========================

\newcommand{\PLj}{\emph{Philosophical Logic}\xspace}
\newcommand{\spj}{\PLj}

\def\co{\colon\thinspace}

\DeclareRobustCommand\dash{%
  \unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}
\pdfstringdefDisableCommands{\renewcommand{\dash}{ - }}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}

\providecommand{\sv}[1]{\ensuremath{\llbracket #1 \rrbracket}}

%================================ miscellaneous ======================
%=====================================================================

\setlist{nosep} % reduce space between items in lists
