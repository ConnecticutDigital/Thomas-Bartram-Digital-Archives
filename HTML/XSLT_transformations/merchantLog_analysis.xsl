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
                    <a href="merchantLog_main.html">Home</a> | <a href="about.html">About</a>
                </div>
                <div class="col-xs-12">
                    <p class="text-center">Disclaimer: the analysis represented on this page
                        fluctuates as additional pages of Bartram's merchant logs are encoded.</p>
                    <ul>
                        <li>Pages Transcribed and Encoded: <xsl:apply-templates
                                select="count(descendant::div[@type = 'page'])"/></li>
                        <li>Lines Transcribed and Encoded: <xsl:apply-templates
                                select="count(descendant::body//descendant::item)"/></li>
                        <li>Instances of unclear/missing text: <xsl:apply-templates
                                select="count(descendant::body//unclear)"/></li>
                        <li>Distinct People Mentioned: <xsl:apply-templates
                                select="count(distinct-values(descendant::back/descendant::person/@xml:id))"
                            /></li>
                        <li>Distinct Places Mentioned: <xsl:apply-templates
                                select="count(distinct-values(descendant::back/descendant::place/@xml:id))"
                            /></li>
                        <li>Distinct Commodities Mentioned: <xsl:apply-templates
                                select="count(distinct-values(descendant::body/descendant::measure/@commodity))"
                            /></li>
                    </ul>
                </div>
                <div class="col-xs-12">
                    <h2>Help us transcribe!</h2>
                    <p>Below is a table displaying portions of text that our transcribers are unsure
                        of and we have marked as unclear/missing. We ask that if you can figure out
                        what the missing/unclear text is that you send our project manager an email
                        (bportnow at gmail dot com) that includes your transcription, the unclear
                        ID, and your full name so we can credit you with the transcription. Thank
                        you!</p>
                    <table class="table">
                        <tr>
                            <th>Unclear ID Number</th>
                            <th>Page Where Text is Missing/Unclear</th>
                            <th>Person Missing/Unclear Text is Under</th>
                            <th>Units of Missing/Unclear Text</th>
                            <th>Our Transcriber's Best Guess</th>
                        </tr>

                        <xsl:apply-templates select="descendant::body/descendant::unclear"
                            mode="unclearText"/>

                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="unclear" mode="unclearText">
        <tr>
            <td>UN_<xsl:apply-templates select="count(preceding::unclear) + 1"/></td>
            <td>
                <xsl:apply-templates select="ancestor::div[@type = 'page'][last()]/@facs"/>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="ancestor::div[@type = 'group']/child::head//persName">
                        <xsl:apply-templates
                            select="ancestor::div[@type = 'group']/child::head//persName[last()]/text()"
                        />
                    </xsl:when>
                    <xsl:otherwise>Not associated to a person.</xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:apply-templates select="@quantity"/>
                <xsl:choose>
                    <xsl:when test="@unit = 'chars'">
                        <xsl:text> character(s)</xsl:text>
                    </xsl:when>
                    <xsl:when test="@unit = 'words'">
                        <xsl:text> word(s)</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="child::supplied">
                        <xsl:apply-templates select="child::supplied"/>
                    </xsl:when>
                    <xsl:when test="not(child::supplied)">No Guess</xsl:when>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
