dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "STOMPY",
	ui_name = "Tremor Step",
	ui_description = "The earth crumbles beneath your feet.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/tremor.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/tremor.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
	func = function(entity_perk_item, player_entity, item_name)
	
		local data = get_data_comp(player_entity)
	
		ComponentSetValue(data, "destroy_ground", 100)
		ComponentSetValue(data, "eff_hg_damage_max", 600)
		ComponentSetValue(data, "eff_hg_damage_min", 500)
		ComponentSetValue(data, "eff_hg_size_x", 5)
		ComponentSetValue(data, "eff_hg_size_y", 5)
		
	end,
})

function get_data_comp(id)

    local components = EntityGetAllComponents(id)
	
    for i, component_id in ipairs(components) do
	
      for k, v2 in pairs(ComponentGetMembers(component_id)) do
	  
        if (k == "mFramesOnGround") then
		
          return component_id
		  
        end
		
      end
	  
    end
	
end