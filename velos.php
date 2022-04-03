<?php


$options = stream_context_get_default(array(
    'http' => array(
        'proxy' =>  'tcp://www-cache:3128',
        'request_fulluri' => True,
    ),
    'ssl' => array(
        'verify_peer' => false,
        'verify_peer_name' => false,
    ),
));
/************************************** CARTE LEAFLET **********************************************************/
$xml = new DOMDocument;
$xml->load('http://www.velostanlib.fr/service/carto');

$xsl = new DOMDocument;
$xsl->load('velo.xsl');

$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); 

$htmlvelo = $proc->transformToXML($xml);

/*************************************** GEO LOCALISATION ******************************************************/

$jsongps = json_decode(file_get_contents('http://ip-api.com/json', NULL, $options));

$x = $jsongps->lat;
$y = $jsongps->lon;

$htmlvelo = str_replace('@latitude@',$y, $htmlvelo);
$htmlvelo = str_replace('@longitude@',$x, $htmlvelo);

$Lmarkers  = '';
$Lmarkers .= "L.marker([$x ,$y],{icon: locateIcon}).addTo(mymap).bindPopup('<b>Vous êtes ici !</b>');";

/*************************************** TRAVAUX ******************************************************************/

$jsontravaux = json_decode(file_get_contents('https://geoservices.grand-nancy.org/arcgis/rest/services/public/VOIRIE_Info_Travaux_Niveau/MapServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=pjson'));

$travaux = $jsontravaux->features[0]->attributes;

$Tmarkers = '';
foreach($jsontravaux->features as $f) {
	$i = addslashes($f->attributes->INTERVENANT);
	$d = addslashes($f->attributes->DESCR_GENE1);
	$a = addslashes($f->attributes->ADRESSE);
	$x = $f->geometry->x;
	$y = $f->geometry->y;
	$Tmarkers .= "L.marker([$y ,$x],{icon: buildIcon}).addTo(mymap).bindPopup('<b>Intervenant:</b>$i<br><br><b>Description:</b>$d<br><br><b>Adresse:</b>$a');";
}


 /**************************************** METEO *******************************************************************/

$urlmeteo = 'https://www.infoclimat.fr/public-api/gfs/xml?_ll=48.67103,6.15083&_auth=ARsDFFIsBCZRfFtsD3lSe1Q8ADUPeVRzBHgFZgtuAH1UMQNgUTNcPlU5VClSfVZkUn8AYVxmVW0Eb1I2WylSLgFgA25SNwRuUT1bPw83UnlUeAB9DzFUcwR4BWMLYwBhVCkDb1EzXCBVOFQoUmNWZlJnAH9cfFVsBGRSPVs1UjEBZwNkUjIEYVE6WyYPIFJjVGUAZg9mVD4EbwVhCzMAMFQzA2JRMlw5VThUKFJiVmtSZQBpXGtVbwRlUjVbKVIuARsDFFIsBCZRfFtsD3lSe1QyAD4PZA%3D%3D&_c=19f3aa7d766b6ba91191c8be71dd1ab2';

$xmlmeteo = file_get_contents($urlmeteo);
$xslmeteo = file_get_contents('meteo.xsl');

$xml = new DOMDocument;
$xml->loadXML($xmlmeteo);
$xsl = new DOMDocument;
$xsl->loadXML($xslmeteo);

$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);

$htmlmeteo = $proc->transformToXML($xml);

$htmlvelo = str_replace('@travaux@', $Tmarkers , $htmlvelo);
$htmlvelo = str_replace('@localisation@', $Lmarkers , $htmlvelo);
$htmlvelo = str_replace('@meteo@', $htmlmeteo, $htmlvelo);

echo $htmlvelo;

/*************************************** QUALITÉ DE L'AIR *********************************************************/

$jsonair = json_decode(file_get_contents('https://api.waqi.info/feed/nancy/?token=63c51e870180981f9f14457a8032b7ea20df1319'));

$air = $jsonair->data->aqi;

$html = '<div id="Air"> <b>Votre qualité de l\'air : ' . $air . ' PPM.</b> <br /><br />
<img alt="aqi" src="https://en.gouv.mc/var/monaco/storage/images/media/images/communication/environnement/tableau-indice-de-qualite-de-l-air/5198791-1-fre-FR/Tableau-indice-de-qualite-de-l-air_900x900.jpg" width="400px" height="200px"/><br /><br /></div>';

echo $html;

/******************************************************************************************************************/
