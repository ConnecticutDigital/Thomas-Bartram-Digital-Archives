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
                    <h1 class="nav"> Matching Currencies </h1>
                    <a href="merchantLog_main.html">Home</a> | <a href="about.html">About</a>
                </div>
                <div class="col-xs-12">
                    <table id="places" class="placeTable table">
                        <tr>
                            <th>Currency</th>
                            <th>Mouse Over (@ana)</th>
                            <th>Page #</th>
                            <th>Surrounding Text</th>
                        </tr>
                        <xsl:variable name="textHolder" select="descendant::body/descendant::measure[@type='currency'][@unit='£sd']/tokenize(normalize-space(text()),' ')"/>
                        <xsl:apply-templates select="descendant::body/descendant::measure[@type='currency'][@unit='£sd'][tokenize(@ana,'_')=$textHolder]"/>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="measure[@type='currency'][@unit='£sd']">
        <tr>
            <td><xsl:apply-templates select="normalize-space(text())"/></td>
            <td><xsl:apply-templates select="@ana"/></td>
            <td><xsl:apply-templates select="ancestor::div[@type='page']/@facs"/></td>
            <td><xsl:apply-templates select="preceding-sibling::text()/normalize-space()"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
