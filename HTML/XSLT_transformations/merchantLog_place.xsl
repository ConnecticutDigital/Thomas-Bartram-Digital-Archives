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
               <h1 class="nav"> Places in Thomas Bartram's Merchant and Shipping Logs </h1>
               <a href="merchantLog_main.html">Home</a> | <a href="about.html">About</a>
            </div>
            <div class="col-xs-12">
               <table id="places" class="placeTable table">
                  <tr>
                     <th>Place</th>
                     <th>Reference ID</th>
                     <th># of Times Referenced</th>
                     <th>Geo Location</th>
                     <th>Description</th>

                  </tr>
                  <xsl:apply-templates
                     select="descendant::back/descendant::listPlace/descendant::place"/>
                  <!--<xsl:sort select="descendant::placeName"/>-->


               </table>
            </div>
         </body>
      </html>
   </xsl:template>
   <xsl:template match="place">
      <xsl:variable name="ID" select="@xml:id"/>

      <tr>

         <td>
            <xsl:apply-templates select="descendant::placeName"/>
         </td>

         <td>
            <xsl:text>#</xsl:text>
            <xsl:apply-templates select="$ID"/>
         </td>

         <td>
            <xsl:value-of select="count(//placeName[@ref eq $ID])"/>
         </td>
         <td>
            <xsl:apply-templates select="descendant::geo"/>
         </td>
         <td>
            <xsl:apply-templates select="descendant::note"/>
         </td>
      </tr>
   </xsl:template>

</xsl:stylesheet>
