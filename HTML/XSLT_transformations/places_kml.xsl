<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.opengis.net/kml/2.2"
    xmlns:gx="http://www.google.com/kml/ext/2.2"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <kml>
            <Document>
                <xsl:apply-templates select="descendant::back/descendant::listPlace"/>
            </Document>
        </kml>
    </xsl:template>
    <xsl:template match="place[not(descendant::geo/text())]"> </xsl:template>
    <xsl:template match="place[descendant::geo/text()]">
        <Placemark>
            <name>
                <xsl:apply-templates select="placeName"/>
            </name>
            <description>
                <xsl:text>Project ID: #</xsl:text>
                <xsl:apply-templates select="@xml:id"/>
                <xsl:text>. Number of times mentioned in log book: </xsl:text>
                <xsl:value-of
                    select="count(//placeName[@ref/tokenize(., '#')[2] eq current()/@xml:id])"/>
                <xsl:text>. </xsl:text>
                <xsl:apply-templates select="descendant::desc"/>
            </description>
            <Point>
                <coordinates>
                    <xsl:value-of select="descendant::geo/tokenize(., ' ')[2]"/>
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="descendant::geo/tokenize(., ' ')[1]"/>
                </coordinates>
            </Point>
        </Placemark>
    </xsl:template>

</xsl:stylesheet>
