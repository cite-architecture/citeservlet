<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts" xmlns:dc="http://purl.org/dc/elements/1.1" xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html" encoding="UTF-8"/>
    <xsl:include href="header.xsl"/>
    <xsl:include href="chs_tei_to_html5.xsl"/>
	<xsl:include href="alternates.xsl"/>
    
    <xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
    <xsl:variable name="formsUrl">@queryforms@</xsl:variable>
	
   
	<!-- Framework for main body of document -->
	<xsl:template match="/">
		<!-- can some of the reply contents in xsl variables
			for convenient use in different parts of the output -->
		<xsl:variable name="urnString">
			<xsl:value-of select="//cts:request/cts:requestUrn"/>
		</xsl:variable>
		
		
		
		
		<html>
			<head>
				
				<link
						href="css/graph.css"
					rel="stylesheet"
					title="CSS for CTS"
					type="text/css"/>
			    <link
			        href="css/citekit_special.css"
			        rel="stylesheet"
			        title="CSS for CTS"
			        type="text/css"/>
			<link
						href="@coreCss@"
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
						<title><xsl:value-of
							select="//cts:reply/cts:label/cts:groupname"/>, <xsl:value-of
							    select="//cts:reply/cts:label/cts:title"/> (<xsl:value-of
							        select="//cts:reply/cts:label/cts:version"/>): 
							<xsl:call-template name="urnPsg">
								<xsl:with-param name="urnStr">
									<xsl:value-of select="$urnString"/>
								</xsl:with-param>
							</xsl:call-template>
						</title>
					</xsl:otherwise>
				</xsl:choose>
			</head>
			<body>
				
				
			    <header>
			        <xsl:call-template name="header"/>
			    </header>
				<nav>
					<p>  @projectlabel@:
						<xsl:element name="a">
						    <xsl:attribute name="href"><xsl:value-of select="$homeUrl"/></xsl:attribute>
						        home
						</xsl:element>
						   
						<!--<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="$formsUrl"/></xsl:attribute>
							Look up material by URN
						</xsl:element>-->
						    
						
					</p>
					
				</nav>
				
				<article>
					<xsl:choose>
						<xsl:when
							test="/cts:CTSError">
							<xsl:apply-templates
								select="cts:CTSError"/>
						</xsl:when>
						<xsl:otherwise>
							<h1><xsl:value-of
							    select="//cts:reply/cts:label/cts:groupname"/>, <em>
											<xsl:value-of
											    select="//cts:reply/cts:label/cts:title"/>
										</em> (<xsl:value-of
										    select="//cts:reply/cts:label/cts:version"/>):
								<xsl:call-template name="urnPsg">
									<xsl:with-param name="urnStr">
										<xsl:value-of select="$urnString"/>
									</xsl:with-param>
								</xsl:call-template>
								
									</h1>
									
									<p><xsl:value-of select="$urnString"/></p>
								
							
							<xsl:apply-templates
								select="//cts:reply"/>
						</xsl:otherwise>
					</xsl:choose>
					
				</article>
			    <footer>
			        <xsl:call-template name="footer"/>
			    </footer>
			</body>
		</html>
	</xsl:template>
	<!-- End Framework for main body document -->
	<!-- Match elements of the CTS reply -->
	<xsl:template match="cts:reply">
		<!--<xsl:if test="(@xml:lang = 'grc') or (@xml:lang = 'lat')">
			<div class="chs-alphaios-hint">Because this page has Greek or Latin text on it, it can take advantage of the morphological and lexical tools from the <a href="http://alpheios.net/" target="blank">Apheios Project</a>.</div>
		</xsl:if>-->
		<xsl:element name="div">
			<xsl:attribute name="lang">
				<xsl:value-of select="@xml:lang"/>
			</xsl:attribute>
			
			<!-- This is where we will catch TEI markup -->
			<xsl:apply-templates/>
			<!-- ====================================== -->
			
		</xsl:element>
	</xsl:template>
    <xsl:template match="cts:urn"/>
    <xsl:template match="cts:groupname"/>
    <xsl:template match="cts:title"/>
    <xsl:template match="cts:label"/>
	<xsl:template match="cts:CTSError">
		<h1>CTS Error</h1>
		<p class="cts:error">
			<xsl:apply-templates select="cts:message"/>
		</p>
		<p>Error code: <xsl:apply-templates select="cts:code"/></p>
		<p>Error code: <xsl:apply-templates select="cts:code"/></p>
		<p>CTS library version: <xsl:apply-templates select="cts:libraryVersion"/>
		</p>
		<p>CTS library date: <xsl:apply-templates select="cts:libraryDate"/>
		</p>
	</xsl:template>
    
	<xsl:template
		match="cts:prevnext">
		<xsl:variable
			name="ctxt">
			<xsl:value-of
				select="//cts:context"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="$ctxt > 0">
				<!-- Do nothing! -->
			</xsl:when>
			<xsl:otherwise>
				<div
					class="prevnext">
					<span
						class="prv">
						<xsl:if
							test="cts:prev != ''">
							<xsl:choose>
								<xsl:when
									test="//cts:inv">
									<xsl:variable
										name="inv">
										<xsl:value-of
											select="//cts:inv"/>
									</xsl:variable>
									<xsl:variable
										name="prvVar">@texts@?inv=<xsl:value-of
											select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
												select="cts:prev"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$prvVar"/>
										</xsl:attribute> prev </xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable
										name="prvVar">@texts@?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
											select="cts:prev"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$prvVar"/>
										</xsl:attribute> prev </xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</span> | <span
						class="nxt">
						<xsl:if
							test="cts:next != ''">
							<xsl:choose>
								<xsl:when
									test="//cts:inv">
									<xsl:variable
										name="inv">
										<xsl:value-of
											select="//cts:inv"/>
									</xsl:variable>
									<xsl:variable
										name="nxtVar">@texts@?inv=<xsl:value-of
											select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
												select="cts:next"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$nxtVar"/>
										</xsl:attribute> next </xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable
										name="nxtVar">@texts@?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
											select="cts:next"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$nxtVar"/>
										</xsl:attribute> next </xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</span>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
		
		
	
	
	<xsl:template name="urnPsg">
		<xsl:param name="urnStr"/>
		<xsl:choose>
			<xsl:when test="contains($urnStr,':')">
				<xsl:call-template name="urnPsg">
					<xsl:with-param name="urnStr">
						<xsl:value-of select="substring-after($urnStr,':')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$urnStr"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Special!! Identify leaf-nodes -->
	<xsl:template match="cts:node">
		<xsl:element name="mark">
			<xsl:attribute name="class">cts_node</xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="@urn"/></xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
		
		
	</xsl:template>
	
	<xsl:template match="node">
		<xsl:element name="mark">
			<xsl:attribute name="class">cts_node</xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="@urn"/></xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	 </xsl:template>
	
	<!-- Default: replicate unrecognized markup -->
	<xsl:template match="@*|node()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
