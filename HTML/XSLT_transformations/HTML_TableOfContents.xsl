<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/html" version="3.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
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
                                    <a href="wheeler_html">Wheeler Diary</a>
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
                            <h1 class="main">TABLE OF CONTENTS</h1>
                            <h2 class="main">
                                <xsl:apply-templates select="//teiHeader//titleStmt//title"/>
                            </h2>
                            <h3 class="main">Authored by <xsl:apply-templates
                                    select="//teiHeader//titleStmt//author"/></h3>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div id="toc" class="col-xs-2">
                            <ul>
                                <xsl:apply-templates select="//div[@type = 'page']" mode="toc"/>
                            </ul>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type = 'page']" mode="toc">
        <li>
            <a href="merchantLog.html#page{count(preceding::div[@type='page']) + 1}">Page
                    <xsl:apply-templates select="count(preceding::div[@type = 'page']) + 1"/></a>
        </li>
    </xsl:template>


</xsl:stylesheet>
