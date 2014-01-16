<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:citeimg="http://chs.harvard.edu/xmlns/citeimg" exclude-result-prefixes="citeimg"
    version="1.0">
    <xsl:include href="header.xsl"/>
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    <xsl:variable name="pathToICT">ict.html?urn=</xsl:variable>
    
    <xsl:template match="/">
        
        <html lang="en">
            <head>
                <meta charset="utf-8" />
                <title>CITE Image · <xsl:value-of select="//citeimg:request/citeimg:urn"/></title>
                <link href="css/normalize.css"
                    rel="stylesheet"
                    title="CSS for CTS"
                    type="text/css"/>
                
                <link
                    href="css/main.css"
                    rel="stylesheet"
                    title="CSS for CTS"
                    type="text/css"/>
                
                <link rel="stylesheet" href="css/cite_common.css"></link>
                <link
                    href="css/steely.css"
                    rel="stylesheet"
                    title="CSS for CTS"
                    type="text/css"/>
                <link
                    href="css/graph.css"
                    rel="stylesheet"
                    title="CSS for CTS"
                    type="text/css"/>
                
            </head>
            <body>
                
                <header>
                    <xsl:call-template name="header"/>
                </header>
                <nav>
                    <p>
                        <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="$homeUrl"/></xsl:attribute>
                            Home
                        </xsl:element>
                        
                        :
                        <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="$formsUrl"/></xsl:attribute>
                            Look up material by URN
                        </xsl:element>
                        
                        
                    </p>
                    
                </nav>
                
                
                <article>
                    
                    <h2><xsl:value-of select="//citeimg:request/citeimg:urn"/></h2> 
                    <p class="cite_caption"><xsl:value-of select="//citeimg:reply/citeimg:caption"/></p>
                    
                    <p>
                        <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="$pathToICT"/><xsl:value-of select="//citeimg:request/citeimg:urn"/></xsl:attribute>
                            Cite and quote this image.
                        </xsl:element>
                        
                        
                        
                    </p>
                    
                    <p>The image is linked to a view you can zoom/pan.</p>
                    <p>
                        <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="translate(//citeimg:reply/citeimg:zoomableUrl,' ','')"/></xsl:attribute>
                            <xsl:element name="img">
                                <xsl:attribute name="src"><xsl:value-of select="translate(//citeimg:reply/citeimg:binaryUrl,' ','')"/></xsl:attribute>
                            </xsl:element>
                        </xsl:element>
                    </p>
                    
                    <h2>Rights</h2>
                    
                    <p class="cite_caption"><xsl:value-of select="//citeimg:reply/citeimg:rights"/></p>
                    
                </article>
                
                <footer>
                    <xsl:call-template name="footer"/>
                </footer>
            </body>
        </html>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>
