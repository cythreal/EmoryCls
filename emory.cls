%%%%%%%%%%%%%%%%%%%%%% Emory Dissertation Class %%%%%%%%%%%%%%%%%%%%%
% This class provides style settings suitable for the dissertation  %
% of the Laney Graduate School of Emory University, specially for   %
% STEM fields of study                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------------------------ Class declaration ----------------------
\ProvidesClass{emory}[2016/08/01 LaTeX class for Emory dissertation]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{ifthen}

% ----- Declare options can be passed on to report.cls -----
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\DeclareOption{final}{\PassOptionsToClass{final}{report}}
\DeclareOption*{\OptionNotUsed \ClassWarning{emory}{'\CurrentOption' not allowed.}}

% ----- Process options & load class -----%
\ProcessOptions
\LoadClass[12pt]{report}
% ----------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------ Page Style Control ------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----- Declare boolean switches
\newboolean{If@doc@dissertation}
\setboolean{If@doc@dissertation}{true}
\newboolean{If@style@twoside}
\setboolean{If@style@twoside}{false}

% ----- Define key value pairs -----
\RequirePackage{xkeyval}
\define@boolkey[emory]{doc}{dissertation}[true]{%
  \setboolean{If@doc@dissertation}{#1}
}

\define@boolkey[emory]{style}{twoside}[false]{%
  \setboolean{If@style@twoside}{#1}
}

\define@choicekey+[emory]{style}{major}[\val\nr]{chem,phys,math,bio,cs}[]{%
  \ifcase\nr\relax
    \load@chem@package
    \set@chem@style
    \newcommand*{\@th@bibstyle@major}{chem}
  \or
    \load@phys@package
    \newcommand*{\@th@bibstyle@major}{phys}    
  \or
    \load@math@package
    \newcommand*{\@th@bibstyle@major}{math}    
  \or
    \load@bio@package
    \newcommand*{\@th@bibstyle@major}{bio}    
  \or
    \load@cs@package
    \newcommand*{\@th@bibstyle@major}{cs}    
  \fi
}{%
  \newcommand*{\@th@bibstyle@major}{default}
  \ClassWarning{emory}{Use default style}%
}

% ------ define custome environments -------
\newenvironment{schematic}{%
\begin{figure}[htp!]
\renewcommand{\figurename}{Schematic}
}{\end{figure}}

% ------ Load packages shared by all majors -------
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{color}

% double space for 12pt font
\renewcommand*{\baselinestretch}{1.655}
\renewcommand*{\arraystretch}{1}

% ------ Load major specific package ------
\newcommand*{\load@math@package}{%
  \RequirePackage{amsfonts}
  \RequirePackage{amssymb}
}
\newcommand*{\load@chem@package}{%
  \RequirePackage[version=3]{mhchem}
}
\newcommand*{\load@phys@package}{%
  \RequirePackage[version=3]{mhchem}
}
\newcommand*{\load@bio@package}{%
}
\newcommand*{\load@cs@package}{%
  \RequirePackage{fancyvrb}
}

% ------ Define major specific style sequences ------
\newcommand*{\set@chem@style}{%
  \cfg@chapter@chptname@arabic
  \cfg@section@arabic
  \cfg@itemize@bullet
  \cfg@itemize@sep
  \cfg@toc
  \cfg@table
}

% ------ Configure styles for individual page elements -------
% --- chapter with arabic numbering and "Chapter"
\newcommand*{\cfg@chapter@chptname@arabic}{%
  \titleformat{\chapter}[block]{\bfseries\LARGE}{\chaptername\ \thechapter}{2ex}{}
  \titlespacing{\chapter}{0pt}{0pt}{4ex}
}
% --- chapter with arabic numbering, without "Chapter"
\newcommand*{\cfg@chapter@nochptname@arabic}{%
  \titleformat{\chapter}[block]{\bfseries\LARGE}{\thechapter}{2ex}{}
  \titlespacing{\chapter}{0pt}{3pt}{4ex}
}
% --- chapter with roman numbering and "Chapter"
\newcommand*{\cfg@chapter@chptname@roman}{%
  \titleformat{\chapter}[block]{\bfseries\LARGE}{\chaptername\ \@Roman{\thechapter}}{2ex}{}
  \titlespacing{\chapter}{0pt}{3ex}{4ex}
}
% --- chapter with arabic numbering, without "Chapter"
\newcommand*{\cfg@chapter@nochptname@roman}{%
  \titleformat{\chapter}[block]{\bfseries\LARGE}{\@Roman{\thechapter}}{2ex}{}
  \titlespacing{\chapter}{0pt}{3ex}{4ex}
}
% --- section/subsections with arabic numbering
\newcommand*{\cfg@section@arabic}{%
  \titleformat{\section}[block]{\bfseries\Large}{\thesection}{2ex}{}
  \titlespacing{\section}{0pt}{4ex}{3ex}
  \titleformat{\subsection}[block]{\bfseries\large}{\thesubsection}{2ex}{}
  \titlespacing{\section}{0pt}{3ex}{2ex}
  \titleformat{\subsubsection}[block]{\bfseries\normalsize}{}{2ex}{}
  \titlespacing{\subsubsection}{0pt}{2ex}{2ex}
}
% --- configure lists and enumerates 
\newcommand*{\cfg@itemize@bullet}{%
  \renewcommand{\labelitemi}{$\bullet$}
  \renewcommand{\labelitemii}{--}
  \renewcommand{\labelitemiii}{$\ast$}
  \renewcommand{\labelitemiv}{$\circ$}
  \renewcommand{\theenumii}{\arabic{enumii}}
  \renewcommand{\theenumiii}{\roman{enumiii}}
  \renewcommand{\theenumiv}{\alph{enumiv}}
  \renewcommand{\labelenumi}{\theenumi.}
  \renewcommand{\labelenumii}{(\theenumii).}
  \renewcommand{\labelenumiii}{(\theenumiii).}
  \renewcommand{\labelenumiv}{(\theenumiv).}
}
\newcommand*{\cfg@itemize@sep}{%
  \let\olditemize\itemize
  \renewcommand{\itemize}{\olditemize\setlength{\parsep}{0.2ex}}
  \let\oldenumerate\enumerate
  \renewcommand{\enumerate}{\oldenumerate\setlength{\parsep}{1ex}}
  \let\olditem\item
  \renewcommand{\item}{\setlength{\itemsep}{0.5ex}\olditem}
}
\newcommand*{\cfg@toc}{%
  \dottedcontents{chapter}[1.5em]{\bfseries\large\addvspace{1ex}}{1em}{0.75pc}
  \dottedcontents{section}[3.5em]{\normalsize}{2em}{0.75pc}
  \dottedcontents{subsection}[6.5em]{\normalsize}{3em}{0.75pc}
}
\newcommand*{\cfg@table}{%
  \setlength{\arrayrulewidth}{0.5pt}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------ Biblatex Style Handling ------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bibliography style. Set by user defined keys.
\newboolean{If@bib@preset}
\setboolean{If@bib@preset}{true}

% ------ Define key value pairs for bibliography control -----

\define@boolkey[emory]{bib}{preset}[true]{%
  \setboolean{If@bib@preset}{#1}
}

% ------ Load biblatex (last thing to do) -------
\newcommand*{\presetbibchem}[1]{%
  \RequirePackage[%
    backend=biber,
    style=chem-acs,
    citestyle=numeric-comp,
    bibstyle=chem-acs,
    autocite=superscript,
    sorting=none,
    maxnames=15,
    url=false,
    doi=false,
    eprint=false,
  ]{biblatex}
  \addbibresource{#1}
}

% --------------  The dean! --------------------%
\def\th@Dean{Lisa A.\ Tedesco, Ph.D}  %
% ----------------------------------------------%


%% Internal preamble commands -- provide warning messages
\newcommand*{\th@PassCmd}[2]{\gdef#1{#2}}
\newcount\th@advisor@count
\newcount\th@committee@count
\newcount\th@prevdeg@count
\newcount\@tmp
\newcount\@half

%% Define preamble commands
\renewcommand*{\title}[1]{\th@PassCmd{\th@title}{#1}}
\renewcommand*{\author}[1]{\th@PassCmd{\th@author}{#1}}
\newcommand*{\degree}[1]{\th@PassCmd{\th@degree}{#1}}
\newcommand*{\field}[1]{\th@PassCmd{\th@field}{#1}}
\newcommand*{\yr}[1]{\th@PassCmd{\th@year}{#1}}
\newcommand*{\prevdegree}[1]{%
  \global\advance\th@prevdeg@count\@ne\relax
  \expandafter\gdef\csname th@prevdegree\@roman\th@prevdeg@count \endcsname{#1}\relax
}
\newcommand*{\advisor}[2]{%
  \global\advance\th@advisor@count\@ne\relax
  \expandafter\gdef\csname th@advisor\@roman\th@advisor@count \endcsname{#1, #2}\relax
}
\newcommand*{\committee}[2]{%
  \global\advance\th@committee@count\@ne\relax
  \expandafter\gdef\csname th@committee\@roman\th@committee@count \endcsname{#1, #2}\relax
}

%% ----- Define special pages ------

% Distribution Agreement
\newcommand*{\th@DistributionAgreement}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \subsection*{Distribution Agreement}
  
  \noindent\normalsize
  In presenting this thesis or dissertation as a partial fulfillment of the 
  requirements for an advanced degree from Emory University, I hereby grant to 
  Emory University and its agents the non-exclusive license to archive, make 
  accessible, and display my thesis or dissertation in whole or in part in all 
  forms of media, now or hereafter known, including display on the world wide 
  web.  I understand that I may select some access restrictions as part of the 
  online submission of this thesis or dissertation.  I retain all ownership 
  rights to the copyright of the thesis or dissertation.  I also retain the 
  right to use in future works (such as articles or books) all or part of this 
  thesis or dissertation.
  
  
  \vspace{1in}
  \noindent Signature:
  \vspace{1em}
  
  \noindent
  \begin{tabular}{c c c}
  \underline{\hspace{2.5in}} & \hspace{0.25in} & \underline{\hspace{1.5in}}\\
  \th@author & \hspace{0.25in} & Date\\
  \end{tabular}
  \vspace*{\fill}
  
  \clearpage
}

% Approval Sheet
\newcommand*{\th@ApprovalSheet}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \noindent
  \begin{center}
    \large \th@title \normalsize
    \vspace{3ex}
    
    By
    \vspace{3ex}
    
    \th@author
    
    \th@degree
    \vspace{1ex}
    
    \th@field
    \vspace{5ex}
    
    \@tmp\z@\relax
    
    \loop
      \advance\@tmp\@ne\relax
      \underline{\hspace{4in}}
    
      \@nameuse{th@advisor\@roman\@tmp}
      
      Advisor
      \vspace{3ex}
      
      \ifnum\@tmp<\th@advisor@count\relax
    \repeat
    
    \vspace{1ex}
    
    \@tmp\z@\relax
    \ifnum\th@committee@count<4
      % less than 3 committee, one column layout
      \loop
        \advance\@tmp\@ne\relax
        \underline{\hspace{4in}}
        
        \@nameuse{th@committee\@roman\@tmp}
        
        Committee Member
        \vspace{3ex}
        
        \ifnum\@tmp<\th@committee@count\relax
      \repeat
    \else
      % more than 3 committee, two column layout
      \@half=\th@committee@count
      \ifodd\th@committee@count
        \divide\@half by\tw@
        \advance\@half\@ne
      \else
        \divide\@half by\tw@
      \fi
      
      \parbox[t][][c]{2.5in}{%
        \centering
        \loop
          \advance\@tmp\@ne\relax
          \underline{\hspace{2.4in}}
          
          \@nameuse{th@committee\@roman\@tmp}
          
          Committee Member
          \vspace{3ex}
          
          \ifnum\@tmp<\@half\relax
        \repeat
      }
      \parbox[t][][c]{2.5in}{%
        \@tmp=\@half
        \centering
        \loop
          \advance\@tmp\@ne\relax
          \underline{\hspace{2.4in}}
          
          \@nameuse{th@committee\@roman\@tmp}
          
          Committee Member
          \vspace{3ex}
          
          \ifnum\@tmp<\th@committee@count\relax
        \repeat
      }
    \fi
    
    \vspace*{\fill}
    
    Accepted:
    \vspace{2ex}
    
    \underline{\hspace{4in}}
    
    \th@Dean
    
    Dean of the James T.\ Laney School of Graduate Studies
    
    \vspace{5ex}
    \underline{\hspace{2in}}
    
    Date
  \end{center}
  \vspace*{\fill}
  \clearpage
} 

\newcommand*{\th@AbstractCoverPage}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{center}
    \large \th@title \normalsize
    \vspace{1in}
    
    By
    \vspace{1in}
    
    \th@author
    
    \@tmp\z@\relax
    \ifnum\th@prevdeg@count=\@ne
      \@nameuse{th@prevdegree\@roman\@ne}
    \else
      \@tmp\z@
      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@prevdegree\@roman\@tmp}
        
        \ifnum\@tmp<\th@prevdeg@count
      \repeat
    \fi
    
    \vspace{1in}
    
    \@tmp\z@\relax
    \ifnum\th@advisor@count=\@ne
      Advisor: \@nameuse{th@advisor\@roman\@ne}
    \else
      Advisor:

      \@tmp\z@
      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@advisor\@roman\@tmp}
        
        \ifnum\@tmp<\th@advisor@count
      \repeat          
    \fi
    
    \vfill
    An abstract of \\
    A \ifthenelse{\boolean{If@doc@dissertation}}{dissertation}{thesis} submitted to the Faculty of the \\
    James T.\ Laney School of Graduate Studies of Emory University \\
    in partial fulfillment of the requirements for the degree of \\
    \th@degree \\
    in \th@field \\
    \th@year
  \end{center}
  \vspace{1.5in}
  
  \clearpage
}

\newcommand*{\th@CoverPage}{%
  \thispagestyle{empty}
  \vspace*{\fill}

  \begin{center}
    \large \th@title \normalsize
    \vspace{1in}
    
    By
    \vspace{1in}
    
    \th@author
    
    \@tmp\z@\relax
    \ifnum\th@prevdeg@count=\@ne
      \@nameuse{th@prevdegree\@roman\@ne}
    \else
      \@tmp\z@
      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@prevdegree\@roman\@tmp}
        
        \ifnum\@tmp<\th@prevdeg@count
      \repeat
    \fi
    
    \vspace{1in}
    
    \@tmp\z@\relax
    \ifnum\th@advisor@count=\@ne
      Advisor: \@nameuse{th@advisor\@roman\@ne}
    \else
      Advisor:

      \loop
        \advance\@tmp\@ne\relax
        \@nameuse{th@advisor\@roman\@tmp}
        
        \ifnum\@tmp<\th@advisor@count
      \repeat          
    \fi
    
    \vfill
    A \ifthenelse{\boolean{If@doc@dissertation}}{dissertation}{thesis} submitted to the Faculty of the \\
    James T.\ Laney School of Graduate Studies of Emory University \\
    in partial fulfillment of the requirements for the degree of \\
    \th@degree \\
    in \th@field \\
    \th@year
  \end{center}
  \vspace{1.5in}
  \clearpage
}

\renewenvironment{abstract}{%
  \typeout{>>> Make Abstract Cover Page >>>}
  \thispagestyle{empty}

  \begin{center}
    \large
    \textbf{Abstract}
    \vspace{3ex}
    
    \th@title\normalsize
    
    \vspace{2ex}
    By \th@author
  \vspace{0.5in}
  
  \begin{minipage}[t]{4.5in}
}{%
  \end{minipage}
  \end{center}
  \clearpage
  \typeout{>>> Make Cover Page >>>}
  \th@CoverPage
}

\newenvironment{acknowledgement}{%
  \typeout{>>> Make Acknowledgement Page >>>}
  
  \thispagestyle{empty}
  
  \begin{center}
    \large
    \textbf{Acknowledgement}
  \end{center}
}{%
  \clearpage
}


%% ------ set up page geometry and header ------

\newcommand*{\set@geometry}{%
  \ifthenelse{\boolean{If@style@twoside}}{%
    \RequirePackage[onecolumn,twoside,paper=letterpaper,total={6in,9in},left=1.5in,right=1in,vmargin=1in,vcentering=true,landscape=false]{geometry}
  }{
    \RequirePackage[onecolumn,paper=letterpaper,total={6.5in,9in},hmargin={1.5in,1in},vmargin=1in,vcentering=true,landscape=false]{geometry}}
}

\newcommand*{\set@header}{%
  \RequirePackage{fancyhdr}
  % set page numbering on the right top
  \pagestyle{myheadings}
  \ifthenelse{\boolean{If@style@twoside}}{%
    \fancyhead[RO, RE]{\thepage}
  }{%
    \rhead{\thepage}
  }
  % get rid of page number footer on chapter pages
  \fancypagestyle{plain}{%
    \fancyfoot{}
    \renewcommand{\headrulewidth}{0pt}
  }
}


%% Make special pages
\AtBeginDocument{%
  \set@geometry
  \set@header
  \newgeometry{twoside=false,left=1.5in,right=1in,vmargin=1in}
  \pagenumbering{gobble}     % suppress page numbering 
  \th@special@page
}

\newcommand*\th@special@page{%
 \renewcommand{\baselinestretch}{1}
  \typeout{>>> Make Distribution Agreement >>>}
  \th@DistributionAgreement
  \typeout{>>> Make Approval Sheet >>>}
  \th@ApprovalSheet
}

\newcommand*{\maketoc}{\th@t@c}
\newcommand*\th@t@c{%
  \begingroup
  \typeout{>>> Make Table of Contents >>>}
  \renewcommand{\contentsname}{Table of Contents}
  \tableofcontents
  \clearpage
  \listoffigures
  \clearpage
  \listoftables
  \clearpage
  \endgroup
  \typeout{}
  \typeout{--------------------------------------}
  \typeout{}
  \typeout{>>> Make Body >>>}
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \restoregeometry
}

%\AtEndDocument{
%\bibliographystyle{emory}
%}

\newcommand*{\BibTeX}{\rm B\kern-.05em{\sc i\kern-.025em b}\kern-.08em\TeX}
