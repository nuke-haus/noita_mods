
RegisterSpawnFunction( 0xff2aff00, "load_wand_altar" )

local altar = {
	prob   			= ModIsEnabled("commonifier") and 1 or 0.8,
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_wand.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_wand_visual.png",
	background_file	= "",
	is_unique		= ModIsEnabled("commonifier") and 0 or 1,
}

local altar2 = {
	prob   			= ModIsEnabled("commonifier") and 1 or 0.8,
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_wand_alt.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_wand_visual.png",
	background_file	= "",
	is_unique		= ModIsEnabled("commonifier") and 0 or 1,
}

table.insert(g_pixel_scene_04, altar)
table.insert(g_pixel_scene_04_alt, altar2)

function load_wand_altar( x, y )
	EntityLoad( "mods/nukes_altars/files/nuke/entities/wand_altar.xml", x, y )
end