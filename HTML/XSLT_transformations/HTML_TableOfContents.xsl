<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" indent="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                </title>
                <xsl:comment>Bootstrap CSS</xsl:comment>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <xsl:comment>Custom CSS</xsl:comment>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1 class="main">TABLE OF CONTENTS</h1>
                <h2 class="main">
                    <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                </h2>
                <h3 class="main">Authored by <xsl:apply-templates select="//teiHeader//titleStmt//author"/></h3>
                <div class="col-xs-12">
                    <div id="toc" class="col-xs-2">
                        <ul>
                            <xsl:apply-templates select="//div[@type = 'page']" mode="toc"/>
                        </ul>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type = 'page']" mode="toc">
        <li>
            <a href="HTML_output.html#page{count(preceding::div[@type='page']) + 1}">Page <xsl:apply-templates
                select="count(preceding::div[@type = 'page']) + 1"/></a>
        </li>
    </xsl:template>
    
    
</xsl:stylesheet>