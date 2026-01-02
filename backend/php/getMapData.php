<?php

require_once 'databaseConnect.php';
header('Content-Type: application/json');

$sql = 
"
SELECT map_name, map_description, map_min_zoom, map_max_zoom
FROM maps
WHERE map_name = ?
";



$binding_values = ["test name"];
echo Db::selectData($sql, $binding_values);



?>