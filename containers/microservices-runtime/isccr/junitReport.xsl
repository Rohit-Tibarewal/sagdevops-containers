<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
	<xsl:template match="/">
		<testsuites name="Integration Server Code Review">
		<xsl:attribute name="disabled"><xsl:value-of select="count(//CodeCheckConfiguration/checks/check[@enabled='false'])"></xsl:value-of></xsl:attribute>
		<xsl:attribute name="failures"><xsl:value-of select="sum(//CodeCheckConfiguration/checks/check/results/Summary/fail/text())"></xsl:value-of></xsl:attribute>
		<xsl:attribute name="tests"><xsl:value-of select="sum(//CodeCheckConfiguration/checks/check/results/Summary/pass/text())"></xsl:value-of></xsl:attribute>
		<xsl:attribute name="time"><xsl:value-of select="sum(//CodeCheckConfiguration/checks/check/results/Summary/executeTime/text()) div 1000"></xsl:value-of></xsl:attribute>
		<!-- time="{sum(/CodeCheckConfiguration/checks/check/results/Summary/executeTime/text() div 1000}">-->
			<xsl:for-each select="//CodeCheckConfiguration/checks/check">
				<xsl:variable name="currentCheck" select="."/>
				<xsl:if test="results/Summary/total/text()!='0'">
					<testsuite errors="0" hostname="localhost" timestamp="{../../properties/date}" package="{../../properties/packageName}" id="{../../properties/packageName}-{results/Report/Test[1]/@check-id}">
						<xsl:attribute name="failures"><xsl:value-of select="results/Summary/fail/text()"/></xsl:attribute>
						<xsl:attribute name="tests"><xsl:value-of select="results/Summary/total/text()"/></xsl:attribute>
						<xsl:attribute name="time"><xsl:value-of select="results/Summary/executeTime/text() div 1000"/></xsl:attribute>
						<xsl:attribute name="name"><xsl:value-of select="@id"/><xsl:text>: </xsl:text><xsl:value-of select="@name"/></xsl:attribute>
						<!-- -->
						<properties>
							<xsl:for-each select="CodeCheckConfiguration/globalParameters/globalParameter_x">
								<property>
									<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="value/text()"/></xsl:attribute>
								</property>
							</xsl:for-each>
						</properties>
						<xsl:for-each select="results/Report/Test">
							<testcase time="{@executeTime div 1000}" classname="{Service/text()}" name="{$currentCheck/@name}">
								<!--<xsl:attribute name="classname"><xsl:value-of select="Service/text()"/></xsl:attribute>
								<xsl:attribute name="name"><xsl:value-of select="$currentCheck/@name"/></xsl:attribute>-->
								<!-- Failed -->
								<xsl:if test="@passed!='true' and ../../../@ignoreFailure='false'">
									<failure>
										<xsl:attribute name="message"><xsl:value-of select="$currentCheck/description/text()"/></xsl:attribute>
										<xsl:attribute name="type"><xsl:value-of select="$currentCheck/implementation/class/text()"/></xsl:attribute>
										<xsl:value-of select="$currentCheck/description/text()"/>
									</failure>
								</xsl:if>
							</testcase>
						</xsl:for-each>
					</testsuite>
				</xsl:if>
			</xsl:for-each>
		</testsuites>
	</xsl:template>
</xsl:stylesheet>
