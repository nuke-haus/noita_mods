
RegisterSpawnFunction( 0xff00ff28, "load_tablet_altar" )

local tab_altar = {
	prob   			= ModIsEnabled("commonifier") and 1 or 0.8,
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_tablet.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_tablet_visual.png",
	background_file	= "",
	is_unique		= ModIsEnabled("commonifier") and 0 or 1,
}

local tab_altar2 = {
	prob   			= ModIsEnabled("commonifier") and 1 or 0.8,
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_tablet.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_tablet_visual.png",
	background_file	= "",
	is_unique		= ModIsEnabled("commonifier") and 0 or 1,
}

table.insert(g_pixel_scene_04, tab_altar)
table.insert(g_pixel_scene_04_alt, tab_altar2)

function load_tablet_altar( x, y )
	EntityLoad( "mods/nukes_altars/files/nuke/entities/tablet_altar.xml", x, y )
end