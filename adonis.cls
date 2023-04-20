\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{adonis}[2023/04/14 Adonis LaTeX article class]

% OPTIONS

\RequirePackage{etoolbox}
\newbool{twocolumn}
\boolfalse{twocolumn}
\newbool{wide}
\boolfalse{wide}

\DeclareOption{twocolumn}{
	\PassOptionsToClass{\CurrentOption}{article}
	\booltrue{twocolumn}
}
\DeclareOption{wide}{\booltrue{wide}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% LAYOUT

% enable frame using the `showframe` option
% page size and margins: https://www.overleaf.com/learn/latex/Page_size_and_margins
\ifboolexpr{bool {twocolumn} or bool {wide}}{\def\margin{25mm}}{\def\margin{40mm}}
\RequirePackage[a4paper, bindingoffset=0.2in,
				left=\margin, right=\margin, top=57mm, bottom=57mm,
				footskip=15mm]{geometry}

% add space between columns
\setlength{\columnsep}{10mm}

% header and footer
\newcommand\runningauthor[1]{\gdef\@runningauthor{#1}}
\newcommand\runningtitle[1]{\gdef\@runningtitle{#1}}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\thispagestyle{empty} % not on first page
\lhead{\footnotesize \ifdefined\@runningauthor \@runningauthor \else \@author \fi}
\rhead{\footnotesize \ifdefined\@runningtitle \@runningtitle \else \@title \fi}
\cfoot{\footnotesize \thepage}

% title
\newcommand\affiliation[1]{\gdef\@affiliation{#1}}
\newcommand\correspondence[1]{\gdef\@correspondence{#1}}
\renewcommand\abstract[1]{\gdef\@abstract{#1}}

% show the rest of the frontmatter as a footer
\RequirePackage{newfloat}
\DeclareFloatingEnvironment[placement={!b}]{frontmatter}
\newenvironment{frontmattercontainer}[1][]{
	\begin{frontmatter}
		\rule{\linewidth}{0.5pt}
		\footnotesize
	}{
	\end{frontmatter}
}

\renewcommand{\maketitle}{
	\noindent
	\ifdefined \@title {\huge \selectfont \noindent \@title \vspace{0.2cm} \par} \fi
	\ifdefined \@author {\small \selectfont \noindent \@author \vspace{0.25cm} \par} \fi
	\ifdefined \@abstract {\small \fontshape{it} \selectfont \noindent \@abstract \bigskip \par} \fi
	{\noindent\rule{\linewidth}{0.5pt} }
	\ifbool{twocolumn}{\vspace{\fill}}{}
	
	\ifdefined \@affiliation
	\ifdefined \@date
	\ifdefined \@correspondence
		\begin{frontmattercontainer}
			\ifdefined \@affiliation
			\@affiliation \par
			\fi
			\ifdefined \@date
			{\sffamily\fontseries{sb}\selectfont\scshape Draft} \@date \par
			\fi
			\ifdefined \@correspondence
			{\sffamily\fontseries{sb}\selectfont\scshape Correspondence} \@correspondence \par
			\fi
		\end{frontmattercontainer}
	\fi
	\fi
	\fi
}

% TYPOGRAPHY

% the class requires 'Source Serif' to be installed
% you may need to download and install  it, and then clear font cache using `fc-cache`
% other fonts: https://tug.org/FontCatalogue/
%
% to use a font temporarily, see their packages
% for example, the quattrocento font uses macros \quattrocento and \quattrocentosans: https://www.ctan.org/tex-archive/fonts/quattrocento/
% bookman uses \fontfamily{pbk}, which are the first three letters of the font: https://www.ctan.org/tex-archive/fonts/psfonts/psnfss-source/bookman
%
% debug in-use fonts with: `\meaning\sfdefault` and `\meaning\rmdefault`
\RequirePackage[rmdefault]{sourceserifpro}
\RequirePackage[sfdefault]{sourcesanspro}
\RequirePackage[T1]{fontenc}

% set the default fonts
\renewcommand\familydefault{\rmdefault}
\renewcommand{\ttdefault}{txtt}

% add protrusion (punctuation can bleed into margins) and text expansion (to vary font width for more even spacing)
% docs: https://ctan.math.illinois.edu/macros/latex/contrib/microtype/microtype.pdf
\RequirePackage[protrusion=true,factor=500,expansion=true]{microtype}

% font size: https://www.overleaf.com/learn/latex/Writing_your_own_class
\ifbool{twocolumn}{\def\lineheight{13}}{\def\lineheight{14}}
\renewcommand{\tiny}{\fontsize{7}{10}\selectfont}
\renewcommand{\footnotesize}{\fontsize{8}{11}\selectfont}
\renewcommand{\small}{\fontsize{9.5}{12.5}\selectfont}
\renewcommand{\normalsize}{\fontsize{10}{\lineheight}\selectfont}
\renewcommand{\large}{\fontsize{16}{19}\selectfont}
\renewcommand{\huge}{\fontsize{20}{24}\selectfont}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\textbf[1]{{\fontseries{sb}\selectfont#1}}

% From: https://latexref.xyz/_005c_0040startsection.html
% More on plus and minus: https://latexref.xyz/Lengths.html
\renewcommand{\section}{
	\@startsection
	{section} % name
	{1}       % level
	{0pt}     % indent
	{-4ex plus -1ex minus -.2ex} % beforeskip
	{1ex plus 0.2ex minus -.2ex} % afterskip
	{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont}
}

\renewcommand{\subsection}{
	\@startsection
	{subsection} % name
	{2}          % level
	{0pt}        % indent
	{-2ex plus -1ex minus -.2ex} % beforeskip
	{1ex plus 0.2ex minus -.2ex} % afterskip
	{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont}
}

\renewcommand{\subsubsection}{
	\@startsection
	{subsubsection} % name
	{2}             % level
	{0pt}           % indent
	{-1ex plus -1ex minus -.2ex} % beforeskip
	{-2ex plus 0.2ex minus -.2ex} % afterskip
	{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont}
}

% OTHER ELEMENTS

% tables
\setlength{\tabcolsep}{10pt} % cell padding
\renewcommand{\arraystretch}{1.5} % row spacing

% margin notes
\makeatletter
\renewcommand{\@marginparreset}{\reset@font\footnotesize\@setminipage}
\makeatother