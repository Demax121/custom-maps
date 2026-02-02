--
-- Custom Maps Database Initialization
-- Database is created by Docker (POSTGRES_DB environment variable)
--

\connect maps_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16402)
-- Name: map_overlays; Type: TABLE; Schema: public; Owner: postgresAdmin
--

CREATE TABLE public.map_overlays (
    map_id integer NOT NULL,
    overlay_id integer NOT NULL
);


ALTER TABLE public.map_overlays OWNER TO "postgresAdmin";

--
-- TOC entry 220 (class 1259 OID 16386)
-- Name: maps; Type: TABLE; Schema: public; Owner: postgresAdmin
--

CREATE TABLE public.maps (
    map_id integer NOT NULL,
    map_name character varying(128) NOT NULL,
    map_min_zoom integer NOT NULL,
    map_max_zoom integer NOT NULL,
    map_tiles_link text NOT NULL,
    map_description text,
    map_img text
);


ALTER TABLE public.maps OWNER TO "postgresAdmin";

--
-- TOC entry 219 (class 1259 OID 16385)
-- Name: maps_map_id_seq; Type: SEQUENCE; Schema: public; Owner: postgresAdmin
--

ALTER TABLE public.maps ALTER COLUMN map_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.maps_map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16420)
-- Name: markers; Type: TABLE; Schema: public; Owner: postgresAdmin
--

CREATE TABLE public.markers (
    marker_id integer NOT NULL,
    map_id integer NOT NULL,
    overlay_id integer NOT NULL,
    marker_name character varying(128) NOT NULL,
    marker_lat real NOT NULL,
    marker_lng real NOT NULL,
    marker_desc text,
    marker_icon character varying(128) NOT NULL,
    marker_img text
);


ALTER TABLE public.markers OWNER TO "postgresAdmin";

--
-- TOC entry 224 (class 1259 OID 16419)
-- Name: markers_marker_id_seq; Type: SEQUENCE; Schema: public; Owner: postgresAdmin
--

ALTER TABLE public.markers ALTER COLUMN marker_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.markers_marker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16395)
-- Name: overlays; Type: TABLE; Schema: public; Owner: postgresAdmin
--

CREATE TABLE public.overlays (
    overlay_id integer NOT NULL,
    overlay_name character varying(128) NOT NULL
);


ALTER TABLE public.overlays OWNER TO "postgresAdmin";

--
-- TOC entry 221 (class 1259 OID 16394)
-- Name: overlays_overlay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgresAdmin
--

ALTER TABLE public.overlays ALTER COLUMN overlay_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.overlays_overlay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3466 (class 0 OID 16402)
-- Dependencies: 223
-- Data for Name: map_overlays; Type: TABLE DATA; Schema: public; Owner: postgresAdmin
--

COPY public.map_overlays (map_id, overlay_id) FROM stdin;
2	1
2	2
2	3
2	4
2	5
2	6
2	7
2	8
2	9
2	10
\.


--
-- TOC entry 3463 (class 0 OID 16386)
-- Dependencies: 220
-- Data for Name: maps; Type: TABLE DATA; Schema: public; Owner: postgresAdmin
--

