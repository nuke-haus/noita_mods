
table.insert( perk_list,
{
	id = "PERKS_4_SALE",
	ui_name = "Perks For Sale",
	ui_description = "Perks are sometimes available for purchase in the temple shop.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/perks_4_sale.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/perks_4_sale.png",
	func = function(entity_perk_item, player_entity, item_name)

		GlobalsSetValue("PERKS_4_SALE", "true")
		
	end,
})
