dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "REPEL_FIELD",
	ui_name = "Repulsion Field",
	ui_description = "$perkdesc_field",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/repel_field.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/repel_field.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/nukes_perks/files/nuke/entities/repel_field.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})