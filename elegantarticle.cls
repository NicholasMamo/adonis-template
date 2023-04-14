\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantarticle}[2023/04/14 Elegant LaTeX article class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

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
\RequirePackage[a4paper, bindingoffset=0.2in,
			left=40mm, right=40mm, top=57mm, bottom=57mm,
			footskip=.25in]{geometry}

% font size: https://www.overleaf.com/learn/latex/Writing_your_own_class#Options
\renewcommand{\normalsize}{\fontsize{10}{14}\selectfont}
\renewcommand\familydefault{\rmdefault}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\seriesdefault{m}