COPY public.maps (map_id, map_name, map_min_zoom, map_max_zoom, map_tiles_link, map_description, map_img) FROM stdin;
2	Merges	2	4	http://127.0.0.1:8885/maps/Merges/{z}/{y}/{x}.webp	# Merges: The Valley of Whispering Winds\n## A Geography of Shadow and Stone\n\nWelcome to the **Merges**, a basin of treacherous beauty caught between the crushing weight of the **Whistling Peaks** and the silent expanse of the western forests. It is a land where the wind never truly stops blowing, and **silence is suspicious**.\n\n### The Lay of the Land\n---\n\nThe valley is not merely a passage; it is a trap for the unwary. The roads are well-worn, suggesting trade, but the overgrown ruins suggest that civilization here is a ~~permanent state~~ **fleeting privilege**. The geography is defined by water that flows deceptively calm and woods that seem to lean in as you pass.\n\n> "They call it 'Merges' because here the wind merges with the soul."\n>> ...is what the poets claim in the taverns of Nestal...\n> > > ...but the soldiers know it's where the living merge with the dead.\n\n### Key Locations\n\nBased on the cartographer's survey, these are the primary points of interest (and danger):\n\n+ **The Citadels of Men**\n  - **Nestal**\n    The largest stronghold, sitting comfortably near the southern forests. Its red roofs hide a nobility that has grown paranoid of the woods.\n  - **Tarantez**\n    A fortified outpost in the west. It guards the river, but its walls face *inward* toward the town, not just outward.\n  - **Istenis**\n    Hidden in the shadow of the mountains to the northeast. The sun reaches Istenis only for a few hours a day.\n\n+ **The Wilds**\n  - **Raven Woods**\n    A massive, sprawling thicket dominating the south. The trees are dense, and the canopy chokes out the light.\n  - **Deceptive Wetlands**\n    Located in the northwest. The ground here looks solid, but it is a lie.\n    - Home to the sunken ruins of **Mothar**.\n  - **Whistling Peaks**\n    The jagged mountain range to the east that creates the valley's unnatural wind currents.\n  - **Windy Valley**\n    The narrow pass leading out of the region near Istenis.\n\n### Rules of the Road\n\n1. Stick to the main roads between **Nestal** and **Istenis**.\n2. If you see lights in the **Deceptive Wetlands**, do not follow them.\n3. Keep your weapons oiled; the dampness here rusts steel and rots bowstrings.\n\n---\n\n## Recovered Patrol Log\n\nA waterlogged journal found near the bridge crossing into the Windy Valley. The ink is running:\n\n*Day 4: We lost Kaelen near Mothar. Day 5: He stepped off the path. Just one step. Day 6: The mud didn't sink. It grabbed him. NOTE: DO NOT STOP FOR THE WOUNDED.*\n\n\nScratched into the leather cover is the code: `0-4-0-4`.\n\n---\n\n## Regional Threat Assessment\n\nA quick reference for travelers traversing the Merges:\n\n| Location | Primary Threat | Survival Chance |\n| :------- | :------------- | --------------: |\n| **Whistling Peaks** | Harpies, Rock Slides | Moderate |\n| **Raven Woods** | Giant Arachnids, Bandits | Low |\n| **Deceptive Wetlands** | Drowning, Will-o'-the-wisps | Very Low |\n| **Town of Nestal** | Corrupt Guards, Thieves | High |\n\n---\n\n*Keep your eyes on the horizon, traveler. In the Merges, the landscape changes when you blink.*\n\n# City Chronicles: The Settlements of Merges\n\nDetailed archives regarding the major population centers, their exports, and their secrets.\n\n---\n\n## Mythar: The Drowned City\n### Location: Deceptive Wetlands\n\nOnce a jewel of architecture, Mythar is now a testament to hubris. Built upon the **Deceptive Wetlands**, the city is slowly being reclaimed by the muck. Half the buildings are submerged, and the other half stand on rotting stilts.\n\n> "The ground here is hungry."\n>> ...is the warning etched into the city gates...\n> > > ...which are currently sinking three inches a year.\n\n### Life in the Muck\n+ **Architecture**: Connected by precarious rope bridges and floating walkways.\n+ **Economy**:\n  - Harvesting **Bog Iron**.\n  - Distilling "Marsh-Gas" for lanterns.\n  - Scavenging ruins of the lower city levels.\n+ **Atmosphere**: The air smells of sulfur and stagnant water. The locals never walk on the ground—only on the walkways.\n\n**Rumor:** *They say the Mayor of Mythar isn't human anymore. They say he breathes water.*\n\n---\n\n## Tarantez: The Golden Cage\n### Location: Western Meadows\n\nTarantez sits amidst the rolling golden fields of the west. On the surface, it is a bustling hub of agriculture, supplying the valley with grain. However, the walls are unusually high for a farming town, and the gates are barred **before** sunset.\n\n### The Trade of Grain and Grief\nThe city is famous for its vast silos, but travelers often note the silence of the workers.\n\n* **Exports**:\n    1. Golden Wheat (The staple of the region).\n    2. Sun-dried Hay.\n    3. ~~Smuggled Artifacts~~ from the Raven Woods.\n* **The Meadows**: Beautiful by day, but prone to "Shifting Grass" at night—predatory flora that mimics the wheat.\n\n> "Eat the bread of Tarantez, but do not sleep in its fields."\n\n---\n\n## Nestal: The Divided Jewel\n### Location: The Southern River Fork\n\nNestal is the beating heart of commerce, straddling the great river that flows from the south. The city is physically split in two by the rushing waters, connected only by the massive **Bridge of Tithes**.\n\n### The Two Banks\n+ **The East Bank (The Gold Side)**\n  - Home to the merchants and nobility.\n  - Paved with stone, lit by magical lamps.\n+ **The West Bank (The Silt Side)**\n  - Where the goods from the south are offloaded.\n  - Muddy, chaotic, and ruled by the dock gangs.\n  - *Keep your purse strings tight here.*\n\n**Strategic Importance**: Nothing enters Merges from the south without passing through Nestal's river chains. It is a choke point of immense wealth and corruption.\n\n| District | Ruling Faction | Danger Level |\n| :------- | :------------- | :----------- |\n| High Market | Merchant Guild | Low |\n| River Docks | The "River Rats" | High |\n| The Bridge | City Watch | Moderate |\n\n---\n\n## Istenis: The Anvil of the Peaks\n### Location: The Whistling Peaks Foothills\n\nCarved into the living rock of the mountains, Istenis is a fortress of industry. It is the domain of the dwarves, a place of fire, soot, and unyielding stone. The constant wind from the **Whistling Peaks** is drowned out by the rhythmic clanging of hammers.\n\n### The City of Forges\nIstenis does not sleep. The glow of the smelters illuminates the mountain face throughout the night.\n\n* **Industry**:\n    - **Weaponsmithing**: The finest blades in the valley, designed to cut through "thickened" air.\n    - **Structural Engineering**: They maintain the bridges of Nestal.\n* **Culture**:\n    - Stoic and distrustful of magic.\n    - They worship the **Eternal Flame**, believing it keeps the encroaching shadows of the valley at bay.\n\n> "Iron does not lie. Iron does not bleed. Iron endures."\n>> -- Motto of the Iron-Hearth Clan\n\n---\n\n## Summary of Trade Routes\n\n| Origin | Destination | Cargo | Risk |\n| :----- | :---------- | :---- | ---: |\n| Tarantez | Nestal | Grain | Low |\n| Istenis | Mythar | Tools/Iron | High |\n| Nestal | Istenis | Southern Spices | Moderate |	https://images.alphacoders.com/900/thumb-1920-900186.jpg
\.


