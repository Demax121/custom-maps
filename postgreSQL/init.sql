-- Database is created by Docker (POSTGRES_DB=maps_db).
-- This script only defines schema inside that database.



CREATE TABLE maps (
    map_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    map_name VARCHAR(128),
    map_min_zoom INT,
    map_max_zoom INT,
    map_tiles_link TEXT,
    map_description TEXT
);

CREATE TABLE overlays (
    overlay_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    overlay_name VARCHAR(128) NOT NULL
);

CREATE TABLE map_overlays (
    map_id INT NOT NULL,
    overlay_id INT NOT NULL,
    PRIMARY KEY (map_id, overlay_id),
    FOREIGN KEY (map_id) REFERENCES maps(map_id) ON DELETE CASCADE,
    FOREIGN KEY (overlay_id) REFERENCES overlays(overlay_id) ON DELETE CASCADE
);

CREATE TABLE markers (
    marker_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    map_id INT NOT NULL,
    overlay_id INT NOT NULL,
    marker_name VARCHAR(128) NOT NULL,
    marker_lat REAL NOT NULL,
    marker_lng REAL NOT NULL,
    marker_desc TEXT,
    marker_icon VARCHAR(128) NOT NULL,
    FOREIGN KEY (map_id) REFERENCES maps(map_id) ON DELETE CASCADE,
    FOREIGN KEY (overlay_id) REFERENCES overlays(overlay_id) ON DELETE CASCADE
);
