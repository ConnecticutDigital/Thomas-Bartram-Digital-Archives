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
                <link href="css/portfolio-item.css" rel="stylesheet"/>
            </head>
            <body>
                <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                    <div class="container">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse"
                                data-target="#bs-example-navbar-collapse-1">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"/>
                                <span class="icon-bar"/>
                                <span class="icon-bar"/>
                                <span class="icon-bar"/>
                            </button>
                            <a class="navbar-brand" href="index.html">Black Rock History</a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="about.html">About</a>
                                </li>
                                <li>
                                    <a href="historicDistrict.html">Historic District</a>
                                </li>
                                <li>
                                    <a href="merchantLog_main.html">Bartram Merchant Logs</a>
                                </li>
                                <li>
                                    <a href="wheelerDiary_main.html">Wheeler Diary</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /.navbar-collapse -->
                    </div>
                    <!-- /.container -->
                </nav>
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="main">
                            <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                        </h1>
                        <h2 class="main">Authored by <xsl:apply-templates
                                select="//teiHeader//titleStmt//author"/></h2>
                    </div>
                </div>
                <div class="col-xs-12">
                    <!-- RJP:2017-04-30: We have decided to make the TOC appear on a seperate page. Uncomment the code below for it to appear on the same page as the manuscript/transcriptions. -->
                    <!-- <div id="toc" class="col-xs-2">
                    <h3>Table of Contents</h3>
                    <ul>
                        <xsl:apply-templates select="//div[@type = 'page']" mode="toc"/>
                    </ul>
                </div> -->
                    <xsl:apply-templates select="//div[@type = 'page']"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <!-- RJP:2017-04-30: We have decided to make the TOC appear on a seperate page. Uncomment the code below for it to appear on the same page as the manuscript/transcriptions. -->
    <!-- <xsl:template match="div[@type = 'page']" mode="toc">
        <li>
            <a href="#page{count(preceding::div[@type='page']) + 1}">Page <xsl:apply-templates
                    select="count(preceding::div[@type = 'page']) + 1"/></a>
        </li>
    </xsl:template> -->
    <xsl:template match="div[@type = 'page']">
        <div id="page{count(preceding::div[@type = 'page']) + 1}" class="col-xs-12 page">

            <div class="manu_Image col-xs-4">
                <a href="images/{@facs}" target="_blank">
                    <img alt="manuscript image for page {count(preceding::div[@type='page']) + 1}"
                        src="images/{@facs}"/>
                </a>

            </div>
            <div class="col-xs-2"/>
            <div class="manu_Content col-xs-6">
                <hr class="pageDivider"/>
                <span class="pageNum">
                    <xsl:text>Page </xsl:text>
                    <xsl:apply-templates select="count(preceding::div[@type = 'page']) + 1"/>
                </span>
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
            <hr class="sectionDivider"/>
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
    <xsl:template match="measure[@type = 'currency'][matches(@ana, '\d{2,}_\d{2,}_\d{2,}')]">
        <!--
            RJP:2017-05-21: Currently not function isn't working to only grab the currency elements that are not followed by the hyphen notation
            
            <xsl:if test="not(preceding-sibling::g[@ref='#longHyphen'])">
            <span class="currSpacer" title="The *** does not appear in the original document and is only included in the transcription for purposes of webpage layout."><xsl:text> *** </xsl:text></span>
        </xsl:if>-->
        <span class="curr"
            title="£{tokenize(@ana,'_')[1]} s{tokenize(@ana,'_')[2]} d{tokenize(@ana,'_')[3]}">
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
                    title="The text provided here was interpreted by a project editor (ID: {child::supplied/tokenize(@resp,'#')[last()]}) because the transcription source was unclear.">
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
            title="The text provided here was interpreted by a project editor (ID: {tokenize(@resp,'#')[last()]}). In the manuscript this text is represented by Bartram's ditto character.">
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
            title="A symbol bearing resemblance to the currency £ appears before money notation.">
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
            title="A symbol appears here before the start of most logged items. It bears resemblance to the word To, and seems to be the way Bartram noted new entries.">
            <xsl:text>To</xsl:text>
        </span>
    </xsl:template>
</xsl:stylesheet>
