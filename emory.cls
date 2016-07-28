%%% --- Emory Dissertation Class ---
% This class provides style settings suitable for the dissertation 
% of the Laney Graduate School of Emory University, specially for
% STEM fields of study
%%% --------------------------------

% ----- Class declaration -----
\ProvidesClass{emory}[2016/08/01 LaTeX class for Emory dissertation]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{ifthen}

% ----- Declare options can be passed on to report.cls -----
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\DeclareOption{final}{\PassOptionsToClass{final}{report}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{report}}
\DeclareOption*{\OptionNotUsed \ClassWarning{emory}{'\CurrentOption' not allowed.}}

% ----- Process options -----
\ProcessOptions
\LoadClass[12pt]{report}

% ----- Declare boolean switches
% document type. [true]: dissertation, false: thesis 
\newboolean{If@doc@dissertation}
\setboolean{If@doc@dissertation}{true}
% document style. set by user input key. 
\newboolean{If@major@chem}
\newboolean{If@major@phys}
\newboolean{If@major@math}
\newboolean{If@major@bio}
\newboolean{If@major@cs}

% ----- Define key value pairs -----
\RequirePackage{xkeyval}
\define@boolkey[emory]{doc}{dissertation}[true]{%
  \setboolean{If@doc@dissertation}{#1}
}
\define@choicekey+[emory]{style}{major}[]{chem,phys,math,bio,cs}[]{%
  \setboolean{If@major@#1}{true}
}{%
  \ClassWarning{emory}{Style corrently not supported}%
}

% ------ Load key values from user input ------
\AtBeginDocument{
\ifthenelse{\boolean{If@major@chem}}{%
  \load@chem@package
}{%
  \typeout{chem disabled}
}
\ifthenelse{\boolean{If@major@phys}}{%
  \load@phys@package
}{}
\ifthenelse{\boolean{If@major@math}}{%
  \load@math@package
}{}
\ifthenelse{\boolean{If@major@bio}}{%
  \load@bio@package
}{}
\ifthenelse{\boolean{If@major@cs}}{%
  \load@cs@package
}{}
}

% ------ Load packages shared by all majors -------
\RequirePackage{amsmath}
\RequirePackage{graphicx}

% ------ Define major specific style and package ------
\newcommand*{\load@math@package}{%
  \RequirePackage{amsfonts}
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
}

%% Custom options
% The dean! If Dean Tedesco resigns oneday, replace this with the name of the new dean
\newcommand*{\th@Dean}{Lisa A.\ Tedesco, Ph.D}

% Set default values


%% Internal commands


%% Internal preamble commands -- provide warning messages
\newcommand*{\th@PassCmd}[2]{\gdef#1{#2}}
\newcount\th@advisor@count
\newcount\th@committee@count
\newcount\th@prevdegree@count
\newcount\@tmp
\newcount\@half

%% Define preamble commands
\renewcommand*{\title}[1]{\th@PassCmd{\th@title}{#1}}
\renewcommand*{\author}[1]{\th@PassCmd{\th@author}{#1}}
\newcommand*{\degree}[1]{\th@PassCmd{\th@degree}{#1}}
\newcommand*{\prevdegree}[1]{\th@PassCmd{\th@previousdegree}{#1}}
\newcommand*{\field}[1]{\th@PassCmd{\th@field}{#1}}
%\newcommand*{\advisor}[1]{\th@PassCmd{\th@advisor}{#1}}
\newcommand*{\advisordegree}[1]{\th@PassCmd{\th@advisordegree}{#1}}
\newcommand*{\yr}[1]{\th@PassCmd{\th@year}{#1}}
\renewcommand*{\abstract}[1]{\th@PassCmd{\th@abstract}{#1}}
\newcommand*{\acknowledgment}[1]{\th@PassCmd{\th@acknowledgement}{#1}}

\newcommand*{\advisor}[2]{%
  \global\advance\th@advisor@count\@ne\relax
  \expandafter\gdef\csname th@advisor\@roman\th@advisor@count \endcsname{#1, #2}\relax
}
\newcommand*{\committee}[2]{%
  \global\advance\th@committee@count\@ne\relax
  \expandafter\gdef\csname th@committee\@roman\th@committee@count \endcsname{#1, #2}\relax
}

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
\newcommand*{\th@year}{%
  \ClassWarning{emory}{Missing graduation year!}
}
\newcommand*{\th@abstract}{%
  \ClassWarning{emory}{Missing abstract!}
}
\newcommand*{\th@acknowledgement}{%
  \ClassWarning{emory}{Do you have anybody to say thank you?}
}



%% Define special pages
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
    
    \th@previousdegree
    \vspace{1in}
    
    \ifnum\th@advisor@count=\@ne
      Advisor: \@nameuse{th@advisor\@roman\@ne}
    \else
      Advisor:

      \newcount\@tmp
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

\newcommand*{\th@AbstractPage}{%
  \thispagestyle{empty}

  \begin{center}
    \large
    \textbf{Abstract}
    \vspace{2ex}
    
    \th@title\normalsize
    
    \vspace{1ex}
    By \th@author
  \vspace{0.5in}
  
  \parbox{4.5in}{\th@abstract}
  \end{center}
  
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
    
    \th@previousdegree
    \vspace{1in}
    
    \ifnum\th@advisor@count=\@ne
      Advisor: \@nameuse{th@advisor\@roman\@ne}
    \else
      Advisor:

      \newcount\@tmp
      \@tmp\z@
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

\newcommand*{\th@AcknowledgementPage}{%
  \thispagestyle{empty}
  \begin{center}
    \large
    Acknowledgement
    \normalsize
  \end{center}
  
  \setcounter{page}{0}
  \th@acknowledgement
  
  \clearpage
}


\newcommand*{\set@geometry}{%
  \RequirePackage[onecolumn,paper=letterpaper,total={6in,9in},left=1.5in,right=1in,vmargin=1in,vcentering=true,landscape=false]{geometry}
}

\newcommand*{\set@header}{%
  \RequirePackage{fancyhdr}
  % set page numbering on the right top
  \pagestyle{myheadings}
  \rhead{\thepage}
  % get rid of page number footer on chapter pages
  \fancypagestyle{plain}{%
    \fancyfoot{}
    \renewcommand{\headrulewidth}{0pt}
  }
}


%% Make special pages
\AtBeginDocument{
  \set@geometry
  \newgeometry{twoside=false,left=1.5in,right=1in,vmargin=1in}
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
  \th@AcknowledgementPage
  \typeout{>>> Make Table of Contents >>>}
  \renewcommand{\contentsname}{Table of Contents}
  \tableofcontents
  \listoffigures
  \listoftables
  \clearpage
  \typeout{}
  \typeout{--------------------------------------}
  \typeout{}
  \typeout{>>> Make Body >>>}
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \restoregeometry
  \set@header
}

\renewcommand{\arraystretch}{1}


\AtEndDocument{
\bibliographystyle{unsrt}
}
