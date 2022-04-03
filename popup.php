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

$xmlvelo = file_get_contents('http://www.velostanlib.fr/service/stationdetails/nancy/'.$_GET['station_id']);
$xslvelo = file_get_contents('station.xsl');

$xml = new DOMDocument;
$xml->loadXML($xmlvelo);
$xsl = new DOMDocument;
$xsl->loadXML($xslvelo);

$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); 

echo $proc->transformToXML($xml);