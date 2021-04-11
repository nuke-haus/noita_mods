dofile( "data/scripts/lib/utilities.lua" )

local function shoot( who_shot, entity_file, x, y, send_message, herd )

    local entity_id = EntityLoad( entity_file, x, y )
    
	if( send_message == nil ) then send_message = true end
    
    PhysicsApplyForce( entity_id, 0, -30 )

    return entity_id
    
end

local me = GetUpdatedEntityID()
local x,y = EntityGetTransform(me)
local tbl = EntityGetWithTag("gorgon_stonebaby")
local players = EntityGetWithTag("player_unit")

if (#players > 0) then

    local player = players[1]

    if (tbl1 == nil or #tbl1 == 0) then
    
        shoot(player, "mods/nukes_perks/files/nuke/entities/stone_babygorgon_physics.xml", x, y, nil, genome)
    
        return
    
    end
        
end
