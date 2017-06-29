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
                    <h1 class="nav"> People, Organizaitons, and Places Mentioned in Thomas Bartram's
                        Merchant and Shipping Logs </h1>
                    <a href="index.html">Home</a> | <a href="about.html">About</a>
                </div>
                <div class="col-xs-12">
                    <h3 class="text-center">People</h3>
                    <table id="people" class="personTable table">
                        <tr>
                            <th>Surname</th>

                            <th>Forename</th>

                            <th>Reference ID</th>

                            <th>Birth</th>

                            <th>Death</th>

                            <th>Spouse</th>

                            <th>Occupation</th>
                        </tr>
                        <xsl:apply-templates select="descendant::back/descendant::listPerson/descendant::person" mode="people">
                            <xsl:sort select="descendant::surname"/>
                        </xsl:apply-templates>

                    </table>
                    <div class="text-center">
                        <h3>Organizations</h3>
                        <p>Coming soon!</p>
                        <h3>Places</h3>
                        <p>Coming soon!</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="person" mode="people">
        <tr>

            <td>
                <xsl:apply-templates select="descendant::persName/child::surname"/>
            </td>

            <td>
                <xsl:apply-templates select="descendant::persName/child::forename"/>
            </td>

            <td>
                <xsl:text>#</xsl:text>
                <xsl:apply-templates select="@xml:id"/>
            </td>

            <td>
                <xsl:choose>
                    <xsl:when test="child::birth">
                        <xsl:apply-templates select="child::birth/@when"/>
                    </xsl:when>
                    <xsl:otherwise>N.A.</xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="child::death">
                        <xsl:apply-templates select="child::death/@when"/>
                    </xsl:when>
                    <xsl:otherwise>N.A.</xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="child::note[@type = 'spouse']">
                        <xsl:apply-templates select="child::note[@type = 'spouse']"/>
                    </xsl:when>
                    <xsl:otherwise>N.A.</xsl:otherwise>
                </xsl:choose>

            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="child::occupation">
                        <xsl:apply-templates select="child::occupation"/>
                    </xsl:when>
                    <xsl:otherwise>N.A.</xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>

    </xsl:template>
</xsl:stylesheet>
