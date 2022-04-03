<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8" />

	
	<xsl:template match="/carto/markers">

		<html>
			<head>
				
				<title>Informations à Nancy</title>

				<meta charset="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

				<link rel="shortcut icon" type="image/x-icon" href="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Logo_informations.svg/1024px-Logo_informations.svg.png" />
				<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A==" crossorigin=""/>

				<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js" integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA==" crossorigin=""></script>

				<style>
					body {
					display:flex;
					flex-direction: row;
					flex-wrap: wrap;
					}

					body > h1 {
					text-align : center;
					flex-basis : 100%;
					}

					body > #mapid {
					border : solid 2px black;
					margin : 2%;
					flex-basis : 45%;
					}
					.leaflet-touch .leaflet-bar {
					border : none;
					}

					body div#tableau {
					text-align : center;
					margin-left : 2%;
					flex-basis : 45%;
					}

					body div#Air {
					text-align : center;
					margin-left : 2%;
					flex-basis : 100%;
					}

					.echeance {
					font-weight : bold;
					}
					strong {
					padding : 5px;
					}
	
				</style>

			</head>
			
			<body>

				<h1>Informez-vous sur la ville de Nancy</h1>


				<div id="mapid" style="width: 48%; height: 400px;"></div>
				@meteo@
				<script>
					
					var LeafIcon = L.Icon.extend({
					options: {
					iconSize:     [38, 50],
					popupAnchor:  [0, -15]
					}
					});

					var Leaf2Icon = L.Icon.extend({
					options: {
					iconSize:     [50, 50],
					popupAnchor:  [0, -15]
					}
					});

					var Leaf3Icon = L.Icon.extend({
					options: {
					iconSize:     [70, 70],
					popupAnchor:  [0, -15]
					}
					});


					var bikeIcon = new LeafIcon({iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/55/BicycleMarkerSymbol.png'});
					
					var locateIcon = new Leaf2Icon({iconUrl: 'https://webstockreview.net/images/location-clipart-location-pointer-15.png'});

					var buildIcon = new Leaf3Icon({iconUrl: 'https://cdn4.iconfinder.com/data/icons/map-pins-7/64/map_pin_pointer_location_navigation_building_apartment_office-512.png'});



					L.icon = function (options) {
					return new L.Icon(options);
					};


					var mymap = L.map('mapid').setView([48.697479, 6.185673], 13);

					L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
					maxZoom: 15,
					attribution: 'Map data <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, ' +
					'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
					id: 'mapbox/streets-v11',
					tileSize: 512,
					zoomOffset: -1
					}).addTo(mymap);
					<xsl:apply-templates select="marker" />
					@travaux@
					@localisation@

					var popup = L.popup();

					function onMapClick(e) {
					popup
					.setLatLng(e.latlng)
					.setContent("Ne clique pas ici bon sang, il n'y a rien ! " + e.latlng.toString())
					.openOn(mymap);
					}

					mymap.on('click', onMapClick);

				</script>	

			</body>
		</html>
		
	</xsl:template>
	
	<xsl:template match="marker">

		L.marker([<xsl:value-of select="@lat"/>, 
		<xsl:value-of select="@lng"/>],{icon: bikeIcon}).addTo(mymap)
		.bindPopup('<iframe src="popup.php?station_id={@number}" width="150" height="100"></iframe>');
	</xsl:template>

	
</xsl:stylesheet>



