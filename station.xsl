<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="UTF-8" />

	
	<xsl:template match="/station">

	<html>
		<head>
	
		<title>Detail Station</title>
		<meta charset="utf-8" />
	
		</head>
		<body>
			Disponile : <xsl:value-of select="available"/><br/>
			Libre : <xsl:value-of select="free"/><br/>
			Total : <xsl:value-of select="total"/><br/>
		</body>
	</html>
	
	</xsl:template>

</xsl:stylesheet>