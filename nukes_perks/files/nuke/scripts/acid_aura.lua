dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "ACID_AURA",
	ui_name = "Acid Transmutation",
	ui_description = "You convert nearby acid to oil.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/acid_aura.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/acid_aura.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/nukes_perks/files/nuke/entities/acid_aura.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})