--
-- TOC entry 3468 (class 0 OID 16420)
-- Dependencies: 225
-- Data for Name: markers; Type: TABLE DATA; Schema: public; Owner: postgresAdmin
--

COPY public.markers (marker_id, map_id, overlay_id, marker_name, marker_lat, marker_lng, marker_desc, marker_icon, marker_img) FROM stdin;
10	2	2	Spruce Village	-19.97	25.31	## Spruce Village\n### Location: Northern Forest Edge\n\nTucked away near the northern tree line, Spruce Village is a settlement that smells perpetually of fresh sawdust and pine resin. It is quiet, orderly, and fiercely proud of its craft.\n\n### The Carpenters' Domain\nThe woodworkers here do not just cut wood; they "listen" to it.\n+ **Specialty**:\n  - **Spruce Furniture**: Known across the continent for its durability and a faint, pleasant scent that never fades.\n  - **Living Wood**: Rumors persist that their most expensive chairs can "adjust" to the sitter.\n\n> "A Spruce table will outlast the house it sits in."\n>> -- Common market saying in Tarantez.\n\n### Points of Interest\n* **The Sawmill**: Powered by a diverted stream, its rhythmic thumping is the village's heartbeat.\n* **The Showroom**: A massive longhouse where the finest works are displayed for visiting merchants.	leaf-green.png	\N
11	2	2	The Forest Enclave	-12.73	-17.75	## The Forest Enclave\n### Location: Deep Raven Woods\n\nThis is not a village found on most maps. Hidden deep within the menacing **Raven Woods**, the Enclave is a sanctuary for those who worship the wild. It is less a collection of buildings and more a part of the forest itself.\n\n### The Circle of Druids\nThe inhabitants here live in harmony with the dangers of the woods, protected by ancient pacts rather than walls.\n+ **Inhabitants**:\n  - Druids of the Old Growth.\n  - Rangers who guide lost travelers (for a price).\n  - *Awakened Animals*.\n\n### Atmosphere & Danger\n* **Lighting**: Bioluminescent fungi provide the only light at night; fire is forbidden.\n* **Defense**: The trees themselves shift to block intruders.\n* **Rule**: "Take only what falls; cut nothing that grows."\n\n> **Warning**: Do not approach the Enclave with an axe on your belt. You will not be asked to leave twice.	leaf-green.png	\N
14	2	2	Verdin	23.89	-14.24	## Verdin\n### Location: The Central Crossroads\n\nVerdin sits squarely at the intersection of the major trade routes between Tarantez, Nestal, and the northern pass. It is the transient capital of the Merges, where everyone stops, but no one stays.\n\n### The Traveler's Respite\nVerdin exists for one purpose: hospitality. It is a hub of gossip, news, and rest.\n\n### Key Landmark: The Crossroads Inn\nA legendary establishment known far and wide.\n+ **The Hearth**: A fire that is said to have been burning for fifty years without going out.\n+ **The Menu**:\n  - *Roasted Boar* (Fresh from the woods).\n  - *Verdin Ale* (Dark, heavy, and cheap).\n+ **The Notice Board**: The best place in the valley to find work—or a bounty hunter.\n\n| Service | Quality | Price |\n| :------ | :------ | :---- |\n| Stables | Excellent | High |\n| Lodging | Crowded | Moderate |\n| Rumors | Unreliable | **Free** |	leaf-red.png	\N
5	2	5	Ruins of Cavrin	18.98	-66.27	## Ruins of Cavrin\n### Location: Outskirts of the Deceptive Wetlands\n\nCavrin is a village that is dying, though it hasn't quite realized it yet. Located dangerously close to the **Deceptive Wetlands**, the soil here has turned gray and sodden.\n\n### The Silent Sickness\nThe villagers are afflicted by a malady that defies the healers of Nestal.\n+ **Symptoms**:\n  - Paleness of skin.\n  - Loss of time (hours feel like minutes).\n  - A compulsion to walk toward the swamps at night.\n+ **The Missing**: Every week, someone vanishes. There are no struggles, no blood, and no footprints leading away. They simply cease to exist between one blink and the next.\n\n> "It's not a plague. It's a titration. The swamp is drinking them."\n>> -- A passing alchemist (currently missing).	leaf-orange.png	\N
6	2	3	Raven Woods	-39.23	-27.77	## Raven Woods\n### Location: The Southern Expanse\n\nThe oldest entity in the valley. The elves claim the woods were here before the mountains rose, and they will remain after the mountains crumble into dust.\n\n### The Eternal Canopy\nThe trees are ancient, with bark like iron and leaves that absorb sound. The forest does not just house wildlife; it seems to possess a collective consciousness.\n* **Time dilation**: Shadows move faster than the sun here.\n* **The Law**: Do not carry fire. Do not cut green wood.\n* **The Name**: It isn't named for the birds. It's named for the *color* of the darkness inside.	leaf-orange.png	\N
7	2	7	Whistling Peaks	45.71	78.57	## Whistling Peaks\n### Location: Eastern Mountain Range\n\nA jagged spine of rock where the wind screams constantly. The sound can drive a man mad if he listens too long without earplugs.\n\n### The Climbers' Folly\nDespite the obvious death wish required, people still try to scale the Needle-Point.\n+ **The "Wind-Walkers"**: A group of insane mountaineers who believe god lives at the summit.\n+ **Hazards**:\n  - 100 mph gusts.\n  - Oxygen deprivation.\n  - Frost-Wraiths.\n\n> "I know a man who climbed the Peaks. He came back with no fingers and a smile that hasn't left his face in three years. He says he heard the mountain tell a joke."	leaf-orange.png	\N
8	2	6	Windy Valley	14.94	75.59	## Windy Valley\n### Location: The Narrow Pass (Shortcut)\n\nTechnically the fastest route between Istenis and the lowlands. Practically, it is a gauntlet of pain.\n\n### Risk vs. Reward\n| Factor | Description |\n| :----- | :---------- |\n| **Time Saved** | 2 Days |\n| **Terrain** | Loose Scree, Falling Rocks |\n| **Fauna** | **Harpies** (They drop rocks for fun) |\n| **Verdict** | *Only if you are desperate or armored.* |	leaf-orange.png	\N
2	2	1	Tarantez	-31.8	-77.17	# Location Profile: Tarantez\n## The Gilded Silo\n\nTarantez dominates the western meadows, acting as the breadbasket for the entire Merges valley. It is a city of golden fields and golden coin, but the open plains offer no place to hide when night falls.\n\n### Geography & Atmosphere\n---\n\nSurrounded by an ocean of wheat and barley, the city walls rise like a cliff island. By day, it is idyllic and warm. By night, the wind rustles the grain, sounding suspiciously like whispering voices.\n\n> "The grain feeds us. The grain watches us."\n\n### Key Features\n\n+ **The Great Granaries**\n  - Towering stone cylinders that hold enough food to survive a ten-year siege.\n  - Guarded by the "Straw-Men"—golems made of woven hay and old magic.\n+ **The Trade Road**\n  - The main artery for export.\n  - *Warning*: Bandit activity is high during harvest season.\n\n### Social Hierarchy\n\n1. **The Grain Barons** (Rule from the high towers)\n2. **The Overseers** (Manage the fields)\n3. **The Harvesters** (Live in huts outside the walls; expandable)\n\n	leaf-green.png	\N
4	2	1	Istenis	43.07	62.4	# Location Profile: Istenis\n## The Iron Heart\n\nCarved into the living rock of the **Whistling Peaks**, Istenis is the fortress-home of the dwarves. It is a grim, industrial sanctuary where the fires never die and the hammers never stop.\n\n### Geography & Atmosphere\n---\n\nIstenis is vertical. The city climbs the mountain face, with smoke venting from hundreds of chimneys. The constant wind from the peaks howls through the stone arches, creating a mournful song that gives the mountains their name.\n\n> "Stone breaks the wind. Fire breaks the dark."\n\n### Key Features\n\n+ **The High Forge**\n  - Located at the summit, powered by magma pumped from the deep earth.\n  - Producing: **Merges Steel** (resistant to rust and magic).\n+ **The Deep Roads**\n  - Tunnels leading under the mountains.\n  - *Status*: **Sealed** due to "infestation."\n+ **The Gate of Cinders**\n  - The only entrance, capable of withstanding dragon fire.\n\n### Cultural Rules\n\n1. **No open flame** outside of designated forges (the wind spreads fire too fast).\n2. **Do not whistle** (it mocks the mountain spirits).\n3. **Pay in metal**, not paper.\n	leaf-green.png	\N
9	2	6	The Bridge of Dead Horse	1.05	48.87	## The Bridge of Dead Horse\n### Location: Crossing the Grim Tributary\n\nA sturdy stone bridge that looks unremarkable, save for the bleached skull mounted on the central arch.\n\n### The Origin Story\nYou would assume a horse died here in battle, or perhaps fell off.\n* **The Truth**: A merchant's horse simply sat down in the middle of the bridge and refused to move. It didn't bolt, it didn't eat, it didn't drink. It stared at the other side, trembling, until its heart gave out.\n* **The Warning**: Locals say the horse saw something invisible on the far bank. *Something that is still there.*	leaf-red.png	\N
12	2	10	Grim Water Lake	-21.78	-24.61	## Grim Water Lake\n### Location: The Deep Basin\n\nA body of water so dark it looks like a hole in the world. It reflects no stars.\n\n### The Depths\nFishermen avoid the center. They say the lake has no bottom, connecting directly to the Underdark waters.\n* **The Temptation**: Sometimes, you see gold glinting just below the surface.\n* **The Rule**: Never reach for it.\n* **The Catch**: The fish here are blind, pale, and taste like copper.\n\n> "Do you want to go down there? No.\n> Does a part of you want to jump? **Yes.**"	leaf-green.png	\N
13	2	8	Teheris Mines	6.14	68.73	## Teheris Mines\n### Location: Beneath Istenis\n\nAn ancient dwarven complex that runs deeper than any human map can track. The upper levels are active mines; the lower levels are sealed with runic lead.\n\n### The Dwarven Secret\nThe Dwarves of Istenis are mining iron and gold, but they are also guarding something.\n1.  **Level 1-5**: Iron Ore extraction.\n2.  **Level 6-10**: Precious gems.\n3.  **Level 11+**: `RESTRICTED AREA - KING'S EYES ONLY`\n\n**Rumor**: The mines didn't hit a vein of ore. They hit a door. And the dwarves are terrified of what is knocking on the other side.	leaf-red.png	\N
1	2	1	Mythar	39.37	-71.89	# Location Profile: Mythar\n## The Drowning City\n\nLocated deep within the **Deceptive Wetlands**, Mythar is a city fighting a losing battle against nature. It does not sit upon the land; it floats above it, a precarious network of rotting wood and desperate magic.\n\n### Geography & Atmosphere\n---\n\nThe air here is thick with moisture and the smell of decay. The "streets" are merely boardwalks suspended over the muck, and the stone foundations of the old city have long since sunk beneath the surface.\n\n> "To walk in Mythar is to test one's faith in wood and nail."\n>> ...local proverb...\n> > > ...often recited at funerals.\n\n### Key Features\n\n+ **The Sunken Quarter**\n  - The original city center, now visible only through the murky water.\n  - Scavengers dive here for ancient relics, though many never resurface.\n+ **The Fog-Lanterns**\n  - Massive braziers that burn green fire to push back the encroaching mists.\n  - If the lights go out, the city closes its doors. Immediately.\n\n### Threat Assessment\n\n| Hazard | Source | Lethality |\n| :----- | :----- | :-------- |\n| Structure Collapse | Rotting Stilts | Moderate |\n| Disease | "Swamp Fever" | High |\n| Predation | Crocodiles, Drowners | High |\n	leaf-orange.png	https://www.fredrikrosado.com/wp-content/uploads/2024/08/rossa_s_dnd_fantasy_dark_rain_grey_sun_rise_town_street_in_the__ae0de2ce-7658-4aac-aef1-69d23cecf615-1024x574.png
3	2	1	Nestal	-35.03	29.88	# Location Profile: Nestal\n## The City of Two Banks\n\nNestal is the throat of the valley. Sitting astride the great southern river, it controls all commerce entering the region. It is a city divided by water and united by greed.\n\n### Geography & Atmosphere\n---\n\nThe river here is wide and fast. Nestal is built on both banks, connected by the massive **Bridge of Tithes**. The roar of the water is constant, masking the sounds of back-alley deals and midnight assassinations.\n\n> "Southbound goods, Northbound lies."\n>> -- Graffiti found on the western docks.\n\n### Key Features\n\n+ **The East Bank (The Gilded Bank)**\n  - **Castle Nestal**: The seat of power, adorned with red tiles.\n  - **The Grand Market**: Where southern spices and silks are sold.\n+ **The West Bank (The Silt Bank)**\n  - **The Processing Yards**: Where raw goods are sorted.\n  - **The Slums**: Muddy, crowded, and dangerous.\n+ **The Bridge of Tithes**\n  - A fortress in itself.\n  - Tolls are heavy: 10% of your cargo or 10% of your blood.\n\n### Imports & Exports\n\n| Item | Origin | Value in Nestal |\n| :--- | :----- | :-------------- |\n| Exotic Spices | South | **Very High** |\n| Iron Weapons | Istenis | High |\n| Swamp Roots | Mythar | Low |\n\n	leaf-green.png	\N
\.


