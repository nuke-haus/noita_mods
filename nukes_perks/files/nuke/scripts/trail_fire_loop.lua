
dofile( "data/scripts/lib/utilities.lua" )

local RADIUS = 6.0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local function shoot( who_shot, entity_file, x, y, vel_x, vel_y, send_message )
	local entity_id = EntityLoad( entity_file, x, y )
	local herd_id = 0
	if( send_message == nil ) then send_message = true end

	GameShootProjectile( who_shot, x, y, x+vel_x, y+vel_y, entity_id, send_message )

	edit_component( entity_id, "ProjectileComponent", function(comp,vars)
		vars.mWhoShot       = who_shot
		vars.mShooterHerdId = herd_id
	end)

	edit_component( entity_id, "VelocityComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y )
	end)

	return entity_id
end

local me = GetUpdatedEntityID() 
local x, y = EntityGetTransform(me)
local ents = EntityGetInRadiusWithTag(x, y, RADIUS, "fires_trail")

if (ents == nil) then

	ents = {}

end

local skip = false

for k,v in pairs(ents) do

	local x2, y2 = EntityGetTransform(v)
	local dist = distance(x, y, x2, y2)

	if (dist < RADIUS) then

		goto skips

	end

end

shoot(me, "files/nuke/entities/blob_fire.xml", x, y - 3, 0, 0, nil)

::skips::