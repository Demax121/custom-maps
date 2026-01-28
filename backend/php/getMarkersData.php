<?php

require_once 'databaseConnect.php';
header('Content-Type: application/json');

$sql =
"
SELECT 
marker_name, marker_lat, marker_lng, marker_description, marker_icon,
public.overlays.overlay_name
FROM public.markers
JOIN public.overlays
    ON public.markers.overlay_id = public.overlays.overlay_id
JOIN public.maps
    ON public.maps.map_id = public.markers.map_id
WHERE public.maps.map_name = ?;
";

$binding_values = [$_GET['map_name']];
echo Db::selectData($sql, $binding_values);


?>