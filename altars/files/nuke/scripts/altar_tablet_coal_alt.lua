
RegisterSpawnFunction( 0xff00ff28, "load_tablet_altar" )

local tab_altar = {
	prob   			= 0.8, 
	material_file 	= "files/nuke/biome_impl/coalmine_altar_tablet_alt.png",
	visual_file		= "files/nuke/biome_impl/coalmine_altar_tablet_visual.png",
	background_file	= "",
	is_unique		= 0,
}

table.insert(g_pixel_scene_02, tab_altar)

function load_tablet_altar( x, y )
	EntityLoad( "files/nuke/entities/tablet_altar.xml", x, y )
end