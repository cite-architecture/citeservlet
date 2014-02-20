<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts" xmlns:ti="http://chs.harvard.edu/xmlns/cts" xmlns:dc="http://purl.org/dc/elements/1.1" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" method="html" encoding="UTF-8"/>
    <xsl:include href="header.xsl"/>
    
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    
    <xsl:template match="/">
        
        <html>
            <head>
                
                
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
                <xsl:choose>
                    <xsl:when
                        test="/cts:CTSError">
                        <title>Error</title>
                    </xsl:when>
                    <xsl:otherwise>
                        <title>Contents of CTS Library
                        </title>
                    </xsl:otherwise>
                </xsl:choose>
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
                    <h1>Catalogue</h1>
                    
                    <ul class="mH" id="invMenu" >
                            <xsl:apply-templates
                                select="//ti:textgroup"/>
                    </ul>
                    
                    
                </article>
                
                <footer>
                    <xsl:call-template name="footer"/>
                </footer>
                
            </body>
        </html>
        
        
        
    </xsl:template>
    
    <xsl:template match="ti:textgroup">
        <div class="textgroup" >
            <h4><xsl:apply-templates select="ti:groupname"/></h4>
            <p><xsl:value-of select="@urn"/></p>
            <ul>
                <xsl:apply-templates select="ti:work"/>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="ti:work">
        <li class="cts-work" >
            <p><xsl:apply-templates select="../ti:groupname"/>, <strong><xsl:apply-templates select="ti:title"/></strong></p>
            
            <p><xsl:value-of select="@urn"/></p>
            <ul>
                <xsl:apply-templates select="ti:edition"/>
                <xsl:apply-templates select="ti:translation"/>
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="ti:edition">
        <li class="cts-edition cts-version">
            <p>Edition: <strong><xsl:apply-templates select="ti:label"/></strong></p>
            <p><xsl:apply-templates select="ti:description"/></p>
            <p><xsl:value-of select="@urn"/></p>
           
        </li>
    </xsl:template>
    
    <xsl:template match="ti:translation">
        <li class="cts-translation cts-version">
            <p>Translation: <strong><xsl:apply-templates select="ti:label"/></strong></p>
            <p><xsl:apply-templates select="ti:description"/></p>
            <p><xsl:value-of select="@urn"/></p>
            
        </li>
    </xsl:template>
    
    <xsl:template match="ti:groupname">
        <xsl:value-of select="."/><xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="ti:title">
        <xsl:value-of select="."/><xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
