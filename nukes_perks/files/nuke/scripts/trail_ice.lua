dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "TRAIL_MAGIC_ICE",
	ui_name = "Freezing Afterimage",
	ui_description = "You leave a trail of freezing magic wherever you go.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/trail_ice.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/trail_ice.png",
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("files/nuke/entities/trail_ice.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})