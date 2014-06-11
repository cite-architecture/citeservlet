
html.html {
  head {
    title("@projectlabel@: software version")
    link(type : "text/css", rel : "stylesheet", href : "@coreCss@", title : "CSS stylesheet")
  }
  body {
    h1("@projectlabel@: software version")
    ul {
      li("citeservlet:  @csversion@")
      li("sparqlimg: @sparqlimgVersion@")
      li("sparqlcts: @sparqlctsVersion@")
      li("sparqlcc: @sparqlccVersion@")
      li("cite graph: @graphVersion@")
      li("citekit: @ckVersion@")
    }
  }  
}