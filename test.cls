\ProvidesClass{test}[2016/08/01 LaTeX class for bibtex test]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{ifthen}
\LoadClass[12pt]{report}

\newboolean{If@bib@eof}
\newboolean{If@bib@article@title}
\newboolean{If@bib@doi}
\newboolean{If@bib@superscript}
\newcount\@bib@bracket@num
\newcount\@bib@format@num

% ----- Define key value pairs -----
\RequirePackage{xkeyval}

\define@choicekey+[emory]{bib}{location}[\val\nr]{eof,eoc}[]{%
  \ifnum\nr=\z@
    \setboolean{If@bib@eof}{true}
  \else
    \setboolean{If@bib@eof}{false}
  \fi
}{%
  \ClassWarning{emory}{Undefined location code}%
}

\define@choicekey+[emory]{bib}{format}[\val\nr]{numeric,authoryear}[]{%
  \@bib@format@num=\nr
}{%
  \ClassWarning{emory}{Undefined citation format}%
}

\define@choicekey+[emory]{bib}{bracket}[\val\nr]{round,square,none}[]{%
  \@bib@bracket@num=\nr
}{%
  \ClassWarning{emory}{Undefined biblabel}%
}

\define@key[emory]{bib}{articletitle}[true]{%
  \newcommand*{\@bib@article@title}{#1}
}

\define@key[emory]{bib}{doi}[false]{%
  \newcommand*{\@bib@doi}{#1}
}

\define@boolkey[emory]{bib}{superscript}[true]{%
  \setboolean{If@bib@superscript}{#1}
}

\define@key[emory]{bib}{maxauthor}[15]{%
  \newcommand*{\@bib@max@author}{#1}
}