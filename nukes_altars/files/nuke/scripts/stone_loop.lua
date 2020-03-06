local RADIUS = 135

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

function damage_received(damage, message, entity_thats_responsible, is_fatal)

	if (is_fatal) then

		local me = GetUpdatedEntityID()
		local x, y = EntityGetTransform(me)
		local gorgs = EntityGetWithTag("gorgon")
		local can_spawn = true

		if (gorgs == nil) then

			gorgs = {}

		end

		for k,v in pairs(gorgs) do

			if (v ~= nil and v ~= 0) then

				local px, py = EntityGetTransform(v)
				local dist = distance(px, py, x, y)
		
				if (dist < RADIUS) then

					goto avoid

				end
		
			end
		
		end

		EntityLoad( "mods/nukes_spells/files/nuke/entities/petrify.xml", x, y )

		::avoid::

	end

end

local me = GetUpdatedEntityID()
local bod = EntityGetFirstComponent(me, "PhysicsBodyComponent")
local x, y = EntityGetTransform(me)

if (bod ~= nil and bod ~= 0) then

	local pix = ComponentGetValueInt(bod, "mPixelCount")
		
	if (pix < 40) then 

		EntityConvertToMaterial(me, "acid")
		EntityKill(me)

	end

end