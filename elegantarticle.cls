\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantarticle}[2023/04/14 Elegant LaTeX article class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% the class requires 'Noto Serif' to be installed
% download and install font, and then clear font cache using `fc-cache`
% other fonts: https://tug.org/FontCatalogue/
\RequirePackage{noto-serif}
\RequirePackage[T1]{fontenc}
\usepackage[a4paper, bindingoffset=0.2in,
			left=40mm, right=40mm, top=57mm, bottom=57mm,
			footskip=.25in]{geometry}

% font size: https://www.overleaf.com/learn/latex/Writing_your_own_class#Options
\renewcommand{\normalsize}{\fontsize{9}{12}\selectfont}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\seriesdefault{m}

% page size and margins: https://www.overleaf.com/learn/latex/Page_size_and_margins
%\setlength{\lmargin}{40cm}
%\setlength{\textheight}{22cm}