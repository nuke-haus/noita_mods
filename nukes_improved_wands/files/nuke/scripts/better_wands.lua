function generate_gun( cost, level, force_unshuffle )

	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y )

	local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )
	--[[
	local capacity = ComponentObjectGetValue( ability_comp, "gun_config", 			"deck_capacity" )
	local actions = ComponentObjectGetValue( ability_comp, "gun_config", 			"actions_per_round" )
	local reload = ComponentObjectGetValue( ability_comp, "gun_config", 			"reload_time" )
	local shuffle = ComponentObjectGetValue( ability_comp, "gun_config", 			"shuffle_deck_when_empty" )
	local firerate = ComponentObjectGetValue( ability_comp, "gunaction_config", 	"fire_rate_wait" )
	local spread = ComponentObjectGetValue( ability_comp, "gunaction_config", 		"spread_degrees" )
	local bullet_speed = ComponentObjectGetValue( ability_comp, "gunaction_config", "speed_multiplier" )
	]]--

	-- Algorithm overview
	-- We do the generation of these in random order. Each variable, looks at the cost and tries to figure out what's
	-- the maximum random value it can do for that cost
	-- The random order is first the shuffled variables_01, then variables_02, then variables_03

	if( level == 1 ) then
		if( Random(0,100) < 50 ) then
			cost = cost + 5
		end
	end
	cost = cost + Random(-3, 3)
	-- for temp_i=1,25 do
		local gun = { }
		gun["cost"]	= cost
		gun["deck_capacity"] = 0
		gun["actions_per_round"] = 0
		gun["reload_time"] = 0
		gun["shuffle_deck_when_empty"] = 1
		gun["fire_rate_wait"] = 0
		gun["spread_degrees"] = 0
		gun["speed_multiplier"] = 0
		gun["prob_unshuffle"] = 0.1
		gun["prob_draw_many"] = 0.15
		gun["mana_charge_speed"] = 50*level + Random(-5,5*level)
		gun["mana_max"] = 50 + (150 * level) + (Random(-5,5)*10)
		gun["force_unshuffle"] = 0

		p = Random(0,100)
		-- slow mana charger
		if( p < 20 ) then
			gun["mana_charge_speed"] = ( 50*level + Random(-5,5*level) ) / 5
			gun["mana_max"] = ( 50 + (150 * level) + (Random(-5,5)*10) ) * 3

			if( gun["mana_charge_speed"] < 10 ) then
				gun["mana_charge_speed"] = 10
			end
		end

		p = Random(0,100)
		if( p < 15 + level*6 ) then
			gun["force_unshuffle"] = 1
			-- print( "force_unshuffle" ) 
		end

		local is_rare = 0
		p = Random(0,100)
		if( p < 5 ) then
			is_rare = 1
			-- gun["cost"] = gun["cost"] * 2.5
			gun["cost"] = gun["cost"] + 65
			local light_comp = EntityGetFirstComponent( entity_id, "LightComponent" )
			if( light_comp ~= nil ) then
				ComponentSetValue( light_comp, "update_properties", 1)
				ComponentSetValue( light_comp, "r", 128 )
				ComponentSetValue( light_comp, "g", 0 )
				ComponentSetValue( light_comp, "b", 255 )
			end
		end
		-- based on capacity:
		-- deck_capacity, shuffle_deck_when_empty, actions_per_round,
		-- reload_time, fire_rate_wait, spread_degrees, speed_multiplier

		local variables_01 = { "reload_time", "fire_rate_wait", "spread_degrees", "speed_multiplier" }
		local variables_02 = { "deck_capacity" }
		local variables_03 = { "shuffle_deck_when_empty", "actions_per_round" }

		shuffleTable( variables_01 );
		if( gun["force_unshuffle"]~= 1 ) then shuffleTable( variables_03 ); end

		for k,v in pairs(variables_01) do
			apply_random_variable( gun, v )
		end

		for k,v in pairs(variables_02) do
			apply_random_variable( gun, v )
		end

		for k,v in pairs(variables_03) do
			apply_random_variable( gun, v )
		end

		-- Do this in 99% of the cases
		if( gun["cost"] > 5 and Random(0,1000) < 995 ) then
			if( gun["shuffle_deck_when_empty"] == 1 ) then
				gun["deck_capacity"] = gun["deck_capacity"] + ( gun["cost"] / 5 )
				gun["cost"] = 0
			else
				-- I don't know if this is correct or not...?
				gun["deck_capacity"] = gun["deck_capacity"] + ( gun["cost"] / 10 )
				gun["cost"] = 0
			end
		end

		--[[
		for k,v in pairs(gun) do
			print(k, tostring( v ))
		end
		]]--

		local name = ComponentGetValue( ability_comp, "ui_name" )
		if( gun_names ~= nil ) then name = gun_names[Random(1, #gun_names)] .. ' ' .. name end
	-- end
	
	-- debug
	if( force_unshuffle or GlobalsGetValue( "PERK_NO_MORE_SHUFFLE_WANDS", "0" ) == "1" ) then
		gun["shuffle_deck_when_empty"] = 0
	end

	-- fix the unshuffle size 1
	-- TODO( Petri ) - if deck_capacity == 1, we should do a digger or a material gun
	
	-- HAX HAX HAX HAX HAX
	-- OLLI REQUIRED A MAX CLAMP FOR UI
	-- this is so boring
	if( Random( 0, 10000 ) <= 9999 ) then
		gun["deck_capacity"] = clamp( gun["deck_capacity"], 2, 26 )
	end

	if( gun["deck_capacity"] <= 1 ) then
		gun["deck_capacity"] = 2
	end

	if( gun["reload_time"] >= 60 ) then
		
		function random_add_actions_per_round()
			gun["actions_per_round"] = gun["actions_per_round"] + 1
			if( Random( 0, 100 ) < 70 ) then 
				random_add_actions_per_round()
			end
		end

		random_add_actions_per_round()

		if( Random( 0, 100 ) < 50 ) then 
			-- gun["actions_per_round"] = Random( gun["actions_per_round"], gun["deck_capacity"] )
			local new_actions_per_round = gun["deck_capacity"]
			for i=1,6 do
				local temp_actions_per_round = Random( gun["actions_per_round"], gun["deck_capacity"] )
				if( temp_actions_per_round < new_actions_per_round ) then
					new_actions_per_round = temp_actions_per_round
				end
			end
			gun["actions_per_round"] = new_actions_per_round

		end
		
	end

	gun["actions_per_round"] = clamp( gun["actions_per_round"], 1, gun["deck_capacity"] )

	-- SetItemSprite( entity_id, ability_comp, "data/items_gfx/gungen_guns/submachinegun_", Random( 0, 7 ) )
	ComponentSetValue( ability_comp, "ui_name", name )
	ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun["actions_per_round"] )
	ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", gun["reload_time"] )
	ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", gun["deck_capacity"] )
	ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun["shuffle_deck_when_empty"] )
	ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", gun["fire_rate_wait"] )
	ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun["spread_degrees"] )
	ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun["speed_multiplier"] )
	ComponentSetValue( ability_comp, "mana_charge_speed", gun["mana_charge_speed"])
	ComponentSetValue( ability_comp, "mana_max", gun["mana_max"])
	ComponentSetValue( ability_comp, "mana", gun["mana_max"])

	ComponentSetValue( ability_comp, "item_recoil_recovery_speed", 15.0 ) -- TODO: implement logic for setting this

	-- stuff in the gun
	local good_cards = 5
	if( Random(0,100) < 7 ) then good_cards = Random(20,50) end

	if( is_rare == 1 ) then
		good_cards = good_cards * 2
	end

	local orig_level = level
	level = level - 1
	local deck_capacity = gun["deck_capacity"]
	local actions_per_round = gun["actions_per_round"]
	local card_count = Random( 1, 3 ) 
	local bullet_card = GetRandomActionWithType( x, y, level, ACTION_TYPE_PROJECTILE, 0 )
	local random_bullets = 0 
	local good_card_count = 0

	if( Random(0,100) < 50 and card_count < 3 ) then card_count = card_count + 1 end 
	
	if( Random(0,100) < 10 or is_rare == 1 ) then 
		card_count = card_count + Random( 1, 2 )
	end

	good_cards = Random( 5, 45 )
	card_count = Random( 0.51 * deck_capacity, deck_capacity )
	card_count = clamp( card_count, 1, deck_capacity-1 )

	-- card count is in between 1 and 6

	if( Random(0,100) < (orig_level*10)-5 ) then
		random_bullets = 1
	end

	if( Random( 0, 100 ) < 4 or is_rare == 1 ) then
		local card = 0
		local p = Random(0,100) 
		if( p < 77 ) then
			card = GetRandomActionWithType( x, y, level+1, ACTION_TYPE_MODIFIER, 666 )
		elseif( p < 94 ) then
			card = GetRandomActionWithType( x, y, level+1, ACTION_TYPE_DRAW_MANY, 666 )
			good_card_count = good_card_count + 1
		else 
			card = GetRandomActionWithType( x, y, level+1, ACTION_TYPE_PROJECTILE, 666 )
		end
		AddGunActionPermanent( entity_id, card )
	end

	if (card_count == 1) then -- special case for 1 spell slot REEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

		AddGunAction( entity_id, bullet_card )

	else -- all other cases

		for i=1,card_count do
			if( Random(0,100) < good_cards ) then
				-- if actions_per_round == 1 and the first good card, then make sure it's a draw x
				local card = 0
				if( good_card_count == 0 and actions_per_round == 1 ) then
					card = GetRandomActionWithType( x, y, level, ACTION_TYPE_DRAW_MANY, i )
					good_card_count = good_card_count + 1
				else
					if( Random(0,100) < 83 ) then
						card = GetRandomActionWithType( x, y, level, ACTION_TYPE_MODIFIER, i )
					else
						card = GetRandomActionWithType( x, y, level, ACTION_TYPE_DRAW_MANY, i )
					end
				end
			
				AddGunAction( entity_id, card )
			else
				AddGunAction( entity_id, bullet_card )
				if( random_bullets == 1 ) then
					bullet_card = GetRandomActionWithType( x, y, level, ACTION_TYPE_PROJECTILE, i )
				end
			end
		end
	end

	-- Set wand sprite
	-- print(gun)
	--[[
	print("gun[\"fire_rate_wait\"] = ", gun["fire_rate_wait"] )
	print("gun[\"actions_per_round\"] = ", gun["actions_per_round"] )
	print("gun[\"shuffle_deck_when_empty\"] = ", gun["shuffle_deck_when_empty"] )
	print("gun[\"deck_capacity\"] = ", gun["deck_capacity"] )
	print("gun[\"spread_degrees\"] = ", gun["spread_degrees"] )
	print("gun[\"reload_time\"] = 	", gun["reload_time"]	 )
	]]--

	local wand = GetWand( gun )
	-- local wand = RandomFromArray(wands)

	SetWandSprite( entity_id, ability_comp, wand.file, wand.grip_x, wand.grip_y, (wand.tip_x - wand.grip_x), (wand.tip_y - wand.grip_y) )
	-- SetItemSprite( entity_id, ability_comp, "data/items_gfx/wands/wand_", Random( 0, 999 ) )

	-- this way:
	-- AddGunActionPermanent( entity_id, "ELECTRIC_CHARGE" )
end
