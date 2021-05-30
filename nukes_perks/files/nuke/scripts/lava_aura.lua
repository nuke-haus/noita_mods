dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "LAVA_AURA",
	ui_name = "Alcoholic Transmutation",
	ui_description = "$perkdesc_lava",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/lava_aura.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/lava_aura.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/nukes_perks/files/nuke/entities/lava_aura.xml", x, y)
		local child_id2 = EntityLoad("mods/nukes_perks/files/nuke/entities/acid_aura.xml", x, y)
		
		EntityAddChild(player, child_id)
		EntityAddChild(player, child_id2)
		
	end,
})