dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "WAND_BUFF",
	ui_name = "Upgraded Wands",
	ui_description = "Your wands have become more powerful.",
	ui_icon = "mods/more_perks/files/nuke/perks_gfx/ui/wand_buff.png",
	perk_icon = "mods/more_perks/files/nuke/perks_gfx/ig/wand_buff.png",
	--not_in_default_perk_pool = cfg_disable_wandbuff,
	func = function(entity_perk_item, player_entity, item_name)
	
		local childs = EntityGetAllChildren(player_entity)
		
		for key, child in pairs(childs) do
		
			if EntityGetName(child) == "inventory_quick" then
			
				local wands = EntityGetAllChildren(child)
			
				for key2, wand in pairs(wands) do
		
					if EntityHasTag(wand, "wand") then
					
						local rand = Random(1,8)
						buff_wand(wand, rand)
						
						if (Random(1,4) == 1) then -- 25% chance you get a double buff
						
							local rand2 = Random(2,8)
							
							while (rand2 == rand1) do
							
								rand2 = Random(2,8)
							
							end
						
							buff_wand(wand, rand2)
						
						end
					
					end
					
				end
				
			end 
			
		end
		
	end,
})

function get_ability_component_from_wand(wand_id)

    local components = EntityGetAllComponents(wand_id)
	
    for i, component_id in ipairs(components) do
	
      for k, v2 in pairs(ComponentGetMembers(component_id)) do
	  
        if (k == "mItemRecoil") then
		
          return component_id
		  
        end
		
      end
	  
    end
	
end


function buff_wand(wand, rand)

	local id = get_ability_component_from_wand(wand)
	EntitySetComponentIsEnabled(wand, id, true)

	local ability_comp = EntityGetFirstComponent(wand, "AbilityComponent")

	if( ability_comp == nil ) then
	
		print_error( "Couldn't find AbilityComponent for entity, it is probably not enabled" )
		return
		
	end

	local shuffle = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "shuffle_deck_when_empty" ) )
	local reload_time = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "reload_time"  ) )
	local apr = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "actions_per_round"  ) )
	local fire_rate_wait = tonumber( ComponentObjectGetValue( ability_comp, "gunaction_config", "fire_rate_wait" ) )
	local spread_degrees = tonumber( ComponentObjectGetValue( ability_comp, "gunaction_config", "spread_degrees" ) )
	local deck_capacity = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "deck_capacity" ) )
	local mana_max = tonumber( ComponentGetValue( ability_comp, "mana_max" ) )
	local mana_chrg = tonumber( ComponentGetValue( ability_comp, "mana_charge_speed" ) )
	
	if (rand == 1 and shuffle == 0) then
	
		rand = Random(2,8)
	
	end
	
	if (rand == 1) then -- shuffle becomes no shuffle
	
		ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", 0)
	
	elseif (rand == 2) then -- reload time
	
		ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", reload_time - Random(10,50))
	
	elseif (rand == 3) then -- apr
	
		local num_add = 1
		
		if (Random(1,5) == 1) then -- small chance to get double boost
		
			num_add = 2
		
		end
		
		ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", apr + num_add)
	
	elseif (rand == 4) then -- rate of fire
	
		ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", fire_rate_wait - Random(10,50))
	
	elseif (rand == 5) then -- spread
	
		ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", spread_degrees - Random(2,10))
	
	elseif (rand == 6) then -- capacity
	
		ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity + Random(1,5))
	
	elseif (rand == 7) then -- mana max
	
		ComponentSetValue( ability_comp, "mana_max", mana_max + Random(50,250))
	
	elseif (rand == 8) then -- mana chrg
	
		ComponentSetValue( ability_comp, "mana_charge_speed", mana_chrg + Random(20,80))
	
	end
	
	EntitySetComponentIsEnabled(wand, id, false)

end