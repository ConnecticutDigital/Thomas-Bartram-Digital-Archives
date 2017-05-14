<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Wheeler Project</title>
                <link href="style.css" rel="stylesheet" type="text/css"/>
            </head>
            <body>
             
                <h1 class="center">The Journal of William Wheeler</h1>
                <h1 class="center">Seaport of Old Fairfield, Connecticut, 1644-1870</h1>
                
<div id="intro">
    <h4 class="center">"A Journal for the Town of Fairfield, or An exact &amp; impartial Account of the most Material Transactions from the first Settelment thereof till the Present Time,"  by WWI (William Wheeler I).  </h4>
    <p class="center"><em>This online historic text is a work in progress. Currently only the 1630-1772 is completed, and we are now up to August 1780 of the Revolutionary War section. See chapters sections below.</em></p>
<!--    <p class="center"><italic>Fascimile of original title page drawn by William Wheeler in 1780 for his Journal</italic></p>-->
    
  </div>
                <div id="navigation">
                    <h3><a href="about.html">About the Project</a></h3>
                    
            <!--        <h3> | </h3>
                    <h3><a href="Issues_List.html">Issues List</a></h3>-->
                    <!-- <h3><a href="contact.html">Contact</a></h3>-->
                    
                </div>
                
                <!--<div id="header"><a href="Map 1867.jpg"><img class="left" src="Map 1867.jpg"/></a><a href="blackrock_history_port_pan.jpeg"><img class="right" src="blackrock_history_port_pan.jpeg"/></a><a href="Map 1649 Wheeler.jpg"><img class="middle" src="Map 1649 Wheeler2.jpg"/></a>
                    <p class="left">Map 1867</p><p class="right">Blackrock Port</p><p class="middle">Map 1649</p></div>-->
                <div class="container">
                    <div id="toc">
                        <h3>Book chapter sections
                        </h3>

                    
    
                        <ol>
                            <xsl:apply-templates select="//div[@type='chapter']/head"/>
                        </ol>
                    </div>
                    

                    <div id="titlepage">
                        <a href="Wheeler_title_page.jpg"><img src="Wheeler_title_page_smaller.jpg"/></a>
                    </div>
                </div>
               
                <div id="diary">
                    <hr/>
                    <xsl:apply-templates select="//div[@type='section'][p]"/>
                </div>
              
            </body>
          
        </html>
    </xsl:template>
    <xsl:template match="div[@type='chapter']/head">
        <li>
            <xsl:apply-templates/>
            <xsl:if test="following-sibling::div[@type='section']">
<!--The "test" checks to see if there is a section within the chapter.  So the revolutionary war section checks if part of the wheeler diary or the DAR other chaprters of the book, then if part of the diary then it allows the indented and the section headings                 -->
                <ol>
                    <xsl:apply-templates mode="embed"
                        select="following-sibling::div[@type='section']/head"/>
<!--It returns the title which is in the head element                    -->
                </ol>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="div[@type='section']/head" mode="embed">
<!-- The mode = embed allows to have multiple templates in a singular environment to do different things. We are using it for a table of contents to output the title of contents and another in the body of the document. Then it makes it a link to the table of contents outherwise just outputs       -->
        <li>
            <xsl:choose>
                <xsl:when
                    test="contains(parent::div/parent::div/head,'The Journal of William Wheeler')">
                    <a href="#{.}" name="toc{.}">
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>
    <xsl:template match="div[@type='section'][p]">
        <div class="entry" id="{head}">
            <h3>
                <a href="#toc{head}" id="{head}">
                    <xsl:apply-templates select="head"/>
                </a>
            </h3>
            <xsl:apply-templates select="p"/>
        </div>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="italic">
        <em><xsl:apply-templates></xsl:apply-templates></em>
        
    </xsl:template>
<!--adding italics    -->
    
</xsl:stylesheet>
