%% Emory Dissertation Class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{emory}[2016/08/01 LaTeX Emory dissertation class]

%% Load dependent packages
\RequirePackage{ifthen}
%\RequirePackage{geometry}
%\RequirePackage{fancyhdr}

%% Declare options can be passed on to report.cls
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\DeclareOption{final}{\PassOptionsToClass{final}{report}}
\DeclareOption{letter}{\PassOptionsToClass{letter}{report}}

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
\newboolean{IfDoubleSided}
\newboolean{IfDissertation}

% Set default values
\setboolean{IfDoubleSided}{true}
\setboolean{IfDissertation}{true}


\DeclareOption{doublesided}{\setboolean{IfDoubleSided}{true}}
\DeclareOption{singlesided}{\setboolean{IfDoubleSided}{false}}
\DeclareOption{thesis}{\setboolean{IfDissertation}{false}}
\DeclareOption{dissertation}{\setboolean{IfDissertation}{true}}

\newcommand*{\th@PageGeometry}{%
	\setlength{\topmargin}{-0.30in}
	\setlength{\headheight}{0.20in}
	\setlength{\headsep}{0.0in}
	\setlength{\topskip}{0.40in}	% first line, down from page number
	\setlength{\footskip}{0pt}
	\setlength{\oddsidemargin}{0.50in}
	\setlength{\evensidemargin}{0.00in}
	\setlength{\parindent}{0.40in}	% somewhere between 0.3" and 0.5"
	\setlength{\textheight}{9.10in}	% 9"-(topmargin+headsep+headheight)
	\setlength{\textwidth}{7.0in}
%	\setlength{\leftmargini}{3.5em}
%	\setlength{\leftmarginii}{2.2em}
%	\setlength{\leftmarginiii}{2.2em}
%	\setlength{\leftmarginiv}{2.2em}
%	\setlength{\leftmarginv}{2.2em}
%	\setlength{\leftmarginvi}{2.2em}
	\setlength{\leftmargin}{3.5em}
%	\setlength{\labelsep}{.5em}
%	\setlength{\labelwidth}{1.5em}
	\pagenumbering{arabic}
%	\pagestyle{myheadings}
%	\markright{}
	\normalsize
	\normalfont
%	\doublespacing	% footnotes and floats still singlespaced
}

%% Process options and load class
\ProcessOptions
\LoadClass{report}

%% Internal commands

% double spacing
\def\doublespacing{ \ifcase \@ptsize \relax
  \def \baselinestretch {1.771}%	11pt
  \or \def \baselinestretch {1.660}%	12pt
  \fi \setspace@size}
  

