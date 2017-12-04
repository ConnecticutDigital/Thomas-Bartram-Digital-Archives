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
                    <h1 class="nav">
                       Thomas Bartram's 1801 - 1838 Account Log Books
                    </h1>
                    <a href="merchantLog_main.html">Home</a> |
                    <a href="about.html">About</a>
                    <h3 class="main">Table of Contents</h3>
                    
                </div>
                    <div class="col-xs-12 toc">
                        <h4 style="text-align:center;"><a href="https://docs.google.com/document/d/1rYQJzrl-6TFbnXuIr171zxQB5vCQU6bVws62I0d4b_c/edit?usp=sharing">View our Google Doc page by page summaries.</a></h4>
                        <h4>Volume 1 : 1801-1819</h4>
                        <div id="tocVolume1" class="col-xs-4">
                            <ul>
                                <xsl:apply-templates select="//div[@type = 'page'][@facs/tokenize(.,'[_.]')[2] = 'Vol-001']"/>
                            </ul>
                        </div>
                        <h4>Volume 2 : 1815-1819</h4>
                        <div id="tocVolume2" class="col-xs-4">
                            <ul>
                                <xsl:apply-templates select="//div[@type = 'page'][@facs/tokenize(.,'[_.]')[2] = 'Vol-002']"/>
                            </ul>
                        </div>
                        <h4>Volume 3 : 1829-1838</h4>
                        <div id="tocVolume3" class="col-xs-4">
                            <ul>
                                <xsl:apply-templates select="//div[@type = 'page'][@facs/tokenize(.,'[_.]')[2] = 'Vol-003']"/>
                            </ul>
                        </div>
                    </div>
                
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type = 'page']">
        <li>
            <xsl:text>Page </xsl:text>
            <xsl:apply-templates select="@facs/tokenize(.,'[_.]')[4]"/>
            <xsl:text>   </xsl:text>
            <a href="merchantLog.html#{@facs/tokenize(.,'[_.]')[2]}page{@facs/tokenize(.,'[_.]')[4]}"
                >[Transcription]</a>
            <xsl:text>   </xsl:text>
            <a href="images/{@facs}">[Manuscript]</a>
        </li>
    </xsl:template>


</xsl:stylesheet>
