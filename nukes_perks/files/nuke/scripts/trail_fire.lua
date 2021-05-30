dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "TRAIL_MAGIC_FIRE",
	ui_name = "Burning Afterimage",
	ui_description = "$perkdesc_firetrail",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/trail_fire.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/trail_fire.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = true,
	func = function(perk_item, player, item_name)

		local tbl = {
			script_source_file="mods/nukes_perks/files/nuke/scripts/trail_fire_loop.lua",
			execute_on_added="1",
			execute_every_n_frame="2",
			execute_times="-1" }
	
		EntityAddComponent(player, "LuaComponent", tbl ) 

		local tbl2 = {
			name="trailstuff",
			value_string="0,0" }

		EntityAddComponent(player, "VariableStorageComponent", tbl2)
		
	end,
})