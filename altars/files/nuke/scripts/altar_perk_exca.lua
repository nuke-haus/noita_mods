
RegisterSpawnFunction( 0xff43ff07, "load_perk_altar" )

local altar = {
	prob   			= 1.5, 
	material_file 	= "files/nuke/biome_impl/exca_altar_perk.png",
	visual_file		= "files/nuke/biome_impl/exca_altar_perk_visual.png",
	background_file	= "",
	is_unique		= 1,
}

local altar2 = {
	prob   			= 1.5, 
	material_file 	= "files/nuke/biome_impl/exca_altar_perk_alt.png",
	visual_file		= "files/nuke/biome_impl/exca_altar_perk_visual.png",
	background_file	= "",
	is_unique		= 1,
}

table.insert(g_pixel_scene_04, altar)
table.insert(g_pixel_scene_04_alt, altar2)

function load_perk_altar( x, y )

	--EntityLoad( "files/nuke/entities/perk_altar.xml", x, y )
	EntityLoad( "files/nuke/entities/gorgon.xml", x, y + 6 )
	
end