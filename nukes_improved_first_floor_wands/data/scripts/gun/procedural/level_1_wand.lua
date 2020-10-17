dofile("data/scripts/gun/procedural/gun_procedural.lua")


function do_level1( level )

	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y )

	local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

	if( ability_comp == nil ) then
		print_error( "Couldn't find AbilityComponent for entity, it is probably not enabled" )
	end

	local reload_time = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "reload_time"  ) )
	local fire_rate_wait = tonumber( ComponentObjectGetValue( ability_comp, "gunaction_config", "fire_rate_wait" ) )
	local spread_degrees = tonumber( ComponentObjectGetValue( ability_comp, "gunaction_config", "spread_degrees" ) )
	local deck_capacity = tonumber( ComponentObjectGetValue( ability_comp, "gun_config", "deck_capacity" ) )
	local mana_max = tonumber( ComponentGetValue( ability_comp, "mana_max" ) )

	local total = reload_time + fire_rate_wait + spread_degrees
	-- print(total)
	-- print( reload_time + fire_rate_wait + spread_degrees )
	--[[
	ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun["actions_per_round"] )
	ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", gun["deck_capacity"] )
	ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun["shuffle_deck_when_empty"] )
	ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun["spread_degrees"] )
	ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun["speed_multiplier"] )
	]]--

	total = total + Random( -10, 20 )

	local level_1_cards =
	{
		"LIGHT_BULLET",
		"LIGHT_BULLET_TRIGGER", --new
		"LIGHT_BULLET_TIMER", --new
		"SPITTER", --new
		"SPITTER_TIMER", --new
		"BUBBLESHOT", --new
		"BUBBLESHOT_TRIGGER", --new
		"RUBBER_BALL",
		"ARROW",
		"DISC_BULLET",
		"BOUNCY_ORB",
		"BULLET",
		"BULLET_TIMER",
		"AIR_BULLET",
		"SLIMEBALL"
	}	

	-- 0.5
	if( Random( 1, 100 ) <= 85 ) then
		table.insert(level_1_cards, "BUBBLESHOT")
		
		-- 0.25
		if( Random( 1, 100 ) <= 70 ) then
			table.insert(level_1_cards, "SPITTER")
	
			-- 0.125
			if( Random( 1, 100 ) <= 40 ) then
				table.insert(level_1_cards, "LIGHT_BULLET_TRIGGER")
				card_count = 1

				-- 0.0625
				if( Random( 1, 100 ) <= 20 ) then
					table.insert(level_1_cards, "DISC_BULLET_BIG" )
					card_count = 1
					
					-- 0.00625
					if( Random( 1, 100 ) <= 10 ) then
						table.insert(level_1_cards, "TENTACLE_PORTAL" )
						card_count = 1
						if( mana_max < 140 ) then mana_max = 140 end

						-- 0.000625
						if( Random( 1, 100 ) <= 10 ) then
							table.insert(level_1_cards, "BLACK_HOLE_BIG" )
							card_count = 1
							if( mana_max < 240 ) then mana_max = 240 end
						end
					end
				end
			end
		end
	end

	local level_1_mods = 
	{
		"FLY_UPWARDS",
		"FLY_DOWNWARDS",
		"CHAOTIC_ARC",
		"HORIZONTAL_ARC",
		"SINEWAVE",
		"Y_SHAPE",
		"I_SHAPE",
		"T_SHAPE",
		"SCATTER_2",
		"SCATTER_3",
		"BURST_2",
		"BURST_3",
		"LIGHT_BULLET_TRIGGER_2",
		"TORCH_ELECTRIC",
		"TORCH"
	}

	local card_count = Random( 1, 5 ) 

	if ( total > 50 ) then
	
		level_1_cards = 
		{
			"GRENADE",
			"DYNAMITE", --new
			"BOMB",
			"ROCKET"
		}
		
		card_count =  Random( 1, 2 ) 
		
	end

	local do_util = Random( 0, 100 )
	
	if( do_util < 30 ) then
	
		level_1_cards = 
		{
			"CLOUD_WATER",
			"CLOUD_BLOOD", --new
			"MIST_SLIME", --new
			"MIST_BLOOD", --new
			"MIST_ALCOHOL", --new
			"X_RAY",
			"FREEZE_FIELD",
			"LEVITATION_FIELD",
			"SHIELD_FIELD",
			"SUMMON_ROCK",
			"BLACK_HOLE"
		}

		if( Random( 1, 100 ) <= 75 ) then
			table.insert(level_1_cards, "ELECTROCUTION_FIELD")
			if( Random( 1, 100 ) <= 50 ) then
				table.insert(level_1_cards, "DIGGER")

				if( Random( 1, 100 ) <= 50 ) then
					table.insert(level_1_cards, "EXPLODING_DEER")

					if( Random( 1, 100 ) <= 50 ) then
						table.insert(level_1_cards, "POWERDIGGER")

						if( Random( 1, 100 ) <= 50 ) then
							table.insert(level_1_cards, "SOILBALL")

							if( Random( 1, 100 ) <= 50 ) then
								table.insert(level_1_cards, "LUMINOUS_DRILL")

								if( Random( 1, 100 ) <= 50 ) then
									table.insert(level_1_cards, "CHAINSAW")
								end
							end
						end
					end
				end
			end
		end
		
		card_count = 1
		
	end


	if ( card_count > deck_capacity ) then 
	
		card_count = deck_capacity 
		
	end
	
	if ( Random( 0, 100 ) < 15 and card_count > 1 ) then
	
		local mod = RandomFromArray( level_1_mods )
		card_count = card_count - 1
		
		AddGunAction( entity_id, mod )	
	
	end

	local card = RandomFromArray( level_1_cards )

	for i=1,card_count do
	
		AddGunAction( entity_id, card )
		
	end

end

do_level1( 1 )