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
                <title> The Journal of William Wheeler </title>
                <xsl:comment>Bootstrap CSS</xsl:comment>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <xsl:comment>Custom CSS</xsl:comment>
                <link rel="stylesheet" type="text/css" href="css/style.css"/>

            </head>
            <body>
                <div id="nav">
                    <h1 class="main">The Journal of William Wheeler</h1>
                    <a href="index.html">Home</a> |
                    <a href="about.html">About</a>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 class="main">TABLE OF CONTENTS</h1>
                            <!--<h2 class="main"> "A Journal for the Town of Fairfield, or An exact
                                &amp; impartial Account of the most Material Transactions from the
                                first Settelment thereof till the Present Time," </h2>
                            <h3 class="main">Authored by WWI (William Wheeler I)</h3>-->
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div id="toc" class="col-xs-6">
                            <ul>
                                <xsl:apply-templates select="descendant::div[@type = 'section'][parent::div[contains(child::head, 'The Journal of William Wheeler (The historic manuscript')]]"/>
                            </ul>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type = 'section']">
        <li>
            <a href="wheelerDiary.html#section{count(preceding::div[@type='section']) + 1}">
                <xsl:apply-templates select="descendant::head[not(contains(.,'The Journal of William Wheeler (The historic manuscript'))]"/>
            </a>
        </li>
    </xsl:template>


</xsl:stylesheet>
