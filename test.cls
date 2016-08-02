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
\RequirePackage[sort&compress]{natbib}

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


\AtBeginDocument{
\ifcase\@bib@format@num
  \setcitestyle{numbers}
\or
  \setcitestyle{authoryear}
\fi

\ifcase\@bib@bracket@num
  \setcitestyle{round}
\or
  \setcitestyle{square}
\or
  \setcitestyle{open={}}
  \setcitestyle{close={}}
\fi

\ifthenelse{\boolean{If@bib@superscript}}{%
  \setcitestyle{super}
}{}
}

% ----- write controling file
\newcommand*{\@bib@ctrl@name}{\jobname-blx.bib}
\newwrite\@bib@ctrl@file
\AtBeginDocument{%
  \if@filesw
    \expandafter\@bib@write@ctrl
  \fi
}
\newcommand*\@bib@write@ctrl{%
  \immediate\openout\@bib@ctrl@file=\@bib@ctrl@name\relax
  \edef\@tempa##1##2{%
    \space\space##1\space = "##2",^^J%
  }%
  \immediate\write\@bib@ctrl@file{%
    @Control\string{%
      emory-ctrl,^^J%
      \@tempa{ctrl-article-title\space}{\@bib@article@title}
      \@tempa{ctrl-maxauthor\space\space\space}{\@bib@max@author}%
      \@tempa{ctrl-doi\space\space\space}{\@bib@doi}
%      \@tempa{ctrl-etal-firstonly}{%
%        \ifacs@etal@truncate no\else yes\fi
%      }%
    \string}^^J%
  }%
%  \immediate\write\@auxout{%
%    \string\citation\string{achemso-control\string}%
%  }%
  \AtEndDocument{%
    \immediate\closeout\@bib@ctrl@file\relax
  }%
}