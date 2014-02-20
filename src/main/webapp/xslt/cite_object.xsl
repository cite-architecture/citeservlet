<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cite="http://chs.harvard.edu/xmlns/cite" 
    version="1.0">
    <xsl:include href="header.xsl"/>
    <xsl:variable name="imgURL">@images@</xsl:variable>
    <xsl:variable name="thisURL">@collections@</xsl:variable>
    <xsl:variable name="textURL">@texts@</xsl:variable>
    <xsl:variable name="indexUrl">@indices@</xsl:variable>
    
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    <xsl:variable name="ImageServiceGIP"><xsl:value-of select="$imgURL"/>?request=GetImagePlus&amp;xslt=gip.xsl&amp;urn=</xsl:variable>
    <xsl:variable name="ImageServiceThumb"><xsl:value-of select="$imgURL"/>?request=GetBinaryImage&amp;w=200&amp;urn=</xsl:variable>
    
    <xsl:output method="html" omit-xml-declaration="yes"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//cite:citeObject/@urn"/></title>
                <meta charset="utf-8"></meta>
                <link rel="stylesheet" href="@coreCss@"></link>
                <link rel="stylesheet" href="css/graph.css"></link>
                <script type="text/javascript" src="js/jquery.min.js"> </script>
                <script type="text/javascript" src="@citekit@"> </script>
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
                    <xsl:apply-templates select="//cite:prevnext"/>
        <xsl:element name="table">
            <xsl:attribute name="class">citeCollectionTable</xsl:attribute>
            <xsl:element name="caption">
                <xsl:attribute name="class">citeCollectionTable</xsl:attribute>
                <xsl:value-of select="//cite:citeObject/@urn"/>
            </xsl:element>
            <xsl:element name="tr">
                <xsl:attribute name="class">citeCollectionTable</xsl:attribute>
                <xsl:element name="th">Property</xsl:element>
                <xsl:element name="th">Value</xsl:element>
            </xsl:element>
            <xsl:for-each select="//cite:citeProperty">
                <xsl:element name="tr">
                    <xsl:attribute name="class">citeCollectionTable</xsl:attribute>
                    <xsl:element name="td">
                        <xsl:attribute name="class">citeCollectionTable</xsl:attribute>
                        <xsl:value-of select="current()/@label"/>
                </xsl:element>
                    <xsl:element name="td">
                        <xsl:attribute name="class">citeCollectionTable</xsl:attribute>
                        
                        <xsl:choose>
                            <xsl:when test="@type = 'string'">
                                <xsl:value-of select="."/>
                            </xsl:when>
                            <xsl:when test="@type = 'markdown'">
                                <span class="md"><xsl:value-of select="."/></span>
                            </xsl:when>
                            <xsl:when test="@type = 'number'">
                                <span class="number"><xsl:value-of select="."/></span>
                            </xsl:when>
                            <xsl:when test="@type= 'http://www.homermultitext.org/cite/rdf/CiteUrn'">
                                <xsl:element name="blockquote">
                                    <xsl:attribute name="class">cite-collection</xsl:attribute>
                                    <xsl:attribute name="cite"><xsl:value-of select="."/></xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>
                                <!--<xsl:element name="a">
                                    <xsl:attribute name="href"><xsl:value-of select="$thisURL"/>?request=GetObjectPlus&amp;urn=<xsl:value-of select="."/></xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>-->
                            </xsl:when>
                            <xsl:when test="@type= 'http://www.homermultitext.org/cite/rdf/CtsUrn'">
                                <xsl:element name="blockquote">
                                    <xsl:attribute name="class">cite-text</xsl:attribute>
                                    <xsl:attribute name="cite"><xsl:value-of select="."/></xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>
                               <!-- <xsl:element name="a">
                                    <xsl:attribute name="href"><xsl:value-of select="$textURL"/>?request=GetPassagePlus&amp;urn=<xsl:value-of select="."/></xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>-->
                            </xsl:when>
                            <xsl:when test="@type= 'citeimg'">
                                <xsl:if test="string-length(.) &gt; 6">
                                    <xsl:element name="blockquote">
                                        <xsl:attribute name="class">cite-image</xsl:attribute>
                                        <xsl:attribute name="cite"><xsl:value-of select="."/></xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                    <!--<xsl:element name="a">
                                        <xsl:attribute name="href"><xsl:value-of select="$ImageServiceGIP"/><xsl:value-of select="."/></xsl:attribute>
                                        <xsl:element name="img">
                                            <xsl:attribute name="src"><xsl:value-of select="$ImageServiceThumb"/><xsl:value-of select="."/></xsl:attribute>
                                        </xsl:element>
                                    </xsl:element>-->
                                </xsl:if>
                            </xsl:when>
                            <xsl:when test="@type= 'md'">
                                <xsl:value-of select="."/> (md)
                            </xsl:when>
                            
                            
                        </xsl:choose>
                        
                </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
                    
                    
                    
                    <xsl:element name="p">
                        <strong>Links</strong>: see links to
                        <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="$indexUrl"/>?urn=<xsl:value-of select="//cite:citeObject/@urn"/></xsl:attribute>
                            <xsl:value-of select="//cite:citeObject/@urn"/>
                        </xsl:element>
                    </xsl:element>
                    
                    
                    
                <ul id="citekit-sources">
                    <li class="citekit-source cite-text citekit-default" id="defaulttext">@texts@</li>
                    <li class="citekit-source cite-image citekit-default" data-image-w="900" id="defaultimage">@images@</li>
                    <li class="citekit-source cite-collection citekit-default" id="defaultobject">@collections@</li>
                </ul>
                    
                </article>
                <footer>
                    <xsl:call-template name="footer"/>
                </footer>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template
        match="cite:prevnext">
        
           <div
                    class="prevnext">
                    <span
                        class="prv">
                        <xsl:if
                            test="cite:prev != ''">
                            
                                    <xsl:variable
                                        name="prvVar"><xsl:value-of select="$thisURL"/>?request=GetObjectPlus&amp;urn=<xsl:value-of
                                            select="cite:prev"/></xsl:variable>
                                    <xsl:element
                                        name="a">
                                        <xsl:attribute
                                            name="href">
                                            <xsl:value-of
                                                select="$prvVar"/>
                                        </xsl:attribute> prev </xsl:element>
                               
                        </xsl:if>
                    </span> 
               
               <xsl:if test="(cite:prev != '') and (cite:next != '')">|</xsl:if> 
               
               <span
                        class="nxt">
                        <xsl:if
                            test="cite:next != ''">
                            <xsl:variable
                                name="nextVar"><xsl:value-of select="$thisURL"/>?request=GetObjectPlus&amp;urn=<xsl:value-of
                                    select="cite:next"/></xsl:variable>
                            <xsl:element
                                name="a">
                                <xsl:attribute
                                    name="href">
                                    <xsl:value-of
                                        select="$nextVar"/>
                                </xsl:attribute> next </xsl:element>
                        </xsl:if>
                    </span>
                </div>
        
    </xsl:template>
    

</xsl:stylesheet>
