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
\newif\if@DoubleSidedPrinting

\@DoubleSidedPrintingtrue

%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
%\ProcessOptions\relax
\LoadClass[letter]{report}



\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
