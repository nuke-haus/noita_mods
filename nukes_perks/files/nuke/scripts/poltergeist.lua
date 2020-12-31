dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "POLTERGEIST",
	ui_name = "Poltergeist Summoning",
	ui_description = "Poltergeists are summoned to fight for you.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/polter.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/polter.png",
	func = function(perk_item, player, item_name)
		
		local tbl = {
			script_source_file="mods/nukes_perks/files/nuke/scripts/polter_loop.lua",
			execute_on_added="1",
			execute_every_n_frame="180", -- 3 seconds
			execute_times="-1" }
	
		EntityAddComponent(player, "LuaComponent", tbl) 
		
	end,
})