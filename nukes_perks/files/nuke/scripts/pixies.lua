dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "PIXIES",
	ui_name = "Sprite Summoning",
	ui_description = "$perkdesc_pixie",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/pixie.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/pixie.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(perk_item, player, item_name)
		
		local tbl = {
			script_source_file="mods/nukes_perks/files/nuke/scripts/pixie_loop.lua",
			execute_on_added="1",
			execute_every_n_frame="240",
			execute_times="-1" }
	
		EntityAddComponent(player, "LuaComponent", tbl) 
		
	end,
})