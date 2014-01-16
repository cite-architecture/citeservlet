<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:citeindex="http://chs.harvard.edu/xmlns/citeindex" version="1.0">
    <xsl:import href="header.xsl"/>
    <xsl:output encoding="UTF-8" indent="no" method="html"/>
    
    <!-- Linking URLs for nav section -->
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    
    <xsl:variable name="defaultImgVerb"
        >http://www.homermultitext.org/hmt/rdf/hasDefaultImage</xsl:variable>
    <xsl:variable name="prevVerb">http://www.homermultitext.org/cite/rdf/prev</xsl:variable>
    <xsl:variable name="nextVerb">http://www.homermultitext.org/cite/rdf/next</xsl:variable>
    <xsl:variable name="labelVerb">http://www.w3.org/1999/02/22-rdf-syntax-ns#label</xsl:variable>
   
    <xsl:variable name="thisURL">@indices@</xsl:variable>
    <xsl:variable name="ictURL">@ict@</xsl:variable>
    <xsl:variable name="imgURL">@images@</xsl:variable>
    <xsl:variable name="thumbSize">150</xsl:variable>
    <xsl:variable name="bigSize">400</xsl:variable>
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <title>CITE Index</title>
                <link href="css/graph.css" rel="stylesheet"/>
                <link href="css/steely.css" rel="stylesheet"/>
                <script type="text/javascript">
				            function toggleThis(seqId){
				             $("#" + seqId).toggle("slow");
				             }
				        </script>
                <script type="text/javascript" src="js/jquery.min.js"> </script>
                <xsl:element name="script">
                    <xsl:attribute name="type">text/javascript</xsl:attribute>
                    <xsl:attribute name="src">@citekit@</xsl:attribute>
                    <!--<xsl:attribute name="src">http://localhost/citekit/js/cite-jq.js</xsl:attribute>-->
                </xsl:element>
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
                <xsl:apply-templates
                    select="//citeindex:reply/citeindex:graph/citeindex:node[@type='data' and @v=$labelVerb]"
                    mode="data"/>
                <xsl:if test="//citeindex:node[@v = $nextVerb] or //citeindex:node[@v = $prevVerb]">
                    <div class="navigation">
                        <p> <xsl:if test="//citeindex:node[@v = $prevVerb]"> <strong> <xsl:element
                            name="a"> <xsl:attribute name="href"><xsl:value-of select="$thisURL"
                            />?urn=<xsl:value-of
                            select="//citeindex:node[@v = $prevVerb]/citeindex:value"
                            /></xsl:attribute>
				                    previous
				                </xsl:element>
                            </strong> </xsl:if>
				                | 
				                <xsl:if
                            test="//citeindex:node[@v = $nextVerb]"> <strong> <xsl:element name="a">
                            <xsl:attribute name="href"><xsl:value-of select="$thisURL"
                            />?urn=<xsl:value-of
                            select="//citeindex:node[@v = $nextVerb]/citeindex:value"
                            /></xsl:attribute>
				                    next
				                </xsl:element>
                            </strong> </xsl:if> </p>
                    </div>
                </xsl:if>
                <div class="main-text">
                    <xsl:element name="blockquote">
                        <xsl:attribute name="cite">
                            <xsl:value-of select="//citeindex:request/citeindex:urn"/>
                        </xsl:attribute>
                        <xsl:attribute name="class">cite-text defaulttext</xsl:attribute>
                        <xsl:value-of select="//citeindex:request/citeindex:urn"/>
                    </xsl:element>
                </div>
                <h3>Related Texts</h3>
                <xsl:apply-templates select="//citeindex:reply/citeindex:graph/citeindex:sequence"/>
                <xsl:apply-templates
                    select="//citeindex:reply/citeindex:graph/citeindex:node[@type='text']"
                    mode="text"/>
                <h3>Other</h3>
                <xsl:apply-templates
                    select="//citeindex:reply/citeindex:graph/citeindex:node[@type='image']"
                    mode="image"/>
                <xsl:apply-templates
                    select="//citeindex:reply/citeindex:graph/citeindex:node[@type='object']"
                    mode="object"/>
                <xsl:call-template name="citekit-sources"/>
                </article>
                <footer>
                    <xsl:call-template name="footer"/>
                </footer>
            </body>
        </html>
    </xsl:template>
