<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:for-each select="issue/journals/journal/notes">
			<xsl:if test="contains(text(), 'sql')">
				<xsl:value-of select="text()"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
