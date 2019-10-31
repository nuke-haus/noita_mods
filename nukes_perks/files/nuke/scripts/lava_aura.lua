dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "LAVA_AURA",
	ui_name = "Lava Transmutation",
	ui_description = "You convert nearby lava to alcohol.",
	ui_icon = "mods/more_perks/files/nuke/perks_gfx/ui/lava_aura.png",
	perk_icon = "mods/more_perks/files/nuke/perks_gfx/ig/lava_aura.png",
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/more_perks/files/nuke/entities/lava_aura.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})