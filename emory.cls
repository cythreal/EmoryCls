%% Emory Dissertation Class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{emory}[2016/08/01 LaTeX class for Emory dissertation]

%% Load dependent packages
\RequirePackage{ifthen}

%% Declare options can be passed on to report.cls
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\DeclareOption{final}{\PassOptionsToClass{final}{report}}
%\DeclareOption{letter}{\PassOptionsToClass{letter}{report}}

%% Disable options
\DeclareOption{a4paper}{\OptionNotUsed}%\ClassWarning{emory}{Page size 'a4' not allowed.}}
\DeclareOption{a5paper}{\OptionNotUsed}%\ClassWarning{emory}{Page size 'a5' not allowed.}}
\DeclareOption{b5paper}{\OptionNotUsed}%\ClassWarning{emory}{Page size 'b5' not allowed.}}
\DeclareOption{legalpaper}{\OptionNotUsed}%\ClassWarning{emory}{Page size 'legal' not allowed.}}
\DeclareOption{executivepaper}{\OptionNotUsed}%\ClassWarning{emory}{Page size 'executive' not allowed.}}
\DeclareOption{10pt}{\OptionNotUsed}%\ClassWarning{emory}{Font size '10pt' not allowed.}}
\DeclareOption{twocolumn}{\OptionNotUsed}%\ClassWarning{emory}{Two columns style not allowed.}}
\DeclareOption{notitlepage}{\OptionNotUsed}%\ClassWarning{emory}{'notitlepage' not allowed.}}
\DeclareOption{landscape}{\OptionNotUsed}%\ClassWarning{emory}{Landscape layout not allowed.}}
\DeclareOption{twoside}{\OptionNotUsed}%\ClassWarning{emory}{Uneven side margins not allowed.}}

%% Custom options
\newboolean{IfDoubleSided}
\newboolean{IfDissertation}
% The dean! If Dean Tedesco resigns oneday, replace this with the name of the new dean
\newcommand*{\th@Dean}{Lisa A.\ Tedesco, Ph.D}

% Set default values
\setboolean{IfDoubleSided}{true}
\setboolean{IfDissertation}{true}


\DeclareOption{doublesided}{\setboolean{IfDoubleSided}{true}}
\DeclareOption{singlesided}{\setboolean{IfDoubleSided}{false}}
\DeclareOption{thesis}{\setboolean{IfDissertation}{false}}
\DeclareOption{dissertation}{\setboolean{IfDissertation}{true}}
\DeclareOption{footnote}{\setboolean{IfFootnote}{false}}

%% Process options and load class
\ProcessOptions
\LoadClassWithOptions{report}

%% Internal commands

% double spacing
\newcommand*{\doublespacing}{%
  \ifthenelse{\f@size = 11.}{%
    \renewcommand{\baselinestretch}{1.771}}         %	11pt
  {\renewcommand{\baselinestretch}{1.660}           %	12pt
  }
}
  

%% Internal preamble commands -- provide warning messages
\newcommand*{\th@PassCmd}[2]{\gdef#1{#2}}
\newcount\th@advisor@count
\newcount\th@committee@count
\newcount\@tmp
\newcount\@half

%% Define preamble commands
\renewcommand*{\title}[1]{\th@PassCmd{\th@title}{#1}}
\renewcommand*{\author}[1]{\th@PassCmd{\th@author}{#1}}
\newcommand*{\degree}[1]{\th@PassCmd{\th@degree}{#1}}
\newcommand*{\previousdegree}[1]{\th@PassCmd{\th@previousdegree}{#1}}
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
%  \vspace*{\fill}
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
    A \ifthenelse{\boolean{IfDissertation}}{dissertation}{thesis} submitted to the Faculty of the \\
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
  \begin{center}
    Abstract
    \vspace{2ex}
    
    \th@title
    
    By \th@author
  \vspace{1in}
  
  \parbox{4.5in}{\th@abstract}
  \end{center}
  
  \clearpage
}

\newcommand*{\th@CoverPage}{%
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
    A \ifthenelse{\boolean{IfDissertation}}{dissertation}{thesis} submitted to the Faculty of the \\
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
  \subsection*{Acknowledgement}
  
  \th@acknowledgement
  
  \clearpage
}


\RequirePackage{geometry}
\AtEndOfPackage{%
  \geometry{%
    paper=letterpaper,
    total={6in, 9in},
    textwidth=6in,
    textheight=9in,
    includemp=false,
    lmargin=1.5in,
    rmargin=1.0in,
    top=1in,
    bottom=1in,
    vcentering=true,
  }
}

%% Make special pages
\AtBeginDocument{
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
  \doublespacing
  \setcounter{page}{0}
  \pagenumbering{arabic}
}
