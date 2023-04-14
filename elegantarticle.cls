\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantarticle}[2023/04/14 Elegant LaTeX article class]

% OPTIONS

\RequirePackage{ifthen}
\newboolean{onecolumn}
\setboolean{onecolumn}{false}

\DeclareOption{onecolumn}{
	\PassOptionsToClass{\CurrentOption}{article}
	\setboolean{onecolumn}{true}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% LAYOUT

% the class requires 'Source Serif' to be installed
% you may need to download and install  it, and then clear font cache using `fc-cache`
% other fonts: https://tug.org/FontCatalogue/
%
% debug in-use fonts with: `\meaning\sfdefault` and `\meaning\rmdefault`
\RequirePackage[rmdefault,regular,black]{sourceserifpro}
\RequirePackage[sfdefault]{sourcesanspro}
\RequirePackage[T1]{fontenc}
\usepackage[LGR, T1]{fontenc}

% page size and margins: https://www.overleaf.com/learn/latex/Page_size_and_margins
\ifthenelse{\boolean{onecolumn}}{\def\margin{40mm}}{\def\margin{25mm}}
\RequirePackage[a4paper, bindingoffset=0.2in,
				left=\margin, right=\margin, top=57mm, bottom=57mm,
				footskip=.25in]{geometry}

% add space between columns
\setlength{\columnsep}{10mm}

% font size: https://www.overleaf.com/learn/latex/Writing_your_own_class#Options
\ifthenelse{\boolean{onecolumn}}{\def\lineheight{14}}{\def\lineheight{13}}
\renewcommand{\normalsize}{\fontsize{10}{\lineheight}\selectfont}
\renewcommand\familydefault{\rmdefault}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\seriesdefault{m}

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