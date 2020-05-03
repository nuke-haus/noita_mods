
local POWER = 250

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

function throw_item(x2, y2, x, y)

	local me = GetUpdatedEntityID() 
	EntityKill(me)

	local dir_x = x - x2
	local dir_y = y - y2	
	local len = length(dir_x, dir_y)

	if (len == 0) then

		len = 0.001

	end

	local players = EntityGetWithTag("player_unit")

	if (#players > 0) then

		local player = players[1]
		  
		local dir_x = dir_x / len
		local dir_y = dir_y / len
		local projectile = EntityLoad("mods/nukes_more_stones/files/nuke/entities/chakram.xml", x2, y2)
		GameShootProjectile(player, x2, y2, x, y, projectile, true)
		local pc = EntityGetFirstComponent(projectile, "VelocityComponent")
	  
		ComponentSetValueVector2(pc, "mVelocity", dir_x * POWER, dir_y * POWER )

		local tbl = {
			name="chakram",
			value_string="0,0" }

		EntityAddComponent(projectile, "VariableStorageComponent", tbl)

	end

end

