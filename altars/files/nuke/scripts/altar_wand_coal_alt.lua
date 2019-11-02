
RegisterSpawnFunction( 0xff2aff00, "load_wand_altar" )

local altar = {
	prob   			= 0.8, 
	material_file 	= "files/nuke/biome_impl/coalmine_altar_wand_alt.png",
	visual_file		= "files/nuke/biome_impl/coalmine_altar_wand_visual.png",
	background_file	= "",
	is_unique		= 0,
}

table.insert(g_pixel_scene_02, altar)

function load_wand_altar( x, y )
	EntityLoad( "files/nuke/entities/wand_altar.xml", x, y )
end