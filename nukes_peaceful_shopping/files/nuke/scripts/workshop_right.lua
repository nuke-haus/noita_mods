

function temple_spawn_guardian( pos_x, pos_y )

	if( GlobalsGetValue( "TEMPLE_PEACE_WITH_GODS" ) == "1" ) then
		-- peace_with_gods perk
		return
	end

	local guard_spawn_id = EntityGetClosestWithTag( pos_x, pos_y, "guardian_spawn_pos" )
	local guard_x = pos_x
	local guard_y = pos_y

	-- if distance is too far
    if( guard_spawn_id ~= 0  ) then
        
		guard_x, guard_y = EntityGetTransform( guard_spawn_id )
		-- kill the spawn target, so that it doesn't come and haunt us in subsequent spawns
        EntityKill( guard_spawn_id )
        
	end

    EntityLoad( "data/entities/misc/spawn_necromancer_shop.xml", guard_x + 190, guard_y + 110 ) -- move him out of the temple
    
end