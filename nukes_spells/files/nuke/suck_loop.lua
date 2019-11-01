dofile( "data/scripts/lib/coroutines.lua" )
dofile( "data/scripts/lib/utilities.lua" )

local RADIUS = 120.0
local MAX_STRENGTH = 65.0
local MIN_STRENGTH = 5.0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local function get_phys_ents(me, x, y, rad)

	local tbl = {}
	local near = EntityGetInRadius(x, y, rad)

	if (near == nil) then

		return tbl

	end

	for k,v in pairs(near) do

		local body = EntityGetComponent(v, "PhysicsBodyComponent")
    
		if (body ~= nil) then

			table.insert(tbl, v)
			
		end

	end

	return tbl

end

async_loop(function()

	local me = GetUpdatedEntityID() -- the projectile
	local x, y = EntityGetTransform(me)

	local props = get_phys_ents(me, x, y, RADIUS)
	local projectiles = EntityGetInRadiusWithTag(x, y, RADIUS, "projectile")

	for i, prop in pairs(props) do

		local x2, y2 = EntityGetTransform(prop)
		local dist = distance(x, y, x2, y2)

		if (dist < RADIUS) then
	
			local scale = 1.0 - (dist / RADIUS)
			local power = scale * MAX_STRENGTH

			if (power < MIN_STRENGTH) then

				power = MIN_STRENGTH

			end

			--local body = EntityGetComponent(prop, "PhysicsBodyComponent")
			--local vel_x, vel_y = PhysicsGetComponentVelocity(prop, body)

			local dir_x = x - x2
			local dir_y = y - y2
					
			local len = length(dir_x, dir_y)

			if (len == 0) then

				len = 0.001

			end
			
			local dir_x = dir_x / len
			local dir_y = dir_y / len

			PhysicsApplyForce(prop, dir_x * power, dir_y * power)

		end

	end

	if (projectiles ~= nil) then

		for i, proj in pairs(projectiles) do

			local x2, y2 = EntityGetTransform(proj)
			local dist = distance(x, y, x2, y2)

			if (dist < RADIUS) then

				local pc = EntityGetComponent(proj, "ProjectileComponent")

				if (pc ~= nil and pc ~= 0) then

					local shooter = ComponentGetValue(pc[1], "mWhoShot")

					if (shooter ~= nil) then

						if IsPlayer(shooter) then

							goto avoid

						end

					end

				end

				local scale = 1.0 - (dist / RADIUS)
				local power = scale * MAX_STRENGTH

				if (power < MIN_STRENGTH) then

					power = MIN_STRENGTH

				end

				local vel_comp = EntityGetComponent(proj, "VelocityComponent")

				edit_component( proj, "VelocityComponent", function(comp,vars)
		
					local vel_x, vel_y = ComponentGetValueVector2( comp, "mVelocity")
			
					local dir_x = x - x2
					local dir_y = y - y2
					
					local len = length(dir_x, dir_y)

					if (len == 0) then

						len = 0.001

					end
			
					local dir_x = dir_x / len
					local dir_y = dir_y / len

					local vel_x_fix = (vel_x * 0.95) + (dir_x * power)
					local vel_y_fix = (vel_y * 0.95) + (dir_y * power)
			
					--local force_x = (velocityX*0.96) + (dir_x * Speed)
					--local force_y = (velocityY*0.96) + (dir_y * Speed)
				
					ComponentSetValueVector2( comp, "mVelocity", vel_x_fix, vel_y_fix )
			
				end)

				::avoid::

			end
			
		end

	end	

	wait(1)

end)
