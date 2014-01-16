<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cite="http://chs.harvard.edu/xmlns/cite" 
    version="1.0">
    <xsl:include href="header.xsl"/>
    <xsl:variable name="imgURL">@images@</xsl:variable>
    <xsl:variable name="thisURL">@collections@</xsl:variable>
    <xsl:variable name="textURL">@texts@</xsl:variable>
    
    
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    <xsl:variable name="ImageServiceGIP"><xsl:value-of select="$imgURL"/>?request=GetImagePlus&amp;xslt=gip.xsl&amp;urn=</xsl:variable>
    <xsl:variable name="ImageServiceThumb"><xsl:value-of select="$imgURL"/>?request=GetBinaryImage&amp;w=200&amp;urn=</xsl:variable>
    
    <xsl:output method="html" omit-xml-declaration="yes"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Citations for: <xsl:value-of select="//cite:request/cite:urn"/></title>
                <meta charset="utf-8"></meta>
                <link rel="stylesheet" href="css/normalize.css"></link>
                <link rel="stylesheet" href="css/steely.css"></link>
                <link rel="stylesheet" href="css/graph.css"></link>
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
                    <h2>Citations for <xsl:value-of select="//cite:request/cite:urn"/></h2>
                    <ol>
                        <xsl:for-each select="//cite:reply/cite:urn">
                            <xsl:sort />
                    
                    <li>
                        <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="$thisURL"/>?request=GetObjectPlus&amp;urn=<xsl:value-of select="current()"/></xsl:attribute>
                            <xsl:value-of select="current()"/>
                        </xsl:element>
                    </li>
                        </xsl:for-each>
                    
                    </ol>
                </article>
                <footer>
                    <xsl:call-template name="footer"/>
                </footer>
            </body>
        </html>
    </xsl:template>
    
       

</xsl:stylesheet>
