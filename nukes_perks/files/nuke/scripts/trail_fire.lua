dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "TRAIL_MAGIC_FIRE",
	ui_name = "Burning Afterimage",
	ui_description = "You leave a trail of magical flames wherever you go.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/trail_fire.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/trail_fire.png",
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("files/nuke/entities/trail_fire.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})