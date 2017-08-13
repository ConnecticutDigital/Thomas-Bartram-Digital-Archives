<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <ul>
            <xsl:apply-templates select="root"/>
        </ul>
    </xsl:template>
    <xsl:template  match="row">
        <li>
            <a href="{child::url_description}"><xsl:apply-templates select="child::district"/></a>
            <a href="{child::url_foto}"><img src="images/icon-image-128.png"/></a>
        </li>
    </xsl:template>
</xsl:stylesheet>