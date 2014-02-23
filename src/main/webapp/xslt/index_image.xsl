<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:citeindex='http://chs.harvard.edu/xmlns/citeindex' version="1.0">
    <xsl:import href="header.xsl"/>
    <xsl:output encoding="UTF-8" indent="no" method="html"/>
    
    <xsl:variable name="labelVerb">http://www.w3.org/1999/02/22-rdf-syntax-ns#label</xsl:variable>
    <xsl:variable name="licenseVerb">http://www.homermultitext.org/cite/rdf/license</xsl:variable>
    
    
    <!-- Linking URLs for nav section -->
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
    
    <!-- Variables for CSS Classes and HTML IDs -->
    <xsl:variable name="canvasId">canvas</xsl:variable>
    <xsl:variable name="rectClass">cite_rect</xsl:variable>
    <xsl:variable name="rectIdBase">cite_rect_</xsl:variable>
    <xsl:variable name="objClass">cite_obj</xsl:variable>
    <xsl:variable name="objIdBase">cite_obj_</xsl:variable>
    <xsl:variable name="seqClass">cite_sequence</xsl:variable>
    <xsl:variable name="pairClass">cite_pair</xsl:variable>
    <xsl:variable name="roiLabelClass">cite_label</xsl:variable>
    <xsl:variable name="snipClass">cite_snippet</xsl:variable>
    <xsl:variable name="thumbSize">150</xsl:variable>
    
    <!-- Variables for URLs of services, images, etc. -->
    <xsl:variable name="imgURL">@images@</xsl:variable>
    <xsl:variable name="ictURL">@ict@?urn=</xsl:variable>
    <xsl:variable name="thisURL">@indices@</xsl:variable>
    
    <!-- Variables for RDF verbs, etc. -->
    <xsl:variable name="illustratesVerb">http://www.homermultitext.org/cite/rdf/illustrates</xsl:variable>
    
    <!-- Variables for URLs of services, images, etc. -->
   <!-- <xsl:variable name="imgURL">http://beta.hpcc.uh.edu/tomcat/hmt/images</xsl:variable>
    <xsl:variable name="ictURL">http://localhost:8080/citeservlet/ict.html?urn=</xsl:variable>
    <xsl:variable name="thisURL">http://localhost:8080/citeservlet/indices</xsl:variable>-->
    
    
    <xsl:variable name="imageThumbURL"><xsl:value-of select="$imgURL"
        />?request=GetBinaryImage&amp;w=600&amp;urn=</xsl:variable>
    <xsl:variable name="snipThumbURL"><xsl:value-of select="$imgURL"
    />?request=GetBinaryImage&amp;w=2000&amp;urn=</xsl:variable>
    <xsl:variable name="imageGIPUrl"><xsl:value-of select="$imgURL"
        />?request=GetImagePlus&amp;urn=</xsl:variable>
    <xsl:variable name="imageMooUrl"><xsl:value-of select="$imgURL"
    />?request=GetIIPMooViewer&amp;urn=</xsl:variable>
    
    <!-- Variables from source XML -->
    <xsl:variable name="imageURN">
        <xsl:value-of select="//citeindex:reply/citeindex:graph/@urn"/>
    </xsl:variable>
   
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <title>CITE Index</title>
                <link href="@coreCss@" rel="stylesheet"/>
                <link href="css/graph.css" rel="stylesheet"/>
                
                <script src="js/jquery.min.js"/>
                <script>
							var img_source = "<xsl:value-of select="$imageThumbURL"/><xsl:value-of select="$imageURN"/>";
							var canvasId = "<xsl:value-of select="$canvasId"/>";
							var mapArray = new Array();
							var groupArray = new Array();
							var rectClass = "<xsl:value-of select="$rectClass"/>";
                            var rectIdBase = "<xsl:value-of select="$rectClass"/>";
                            var objectClass = "<xsl:value-of select="$objClass"/>";
                            var objectIdBase = "<xsl:value-of select="$objIdBase"/>";
                            var seqClass = "<xsl:value-of select="$seqClass"/>";
                            var pairClass = "<xsl:value-of select="$pairClass"/>";
                            var labelClass = "<xsl:value-of select="$roiLabelClass"/>";
                            var imgURL = "<xsl:value-of select="$imageGIPUrl"/>";
							
				</script>
                <script src="js/visinv.js" type="text/javascript"/>
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
                        
                        <!--<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="$formsUrl"/></xsl:attribute>
							Look up material by URN
						</xsl:element>-->
                        
                        
                    </p>
                    
                </nav>
                <article>
                <div id="rightDiv">
                    
                    <div id="texts">
                        
                        <xsl:if test="//citeindex:node[(@v = $illustratesVerb) and (@type = 'object')]">
                          <!-- <xsl:for-each select="//citeindex:node[(@v = $illustratesVerb) and (@type = 'object')]">
                               <xsl:apply-templates select="current()" mode="object"/>
                              
                            </xsl:for-each>-->
                            
                            <xsl:call-template name="objectContainer"/>
                        </xsl:if>
                        
                        <xsl:apply-templates
                            select="//citeindex:reply/citeindex:graph/citeindex:sequence"/>
                    </div>
                    <p style="clear: both;">- end data -</p>
                   
                </div>
                <div id="leftDiv">
                    <p>
                        <strong><xsl:value-of select="//citeindex:node[@v = $labelVerb]"/></strong><br/>
                        <xsl:value-of select="//citeindex:node[@v = $licenseVerb]"/><br/>
                        <code><xsl:value-of
                        select="//citeindex:request/citeindex:urn"/></code>
                    </p>
                   
                    <xsl:element name="a">
                        <xsl:attribute name="href"><xsl:value-of select="$ictURL"/><xsl:value-of select="//citeindex:request/citeindex:urn"/></xsl:attribute>
                        cite image
                    </xsl:element>
                    |
                    <xsl:element name="a">
                        <xsl:attribute name="href"><xsl:value-of select="$imageMooUrl"/><xsl:value-of select="//citeindex:request/citeindex:urn"/></xsl:attribute>
                        zoom
                    </xsl:element>
                    |
                    <xsl:element name="a">
                        <xsl:attribute name="href"><xsl:value-of select="$imageGIPUrl"/><xsl:value-of select="//citeindex:request/citeindex:urn"/></xsl:attribute>
                        more info
                    </xsl:element>
                    | (click image to re-center)
                    
                    <xsl:call-template name="makeCanvas"/>
                    
                    <div id="objects">
                        <h3>Others</h3>
                        <!--<xsl:apply-templates select="//citeindex:reply/citeindex:graph/citeindex:node[(@type = 'object') and (@v != 'http://www.homermultitext.org/cite/rdf/illustrates')]"
                        />-->
                        <ul><xsl:for-each select="//citeindex:reply/citeindex:graph/citeindex:node[(@v != 'http://www.homermultitext.org/cite/rdf/illustrates') and (@v != 'http://www.homermultitext.org/cite/rdf/hasExtendedRef') and (@type = 'image')]"
                        >
                            <li><strong>Image: </strong><xsl:apply-templates select="current()"/></li></xsl:for-each>
                        </ul>
                        <ul><xsl:for-each select="//citeindex:reply/citeindex:graph/citeindex:node[(@v != 'http://www.homermultitext.org/cite/rdf/illustrates') and (@v != 'http://www.homermultitext.org/cite/rdf/hasExtendedRef') and (@type = 'object')]"
                            ><li><strong>Object: </strong><xsl:apply-templates select="current()"/></li></xsl:for-each>
                        </ul>
                        <ul>
                        Texts: <xsl:for-each select="//citeindex:reply/citeindex:graph/citeindex:node[(@v != 'http://www.homermultitext.org/cite/rdf/illustrates') and (@v != 'http://www.homermultitext.org/cite/rdf/hasExtendedRef') and (@type = 'text')]"
                            ><li><strong>Text: </strong><xsl:apply-templates select="current()"/></li></xsl:for-each></ul>
                    </div>
                   
                </div>
                <xsl:call-template name="citekit-sources"/>
                </article>
            <footer>
                <xsl:call-template name="footer"/>
            </footer>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="makeCanvas">
        <xsl:element name="canvas">
            <xsl:attribute name="id">
                <xsl:value-of select="$canvasId"/>
            </xsl:attribute>
            <xsl:attribute name="width">800</xsl:attribute>
            <xsl:attribute name="height">1000</xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="objectContainer">
        <xsl:variable name="thisSeqId"><xsl:value-of select="generate-id()"/></xsl:variable>
        <div class="toggler text-column">
            
            <xsl:element name="a">
                <xsl:attribute name="id">toggle_<xsl:value-of select="$thisSeqId"/></xsl:attribute>
                <xsl:attribute name="onclick">toggleThis("<xsl:value-of select="$thisSeqId"/>")</xsl:attribute>
                Show/Hide
            </xsl:element>
            <p class="long-text">Non-textual data mapped to this image</p>
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:value-of select="$seqClass"/>
                    
                </xsl:attribute>
                <xsl:attribute name="id"><xsl:value-of select="$thisSeqId"/></xsl:attribute>
                
                <xsl:for-each select="//citeindex:node[(@v = $illustratesVerb) and (@type = 'object')]">
                    <xsl:call-template name="textNode">
                        <xsl:with-param name="seqId"><xsl:value-of select="$thisSeqId"/></xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
                
            </xsl:element>
        </div>
    </xsl:template>
    
    
    <xsl:template match="citeindex:sequence">
      <xsl:variable name="thisSeqId"><xsl:value-of select="generate-id(.)"/></xsl:variable>
        <div class="toggler text-column">
            
        <xsl:element name="a">
            <xsl:attribute name="id">toggle_<xsl:value-of select="$thisSeqId"/></xsl:attribute>
            <xsl:attribute name="onclick">toggleThis("<xsl:value-of select="$thisSeqId"/>")</xsl:attribute>
            Show/Hide
        </xsl:element>
        <p class="long-text"><xsl:value-of select="./citeindex:label"/></p>
      <xsl:element name="div">
          <xsl:attribute name="class">
              <xsl:value-of select="$seqClass"/>
              
          </xsl:attribute>
          <xsl:attribute name="id"><xsl:value-of select="$thisSeqId"/></xsl:attribute>
          
          <!--<xsl:element name="blockquote">
             <xsl:attribute name="cite"><xsl:value-of select="@urn"/></xsl:attribute>
              <xsl:attribute name="class">cite-cts svc-graph-cts</xsl:attribute>
          <strong><xsl:value-of select="@urn"/></strong>
          </xsl:element>-->
          
          <xsl:apply-templates select="citeindex:value/citeindex:node" mode="visinv-text">
              <xsl:with-param name="seqId"><xsl:value-of select="$thisSeqId"/></xsl:with-param>
          </xsl:apply-templates>
      </xsl:element>
        </div>
    </xsl:template>
    
    <xsl:template match="citeindex:node[@type = 'object']">
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
    
    <xsl:template match="citeindex:node" mode="visinv-text" name="textNode">
        <!-- The following variable will associate the object with the bounding rectangle -->
        <xsl:variable name="thisId"><xsl:value-of select="generate-id()"/></xsl:variable>
        <xsl:variable name="thisType"><xsl:value-of select="@type"/></xsl:variable>
        <!-- Test that this is an "illustrates" relationship, and that the subject has an ROI -->
        <xsl:if
            test="(current()/@v = $illustratesVerb) and (contains(current()/@s,'@'))">
                <!-- The Div of type "pair" holds an object and its ROI -->
                <xsl:element name="div">
                    <xsl:attribute name="id"><xsl:value-of select="$thisId"/></xsl:attribute>
                        <xsl:attribute name="class"><xsl:value-of select="$pairClass"/></xsl:attribute>
                    <xsl:element name="div"> <!-- The ROI rectangle -->
                        <xsl:attribute name="class"><xsl:value-of select="$rectClass"/></xsl:attribute>
                        <xsl:attribute name="id"><xsl:value-of select="$rectIdBase"/><xsl:value-of select="$thisId"/></xsl:attribute>
                        <xsl:element name="span">
                            <xsl:attribute name="class"><xsl:value-of select="$roiLabelClass"/></xsl:attribute>
                            <xsl:value-of select="@s"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="div"> <!-- The object illustrated by the ROI -->
                        <xsl:attribute name="class"><xsl:value-of select="$objClass"/> text-column</xsl:attribute>
                        <xsl:attribute name="id"><xsl:value-of select="$objIdBase"/><xsl:value-of select="$thisId"/></xsl:attribute>
                        
                        <!--<xsl:element name="img">
                            <xsl:attribute name="class"><xsl:value-of select="$snipClass"/></xsl:attribute>
                            <xsl:attribute name="src"><xsl:value-of select="$snipThumbURL"/><xsl:value-of select="@s"/></xsl:attribute>
                        </xsl:element>-->
                        
                        <xsl:choose>
                            <xsl:when test="$thisType = 'text'">
                                <xsl:element name="blockquote">
                                    <xsl:attribute name="cite"><xsl:value-of select="citeindex:value"/></xsl:attribute>
                                    <xsl:attribute name="class">cite-text defaulttext</xsl:attribute>
                                    <xsl:value-of select="citeindex:value"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="$thisType = 'object'">
                                
                                <xsl:element name="blockquote">
                                    <xsl:attribute name="cite"><xsl:value-of select="citeindex:value"/></xsl:attribute>
                                    <xsl:attribute name="class">cite-collection defaultobject</xsl:attribute>
                                    <xsl:value-of select="citeindex:value"/>
                                </xsl:element>
                            </xsl:when>
                           
                        </xsl:choose>
                        <xsl:element name="a">
                            <xsl:attribute name="class">block-link</xsl:attribute>
                            <xsl:attribute name="href"><xsl:value-of select="$thisURL"/>?urn=<xsl:value-of select=".//citeindex:value"/></xsl:attribute>
                            see links
                        </xsl:element>    
                    </xsl:element>
                    
                </xsl:element>
         </xsl:if>
    </xsl:template>
    
   <!-- <xsl:template match="citeindex:node" mode="object">
        <xsl:variable name="thisId"><xsl:value-of select="generate-id(.)"/></xsl:variable>
        <div class="toggler">
            <xsl:element name="a">
                <xsl:attribute name="onclick">toggleThis("<xsl:value-of select="$thisId"/>")</xsl:attribute>
                Show/Hide
            </xsl:element>
            <p class="long-text">Non-textual data mapped to this image</p>
            <xsl:element name="div">
                <xsl:attribute name="id"><xsl:value-of select="$thisId"/></xsl:attribute>
                <xsl:element name="blockquote">
                    <xsl:attribute name="cite"><xsl:value-of select="citeindex:value"/></xsl:attribute>
                    <xsl:attribute name="class">cite-collection defaultobject</xsl:attribute>
                    Label: <xsl:value-of select="citeindex:label"/><br/>
                    Value: <xsl:value-of select="citeindex:value"/>
                </xsl:element>
            </xsl:element>
        </div>
    </xsl:template>-->
    
    <xsl:template match="citeindex:node" mode="show">
        <div>
        
        </div>
    </xsl:template>
     
    <xsl:template name="citekit-sources">
        
        <ul id="citekit-sources">
            <li class="citekit-source cite-text citekit-default" id="defaulttext">@texts@</li>
            <li class="citekit-source cite-image citekit-default" data-image-w="900" id="defaultimage">@images@</li>
            <li class="citekit-source cite-collection citekit-default" id="defaultobject">@collections@</li>
        </ul>
        <!--
        <div id="citekit-additional-sources">
            <p class="citekit-additional-source cite-cts" id="svc-graph-cts"
                >@texts@?request=GetPassagePlus&amp;urn=</p>
            <p class="citekit-additional-source cite-img" id="svc-graph-img"
                >@images@?request=GetImagePlus&amp;urn=</p>
            <p class="citekit-additional-source cite-coll" id="svc-graph-coll">@collections@?request=GetObjectPlus&amp;urn=</p>
        </div> -->
        <!--<div id="citekit-additional-sources">
            <p class="citekit-additional-source cite-cts" id="svc-graph-cts"
                >http://localhost:8080/citeservlet/texts?request=GetPassagePlus&amp;urn=</p>
            <p class="citekit-additional-source cite-img" id="svc-graph-img"
                >http://beta.hpcc.uh.edu/tomcat/hmt/images?request=GetImagePlus&amp;urn=</p>
            <p class="citekit-additional-source cite-coll" id="svc-graph-coll">http://localhost:8080/citeservlet/collections?request=GetObjectPlus&amp;urn=</p>
        </div>-->
    </xsl:template>
    
    
    
</xsl:stylesheet>
