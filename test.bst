ENTRY
  {
    address
    author
    booktitle
    chapter
    doi
    edition
    editor
    howpublished
    institution
    journal
    key
    maintitle
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    version
    volume
    year
    ctrl-article-title
    ctrl-doi
    ctrl-maxauthor
    ctrl-trunc-author-bool
  }
  { }
  {
    label
  }


% --- declare internal variables ---

INTEGERS {  % punctuation symbol tracker
  next.punct.comma
  next.punct.period
  next.punct.semicolon
  next.punct.space
  next.punct.int
}


INTEGERS {  % name
  current.name.int
  names.separate.comma
  names.separate.semicolon
  names.separate.comma.bool
  truncate.author.bool
  remaining.names.int
  total.names.int
}


INTEGERS {  % ctrl & counter
  entries.int
  ctrl.maxauthor.number.int
}


STRINGS {
  current.name.str
  names.str
  ctrl.article.title
}


STRINGS {
  name.format.last.first
  name.format.last.initial
  name.format.first.last
  name.format.initial.last
}


% --- declare intergal basic function ---

FUNCTION { and } {
    { }
    {
      pop$
      #0
    }
  if$
}

FUNCTION { not } {
    { #0 }
    { #1 }
  if$
}

FUNCTION { or } {
    {
      pop$
      #1
    }
    { }
  if$
}

FUNCTION { xor } {
    { not }
    { }
  if$
}


%FUNCTION { str.to.int.aux.ii } {
%  {
%    duplicate$
%    empty$ not
%  }
%    {
%      swap$
%      #10 multiply 'str.conversion.int :=
%      duplicate$
%      #1 #1 substring$
%      chr.to.value
%      str.conversion.int +
%      swap$
%      #2 global.max$ substring$
%    }
%  while$
%  pop$
%}

%FUNCTION { str.to.int.aux.i } {
%  duplicate$
%  #1 #1 substring$
%  "-" =
%   {
%      #1 swap$
%      #2 global.max$ substring$
%    }
%    {
%      #0 swap$
%    }
%  if$
%  #0
%  swap$
%  str.to.int.aux.ii
%  swap$
%    { #0 swap$ - }
%    { }
%  if$
%}


%FUNCTION { str.to.int } {
%  duplicate$
%  empty$
%    {
%      pop$
%      #0
%    }
%    { str.to.int.aux.i }
%  if$
%}


% --- initialize internal variables ---

FUNCTION { initialize.count.entries } {
  #0 'entries.int  :=
}


FUNCTION { count.entries } {
  entries.int #1 + 'entries.int  :=
}


FUNCTION { initialize.tracker } {
  #0 'next.punct.comma     :=
  #1 'next.punct.period    :=
  #2 'next.punct.semicolon :=
  #3 'next.punct.space     :=
}


FUNCTION { initialize.name.separator } {
  #1 'names.separate.comma     :=
  #0 'names.separate.semicolon :=
}


FUNCTION { initialize.control } {
%  ctrl-trunc-author-bool top$
%  ctrl-trunc-author-bool "false" =
%    'skip$
%    { 
%      ctrl-maxauthor str.to.int 'ctrl.maxauthor.number.int  :=
%    }
%  if$
%  "true" 'ctrl.article.title :=
%  ctrl.article.title write$
  #1 'ctrl.maxauthor.number.int :=
%  ctrl.maxauthor.number.int write$
}


FUNCTION { initialize.name.format } {
  "{vv~}{ll}{, jj}{, ff}" 'name.format.last.first :=
  "{vv~}{ll}{, jj}{, f~}" 'name.format.last.initial :=
  "{ff}{vv~}{ll}{, jj}" 'name.format.first.last :=
  "{f.~}{vv~}{ll}{, jj}" 'name.format.initial.last :=
}


FUNCTION { output } {
  swap$
  duplicate$ empty$
    { pop$ }
    {
      next.punct.int next.punct.space =
        { " " * }
        {
          next.punct.int next.punct.comma =
            { ", " * }
            {
              next.punct.int next.punct.semicolon =
                { ", " * }
                { add.period$ }
              if$
            }
          if$
        }
      if$
      write$
    }
  if$
  next.punct.comma 'next.punct.int :=
}


FUNCTION { calculate.names } {
%  calculate.short.names
%  short.names
  year empty$
    { "()" }
    { "(" year * ")" * }
  if$
  *
  'label :=
}


% --- format name strings ---

FUNCTION { format.names.loop } {
  { remaining.names.int #0 > }
    {
      names.str current.name.int "{vv~}{ll}{, jj}{, ff}" format.name$
      'current.name.str :=
%      current.name.int #1 >
%        {
%          duplicate$
%          "others," =
%            {
%              bbl.etal
%              add.space
%              remaining.names.int #1 - 'remaining.names.int :=
%            }
%            {
%              swap$
%              names.separate.comma.bool
%                { ", " * }
%                { "; " * }
%              if$
%              swap$
%              *
%            }
%          if$
%        }
%        { }
%      if$
      current.name.str "; " * 
      write$
      remaining.names.int #1 - 'remaining.names.int :=
      current.name.int #1 + 'current.name.int :=
    }
  while$
}


%FUNCTION { format.names.etal } {
%  ctrl.etal.firstonly.bool
%    { #1 'remaining.names.int := }
%    { ctrl.etal.number.int 'remaining.names.int := }
%  if$
%  format.names.loop
%  current.name.str "others," =
%    'skip$
%    {
%      add.space
%      bbl.etal
%      add.space
%      *
%    }
%  if$
%}


%FUNCTION { format.names.truncation } {
%  ctrl.maxauthor.number.int #0 =
%    { format.names.all }
%    { format.names.etal }
%  if$
%}


FUNCTION { format.names.all } {
  total.names.int 'remaining.names.int :=
  format.names.loop
}


FUNCTION { format.names } {
  'names.separate.comma.bool :=
  'names.str :=
  #1 'current.name.int :=
  names.str num.names$ 'total.names.int :=
%  total.names.int ctrl.maxauthor.number.int >
%    {
%      format.names.truncation
%    }
%    { 
      format.names.all
%    }
%  if$
}


% --- format title string ---
FUNCTION { format.title } {
  'skip$
}


% --- format journal ---


% --- format year ---

% --- format page ---


% --- format note ---


% --- declare string output functions ---

FUNCTION { begin.bibitem } {
  newline$
  "\bibitem" write$
  "{" cite$ * "}" * write$
  newline$
}


FUNCTION { write.author } {
%  author #1 "{vv~}{ll}{, jj}{, ff}" format.name$ write$
   author names.separate.semicolon format.names
%   output
%   write$
%   next.punct.space 'next.punct.int :=
}


FUNCTION { end.bibitem } {
  newline$
}


% --- define each entry type ---

FUNCTION { control } {
  begin.bibitem
  ctrl-article-title duplicate$
  'ctrl.article.title :=
  write$
  end.bibitem
}


FUNCTION { article } {
  begin.bibitem
  write.author
  ctrl.article.title write$
  %format.title.article
  %format.journal
  %format.year.article
  %format.volume.article
  %format.pages.article
  %format.note
  end.bibitem
}


FUNCTION { book } {
  'skip$
}


FUNCTION { booklet } {
  'skip$
}


FUNCTION { conference } {
  'skip$
}


FUNCTION { inbook } {
  'skip$
}


FUNCTION { incollection } {
  'skip$
}


FUNCTION { inproceedings } {
  begin.bibitem
  write.author
  end.bibitem
}


FUNCTION { manual } {
  'skip$
}


FUNCTION { masterthesis } {
  'skip$
}


FUNCTION { misc } {
  'skip$
}


FUNCTION { phdthesis } {
  'skip$
}


FUNCTION { proceedings } {
  'skip$
}


FUNCTION { techreport } {
  'skip$
}


FUNCTION { unpublished } {
  'skip$
}


FUNCTION { default.type } { article }


FUNCTION { begin.bbl } {
  preamble$ empty$
    'skip$
    {
      preamble$ write$
      newline$
    }
  if$
  "\begin{thebibliography}{}" write$
  newline$
}


FUNCTION { end.bbl } {
  newline$
  "\end{thebibliography}" write$
  newline$
}


MACRO { jan } { "Jan." }
MACRO { feb } { "Feb." }
MACRO { mar } { "Mar." }
MACRO { apr } { "Apr." }
MACRO { may } { "May" }
MACRO { jun } { "June" }
MACRO { jul } { "July" }
MACRO { aug } { "Aug." }
MACRO { sep } { "Sept." }
MACRO { oct } { "Oct." }
MACRO { nov } { "Nov." }
MACRO { dec } { "Dec." }


READ

EXECUTE { initialize.control }

%EXECUTE { initialize.count.entries }

EXECUTE { initialize.name.separator }

%EXECUTE { initialize.tracker }

%ITERATE { calculate.names }

%ITERATE { count.entries }

EXECUTE { begin.bbl }

ITERATE { call.type$ }

EXECUTE { end.bbl }
