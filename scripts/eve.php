#!/usr/bin/php
<?php

$api_url = "https://api.eveonline.com/server/ServerStatus.xml.aspx";

$gmt = -5;

while(1){
  $xml = file_get_contents($api_url);
  if($xml !== FALSE){
    $status = new SimpleXMLElement($xml);
    $local = time()-$gmt*60*60;
    $eve = strtotime($status->cachedUntil);
    $cache = $eve-$local;
    echo "eve:".date("Y-m-d H:i:s",$eve  )."\n";
    echo "cache:".($cache)."s remain\n";
    echo "Server is ".
      (($status->result->serverOpen == "True")?("open"):("closed")).
      " [".$status->result->onlinePlayers." players]\n";
    sleep($cache+1);
  } else {
    echo "api call failed.\n";
    sleep(1);
  }
}