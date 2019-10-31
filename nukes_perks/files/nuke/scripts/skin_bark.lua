dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "SKIN_BARK",
	ui_name = "Barkskin",
	ui_description = "Physical damage is reduced by 20%. You have become vulnerable to fire.",
	ui_icon = "mods/more_perks/files/nuke/perks_gfx/ui/skin_bark.png",
	perk_icon = "mods/more_perks/files/nuke/perks_gfx/ig/skin_bark.png",
	--not_in_default_perk_pool = cfg_disable_wandbuff,
	func = function( entity_perk_item, entity_who_picked, item_name )
		
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		local dmg_types = {"ice", "electricity", "slice", "projectile", "physics_hit", "explosion", "melee", "drill"}
		
		if( damagemodels ~= nil ) then
		
			for i,damagemodel in ipairs(damagemodels) do
			
				for k,dmg in pairs(dmg_types) do
				
					local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", dmg ))
					resistance = resistance * 0.8
					ComponentObjectSetValue( damagemodel, "damage_multipliers", dmg, tostring(resistance) )
					
				end
				
				local fire = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "fire" ))
				fire = fire * 2.5
				ComponentObjectSetValue( damagemodel, "damage_multipliers", "fire", tostring(fire) )
				
				ComponentSetValue( damagemodel, "fire_damage_ignited_amount", "2" )
				ComponentSetValue( damagemodel, "fire_probability_of_ignition", "0.8" )
				
			end
		end
			
	end,
		
})
