<?php

require_once 'databaseConnect.php';
header('Content-Type: application/json');

$sql =
"
SELECT public.overlays.overlay_name
FROM public.map_overlays
JOIN public.maps
    ON public.maps.map_id = public.map_overlays.map_id
JOIN public.overlays
    ON public.overlays.overlay_id = public.map_overlays.overlay_id
WHERE public.maps.map_name = ?;

";

$binding_values = [$_GET['map_name']];
echo Db::selectData($sql, $binding_values);

?>