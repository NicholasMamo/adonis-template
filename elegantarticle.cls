\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantarticle}[2023/04/14 Elegant LaTeX article class]

% OPTIONS

\RequirePackage{ifthen}
\newboolean{twocolumn}
\setboolean{twocolumn}{false}

\DeclareOption{twocolumn}{
	\PassOptionsToClass{\CurrentOption}{article}
	\setboolean{twocolumn}{true}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% LAYOUT

\RequirePackage[T1]{fontenc}
\RequirePackage{mdframed}
\RequirePackage{newfloat}

% the class requires 'Source Serif' to be installed
% you may need to download and install  it, and then clear font cache using `fc-cache`
% other fonts: https://tug.org/FontCatalogue/
%
% debug in-use fonts with: `\meaning\sfdefault` and `\meaning\rmdefault`
\RequirePackage[rmdefault,regular,black]{sourceserifpro}
\RequirePackage[sfdefault]{sourcesanspro}

% colors
\definecolor{black}{rgb}{0,0,0}

% page size and margins: https://www.overleaf.com/learn/latex/Page_size_and_margins
\ifthenelse{\boolean{twocolumn}}{\def\margin{25mm}}{\def\margin{40mm}}
\RequirePackage[a4paper, bindingoffset=0.2in,
				left=\margin, right=\margin, top=57mm, bottom=57mm,
				footskip=15mm]{geometry}

% add space between columns
\setlength{\columnsep}{10mm}

% font size: https://www.overleaf.com/learn/latex/Writing_your_own_class
\ifthenelse{\boolean{twocolumn}}{\def\lineheight{13}}{\def\lineheight{14}}
\renewcommand{\tiny}{\fontsize{7}{10}\selectfont}
\renewcommand{\footnotesize}{\fontsize{8}{11}\selectfont}
\renewcommand{\small}{\fontsize{9}{12.5}\selectfont}
\renewcommand{\normalsize}{\fontsize{10}{\lineheight}\selectfont}
\renewcommand\familydefault{\rmdefault}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\seriesdefault{m}

% variables
\newcommand\affiliation[1]{\gdef\@affiliation{#1}}
\newcommand\correspondence[1]{\gdef\@correspondence{#1}}

\DeclareFloatingEnvironment[placement={!b}]{frontmatter}
\newenvironment{frontmattercontainer}[1][]{
	\begin{frontmatter}
		\begin{mdframed}[linecolor=black, linewidth=0.25mm,
						 innertopmargin=0.25cm, innerrightmargin=0, innerbottommargin=0, innerleftmargin=0,
						 topline=true, rightline=false, bottomline=false, leftline=false]
		\footnotesize
		}{
		\end{mdframed}
	\end{frontmatter}
}

\renewcommand{\maketitle}{
	{\noindent\fontsize{20}{20}\selectfont\@title\smallskip\par}
	{\noindent\fontshape{it}\selectfont\@author\par}
	\begin{frontmattercontainer}
		\@affiliation \par
		{\sffamily\fontseries{sb}\selectfont\scshape Draft} \@date \par
		{\sffamily\fontseries{sb}\selectfont\scshape Correspondence} \@correspondence \par
	\end{frontmattercontainer}
}

% From: https://latexref.xyz/_005c_0040startsection.html
% More on plus and minus: https://latexref.xyz/Lengths.html
\renewcommand{\section}{
	\@startsection
	{section} % name
	{1}       % level
	{0pt}     % indent
	{-5ex plus -1ex minus -.2ex} % beforeskip
	{1ex plus 0.2ex minus -.2ex} % afterskip
	{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont}
}

\renewcommand{\subsection}{
	\@startsection
	{subsection} % name
	{2}          % level
	{0pt}        % indent
	{-5ex plus -1ex minus -.2ex} % beforeskip
	{1ex plus 0.2ex minus -.2ex} % afterskip
	{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont}
}

\renewcommand{\subsubsection}{
	\@startsection
	{subsubsection} % name
	{2}             % level
	{0pt}           % indent
	{-5ex plus -1ex minus -.2ex} % beforeskip
	{-1ex plus 0.2ex minus -.2ex} % afterskip
	{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont}
}