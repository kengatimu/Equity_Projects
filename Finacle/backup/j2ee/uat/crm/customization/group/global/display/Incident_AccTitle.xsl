<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml"/>

<xsl:template match="/" >



<xsl:variable name="MainBO" select="'RequestBO'"/>
<xsl:variable name="MainBO_Str" select="'RequestBO.'"/>
<xsl:variable name="MainChildBO1" select="'RequestGenInfo'"/>
<xsl:variable name="MainChildBO1_Str" select="'RequestBO.RequestGenInfo.'"/>

<xsl:variable name="RelatedBO1" select="'IncidentBO'"/>
<xsl:variable name="RelatedBO1_Str" select="'IncidentBO.'"/>




<xsl:for-each select="SRM">
	<xsl:for-each select="SRMData">
		<xsl:for-each select="SRMComposite">
			<xsl:for-each select="SRMRow">
					<xsl:element name="SRMRow">

						<xsl:element name="{$RelatedBO1}">
							<xsl:for-each select="Z">
									<xsl:variable name="element1" select="@n"/>
									<xsl:if test=" contains(@n,$RelatedBO1_Str) and not(contains(@n,$MainBO_Str))">
										<xsl:variable name="element1" select="substring-after(@n,$RelatedBO1_Str)"/>
											<xsl:element name="{$element1}">
											<xsl:value-of select="current()"/>
										</xsl:element>
									</xsl:if>
							</xsl:for-each>
						</xsl:element>



						<xsl:element name="{$MainBO}">
							<xsl:for-each select="Z">
									<xsl:variable name="element1" select="@n"/>
									<xsl:if test=" contains(@n,$MainBO_Str) and not(contains(@n,$RelatedBO1_Str)) and
									not(contains(@n,$MainChildBO1_Str))">
										<xsl:variable name="element1" select="substring-after(@n,$MainBO_Str)"/>
											<xsl:element name="{$element1}">
											<xsl:value-of select="current()"/>
										</xsl:element>
									</xsl:if>
							</xsl:for-each>



						<xsl:element name="{$MainChildBO1}">
							<xsl:for-each select="Z">
									<xsl:variable name="element1" select="@n"/>
									<xsl:if test=" contains(@n,$MainChildBO1_Str)">
										<xsl:variable name="element1" select="substring-after(@n,$MainChildBO1_Str)"/>
											<xsl:element name="{$element1}">
											<xsl:value-of select="current()"/>
										</xsl:element>
									</xsl:if>
							</xsl:for-each>
						</xsl:element>

						</xsl:element>


					</xsl:element>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>
 		<xsl:for-each select="SRMPresentation">
 	</xsl:for-each>
 </xsl:for-each>
 </xsl:template>

</xsl:stylesheet>