%% Internal preamble commands -- provide warning messages
\newcommand*{\th@PassCmd}[2]{\gdef#1{#2}}
\newcommand*{\th@title}{%
  \ClassWarning{emory}{Missing title!}
}
\newcommand*{\th@author}{%
  \ClassWarning{emory}{Missing author name!}
}
\newcommand*{\th@degree}{%
  \ClassWarning{emory}{Missing degree!}{Help}
}
\newcommand*{\th@previousdegree}{%
  \ClassWarning{emory}{Missing previous degree!}
}
\newcommand*{\th@field}{%
  \ClassWarning{emory}{Missing field of study!}
}
\newcommand*{\th@advisor}{%
  \ClassWarning{emory}{Missing advisor name!}
}
\newcommand*{\th@advisordegree}{%
  \ClassWarning{emory}{Missing advisor's degree!}
}
\newcommand*{\th@committee}{%
  \ClassWarning{emory}{Missing committee!}
}
\newcommand*{\th@year}{%
  \ClassWarning{emory}{Missing graduation year!}
}


%\newenvironment*{abstract}{}{}


%\newenvironment*{acknowledgement}{}{}


%% Define special pages
% Distribution Agreement
\newcommand*{\th@DistributionAgreement}{%
  \thispagestyle{empty}
  \vfill
  \large\textbf{Distribution Agreement}\\
  \normalsize
  \vspace{2ex}
  In presenting this thesis or dissertation as a partial fulfillment of the requirements for an advanced
  degree from Emory University, I hereby grant to Emory University and its agents the non-exclusive
  license to archive, make accessible, and display my thesis or dissertation in whole or in part in all
  forms of media, now or hereafter known, including display on the world wide web. I understand
  that I may select some access restrictions as part of the online submission of this thesis or
  dissertation. I retain all ownership rights to the copyright of the thesis or dissertation. I also retain
  the right to use in future works (such as articles or books) all or part of this thesis or dissertation.
  \newline
  \vspace{1in}
  Signature: \newline
  \vspace{1em}
  \begin{tabular}{l l}
  \underline{\hspace{2.5in}}\hspace{1in} & \underline{\hspace{1.5in}}\\
  \th@author & Date\\
  \end{tabular}
  \clearpage
}

% Approval Sheet
\newcommand*{\th@ApprovalSheet}{%
  \thispagestyle{empty}
  \begin{center}
    \th@title
    \vspace{1em}
    by
    \vspace{1em}
    \th@author
    \vspace{1em}
    \th@degree
    \vspace{1ex}
    \th@field
    \vspace{2ex}
    \underline{\hspace{3in}}\hspace{2in}\newline
    \th@advisor, \th@advisordegree\newline
    Advisor
    \underline{\hspace{3in}}\hspace{2in}\newline
    \th@committee \newline
    Committee Member
    \vspace{1in}
    Accepted:
    \underline{\hspace{4in}}\newline
    Lisa A.\ Tedesco, Ph.D.\newline
    Dean of the James T.\ Laney School of Graduate Studies\newline
    \vspace{1em}
    \underline{\hspace{2in}}\newline
    Date
  \end{center}
  \clearpage
} 

\newcommand*{\th@AbstractCoverPage}{%
  \thispagestyle{empty}
  \begin{center}
    \th@title
    \vspace{1in}
    by
    \vspace{1in}
    \th@author
    \th@previousdegree
    \vspace{1in}
    Advisor: \th@advisor, \th@advisordegree
    \vfill
    An abstract of \newline
    A \ifthenelse{\boolean{IfDissertation}}{dissertation}{thesis} submitted to the Faculty of the \newline
    James T.\ Laney School of Graduate Studies of Emory University \newline
    in partial fulfillment of the requirements for the degree of \newline
    \th@degree \newline
    in \th@field \newline
    \th@year
    \vfill
  \end{center}
  \clearpage
}

\newcommand*{\th@AbstractPage}{%
  \th@author
  \clearpage
}

\newcommand*{\th@CoverPage}{%
  \begin{center}
    \th@title
    \vspace{1in}
    by
    \vspace{1in}
    \th@author\newline
    \th@previousdegree\newline
    \vspace{1in}
    Advisor: \th@advisor, \th@advisordegree\newline
    \vfill
    A \ifthenelse{\boolean{IfDissertation}}{dissertation}{thesis} submitted to the Faculty of the \newline
    James T.\ Laney School of Graduate Studies of Emory University \newline
    in partial fulfillment of the requirements for the degree of \newline
    \th@degree \newline
    in \th@field \newline
    \th@year
    \vfill
  \end{center}
  \clearpage
}

\newcommand*{\th@Acknowledgement}{%
  Acknowledgement
  \clearpage
}
%% Make special pages
\AtBeginDocument{
  \th@PageGeometry            % set page geometry
	\pagenumbering{gobble}     % suppress page numbering 
  \typeout{>>> Make Distribution Agreement >>>}
  \th@DistributionAgreement
  \typeout{>>> Make Approval Sheet >>>}
  \th@ApprovalSheet
  \typeout{>>> Make Abstract Cover Page >>>}
  \th@AbstractCoverPage
  \typeout{>>> Make Abstract Page >>>}
  \th@AbstractPage
  \typeout{>>> Make Cover Page >>>}
  \th@CoverPage
  \typeout{>>> Make Acknowledgement Page >>>}
  \th@Acknowledgement
  \typeout{>>> Make Table of Contents >>>}
  \tableofcontents
  \typeout{}
  \typeout{--------------------------------------}
  \typeout{}
  \typeout{Make Body}
  \setcounter{page}{0}
  \pagenumbering{arabic}
}
  
%% Define preamble commands
\renewcommand*{\title}[1]{\th@PassCmd{\th@title}{#1}}
\renewcommand*{\author}[1]{\th@PassCmd{\th@author}{#1}}
\newcommand*{\degree}[1]{\th@PassCmd{\th@degree}{#1}}
\newcommand*{\previousdegree}[1]{\th@PassCmd{\th@previousdegree}{#1}}
\newcommand*{\field}[1]{\th@PassCmd{\th@field}{#1}}
\newcommand*{\advisor}[1]{\th@PassCmd{\th@advisor}{#1}}
\newcommand*{\advisordegree}[1]{\th@PassCmd{\th@advisordegree}{#1}}
\newcommand*{\committee}[1]{\th@PassCmd{\th@committee}{#1}}
\newcommand*{\yr}[1]{\th@PassCmd{\th@year}{#1}}
