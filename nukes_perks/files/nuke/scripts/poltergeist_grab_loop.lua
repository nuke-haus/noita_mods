dofile( "data/scripts/lib/coroutines.lua" )
dofile( "data/scripts/lib/utilities.lua" )

local RADIUS = 110.0
local MAX_STRENGTH = 60.0
local MIN_STRENGTH = 1.0
local CUR_X = 0
local CUR_Y = 0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local function calculate_force_at(body_x, body_y)

    local distance = distance(CUR_X, CUR_Y, body_x, body_y)
    local power = (distance / RADIUS) * MAX_STRENGTH
    
    if (power < MIN_STRENGTH) then

        power = MIN_STRENGTH

    end

    local dir_x = (CUR_X - body_x) / distance 
    local dir_y = (CUR_Y - body_y) / distance
    
    return dir_x * power, dir_y * power

end

local function calculate_force_for_body(entity, body_mass, body_x, body_y, body_vel_x, body_vel_y, body_vel_angular )

    local fx, fy = calculate_force_at(body_x, body_y)

    fx = fx * body_mass * 1.6
    fy = fy * body_mass * 1.6

    return body_x, body_y, fx, fy, 0 -- forcePosX,forcePosY,forceX,forceY,forceAngular

end

async_loop(function()

	local me = GetUpdatedEntityID() 
    local x, y = EntityGetTransform(me)
    CUR_X = x
    CUR_Y = y

    PhysicsApplyForceOnArea(calculate_force_for_body, me, x - RADIUS, y - RADIUS, x + RADIUS, y + RADIUS)

	local projectiles = EntityGetInRadiusWithTag(x, y, RADIUS, "projectile")

	if (projectiles ~= nil) then

		for i, proj in pairs(projectiles) do

			local x2, y2 = EntityGetTransform(proj)
			local dist = distance(x, y, x2, y2)

			if (dist < RADIUS) then

				local pc = EntityGetFirstComponent(proj, "ProjectileComponent")

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

				local vel_comp = EntityGetFirstComponent(proj, "VelocityComponent")

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
