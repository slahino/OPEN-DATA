<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="UTF-8" />

	
	<xsl:template match="/previsions">

		<html>
			<head>
				
				
			</head>

			<body>
				<div id="tableau">
					<table> <br />
					<TR>
						<TD>
							<strong>Echeance</strong>
						</TD>
						<TD>
							<strong>Temp. au sol</strong>
						</TD>
						<TD>
							<strong>Temp. à 2 mètres</strong>
						</TD>
						<TD>
							<strong>Pluie</strong>
						</TD>
						<TD>
							<strong>Humidité</strong>
						</TD>
						<TD>
							<strong>Vent Moyen</strong>
						</TD>
						<TD>
							<strong>Vent Rafales</strong>
						</TD>
						<TD>
							<strong>Date</strong>
						</TD>
						<TR>
							<xsl:apply-templates select="./echeance"/>
						</TR>
					</TR>					
				</table>
			</div>
		</body>
	</html>
	
</xsl:template>

<xsl:template match="echeance">
	<TR>
		<xsl:if test="position() &lt;= 8 ">
			<TD class="echeance">

				<xsl:if test="./@hour &lt;= 6">
					<xsl:value-of select="./@hour"/> &#127770;
				</xsl:if>

				<xsl:if test="(./@hour &gt; 6) and (./@hour &lt;= 18)">
					<xsl:value-of select="./@hour"/> &#127773;
				</xsl:if>

				<xsl:if test="./@hour &gt; 18">
					<xsl:value-of select="./@hour"/> &#127770;
				</xsl:if>
				
			</TD>
			<TD>
				<xsl:apply-templates select="./temperature" mode="sol"/>
			</TD>
			<TD>
				<xsl:apply-templates select="./temperature" mode="deux-metre"/>

			</TD>
			<TD>
				<xsl:if test="./pluie &gt; 0">
					<xsl:value-of select="./pluie"/> &#127783;&#65039;
				</xsl:if>

				<xsl:if test="./pluie &lt;= 0">
					<xsl:value-of select="./pluie"/> 
				</xsl:if>
			</TD>
			<TD> 
				<xsl:value-of select="./humidite/level"/> 
			</TD>
			<TD>
				<xsl:value-of select="./vent_moyen/level"/>		
			</TD>
			<TD>
				<xsl:value-of select="./vent_rafales/level"/>

			</TD>
			<TD>
				<xsl:value-of select="./@timestamp"/> <br/>
			</TD>
			
		</xsl:if>
	</TR>	
</xsl:template> 




<xsl:template match="temperature" mode="sol">
	<xsl:if test="round((./level[2])-273.15) &lt;= 0">
		<xsl:value-of select="round((./level[2])-273.15) div 1 "/>°C &#10052;&#65039;
	</xsl:if>

	<xsl:if test="round((./level[2])-273.15) = 1">
		<xsl:value-of select="round((./level[2])-273.15) div 1 "/>°C &#9729;&#65039;
	</xsl:if> 

	<xsl:if test="round((./level[2])-273.15) &gt; 1">
		<xsl:value-of select="round((./level[2])-273.15) div 1 "/>°C &#x2600;&#xFE0F; 
	</xsl:if>
</xsl:template>

<xsl:template match="temperature" mode="deux-metre">
	<xsl:if test="round((./level[1])-273.15) &lt;= 0">
		<xsl:value-of select="round((./level[1])-273.15) div 1 "/>°C &#10052;&#65039;
	</xsl:if>

	<xsl:if test="round((./level[1])-273.15) = 1">
		<xsl:value-of select="round((./level[1])-273.15) div 1 "/>°C &#9729;&#65039;
	</xsl:if>

	<xsl:if test="round((./level[1])-273.15) &gt; 1">
		<xsl:value-of select="round((./level[1])-273.15) div 1 "/>°C &#x2600;&#xFE0F; 
	</xsl:if>

</xsl:template>


</xsl:stylesheet>





