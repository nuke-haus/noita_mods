dofile( "data/scripts/lib/utilities.lua" )

local new_list = {}

for k,v in pairs(perk_list) do

	if (v.id ~= "PROJECTILE_REPULSION") then

		table.insert(new_list, v)

	end

end

table.insert( new_list, 
{
	id = "REPEL_FIELD",
	ui_name = "Repelling Field",
	ui_description = "An invisible field pushes objects and projectiles away from you, but you feel more frail.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/repel_field.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/repel_field.png",
	func = function(perk_item, player, item_name)
		
		local x,y = EntityGetTransform(player)
		local child_id = EntityLoad("mods/nukes_perks/files/nuke/entities/repel_field.xml", x, y)
		
		EntityAddChild(player, child_id)

		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		local dmg_types = {"ice", "slice", "projectile", "physics_hit", "explosion", "melee", "drill"}
		
		if( damagemodels ~= nil ) then
		
			for i,damagemodel in ipairs(damagemodels) do
			
				for k,dmg in pairs(dmg_types) do
				
					local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", dmg ))
					resistance = resistance * 1.2
					ComponentObjectSetValue( damagemodel, "damage_multipliers", dmg, tostring(resistance) )
					
				end
				
			end
		end
		
	end,
})

perk_list = new_list