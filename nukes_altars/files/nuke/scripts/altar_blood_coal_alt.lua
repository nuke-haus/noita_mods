
RegisterSpawnFunction( 0xff15ff00, "load_blood_altar" )

local blood_altar = {
	prob   			= 0.8, 
	material_file 	= "mods/nukes_altars/files/nuke/biome_impl/coalmine_altar_blood_alt.png",
	visual_file		= "mods/nukes_altars/files/nuke/biome_impl/coalmine_altar_blood_visual.png",
	background_file	= "",
	is_unique		= 1,
}

table.insert(g_pixel_scene_02, blood_altar)

function load_blood_altar( x, y )
	EntityLoad( "mods/nukes_altars/files/nuke/entities/blood_altar.xml", x, y )
end