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
                <title>Black Rock Witch Project</title>
                <xsl:comment>Bootstrap CSS</xsl:comment>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <xsl:comment>Custom CSS</xsl:comment>
                <link rel="stylesheet" type="text/css" href="css/style.css"/>
            </head>
            <body>
                <div id="nav">
                    <h1 class="main">Black Rock Witch Project</h1>
                    <a href="index.html">Home</a> |
                    <a href="about.html">About</a>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            
                            <h3 class="main">The public hanging of Goody Knapp in Black Rock, CT for accusations of witchcraft 
                                as per testimony during the Goody Bassett trial.</h3>
                        </div>
                        <div class="col-xs-12">
                            <xsl:apply-templates select="descendant::body"/>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="p[child::date]">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    <xsl:template match="p[not(child::date)]">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="persName">
        <span class="persName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
