<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts" xmlns:dc="http://purl.org/dc/elements/1.1" xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output omit-xml-declaration="yes" method="html" encoding="UTF-8"/>
	<xsl:include href="header.xsl"/>
	<xsl:include href="chs_tei_to_html5.xsl"/>
	<xsl:include href="alternates.xsl"/>
	
	<xsl:variable name="homeUrl">@homeUrl@</xsl:variable>
	<xsl:variable name="formsUrl">@queryforms@</xsl:variable>
	<xsl:variable name="textsUrl">@texts@</xsl:variable>

	<xsl:template match="/">
		<!-- can some of the reply contents in xsl variables
			for convenient use in different parts of the output -->
		<xsl:variable name="urnString">
			<xsl:value-of select="//cts:request/cts:urn"/>
		</xsl:variable>
		
		<HTML>
			<head>
				
				<link
					href="css/graph.css"
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
						<title>Valid References for <xsl:value-of select="$urnString"/>
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
						
						:
						<!--<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="$formsUrl"/></xsl:attribute>
							Look up material by URN
						</xsl:element>-->
						
						
					</p>
					
				</nav>
				
				
				
				<article>
				<xsl:choose>
					<xsl:when test="/cts:CTSError">
						<xsl:apply-templates select="cts:CTSError"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="//cts:request/cts:edition">
								<h1>Valid references for <xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em></h1>
								<h2>
									<xsl:value-of select="//cts:request/cts:label"/>
								</h2>
							</xsl:when>
							<xsl:when test="//cts:request/cts:translation">
								<h1>Valid references for <xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em></h1>
								<h2>
									<xsl:value-of select="//cts:request/cts:label"/>
								</h2>
							</xsl:when>
							<xsl:when test="//cts:request/cts:title">
								<h1>Valid references for <xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em></h1>
							</xsl:when>
							<xsl:when test="//cts:request/cts:groupname">
								<h1>Valid references for group <xsl:value-of select="//cts:request/cts:groupname"/></h1>
							</xsl:when>
						</xsl:choose>
						<p class="urn"> (= <xsl:value-of select="$urnString"/>) </p>
						<ul class="cts-content">
							<xsl:apply-templates select="/cts:GetValidReff/cts:reply/cts:reff"/>
						</ul>
						
						
						
					</xsl:otherwise>
				</xsl:choose>
				</article>
				
				<footer>
					<xsl:call-template name="footer"/>
				</footer>
				
			</body>
		</HTML>
	</xsl:template>
	<xsl:template match="cts:CTSError">
		<h1>CTS Error</h1>
		<p class="error">
			<xsl:apply-templates select="cts:message"/>
		</p>
		<p>Error code: <xsl:apply-templates select="cts:code"/></p>
		<p>CTS library version: <xsl:apply-templates select="cts:libraryVersion"/>
		</p>
		<p>CTS library date: <xsl:apply-templates select="cts:libraryDate"/>
		</p>
	</xsl:template>
	<xsl:template match="cts:reff">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="cts:urn">
		<li>
			<xsl:call-template name="urnPsg">
				<xsl:with-param name="urnStr">
					<xsl:value-of select="."/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:text>:  </xsl:text>
			<!-- put together var with gp string -->
			
					<xsl:variable name="psg"><xsl:value-of select="$textsUrl"/>?request=GetPassagePlus&amp;urn=<xsl:value-of select="."/></xsl:variable>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="$psg"/>
						</xsl:attribute>view passage</xsl:element>
					<xsl:if test="//cts:request/cts:level">
						<xsl:variable name="level">
							<xsl:value-of select="//cts:request/cts:level"/>
						</xsl:variable>
						<xsl:variable name="minimumLeaf"><xsl:value-of select="//cts:request/cts:minimumLeaf"/></xsl:variable>
							
						
						<!--<xsl:choose>
							<xsl:when test="$level &lt; $minimumLeaf">
								<xsl:variable name="newLevel">
									<xsl:value-of select="$level + 1"/>
								</xsl:variable>
								<xsl:variable name="url"><xsl:value-of select="$textsUrl"/>?request=GetValidReff&amp;urn=<xsl:value-of select="."/>&amp;level=<xsl:value-of select="$newLevel"
									/></xsl:variable>
								<xsl:text> : </xsl:text>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$url"/>
									</xsl:attribute>
                                            expand one level
                                    </xsl:element>
							</xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:if>-->
					</xsl:if>
			
		</li>
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
	<xsl:template match="@*|node()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
