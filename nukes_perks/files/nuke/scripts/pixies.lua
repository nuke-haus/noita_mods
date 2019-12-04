dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "PIXIES",
	ui_name = "Sprite Summoning",
	ui_description = "Mischievous sprites are summoned to fight for you.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/pixie.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/pixie.png",
	game_effect = "PROTECTION_FIRE",
	func = function(perk_item, player, item_name)
		
		local tbl = {
			script_source_file="mods/nukes_perks/files/nuke/scripts/pixie_loop.lua",
			execute_on_added="1",
			execute_every_n_frame="200",
			execute_times="-1" }
	
		EntityAddComponent(player, "LuaComponent", tbl) 
		
	end,
})