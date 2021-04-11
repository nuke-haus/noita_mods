dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "TOX_AURA",
	ui_name = "Alchemical Transmutation",
	ui_description = "You purify nearby toxins and convert harmful magical liquids to safer magical liquids.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/toxin_aura.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/toxin_aura.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/nukes_perks/files/nuke/entities/toxin_aura.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})