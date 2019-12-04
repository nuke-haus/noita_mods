dofile("data/scripts/lib/utilities.lua")

local function get_ability_component_from_wand(wand_id)

    local components = EntityGetAllComponents(wand_id)
	
    for i, component_id in ipairs(components) do
	
      for k, v2 in pairs(ComponentGetMembers(component_id)) do
	  
        if (k == "mItemRecoil") then
		
          return component_id
		  
        end
		
      end
	  
    end
	
end

local function buff_wand(wand, rand)

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
		GamePrint("Your wand feels more predictable")
	
	elseif (rand == 2) then -- reload time
	
		ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", reload_time - Random(10,50))
		GamePrint("Your wand feels like it can cast spells faster")
	
	elseif (rand == 3) then -- apr
	
		local num_add = 1
		
		if (Random(1,5) == 1) then -- small chance to get double boost
		
			num_add = 2
		
		end
		
		ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", apr + num_add)
		GamePrint("Your wand feels like it can cast more spells simultaneously")
	
	elseif (rand == 4) then -- rate of fire
	
		ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", fire_rate_wait - Random(10,50))
		GamePrint("Your wand feels like it can cast spells faster")
	
	elseif (rand == 5) then -- spread
	
		ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", spread_degrees - Random(2,10))
		GamePrint("Your wand feels more accurate")
	
	elseif (rand == 6) then -- capacity
	
		if (deck_capacity >= 20) then

			deck_capacity = math.min(deck_capacity + Random(1,3), 25)

		else

			deck_capacity = deck_capacity + Random(1,5)

		end

		ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity)
		GamePrint("Your wand feels like it can hold more spells")
	
	elseif (rand == 7) then -- mana max
	
		ComponentSetValue( ability_comp, "mana_max", mana_max + Random(50,200))
		GamePrint("Your wand feels like it holds more mana")
	
	elseif (rand == 8) then -- mana chrg
	
		ComponentSetValue( ability_comp, "mana_charge_speed", mana_chrg + Random(20,60))
		GamePrint("Your wand feels like it can regenerate mana faster")
	
	end
	
	EntitySetComponentIsEnabled(wand, id, false)

	EntityAddTag(wand, "wand_upgraded")

end

local me = GetUpdatedEntityID()
local childs = EntityGetAllChildren(me)
local upgraded = false
		
for key, child in pairs(childs) do
		
	if EntityGetName(child) == "inventory_quick" then
			
		local wands = EntityGetAllChildren(child)
			
		for key2, wand in pairs(wands) do
		
			if (EntityHasTag(wand, "wand") and EntityHasTag(wand, "wand_upgraded") == false) then
					
				local rand = Random(1,8)
				buff_wand(wand, rand)
				upgraded = true
			
			end
					
		end
				
	end 
			
end

if (upgraded) then

	local x, y = EntityGetTransform(me)
	EntityLoad("mods/nukes_perks/files/nuke/entities/wand_up_effect.xml", x, y)

end

