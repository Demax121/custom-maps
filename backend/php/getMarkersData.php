<?php

require_once 'databaseConnect.php';
header('Content-Type: application/json');

$sql =
"
SELECT 
marker_name,
marker_lat, 
marker_lng, 
marker_desc, 
map_icons.icon_name,
map_icons.icon_link,
marker_img,
overlays.overlay_name
FROM markers
JOIN overlays
    ON markers.overlay_id = overlays.overlay_id
JOIN maps
    ON maps.map_id = markers.map_id
JOIN map_icons
    ON map_icons.icon_id = markers.icon_id    
WHERE maps.map_name = ?;
";

$binding_values = [$_GET['map_name']];
echo Db::selectData($sql, $binding_values);


?>