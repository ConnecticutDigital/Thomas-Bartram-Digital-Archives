<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="row">
        <xsl:comment> <xsl:apply-templates select="@Heading0/tokenize(.,'_')[2]"/>Page<xsl:apply-templates select="@Heading0/tokenize(.,'[_.]')[4]"/></xsl:comment>
        <div type="page" facs="{@Heading0}.jpg">
            <div type="group">
                <head/>
                <list type="entry">
                    <item/>
                </list>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="Heading1"></xsl:template>
    <xsl:template match="Heading2"></xsl:template>
</xsl:stylesheet>