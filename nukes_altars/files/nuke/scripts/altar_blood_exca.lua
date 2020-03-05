
RegisterSpawnFunction( 0xff15ff00, "load_blood_altar" )

local blood_altar = {
	prob   			= ModIsEnabled("commonifier") and 1 or 0.8,
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_blood.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_blood_visual.png",
	background_file	= "",
	is_unique		= ModIsEnabled("commonifier") and 0 or 1,
}

local blood_altar2 = {
	prob   			= ModIsEnabled("commonifier") and 1 or 0.8,
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_blood_alt.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/exca_altar_blood_visual.png",
	background_file	= "",
	is_unique		= ModIsEnabled("commonifier") and 0 or 1,
}

table.insert(g_pixel_scene_04, blood_altar)
table.insert(g_pixel_scene_04_alt, blood_altar2)

function load_blood_altar( x, y )
	EntityLoad( "mods/nukes_altars/files/nuke/entities/blood_altar.xml", x, y )
end