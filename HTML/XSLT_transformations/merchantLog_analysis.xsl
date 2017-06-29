<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <meta name="description" content="Black Rock History Website"/>
                <meta name="author" content="Rebecca Parker and Robert Foley"/>
                <title>
                    <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                </title>
                <xsl:comment>Bootstrap CSS</xsl:comment>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <xsl:comment>Custom CSS</xsl:comment>
                <link rel="stylesheet" type="text/css" href="css/style.css"/>
                
            </head>
            <body>
                <div id="nav">
                    <h1 class="nav">Analysis of Thomas Bartram's Merchant and Shipping Logs</h1>
                    <a href="index.html">Home</a> | <a href="about.html">About</a>
                </div>
                <div class="col-xs-12">
                    <p class="text-center">Disclaimer: the analysis represented on this page fluctuates as additional pages of Bartram's merchant logs are encoded.</p>
                    <ul>
                        <li>Pages Transcribed and Encoded: <xsl:apply-templates select="count(descendant::div[@type='page'])"></xsl:apply-templates></li>
                        <li>Lines Transcribed and Encoded: <xsl:apply-templates select="count(descendant::body//descendant::item)"></xsl:apply-templates></li>
                        <li>Instances of unclear/missing text: <xsl:apply-templates select="count(descendant::body//unclear)"></xsl:apply-templates></li>
                        <li>Distinct People Mentioned: <xsl:apply-templates select="count(distinct-values(descendant::back/descendant::person/@xml:id))"></xsl:apply-templates></li>
                        <li>Distinct Places Mentioned: <xsl:apply-templates select="count(distinct-values(descendant::back/descendant::place/@xml:id))"></xsl:apply-templates></li>
                        <li>Distinct Commodities Mentioned: <xsl:apply-templates select="count(distinct-values(descendant::body/descendant::measure/@commodity))"></xsl:apply-templates></li>
                    </ul>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
