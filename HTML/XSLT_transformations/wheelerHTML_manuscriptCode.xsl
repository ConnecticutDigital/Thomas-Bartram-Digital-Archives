<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
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
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 class="main">The Journal of William Wheeler</h1>
                            <h3>"A Journal for the Town of Fairfield, or An exact &amp; impartial
                                Account of the most Material Transactions from the first Settelment
                                thereof till the Present Time,"</h3>
                        </div>
                        <div class="col-xs-12">
                            <xsl:apply-templates select="descendant::div[@type = 'section'][parent::div[@type='chapter'][contains(child::head, 'The Journal of William Wheeler (The historic manuscript')]]"/>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type = 'section']">
        <div id="section{count(preceding::div[@type='section']) + 1}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <!--<xsl:template match="italic">
        <span class="italics">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
</xsl:stylesheet>
