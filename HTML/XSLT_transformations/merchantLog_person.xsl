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
                        People, Organizaitons, and Places Mentioned in Thomas Bartram's Merchant and Shipping Logs
                    </h1>
                    <a href="index.html">Home</a> |
                    <a href="about.html">About</a>
                    
                </div>
                <div class="col-xs-12">                    
                        <table id="people" class="prosoTable table">
                            <tr>
                                <th>Surname</th>
                                
                                <th>Forename</th>
                                
                                <th>Reference ID</th>
                                
                                <th>Birth</th>
                                
                                <th>Death</th>
                                
                                <th>Spouse</th>
                                
                                <th>Occupation</th>
                            </tr>
                            <xsl:apply-templates select="//back/listPerson" mode="people"/>
                        </table>
                    
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="person" mode="people">
        <tr>
            
            <td><xsl:apply-templates select="descendant::persName/child::surname"/></td>
            
            <td><xsl:apply-templates select="descendant::persName/child::forename"/></td>
            
            <td><xsl:text>#</xsl:text><xsl:apply-templates select="@xml:id"/></td>
            
            <td>N.A.</td>
            <td>N.A.</td>
            <td>N.A.</td>
            <td>N.A.</td>
            
        </tr>
        
    </xsl:template>
</xsl:stylesheet>