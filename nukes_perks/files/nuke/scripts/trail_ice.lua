dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "TRAIL_MAGIC_ICE",
	ui_name = "Freezing Afterimage",
	ui_description = "You leave a trail of freezing magic wherever you go.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/trail_ice.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/trail_ice.png",
	func = function(perk_item, player, item_name)

		local tbl = {
			script_source_file="files/nuke/scripts/trail_ice_loop.lua",
			execute_on_added="1",
			execute_every_n_frame="2",
			execute_times="-1" }

		EntityAddComponent(player, "LuaComponent", tbl ) 
		
	end,
})