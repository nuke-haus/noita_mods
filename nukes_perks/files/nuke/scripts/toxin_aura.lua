dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "TOX_AURA",
	ui_name = "Toxin Transmutation",
	ui_description = "You convert nearby poison and toxic sludge to water.",
	ui_icon = "mods/more_perks/files/nuke/perks_gfx/ui/toxin_aura.png",
	perk_icon = "mods/more_perks/files/nuke/perks_gfx/ig/toxin_aura.png",
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/more_perks/files/nuke/entities/toxin_aura.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})