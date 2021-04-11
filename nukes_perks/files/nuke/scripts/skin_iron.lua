dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "SKIN_IRON",
	ui_name = "Ironskin",
	ui_description = "Physical damage is reduced by 20%. You have become vulnerable to electricity.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/skin_iron.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/skin_iron.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function( entity_perk_item, entity_who_picked, item_name )
		
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		local dmg_types = {"ice", "fire", "slice", "projectile", "physics_hit", "explosion", "melee", "drill"}
		
		if( damagemodels ~= nil ) then
		
			for i,damagemodel in ipairs(damagemodels) do
			
				for k,dmg in pairs(dmg_types) do
				
					local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", dmg ))
					resistance = resistance * 0.8
					ComponentObjectSetValue( damagemodel, "damage_multipliers", dmg, tostring(resistance) )
					
				end
				
				local el = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "electricity" ))
				el = el * 2.0
				ComponentObjectSetValue( damagemodel, "damage_multipliers", "electricity", tostring(el) )
				
			end
		end
			
	end,
		
})
