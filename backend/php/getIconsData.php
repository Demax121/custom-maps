<?php

require_once 'databaseConnect.php';
header('Content-Type: application/json');

$sql = 
"
SELECT icon_name, icon_link 
FROM map_icons
";


$binding_values = [];
echo Db::selectData($sql, $binding_values);

?>