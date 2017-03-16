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
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                </h1>
                <h2>Authored by <xsl:apply-templates select="//teiHeader//titleStmt//author"/></h2>
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
        <!-- RJP:2016-03-09: Once we decide to add pages 1 and 2 to the master XML file we will go back and fix the code below so that the pages are counting from 1 instead of from 3 onward.  -->
        <li>
            <a href="#page{2 + count(preceding::div[@type='page']) + 1}">Page <xsl:apply-templates
                    select="2 + count(preceding::div[@type = 'page']) + 1"/></a>
        </li>
    </xsl:template>
    <xsl:template match="div[@type = 'page']">
        <div id="page{2 + count(preceding::div[@type = 'page']) + 1}" class="page">
            <div class="manu_Image">
                <img alt="manuscript image for page {2 + count(preceding::div[@type='page']) + 1}"
                    src="images/{@facs}"/>
            </div>
            <div class="manu_Content">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="date[not(parent::title)]">
        <span class="date" title="{@when}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="div[@type = 'group']">
        <div class="section">
            <xsl:if test="child::head">
                <span class="sectionHead">
                    <xsl:apply-templates select="child::head"/>
                </span>
            </xsl:if>
            <xsl:apply-templates select="child::list"/>
        </div>
    </xsl:template>
    <xsl:template match="list">
        <xsl:if test="child::head">
            <span class="entryHead">
                <xsl:apply-templates select="child::head"/>
            </span>
        </xsl:if>
        <ul class="entries">
            <xsl:apply-templates select="child::item"/>
        </ul>
    </xsl:template>
    <xsl:template match="item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="measure[@commodity]">
        <span class="com" title="{@quantity} {@unit} {@commodity}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="measure[@type = 'currency']">
        <span class="curr"
            title="£{tokenize(@quantity,'\d\d')[1]} s{tokenize(@quantity,'\d\d')[2]} d{tokenize(@quantity,'\d\d')[3]}">
            <!-- RJP:2017-03-16: The regular expression to match on two digits at time is not working here. Consult M.Kay and conisder creating variable that gets regular expression and can be entered here in place. Otherwise will need to change XML to better suit info supplied in attribute.  -->
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="persName">
        <span class="person">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!-- RJP:2017-03-16: Matches for Odd Spelling and Missing Text! -->
    <xsl:template match="choice">
        <span class="spelling" title="Spelling retained from original manuscript: {child::sic}">
            <xsl:apply-templates select="child::reg"/>
        </span>
    </xsl:template>
    <xsl:template match="unclear">
        <xsl:choose>
            <xsl:when test="child::supplied">
                <span class="unclear"
                    title="The text provided here was interpreted by a project editor (ID {child::supplied/@resp}) because the transcription source was unclear.">
                    <!-- RJP:2017-03-14: In the future, change this so the @resp goes up into the teiHeader and matches on the full name of the editor associated with the current() ID. -->
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="unclear"
                    title="The text is unclear and could not be transcribed. Reason: {@reason}.">
                    <xsl:text> [MISSING TEXT] </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- RJP:2017-03-14:Matches for Special Characters! -->
    <xsl:template match="add[preceding-sibling::g[@ref = '#ditto']]">
        <span class="ditto"
            title="The text provided here was interpreted by a project editor (ID {@resp}).">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#longHyphen']">
        <span class="hyphen"
            title="The actual number of hyphens present here in the manuscript is {@n}; however, we have standardized the number of hyphens appearing here for the sake of web formatting.">
            <xsl:text>- - -</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#currency']">
        <span class="currency"
            title="A symbol bearing resemblance to the currency £ appears sometimes before money notation.">
            <xsl:text>£</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#afterName']">
        <span class="afterName"
            title="A symbol appears here after this proper name that we speculate indicates a signature.">
            <xsl:text> * </xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#stItem']">
        <span class="stItem"
            title="A symbol appears here before the start of most logged items. It bears resemblance to the word To">
            <xsl:text>To</xsl:text>
        </span>
    </xsl:template>
</xsl:stylesheet>
