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
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                </h1>
                <h3>Table of Contents</h3>
                <div id="toc">
                    <ul>
                        <xsl:apply-templates select="//div[@type = 'page']" mode="toc"/>
                    </ul>
                </div>
                <xsl:apply-templates select="//div[@type = 'page']"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type = 'page']" mode="toc">
        <!-- RJP"2016-03-09: Once we decide to add pages 1 and 2 to the master XML file we will go back and fix the code below so that the pages are counting from 1 instead of from 3 onward.  -->
        <li>
            <a href="#page{2 + count(preceding::div[@type='page']) + 1}">Page <xsl:apply-templates
                    select="2 + count(preceding::div[@type = 'page']) + 1"/></a>
        </li>
    </xsl:template>
    <xsl:template match="div[@type = 'page']">
        <div class="manu_Image">
            <img alt="manuscript image for page {2 + count(preceding::div[@type='page']) + 1}"
                src="images/{@facs}"/>
        </div>
        <div class="manu_Content">
            <div id="page{2 + count(preceding::div[@type = 'page']) + 1}">
                <h2>
                    <xsl:apply-templates select="div[@type = 'group'][1]/child::head[1]"/>
                </h2>
                <xsl:for-each select="div[@type = 'group'][1]/list">
                    <ul>
                        <xsl:apply-templates select="item"/>
                    </ul>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="item[parent::div[@type = 'group']]">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
</xsl:stylesheet>