<!--    <xsl:template match="citeindex:node" mode="object">
        <xsl:variable name="thisId">
            <xsl:value-of select="generate-id(.)"/>
        </xsl:variable>
        <div class="toggler">
            <xsl:element name="a"> <xsl:attribute name="onclick">toggleThis("<xsl:value-of
                select="$thisId"/>")</xsl:attribute>
            Show/Hide
        </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="$thisId"/>
                </xsl:attribute>
                <xsl:element name="blockquote"> <xsl:attribute name="cite"><xsl:value-of
                    select="citeindex:value"/></xsl:attribute> <xsl:attribute name="class"
                    >cite-coll svc-graph-coll</xsl:attribute>
        Label: <xsl:value-of
                    select="citeindex:label"/><br/>
        Value: <xsl:value-of
                    select="citeindex:value"/> </xsl:element>
            </xsl:element>
            <xsl:element name="a">
                <xsl:attribute name="class">block-link</xsl:attribute>
                <xsl:attribute name="href"><xsl:value-of select="$thisURL"/>?urn=<xsl:value-of select=".//citeindex:value"/></xsl:attribute>
                see links
            </xsl:element>
        </div>
    </xsl:template>-->
    <xsl:template match="citeindex:sequence">
        <xsl:variable name="thisId">
            <xsl:value-of select="generate-id(.)"/>
        </xsl:variable>
        <div class="toggler text-column nofloat">
            <xsl:element name="a"> <xsl:attribute name="class">block-link</xsl:attribute>
                <xsl:attribute name="onclick">toggleThis("<xsl:value-of select="$thisId"
                />")</xsl:attribute>
            Show/Hide
        </xsl:element>
            <xsl:choose>
                <xsl:when test="@v='http://www.homermultitext.org/hmt/rdf/commentsOn'">
                    <p>
                        <strong>The passage comments on: <xsl:value-of select=".//citeindex:label"
                            /></strong>
                    </p>
                </xsl:when>
                <xsl:when test="@v='http://www.homermultitext.org/hmt/rdf/commentedOnBy'">
                    <p>
                        <strong>The passages is commented on by: <xsl:value-of
                            select=".//citeindex:label"/></strong>
                    </p>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:value-of select=".//citeindex:label"/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="$thisId"/>
                </xsl:attribute>
                <xsl:element name="blockquote">
                    <xsl:attribute name="class">cite-text defaulttext nofloat</xsl:attribute>
                    <xsl:attribute name="cite">
                        <xsl:value-of select="@urn"/>
                    </xsl:attribute>
                    <xsl:value-of select="@urn"/>
                </xsl:element>
                <div class="toggler nofloat">
                    <xsl:element name="a"> <xsl:attribute name="class">block-link</xsl:attribute>
                        <xsl:attribute name="onclick">toggleThis("list<xsl:value-of select="$thisId"
                        />")</xsl:attribute>
		            Show/Hide
		        </xsl:element>
                    <p>Individual passages for <xsl:value-of select="@urn"/></p>
                    <xsl:element name="div">
                        <xsl:attribute name="id">list<xsl:value-of select="$thisId"
                            /></xsl:attribute>
                        <xsl:apply-templates select="citeindex:value/citeindex:node" mode="text"/>
                    </xsl:element>
                </div>
            </xsl:element>
        </div>
    </xsl:template>
    <!--<xsl:template match="citeindex:node" mode="data">
        <p>
            <strong>
                <xsl:apply-templates/>
            </strong>
        </p>
    </xsl:template>-->
    <xsl:template match="citeindex:node" mode="text">
        <!-- insert stuff for checking types here -->
        <xsl:choose>
            <xsl:when test="@v='http://www.homermultitext.org/cts/rdf/containedBy'">
                <xsl:call-template name="linkyDontShow">
                    <xsl:with-param name="label">The passage is a part of: </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@v='http://www.homermultitext.org/cts/rdf/belongsTo'">
                <xsl:call-template name="linkyDontShow">
                    <xsl:with-param name="label">This passage belongs to: </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@v='http://www.homermultitext.org/cts/rdf/next'"/>
            <xsl:when test="@v='http://www.homermultitext.org/cts/rdf/prev'"/>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@v='http://www.homermultitext.org/hmt/rdf/commentsOn'">
                        <p>
                            <strong>The passage comments on:</strong>
                        </p>
                    </xsl:when>
                    <xsl:when test="@v='http://www.homermultitext.org/hmt/rdf/commentedOnBy'">
                        <p>
                            <strong>The passages is commented on by:</strong>
                        </p>
                    </xsl:when>
                </xsl:choose>
                <xsl:element name="blockquote">
                    <xsl:attribute name="class">cite-text defaulttext nofloat</xsl:attribute>
                    <xsl:attribute name="cite">
                        <xsl:value-of select=".//citeindex:value"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
                <xsl:element name="a"> <xsl:attribute name="class">block-link</xsl:attribute>
                    <xsl:attribute name="href"><xsl:value-of select="$thisURL"/>?urn=<xsl:value-of
                    select=".//citeindex:value"
                    /></xsl:attribute>
		            see links
		        </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="linkyDontShow">
        <xsl:param name="label"/>
        <div>
            <p>
                <strong>
                    <xsl:value-of select="$label"/>
                </strong>
                <xsl:value-of select="citeindex:label"/>
                <xsl:text> = </xsl:text>
                <xsl:value-of select="citeindex:value"/>
            </p>
            <xsl:element name="a"> <xsl:attribute name="class"/> <xsl:attribute name="href"
                ><xsl:value-of select="$thisURL"/>?urn=<xsl:value-of select="citeindex:value"
                /></xsl:attribute>
        see links
    </xsl:element>
        </div>
    </xsl:template>
    
    <xsl:template match="citeindex:node" mode="data">
        <p><strong><xsl:apply-templates/></strong></p>
    </xsl:template>
    
    <xsl:template match="citeindex:node" mode="object">
        
        <xsl:variable name="thisId"><xsl:value-of select="generate-id(.)"/></xsl:variable>
        <div class="toggler">
            <xsl:element name="a">
                <xsl:attribute name="id">toggle_<xsl:value-of select="$thisId"/></xsl:attribute>
                <xsl:attribute name="onclick">toggleThis("<xsl:value-of select="$thisId"/>")</xsl:attribute>
                Show/Hide
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="id"><xsl:value-of select="$thisId"/></xsl:attribute>
                
                <xsl:element name="blockquote">
                    <xsl:attribute name="cite"><xsl:value-of select="citeindex:value"/></xsl:attribute>
                    <xsl:attribute name="class">cite-collection defaultobject</xsl:attribute>
                    Label: <xsl:value-of select="citeindex:label"/><br/>
                    Value: <xsl:value-of select="citeindex:value"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="a">
                <xsl:attribute name="href"><xsl:value-of select="$thisURL"/>?urn=<xsl:value-of select=".//citeindex:value"/></xsl:attribute>
                see links
            </xsl:element>
        </div>
        
    </xsl:template>
    
    <xsl:template match="citeindex:node" mode="image">
        <xsl:param name="default"/>
        <xsl:variable name="justUrn">
            <xsl:choose>
                <xsl:when test="contains(citeindex:value,'@')"><xsl:value-of select="substring-before(citeindex:value,'@')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="citeindex:value"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="thisSize">
            <xsl:choose>
                <xsl:when test="$default = 'true'">
                    <xsl:value-of select="$bigSize"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$thumbSize"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="thisId">
            <xsl:if test="$default = 'true'">def</xsl:if>
            <xsl:value-of select="generate-id(.)"/>
        </xsl:variable>
        <xsl:element name="div">
            <xsl:attribute name="class"> <xsl:if test="$default != 'true'"
                >thumbnail</xsl:if>
            toggler
        </xsl:attribute>
            <xsl:element name="a"> <xsl:attribute name="onclick">toggleThis("<xsl:value-of
                select="$thisId"
                />")</xsl:attribute>
            
            Show/Hide
        </xsl:element>
            <p class="long-text">Image: <xsl:value-of select="citeindex:label"/></p>
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="$thisId"/>
                </xsl:attribute>
                <div>
                    <xsl:element name="blockquote"> <xsl:element name="a"> <xsl:attribute
                        name="class">block-link</xsl:attribute> <xsl:attribute name="href"
                        ><xsl:value-of select="$imgURL"/>?urn=<xsl:value-of select="citeindex:value"
                        />&amp;request=GetIIPMooViewer</xsl:attribute> <xsl:element name="img">
                        <xsl:attribute name="src"><xsl:value-of select="$imgURL"/>?urn=<xsl:value-of
                            select="$justUrn"/>&amp;w=<xsl:value-of select="$thisSize"
                        />&amp;request=GetBinaryImage</xsl:attribute> <xsl:attribute name="alt"
                        ><xsl:value-of select="citeindex:label"/></xsl:attribute> </xsl:element>
                        </xsl:element> <br/> <p class="long-text"><xsl:value-of
                        select="citeindex:value"/></p> <xsl:element name="a"> <xsl:attribute
                        name="href"><xsl:value-of select="$ictURL"/>?urn=<xsl:value-of
                            select="$justUrn"
                        /></xsl:attribute>
						cite image
					</xsl:element>
				    |
				    <xsl:element
                        name="a"> <xsl:attribute name="href"><xsl:value-of select="$thisURL"
                        />?urn=<xsl:value-of select="$justUrn"
                        /></xsl:attribute>
				        see links
				    </xsl:element>
                    </xsl:element>
                </div>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template name="citekit-sources">
        
        <ul id="citekit-sources">
            <li class="citekit-source cite-text citekit-default" id="defaulttext">@texts@</li>
            <li class="citekit-source cite-image citekit-default" id="defaultimage">@images@</li>
            <li class="citekit-source cite-collection citekit-default" id="defaultobject">@collections@</li>
            
        </ul>
       
    </xsl:template>
</xsl:stylesheet>
