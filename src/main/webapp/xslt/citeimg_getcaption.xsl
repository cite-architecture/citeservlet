<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:citeimg="http://chs.harvard.edu/xmlns/citeimg" exclude-result-prefixes="citeimg"
    version="1.0">
    <xsl:output omit-xml-declaration="yes" method="html" encoding="UTF-8"/>
    <xsl:include href="header.xsl"/>
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    <xsl:template match="/">
        
        <html lang="en">
            <head>
                <meta charset="utf-8" />
                <title>CITE Image · <xsl:value-of select="//citeimg:request/citeimg:urn"/></title>
                
                
                <link rel="stylesheet" href="css/cite_common.css"></link>
                <link
                    href="@coreCss@"
                    rel="stylesheet"
                    title="CSS for CTS"
                    type="text/css"/>
                <link
                    href="css/graph.css"
                    rel="stylesheet"
                    title="CSS for CTS"
                    type="text/css"/>
                <link rel="stylesheet" href="css/cite_common.css"></link>
                
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
                    
                    <h2>Caption for <xsl:value-of select="//citeimg:request/citeimg:urn"/></h2>
                    
                    <p class="cite_caption"><xsl:value-of select="//citeimg:reply/citeimg:caption"/></p>
                    
                    
                </article>
                
                <footer>
                    <xsl:call-template name="footer"/>
                </footer>
                
            </body>
        </html>
        
        
        
    </xsl:template>
    
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
