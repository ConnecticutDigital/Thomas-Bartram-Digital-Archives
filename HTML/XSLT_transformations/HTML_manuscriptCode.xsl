<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <!-- RJP:2018-12-02: Output HTML - merchantLog.html -->
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
                <link rel="stylesheet" href="css/bootstrap-magnify.css"/>
                <link rel="stylesheet" type="text/css" href="css/style.css"/>
                <script src="js/jquery.js"/>
                <script src="js/bootstrap.min.js"/>
                <script src="js/bootstrap-magnify.js"/>
                <script>
                        $(document).ready(function() {
                        $('img')
                        .filter(function() {
                        return this.alt.match(/manuscript\simage/);
                        })
                        .magnify();
                        });
                    </script>

            </head>
            <body>
                <div id="nav">
                    <h1 class="main"> 1801 - 1838 Merchant and Shipping Account Log Book </h1>
                    <h2 class="main">Authored by <xsl:apply-templates
                            select="//teiHeader//titleStmt//author"/></h2>
                    <a href="merchantLog_main.html">Home</a> | <a href="about.html">About</a>
                </div>
                <xsl:apply-templates select="//div[@type = 'page']"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="div[@type = 'page']">
        <xsl:choose>
            <xsl:when test="descendant::item/text()">
                <div id="{@facs/tokenize(.,'[_.]')[2]}page{@facs/tokenize(.,'[_.]')[4]}" class="row">
            <div class="manu_Image col-xs-5">
                <a href="images/{@facs}" target="_blank">
                    <img class="img-responsive"
                        alt="manuscript image for page {count(preceding::div[@type='page']) + 1}"
                        src="images/{@facs}"/>
                </a>
            </div>
            <div class="manu_Content col-xs-7">
                <span class="pageNum">
                    <xsl:text>Page </xsl:text>
                    <xsl:apply-templates select="count(preceding::div[@type = 'page']) + 1"/>
                </span>
                <hr class="pageDivider"/>
                <xsl:apply-templates/>
            </div>
        </div>
        <div class="col-xs-12 text-center">
            <a href="#nav">Return to Top</a> | <a href="merchantLog_TOC.html">Table of Contents</a>
            | <a href="merchantLog_main.html">Return to Bartram Main Page</a>
        </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="{@facs/tokenize(.,'[_.]')[2]}page{@facs/tokenize(.,'[_.]')[4]}" class="row">
                    <div class="manu_Image col-xs-5">
                        <a href="images/{@facs}" target="_blank">
                            <img class="img-responsive"
                                alt="manuscript image for page {count(preceding::div[@type='page']) + 1}"
                                src="images/{@facs}"/>
                        </a>
                    </div>
                    <div class="manu_Content col-xs-7">
                        <span class="pageNum">
                            <xsl:text>Page </xsl:text>
                            <xsl:apply-templates select="count(preceding::div[@type = 'page']) + 1"/>
                        </span>
                        <hr class="pageDivider"/>
                        <p><xsl:text>This page still needs transcribed.</xsl:text></p> <p><xsl:text>If you wish to contribute, please fill out our </xsl:text><!--<a href="http://www.blackrockhistory.net/contact.html">-->Contact Form<!--</a>--><xsl:text>.</xsl:text></p>
                    </div>
                </div>
                <div class="col-xs-12 text-center">
                    <a href="#nav">Return to Top</a> | <a href="merchantLog_TOC.html">Table of Contents</a>
                    | <a href="merchantLog_main.html">Return to Bartram Main Page</a>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="descendant::placeName">
        <span class="place" title="{following::back/listPlace/place[@xml:id eq ./tokenize(@ref,'#')[last()]]/location}">
            <a href="http://www.blackrockhistory.net/merchantLog_places.html"><xsl:apply-templates/></a>
        </span>
    </xsl:template>
    <xsl:template match="date[not(parent::title)]">
        <span class="date" title="{@when}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="div[@type = 'group']">
        <div class="section">
            <xsl:if test="preceding-sibling::div[@type='group']">
                <hr class="sectionDivider"/>
            </xsl:if>                
            <xsl:if test="child::head/text()">
                <span class="sectionHead">
                    <xsl:apply-templates select="child::head"/>
                </span>
                <br/>
            </xsl:if>
            <xsl:apply-templates select="child::list"/>
        </div>
    </xsl:template>
    <xsl:template match="list">
        <xsl:if test="child::head//text()">
            <span class="entryHead">
                <xsl:apply-templates select="child::head"/>
            </span>
        </xsl:if>
        <ul class="entries">
            <xsl:apply-templates select="child::item"/>
        </ul>
    </xsl:template>
    <xsl:template match="list[@subtype = 'total']">
        <hr class="total"/>
        <xsl:if test="child::head//text()">
            <span class="totalHead">
                <xsl:apply-templates select="child::head"/>
            </span>
        </xsl:if>
        <ul class="totalItem">
            <xsl:apply-templates select="child::item"/>
        </ul>
    </xsl:template>
    <xsl:template match="item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="measure[@commodity]">
        
        <span class="com" title="{@quantity} {@unit} {@commodity} (Note: We use whole as a unit value when the unit of measurement is not specified.)">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="measure[@type = 'currency'][matches(@ana, '\d{2,}_\d{2,}_\d{2,}')]">
        <span class="curr"
            title="£{tokenize(@ana,'_')[1]} s{tokenize(@ana,'_')[2]} d{tokenize(@ana,'_')[3]}">
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
        <span class="spelling"
            title="Spelling retained from original manuscript. Normalized spelling: {child::reg}">
            <xsl:apply-templates select="child::sic"/>
        </span>
    </xsl:template>
    <xsl:template match="unclear">
        <xsl:choose>
            <xsl:when test="child::supplied[not(@cert)][not(@n)]">
                <span class="suggest"
                    title="The text provided here was interpreted by project editor {//respStmt/persName[@xml:id = current()/supplied/tokenize(@resp,'#')[last()]]}. Reason unclear: {@reason}.">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="count(child::supplied) > 1">
                <span class="multSuggest"
                    title="The text provided here has multiple interpretations by one or more editors. Reason unclear: {@reason}. Other suggestion(s): {child::supplied[not(@cert='high')][1]} {child::supplied[not(@cert='high')][2]}">
                    <xsl:apply-templates select="child::supplied[@cert = 'high']"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="unclear"
                    title="The text is unclear and could not be transcribed. Reason unclear: {@reason}. Unclear # ID_{count(preceding::unclear[not(child::supplied)]) + 1}.">
                    <xsl:text> [MISSING TEXT] </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="unclear[@reason = 'strikethrough']">
        <xsl:choose>
            <xsl:when test="child::supplied">
                <span class="strike suggest"
                    title="The text provided here was interpreted by a project editor ({//respStmt/persName[@xml:id = current()/supplied/tokenize(@resp,'#')[last()]]}). The text is unclear due to {@reason}.">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="strike unclear"
                    title="The text is unclear and could not be transcribed. The text is unclear due to {@reason}.">
                    <xsl:text> [MISSING TEXT] </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- RJP:2017-03-14:Matches for Special Characters! -->
    <xsl:template match="add[preceding-sibling::g[@ref = '#ditto']][child::text()]">
        <span class="ditto"
            title="The text provided here was interpreted by project editor ({//respStmt/persName[@xml:id = current()/tokenize(@resp,'#')[last()]]}). In the manuscript this text is represented by Bartram's ditto character.">
            <xsl:text>*Ditto* (</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>)</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#ditto'][not(following-sibling::add/text())]">
        <span class="ditto"
            title="It is unclear what text from the previous line is meant to be repeated.">
            <xsl:text>*Ditto*</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#longHyphen']">
        <span class="hyphen"
            title="The actual number of hyphens present here in the manuscript is {@n}; however, we have standardized the number of hyphens appearing here for the sake of web formatting.">
            <xsl:text> - - - </xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#currency']">
        <span class="currency" title="A symbol bearing resemblance to the currency £ appears here.">
            <xsl:text>£</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="g[@ref = '#afterName']">
        <span class="afterName"
            title="A symbol appears here that we speculate was Bartram's mark that the entries to follow are debts instead of credits.">
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
