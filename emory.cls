%% Emory Dissertation Class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{emory}[2016/08/01 LaTeX Emory dissertation class]

%% Declare options can be passed on to report.cls
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{report} }
\DeclareOption{final}{\PassOptionsToClass{final}{report} }

%% Disable options
\DeclareOption{a4paper}{\ClassWarning{emory}{Page size 'a4' not allowed.}}
\DeclareOption{a5paper}{\ClassWarning{emory}{Page size 'a5' not allowed.}}
\DeclareOption{b5paper}{\ClassWarning{emory}{Page size 'b5' not allowed.}}
\DeclareOption{legalpaper}{\ClassWarning{emory}{Page size 'legal' not allowed.}}
\DeclareOption{executivepaper}{\ClassWarning{emory}{Page size 'executive' not allowed.}}
\DeclareOption{10pt}{\ClassWarning{emory}{Font size '10pt' not allowed.}}
\DeclareOption{twocolumn}{\ClassWarning{emory}{Two columns style not allowed.}}
\DeclareOption{notitlepage}{\ClassWarning{emory}{'notitlepage' not allowed.}}
\DeclareOption{landscape}{\ClassWarning{emory}{Landscape layout not allowed.}}
\DeclareOption{twoside}{\ClassWarning{emory}{Uneven side margins not allowed.}}

%% Custom options
\newif\if@DoubleSided

\@DoubleSidedtrue

\DeclareOption{doublesided}{\@DoubleSidedtrue}
\DeclareOption{singlesided}{\@DoubleSidedfalse}

%% Process options and load class
\ProcessOptions
\LoadClass[letter]{report}

%% Load dependent packages
\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}

%% Internal commands

% double spacing
\def\doublespacing{ \ifcase \@ptsize \relax
  \def \baselinestretch {1.771}%	11pt
  \or \def \baselinestretch {1.660}%	12pt
  \fi \setspace@size}
  

%% Define global document properties
\AtBeginDocument{
	\setlength{\topmargin}{-0.30in}
	\setlength{\headheight}{0.20in}
	\setlength{\headsep}{0.0in}
	\setlength{\topskip}{0.40in}	% first line, down from page number
	\setlength{\textheight}{9.10in}	% 9"-(topmargin+headsep+headheight)
	\setlength{\footskip}{0pt}
	\setlength{\oddsidemargin}{0.50in}
	\setlength{\evensidemargin}{0.00in}
	\setlength{\parindent}{0.40in}	% somewhere between 0.3" and 0.5"
	\setlength{\textwidth}{7.0in}
	\setlength{\leftmargini}{3.5em}
	\setlength{\leftmarginii}{2.2em}
	\setlength{\leftmarginiii}{2.2em}
	\setlength{\leftmarginiv}{2.2em}
	\setlength{\leftmarginv}{2.2em}
	\setlength{\leftmarginvi}{2.2em}
	\setlength{\leftmargin}{\leftmargini}
	\setlength{\labelsep}{.5em}
	\setlength{\labelwidth}{ 1.5em}
	\pagenumbering{arabic}
	\pagestyle{myheadings}
	\markright{}
	\normalsize
	\normalfont
	\doublespacing	% footnotes and floats still singlespaced
}

%%  Print special pages
% Distribution Agreement
\newcommand*{\th@DistributionAgreement}{
  \thispagestyle{empty}
  \vfill
  \begin{center}
  In presenting this thesis or dissertation as a partial fulfillment of the requirements for an advanced
  degree from Emory University, I hereby grant to Emory University and its agents the non-exclusive
  license to archive, make accessible, and display my thesis or dissertation in whole or in part in all
  forms of media, now or hereafter known, including display on the world wide web. I understand
  that I may select some access restrictions as part of the online submission of this thesis or
  dissertation. I retain all ownership rights to the copyright of the thesis or dissertation. I also retain
  the right to use in future works (such as articles or books) all or part of this thesis or dissertation.
  \end{center}
  \vspace 1in
  Signature:
  
  \underline{\hspace{2.5in}}\hspace{1in}\underline{\hspace{1.5in}}\newline
  Student Name \hspace{2in} Date
  \vfill
}

% Approval Sheet
\newcommand*{\th@ApprovalSheet}{
  \thispagestyle{empty}
} 
