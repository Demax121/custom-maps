<?php

require_once 'databaseConnect.php';
header('Content-Type: application/json');

$sql = 
"
SELECT map_name, map_description, map_min_zoom, map_max_zoom, map_tiles_link, map_img
FROM maps
WHERE map_name = ?
";



$binding_values = [$_GET['map_name']];
echo Db::selectData($sql, $binding_values);



?>