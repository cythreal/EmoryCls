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

STRINGS {
  current.name.str
  names.str
}

FUNCTION { initialize.tracker } {
  #0 'next.punct.comma     :=
  #1 'next.punct.period    :=
  #2 'next.punct.semicolon :=
  #3 'next.punct.space     :=
}


FUNCTION { initialize.control } {
  
  ctrl-trunc-author-bool "false" =
    'skip$
    { 
      ctrl-maxauthor str.to.int 'ctrl.maxauthor.number.int  :=
    }
  if$
}

FUNCTION { article } {
  begin.bibitem
  write.author
  format.title.article
  format.journal
  format.year.article
  format.volume.article
  format.pages.article
  format.note
}

FUNCTION { default.type } { misc }


FUNCTION { begin.bibitem } {
  newline$
  "\bibitem{" write$
  label write$
  "}{" write$
  cite$ write$
  newline$
}


FUNCTION { write.author } {
  author empty$
    'skip$
    {
      author names.separate.semicolon format.names
      output
      write$
      next.punct.space 'next.punct.int :=
    }
  if$
}

FUNCTION { format.names } {
  'names.separate.comma.bool :=
  'names.str :=
  #1 'current.name.int :=
  names.str num.names$ 'total.names.int :=
  total.names.int ctrl.maxauthor.number.int >
    {
      format.names.truncation
    }
    { 
      format.names.all
    }
  if$
}


FUNCTION { format.names.truncation } {
  ctrl.maxauthor.number.int #0 =
    { format.names.all }
    { format.names.etal }
  if$
}


FUNCTION { format.names.all } {
  total.names.int 'remaining.names.int :=
  format.names.loop
}


FUNCTION { format.names.loop } {
  { remaining.names.int #0 > }
    {
      names.str current.name.int "{vv~}{ll,}{~f.}{,~jj}" format.name$
      duplicate$
      'current.name.str :=
      current.name.int #1 >
        {
          duplicate$
          "others," =
            {
              bbl.etal
              add.space
              remaining.names.int #1 - 'remaining.names.int :=
            }
            {
              swap$
              names.separate.comma.bool
                { add.comma }
                { add.semicolon }
              if$
              swap$
              *
            }
          if$
        }
        { }
      if$
      remaining.names.int #1 - 'remaining.names.int :=
      current.name.int #1 + 'current.name.int :=
    }
  while$
}


FUNCTION { output } {
  swap$
  duplicate$ empty$
    { pop$ }
    {
      next.punct.int next.punct.space =
        { add.space }
        {
          next.punct.int next.punct.comma =
            { add.comma }
            {
              next.punct.int next.punct.semicolon =
                { add.semicolon }
                { add.period }
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

EXECUTE { initialize.control.values }

EXECUTE { initialize.count.entries }

EXECUTE { initialize.name.separator }

EXECUTE { initialize.tracker }

ITERATE { calculate.names }

ITERATE { count.entries }

EXECUTE { begin.bbl }

ITERATE { call.type$ }

EXECUTE { end.bbl }