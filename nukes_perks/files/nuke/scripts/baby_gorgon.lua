dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "BABY_GORGON",
	ui_name = "Gorgon Summoning",
	ui_description = "$perkdesc_babygorgon",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/gorgon.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/gorgon.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(perk_item, player, item_name)
		
		local tbl = {
			script_source_file="mods/nukes_perks/files/nuke/scripts/baby_gorg_summon_loop.lua",
			execute_on_added="1",
			execute_every_n_frame="30",
			execute_times="-1" }
	
		EntityAddComponent(player, "LuaComponent", tbl) 
		
	end,
})