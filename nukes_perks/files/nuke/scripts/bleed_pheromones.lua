dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "BLEED_PHEROMONES",
	ui_name = "Pheromone Blood",
	ui_description = "You bleed pheromones.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/pher_blood.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/pher_blood.png",
	--not_in_default_perk_pool = cfg_disable_wandbuff,
	func = function( entity_perk_item, entity_who_picked, item_name )
		
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		
		if( damagemodels ~= nil ) then
		
			for i,damagemodel in ipairs(damagemodels) do
			
				ComponentSetValue( damagemodel, "blood_material", "magic_liquid_charm" )
				ComponentSetValue( damagemodel, "blood_spray_material", "magic_liquid_charm" )
				ComponentSetValue( damagemodel, "blood_multiplier", "4" )
				ComponentSetValue( damagemodel, "blood_sprite_directional", "mods/nukes_perks/files/nuke/perks_gfx/bloodsplatter_directional_purple_1.xml" )
				ComponentSetValue( damagemodel, "blood_sprite_large", "mods/nukes_perks/files/nuke/perks_gfx/bloodsplatter_purple_1.xml" )
				
				local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "melee" ))
				resistance = resistance * 0.6
				ComponentObjectSetValue( damagemodel, "damage_multipliers", "melee", tostring(resistance) )
				
			end
			
		end
			
	end,
		
})


