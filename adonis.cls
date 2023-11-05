\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{adonis}[2023/11/05 Adonis LaTeX article class]

% OPTIONS

\RequirePackage{etoolbox}
\newbool{dark} \boolfalse{dark}
\newbool{legacy} \boolfalse{legacy}
\newbool{twocolumn} \boolfalse{twocolumn}
\newbool{wide} \boolfalse{wide}

\DeclareOption{dark}{\booltrue{dark}}
\DeclareOption{legacy}{\booltrue{legacy}}
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

% dark mode: set the page color to a dark grey and text color to white
\ifbool{dark}{
	\RequirePackage{pagecolor}
	\RequirePackage{xcolor}
	
	\definecolor{DarkGrey}{HTML}{121212}
	
	\pagecolor{DarkGrey}
	\color{white}
}{}

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
\newcommand\subtitle[1]{\gdef\@subtitle{#1}}
\newcommand\affiliation[1]{\gdef\@affiliation{#1}}
\newcommand\correspondence[1]{\gdef\@correspondence{#1}}
\newcommand\version[1]{\gdef\@version{#1}}
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
	\ifdef{\@title}{
		\begin{flushleft}
			{\ifbool{twocolumn}{\Large}{\huge} \selectfont \noindent 
				\@title
				\ifdef{\@subtitle}{\vspace{-0.2cm}}{\vspace{0.2cm} \par}
			}
	\end{flushleft}}{}
	\ifdef{\@subtitle}{
		\begin{flushleft}
			{\large \selectfont \noindent 
				\textit{\@subtitle} \par
			}
	\end{flushleft}}{}
	\ifdef{\@author}{{\small \selectfont \noindent \@author \vspace{0.25cm} \par}}{}
	\ifdef{\@abstract}{{\small \fontshape{it} \selectfont \noindent \@abstract \par}}{}
	{\noindent\rule{\linewidth}{0.5pt} }
	\ifbool{twocolumn}{\vspace{\fill}}{}
	
	\ifboolexpr{test {\ifdef{\@affiliation}} or test {\ifdef{\@correspondence}} or test {\ifdef{\@version}}}{
		\begin{frontmattercontainer}
			\ifdef{\@affiliation}{{\sffamily\fontseries{sb}\selectfont\scshape Affiliation} \@affiliation \par}{}
			
			\ifdef{\@correspondence}{{\sffamily\fontseries{sb}\selectfont\scshape Correspondence} \@correspondence \par}{}
			
			\ifdef{\@version}{{\sffamily\fontseries{sb}\selectfont\scshape Version} \@version \par}{}
		\end{frontmattercontainer}
	}{}
}

% TYPOGRAPHY

% load the Noto font first so that it only affects mathematical notation
% the font requires TeXlive 2021 or later
\ifbool{legacy}{}{\RequirePackage[scale=0.95]{notomath}}

% the class requires 'Source Serif' to be installed
% you may need to download and install the package, and then clear font cache using `fc-cache`
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
\DisableLigatures{encoding=T1,shape=sc}

% font size: https://www.overleaf.com/learn/latex/Writing_your_own_class
\ifbool{twocolumn}{\def\lineheight{13}}{\def\lineheight{14}}
\renewcommand{\tiny}{\fontsize{7}{10}\selectfont}
\renewcommand{\footnotesize}{\fontsize{8}{11}\selectfont}
\renewcommand{\small}{\fontsize{9.5}{12.5}\selectfont}
\renewcommand{\normalsize}{\fontsize{10}{\lineheight}\selectfont}
\renewcommand{\large}{\fontsize{13}{15}\selectfont}
\renewcommand{\Large}{\fontsize{16}{19}\selectfont}
\renewcommand{\LARGE}{\fontsize{18}{21}\selectfont}
\renewcommand{\huge}{\fontsize{20}{24}\selectfont}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\textbf[1]{{\fontseries{sb}\selectfont#1}}

% More on plus and minus: https://latexref.xyz/Lengths.html
\RequirePackage{titlesec}
\titleformat{\section} % command
			{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont} % format
			{\thesection} % label
			{0pt} % skip
			{\hspace*{1ex}} % space between number and heading
\titlespacing{\section}{0pt}
			 {4ex plus 0.5ex minus .5ex} % beforeskip
			 {1ex plus 0.2ex minus .2ex} % afterskip		
\titleformat{name=\section,numberless} % command
			{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont} % format
			{} % no label
			{0pt} % skip
			{} % no space between number and heading

\titleformat{\subsection} % command
			{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont} % format
			{\thesubsection} % label
			{0pt} % skip
			{\hspace*{1ex}} % space between number and heading
\titlespacing{\subsection}{0pt}
			 {2ex plus 0.5ex minus .5ex} % beforeskip
			 {1.5ex plus 0.2ex minus .2ex} % afterskip

\titleformat{\subsubsection} % command
			[runin]
			{\sffamily\fontseries{sb}\scshape\fontsize{10}{10}\selectfont} % format
			{\thesubsubsection} % label
			{0pt} % skip
			{\hspace*{1ex}} % space between number and heading
\titlespacing{\subsubsection}{0pt}
			 {1ex plus 0.5ex minus .5ex} % beforeskip
			 {1ex plus 0.2ex minus .2ex} % afterskip

% OTHER ELEMENTS

% tables
\setlength{\tabcolsep}{10pt} % cell padding
\renewcommand{\arraystretch}{1.5} % row spacing

% margin notes
\makeatletter
\renewcommand{\@marginparreset}{\reset@font\footnotesize\@setminipage}
\makeatother

% horizontal separator
\newcommand{\separator}{
	\begin{center}
		\rule{0.618\linewidth}{0.5pt}	
	\end{center}
}