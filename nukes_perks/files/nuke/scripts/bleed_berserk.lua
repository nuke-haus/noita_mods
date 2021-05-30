dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "BLEED_BERSERK",
	ui_name = "Berserker Blood",
	ui_description = "$perkdesc_berserkb",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/berz_blood.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/berz_blood.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		
		if( damagemodels ~= nil ) then
		
			for i,damagemodel in ipairs(damagemodels) do
			
				ComponentSetValue( damagemodel, "blood_material", "magic_liquid_berserk" )
				ComponentSetValue( damagemodel, "blood_spray_material", "magic_liquid_berserk" )
				ComponentSetValue( damagemodel, "blood_multiplier", "5.5" )
				ComponentSetValue( damagemodel, "blood_sprite_directional", "mods/nukes_perks/files/nuke/perks_gfx/bloodsplatter_directional_purple_1.xml" )
				ComponentSetValue( damagemodel, "blood_sprite_large", "mods/nukes_perks/files/nuke/perks_gfx/bloodsplatter_purple_1.xml" )

				local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "slice" ))
				resistance = resistance * 0.6
				ComponentObjectSetValue( damagemodel, "damage_multipliers", "slice", tostring(resistance) )
				
			end
			
		end
			
	end,
		
})


