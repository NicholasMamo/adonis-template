\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elegantarticle}[2023/04/14 Elegant LaTeX article class]


% the class requires 'Noto Serif' to be installed
% download and install font, and then clear font cache using `fc-cache`
% other fonts: https://tug.org/FontCatalogue/
\RequirePackage{noto-serif}
\RequirePackage[T1]{fontenc}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\renewcommand{\normalsize}{\fontsize{9}{12}\selectfont}

% font weights: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/base/fntguide.pdf
\renewcommand\seriesdefault{m}