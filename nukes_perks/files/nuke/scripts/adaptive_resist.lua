dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "ADAPTIVE_PROTECTION",
	ui_name = "Adaptive Protection",
	ui_description = "When you take damage, you gain a temporary resistance to that damage type.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/adaptive.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/adaptive.png",
	func = function( entity_perk_item, player, item_name )

		local tbl = {
			script_source_file="",
			script_damage_received="files/nuke/scripts/adaptive_loop.lua",
			execute_on_added="0",
			execute_every_n_frame="-1",
			execute_times="-1" }
	
		EntityAddComponent(player, "LuaComponent", tbl) 

		local tbl2 = {
			name="adaptive_resist",
			value_string="" }

		EntityAddComponent(player, "VariableStorageComponent", tbl2)

		local tbl3 = {
			name="adaptive_resist_time",
			value_string="0" }

		EntityAddComponent(player, "VariableStorageComponent", tbl3)
			
	end,
		
})
