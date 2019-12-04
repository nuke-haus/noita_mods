dofile( "data/scripts/lib/utilities.lua" )

local function shoot( who_shot, entity_file, x, y, send_message, herd )
	local entity_id = EntityLoad( entity_file, x, y )
	if( send_message == nil ) then send_message = true end

	GameShootProjectile( who_shot, x, y, x, y, entity_id, send_message )

	edit_component( entity_id, "ProjectileComponent", function(comp,vars)
		vars.mWhoShot       = who_shot
		vars.mShooterHerdId = herd
    end)
    
    PhysicsApplyForce( entity_id, 0, -30 )

	return entity_id
end

local function get_genome(player)

	local test = EntityGetFirstComponent(player, "GenomeDataComponent");
	local herd = ComponentGetMetaCustom(test, "herd_id") or "none"

	if (herd == "rat") then

		return 17

	else

		return 0

	end

end

local me = GetUpdatedEntityID()
local x,y = EntityGetTransform(me)
local genome = get_genome(me)
local tbl1 = EntityGetWithTag( "pixie_fire" )
local tbl2 = EntityGetWithTag( "pixie_ice" )
local tbl3 = EntityGetWithTag( "pixie_electric" )
local tbl4 = EntityGetWithTag( "pixie_poison" )
local did, dx, dy = Raytrace( x, y, x, y - 10 )

if (did) then

    y = dy + 2

else

    y = y - 10

end

if (Random(1,2) == 1) then

    if (tbl1 == nil or #tbl1 == 0) then

        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_fire.xml", x, y, nil, genome)
    
        return
    
    end
    
    if (tbl2 == nil or #tbl2 == 0) then
    
        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_ice.xml", x, y, nil, genome)
    
        return
    
    end
    
    if (tbl3 == nil or #tbl3 == 0) then
    
        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_electric.xml", x, y, nil, genome)
    
        return
    
    end
    
    if (tbl4 == nil or #tbl4 == 0) then
    
        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_poison.xml", x, y, nil, genome)
    
        return
    
    end

else

    if (tbl4 == nil or #tbl4 == 0) then
    
        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_poison.xml", x, y, nil, genome)
    
        return
    
    end

    if (tbl3 == nil or #tbl3 == 0) then
    
        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_electric.xml", x, y, nil, genome)
    
        return
    
    end

    if (tbl2 == nil or #tbl2 == 0) then
    
        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_ice.xml", x, y, nil, genome)
    
        return
    
    end

    if (tbl1 == nil or #tbl1 == 0) then

        shoot(me, "mods/nukes_perks/files/nuke/entities/pixie_fire.xml", x, y, nil, genome)
    
        return
    
    end
    
end