--
-- TOC entry 3465 (class 0 OID 16395)
-- Dependencies: 222
-- Data for Name: overlays; Type: TABLE DATA; Schema: public; Owner: postgresAdmin
--

COPY public.overlays (overlay_id, overlay_name) FROM stdin;
1	Cities
2	Villages
3	Woodlans
4	Castles
5	Ruins
6	Interesting places
7	Mountains
8	Mines
9	Dungeons
10	Lakes
\.


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 219
-- Name: maps_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgresAdmin
--

SELECT pg_catalog.setval('public.maps_map_id_seq', 2, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 224
-- Name: markers_marker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgresAdmin
--

SELECT pg_catalog.setval('public.markers_marker_id_seq', 14, true);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 221
-- Name: overlays_overlay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgresAdmin
--

SELECT pg_catalog.setval('public.overlays_overlay_id_seq', 10, true);


--
-- TOC entry 3308 (class 2606 OID 16408)
-- Name: map_overlays map_overlays_pkey; Type: CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.map_overlays
    ADD CONSTRAINT map_overlays_pkey PRIMARY KEY (map_id, overlay_id);


--
-- TOC entry 3304 (class 2606 OID 16393)
-- Name: maps maps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_pkey PRIMARY KEY (map_id);


--
-- TOC entry 3310 (class 2606 OID 16433)
-- Name: markers markers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.markers
    ADD CONSTRAINT markers_pkey PRIMARY KEY (marker_id);


--
-- TOC entry 3306 (class 2606 OID 16401)
-- Name: overlays overlays_pkey; Type: CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.overlays
    ADD CONSTRAINT overlays_pkey PRIMARY KEY (overlay_id);


--
-- TOC entry 3311 (class 2606 OID 16409)
-- Name: map_overlays map_overlays_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.map_overlays
    ADD CONSTRAINT map_overlays_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.maps(map_id) ON DELETE CASCADE;


--
-- TOC entry 3312 (class 2606 OID 16414)
-- Name: map_overlays map_overlays_overlay_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.map_overlays
    ADD CONSTRAINT map_overlays_overlay_id_fkey FOREIGN KEY (overlay_id) REFERENCES public.overlays(overlay_id) ON DELETE CASCADE;


--
-- TOC entry 3313 (class 2606 OID 16434)
-- Name: markers markers_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.markers
    ADD CONSTRAINT markers_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.maps(map_id) ON DELETE CASCADE;


--
-- TOC entry 3314 (class 2606 OID 16439)
-- Name: markers markers_overlay_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgresAdmin
--

ALTER TABLE ONLY public.markers
    ADD CONSTRAINT markers_overlay_id_fkey FOREIGN KEY (overlay_id) REFERENCES public.overlays(overlay_id) ON DELETE CASCADE;


-- Completed on 2026-02-02 20:39:30 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict BAz7jLRbQNSc0QNq9TSiaUbRZefnjzoLSXBTYfdUEBMLcmIo2LDf6fenk5u5qf0

