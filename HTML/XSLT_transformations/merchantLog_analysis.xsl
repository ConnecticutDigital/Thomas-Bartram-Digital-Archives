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
                    <a href="merchantLog_main.html">Home</a>
                </div>
                <div class="col-xs-12 center-block">
                    <p>Disclaimer: the analysis represented on this page fluctuates as additional
                        pages of Bartram's merchant logs are encoded.</p>
                    <ul class="larger">
                        <li>Pages Transcribed and Encoded: <strong><xsl:apply-templates
                                    select="count(descendant::div[@type = 'page'])"/></strong></li>
                        <li>Lines Transcribed and Encoded: <strong><xsl:apply-templates
                                    select="count(descendant::body//descendant::item)"
                            /></strong></li>
                        <li>Distinct People Mentioned: <strong><xsl:apply-templates
                                    select="count(distinct-values(descendant::back/descendant::person/@xml:id))"
                                /></strong></li>
                        <li>Distinct Places Mentioned: <strong><xsl:apply-templates
                                    select="count(distinct-values(descendant::back/descendant::place/@xml:id))"
                                /></strong></li>
                        <li>Distinct Commodities Mentioned: <strong><xsl:apply-templates
                                    select="count(distinct-values(descendant::body/descendant::measure/@commodity))"
                                /></strong></li>
                        <li>Instances of unclear/missing text: <strong><xsl:apply-templates
                                    select="count(descendant::body//unclear[not(child::supplied)])"
                                /></strong></li>
                    </ul>
                </div>
                <div class="col-xs-12 center-block">
                    <h2>Help us transcribe!</h2>
                    <p>Below is a table displaying portions of text where our transcribers could not
                        determine what was written. We ask that if you can figure out what the
                        missing/unclear text is that you fill out our <a href="contact.html"
                            target="_blank">contact form</a> and let us know of your best guess.
                        When you click on the page, to view the missing/unclear text, you can see
                        all of the missing/unclear text on the page is in <span class="unclear"
                            >RED</span>. Thank you!</p>
                    <table class="table">
                        <tr>
                            <th>Unclear ID</th>
                            <th>Page of Missing/Unclear Text</th>
                            <th>Person Associated with the Missing/Unclear Text</th>
                            <th>Units of Missing/Unclear Text</th>
                            <!--<th>Surrounding Text</th>-->
                            <!--<th>Our Best Guess</th>-->
                        </tr>

                        <xsl:apply-templates
                            select="descendant::body/descendant::unclear[count(child::supplied) eq 0]"
                            mode="unclearText"/>

                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="unclear" mode="unclearText">
        <tr>
            <td>ID_<xsl:apply-templates select="count(preceding::unclear[not(child::supplied)]) + 1"
                /></td>
            <td>
                <a
                    href="merchantLog.html#{ancestor::div[@type = 'page'][1]/@facs/tokenize(.,'[_.]')[2]}page{ancestor::div[@type = 'page'][1]/@facs/tokenize(.,'[_.]')[4]}"
                    target="_blank">
                    <xsl:apply-templates
                        select="ancestor::div[@type = 'page'][1]/@facs/tokenize(.,'[_.]')[2]"/>
                    <xsl:text> Page </xsl:text>
                    <xsl:apply-templates
                        select="ancestor::div[@type = 'page'][1]/@facs/tokenize(., '[_.]')[4]"/>
                </a>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="ancestor::div[@type = 'group']/child::head//persName">
                        <xsl:apply-templates
                            select="ancestor::div[@type = 'group']/child::head//persName[last()]/text()"
                        />
                    </xsl:when>
                    <xsl:otherwise>Not directly associated to a person.</xsl:otherwise>
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
            <!--<td>
                <xsl:choose>
                    <xsl:when test="ancestor::head">
                        <xsl:apply-templates select="ancestor::head"/>
                    </xsl:when>
                    <xsl:when test="ancestor::item">
                        <xsl:apply-templates select="ancestor::item"/>
                    </xsl:when>
                </xsl:choose>
            </td>-->
            <!--<td>
                <xsl:choose>
                    <xsl:when test="child::supplied[not(child::choice)]">
                        <xsl:for-each select="child::supplied">
                            <xsl:apply-templates select="./normalize-space()"/>
                            <xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="child::supplied[child::choice]">
                        <xsl:apply-templates select="descendant::sic"/>
                        <xsl:text> **Normalized Spelling: </xsl:text>
                        <xsl:for-each select="descendant::reg">
                            <xsl:apply-templates select="./normalize-space()"/>
                            <xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="not(child::supplied)">No Guess</xsl:when>
                </xsl:choose>
            </td>-->
        </tr>
    </xsl:template>
</xsl:stylesheet>
