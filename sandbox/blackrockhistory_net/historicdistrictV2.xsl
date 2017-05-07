<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head/>
			<title>Black Rock Harbor Historic District</title>
			<link href="style.css" rel="stylesheet" type="text/css"/>
			<body>
				<div class="banner">
					<img alt="" src="blackrockport.jpg"/>
				</div>
				<ul class="nav">
					<li>
						<h2>
							<a href="index.html">Home</a>
						</h2>
					</li>
					<li>
						<h2>
							<a href="about.html">About</a>
						</h2>
					</li>
					<li>
						<h2>
							<a href="list.html">Historic District</a>
						</h2>
					</li>
					<li>
						<h2>
							<a href="maps.html">Maps</a>
						</h2>
					</li>
				</ul>
				<h2 class="heading">Black Rock Harbor Historic District</h2>
				<p> The Black Rock National Register District includes the remains of the village of
					Black Rock, third most important seaport in Connecticut after the Revolutionary
					War - and important shipbuilding center in the years immediately preceding the
					Civil War. It includes examples of every major American architectural style from
					the late Medieval of the seventeenth century to the Italianate of the
					mid-nineteenth, as well as some resort and suburban styles of the later
					Victorian era.</p>
				<p>Black Rock was made a Port of Entry for all of Western Connecticut in, 1790. A
					government lighthouse was built at the mouth of the harbor in 1807, and a
					turnpike laid out to Danbury in 1812. By 1830, however, Bridgeport begins to
					surpass Black Rock's place as the center of eastern Fairfield County commerce.
					At this time the village turned to ship and carriage building as a means of
					livelihood. </p>
			</body>
		</html>
		<!--Creates am html for each house-->
		<xsl:variable name="houses" select="//house"/>
		<!--<xsl:variable name="houses">
			<xsl:apply-templates select="//houses">
				<xsl:sort select="date"/>
				<xsl:copy select="@*|node()">
					<xsl:apply-templates select="@*|node()"></xsl:apply-templates>
				</xsl:copy>
			</xsl:apply-templates>
		</xsl:variable>-->
		<xsl:for-each select="//house">
			<xsl:sort select="date"/>
			<xsl:result-document href="houses/{@house_name}.html">
				<html>
					<head>
						<title>Black Rock Harbor Historic District</title>
						<link href="../style.css" rel="stylesheet" type="text/css"/>
					</head>
					<body>
						<ul class="nav">
							<li>
								<h2>
									<a href="../index.html">Home</a>
								</h2>
							</li>
							<li>
								<h2>
									<a href="../about.html">About</a>
								</h2>
							</li>
							<li>
								<h2>
									<a href="../list.html">Historic District</a>
								</h2>
							</li>
							<li>
								<h2>
									<a href="../maps.html">Maps</a>
								</h2>
							</li>
						</ul>
						<!-- put in the images-->

						<p class="house_name">
							<xsl:value-of select="@house_name"/>
						</p>
						<p class="date">
							<xsl:value-of select="date"/>
						</p>
						<div class="house_images">
							<img src="../images/{@house_name}.jpg"/>
							<xsl:apply-templates select="images"/>

							<ul class="nav">
								<xsl:if
									test="not($houses[1] = $houses[@house_name = current()/@house_name])">
									<li>
										<a
											href="{$houses[@house_name = current()/@house_name]/preceding-sibling::house[1]/@house_name}.html"
											>Previous</a>
									</li>
								</xsl:if>
								<li>
									<a href="../list.html">Back to list</a>
								</li>
								<xsl:if
									test="not($houses[last()] = $houses[@house_name = current()/@house_name])">
									<li>
										<a
											href="{$houses[@house_name = current()/@house_name]/following-sibling::house[1]/@house_name}.html"
											>Next</a>
									</li>
								</xsl:if>
							</ul>
						</div>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
		<!--  ABOUT PAGE-->
		<xsl:result-document href="about.html">
			<html>
				<head>
					<title>About</title>
					<link href="style.css" rel="stylesheet" type="text/css"/>
				</head>
				<body>
					<div class="banner">
						<img alt="" src="blackrockport.jpg"/>
					</div>
					<ul class="nav">
						<li>
							<h2>
								<a href="index.html">Home</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="about.html">About</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="list.html">Historic District</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="maps.html">Maps</a>
							</h2>
						</li>
					</ul>
					<h2 class="heading">The Black Rock National Register District</h2>
					<p> This project's goal is to raise awareness about the seaside village of Black
						Rock, Connecticut. The historic distrcit is located at the head of Black
						Rock Harbor in the City of Bridgeport, approximately two and one-half miles
						southwest, of downtown. The area within the district boundaries comprises
						the residential section of an eighteenth' and nineteenth century
						seaport/shipbuilding center as delineated by old maps and surviving
						architectural evidence.</p>
					<p>Included are two pre-Revolutionary houses, a Federal Greek Revival housing
						and manufacturing development, and an early Victorian, shipbuilding
						community interspersed with compatible late nineteenth and twentieth century
						structures constructed after the village had become incorporated into the
						larger urban center. The area surrounding the district is an urban
						residential neighborhood of twentieth century one- and two-family houses.
						The district is sited on a coastal plain with a gentle slope up to a small
						hill on Ellsworth Street.</p>
				</body>
			</html>
		</xsl:result-document>
		<!-- LIST PAGE-->
		<xsl:result-document href="list.html">
			<html id="top">
				<head>
					<title>List</title>
					<link href="style.css" rel="stylesheet" type="text/css"/>
					<script src="sorttable.js"/>
				</head>
				<body>
					<div class="banner">
						<img alt="" src="blackrockport.jpg"/>
					</div>
					<ul class="nav">
						<li>
							<h2>
								<a href="index.html">Home</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="about.html">About</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="list.html">Historic District</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="maps.html">Maps</a>
							</h2>
						</li>
					</ul>
					<h2>This databse lists the name of the historic house, the address, the style
						and description of the house and the year it was registered in the national
						register of historic places.</h2>
					<p>CLICK THE HEADINGS TO SORT</p>
					<table class="sortable">
						<!--These are the headings for the table-->
						<thead>
							<tr>
								<th>House Name</th>
								<th>Date</th>
								<th>Address</th>
								<th>Street</th>
								<th>Style</th>
								<th>Description</th>
								<th>ID</th>
								<th>Registered</th>
							</tr>
						</thead>
						<xsl:apply-templates select="/district/*">
							<xsl:sort select="date"/>
						</xsl:apply-templates>
					</table>
					<div class="top">
						<p>
							<a href="#top">Top</a>
						</p>
					</div>
				</body>
			</html>
		</xsl:result-document>
		<!-- MAPS PAGE-->
		<xsl:result-document href="maps.html">
			<html>
				<head>
					<title>Maps</title>
					<link href="style.css" rel="stylesheet" type="text/css"/>
				</head>
				<body>
					<div class="banner">
						<img alt="" src="blackrockport.jpg"/>
					</div>
					<ul class="nav">
						<li>
							<h2>
								<a href="index.html">Home</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="about.html">About</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="list.html">Historic District</a>
							</h2>
						</li>
						<li>
							<h2>
								<a href="maps.html">Maps</a>
							</h2>
						</li>
					</ul>
					<h2 class="map_heading">Black Rock Historical Maps Coming Soon!</h2>
					<div class="maps">
						<p>1867 Map Recreated</p>
						<a href="images/Map1867.jpg">
							<img src="images/Map1867.jpg"/>
						</a>
						<p>Map 1867 Original</p>
						<a href="images/Map1867_original">
							<img src="images/Map1867_original"/>
						</a>
						<p>Map 1</p>
						<p>Map 1</p>
					</div>
				</body>
			</html>
		</xsl:result-document>
		<!--END MAPS PAGE-->
	</xsl:template>
	<!--These are the date for the table-->
	<xsl:template match="district/*">
		<!--   This will fire every time you see a house to make a new row in the table -->
		<tr>
			<td>
				<a href="houses/{@house_name}.html">
					<xsl:apply-templates select="@house_name"/>
				</a>
			</td>
			<td class="list">
				<xsl:apply-templates select="date"/>
			</td>
			<td>
				<xsl:apply-templates select="address"/>
			</td>
			<td>
				<xsl:apply-templates select="street"/>
			</td>
			<td>
				<!--   <a href="http://en.wikipedia.org/wiki/{normalize-space(style)} architecture">-->
				<xsl:apply-templates select="style"/>
				<!--</a>-->
			</td>
			<td class="description">
				<p>
					<xsl:apply-templates select="national_register"/>
				</p>
				<p>
					<xsl:apply-templates select="walking_tour_book"/>
				</p>
				<p>
					<xsl:apply-templates select="justinius_book"/>
				</p>
				<p>
					<xsl:apply-templates select="bicent_book"/>
				</p>
			</td>
			<td>
				<xsl:apply-templates select="id"/>
			</td>
			<td>
				<xsl:apply-templates select="registered"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="images">
		<img src="../images/{.}.jpg"/>
	</xsl:template>
	<!--  THIS WILL BE THE LINK TO THE IMAEGE L-->
	<!--<xsl:template match="date" mode="imglinks">
		<ul class="nav">
			<xsl:if test="not(//house[1] = //house[@house_name = current()/parent::house/@house_name])">
				<li>
					<a href="{//house[@house_name = current()/parent::house/@house_name]/preceding-sibling::house[1]/@house_name}.html">Previous</a>
				</li>
			</xsl:if>
			<li>
				<a href="../list.html">Back to list</a>
			</li>
			<xsl:if test="not(//house[last()] = //house[@house_name = current()/parent::house/@house_name])">
				<li>
					<a href="{//house[@house_name = current()/parent::house/@house_name]/following-sibling::house[1]/@house_name}.html">Next</a>
				</li>
			</xsl:if>
		</ul>
	</xsl:template>-->
</xsl:stylesheet>
