dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

function get_random_from( target )
	local rnd = Random(1, #target)
	
	return tostring(target[rnd])
end

function get_multiple_random_from( target, amount_ )
	local amount = amount_ or 1
	
	local result = {}
	
	for i=1,amount do
		local rnd = Random(1, #target)
		
		table.insert(result, tostring(target[rnd]))
	end
	
	return result
end

function get_random_between_range( target )
	local minval = target[1]
	local maxval = target[2]
	
	return Random(minval, maxval)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y )

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

local gun = { }
gun.name = {"Bolt staff"}
gun.deck_capacity = {2,3}
gun.actions_per_round = 1
gun.reload_time = {20,30}
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = {10,15}
gun.spread_degrees = 0
gun.speed_multiplier = 1
gun.mana_charge_speed = {25,40}
gun.mana_max = {100,140}
gun.actions = { "LIGHT_BULLET", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TIMER", "SPITTER", "SPITTER_TIMER", "RUBBER_BALL", "ARROW"}

if ( Random(1,3) == 1 ) then

	table.insert( gun.actions, "DISC_BULLET" )
	table.insert( gun.actions, "BOUNCY_ORB" )
	table.insert( gun.actions, "BULLET" )
	table.insert( gun.actions, "LIGHT_BULLET_TRIGGER_2" )
	table.insert( gun.actions, "BUBBLESHOT" )
	table.insert( gun.actions, "BUBBLESHOT_TRIGGER" )

end

local gun_action = get_random_from( gun.actions )
local mana_max = get_random_between_range( gun.mana_max )
local deck_capacity = get_random_between_range( gun.deck_capacity )
local action_count = math.min( Random( 1, 3 ), tonumber( deck_capacity ) )

if ( gun_action == "BOUNCY_ORB" or gun_action == "DISC_BULLET" or gun_action == "BULLET" ) then

	gun.reload_time = {45,55}
	gun.fire_rate_wait = {30,45}
	deck_capacity = math.min( 2, deck_capacity )
	action_count = 1

elseif ( gun_action == "RUBBER_BALL" ) then

	deck_capacity = math.max( 2, deck_capacity )
	action_count = math.max( 2, action_count )

elseif ( gun_action == "BUBBLESHOT" or gun_action == "BUBBLESHOT_TRIGGER" ) then

	gun.spread_degrees = -14
	gun.reload_time = {15,25}

elseif ( gun_action == "LIGHT_BULLET_TRIGGER" or gun_action == "LIGHT_BULLET_TIMER" ) then

	gun.reload_time = {30,40}
	deck_capacity = math.max( 2, deck_capacity )
	action_count = math.max( 2, action_count )

elseif ( gun_action == "SPITTER_TIMER" or gun_action == "SPITTER" ) then

	gun.reload_time = {40,50}
	deck_capacity = math.max( 2, deck_capacity )
	action_count = Random( 1, deck_capacity )
	gun.spread_degrees = -1

elseif ( gun_action == "LIGHT_BULLET_TRIGGER_2" ) then

	gun.reload_time = {30,40}
	deck_capacity = math.max( 2, deck_capacity )
	action_count = Random( 1, deck_capacity )

elseif ( gun_action == "LIGHT_BULLET" ) then

	deck_capacity = math.max( 2, deck_capacity )
	action_count = math.max( 2, action_count )

elseif ( gun_action == "ARROW" ) then

	gun.reload_time = {35,45}

end

ComponentSetValue( ability_comp, "ui_name", get_random_from( gun.name ) )

ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", get_random_between_range( gun.reload_time ) )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", get_random_between_range( gun.fire_rate_wait ) )
ComponentSetValue( ability_comp, "mana_charge_speed", get_random_between_range( gun.mana_charge_speed) )

ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun.actions_per_round )
ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun.speed_multiplier )

ComponentSetValue( ability_comp, "mana_max", mana_max )
ComponentSetValue( ability_comp, "mana", mana_max )

for i=1, action_count do

	AddGunAction( entity_id, gun_action )
	
end
