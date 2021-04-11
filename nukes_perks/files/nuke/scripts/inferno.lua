dofile( "data/scripts/lib/utilities.lua" )

table.insert( perk_list, 
{
	id = "INFERNO_AURA",
	ui_name = "Inferno",
	ui_description = "You are immune to fire, but you are constantly shrouded in flames.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/inferno.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/inferno.png",
	game_effect = "PROTECTION_FIRE",
	stackable = STACKABLE_NO,
	usable_by_enemies = true,
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/nukes_perks/files/nuke/entities/inferno.xml", x, y)
		
		EntityAddChild(player, child_id)
		
	end,
})