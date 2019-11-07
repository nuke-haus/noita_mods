
dofile( "data/scripts/lib/utilities.lua" )

local RADIUS = 6.0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local me = GetUpdatedEntityID() -- the player
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

local blob = EntityLoad("files/nuke/entities/blob_fire.xml", x, y - 3)

edit_component(blob, "ProjectileComponent", function(comp,vars)
	vars.mWhoShot       = me
	vars.mShooterHerdId = get_herd_id(me)
end)

::skips::