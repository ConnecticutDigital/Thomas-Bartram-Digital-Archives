<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:template match="/">
           <xsl:for-each select="distinct-values(descendant::body/descendant::persName)">
               
                       <xsl:apply-templates select="tokenize(string(),' ')[2]"/>
                       <xsl:apply-templates select="tokenize(string(),' ')[1]"/>
                       <xsl:apply-templates select="@ref/node()"/>

                             
           </xsl:for-each>
          <!-- <xsl:apply-templates select="distinct-values(descendant::body/descendant::persName)"/>-->
        
    </xsl:template>
    <!--<xsl:template match="persName">
        <person xml:id="{tokenize(@ref,'#')}">
            <persName>
                <surname><xsl:apply-templates select="tokenize(string(),' ')[2]"/></surname>
                <forename type="first"><xsl:apply-templates select="tokenize(string(),' ')[1]"/></forename>
            </persName>
            <note resp="#RF"/>
        </person>
    </xsl:template>-->
    
</xsl:stylesheet>