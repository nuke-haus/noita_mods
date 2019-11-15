
dofile( "data/scripts/lib/utilities.lua" )

local RADIUS = 6.0
local PLAYER_RADIUS = 8.5

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local function shoot( who_shot, entity_file, x, y, send_message, herd )
	local entity_id = EntityLoad( entity_file, x, y )
	if( send_message == nil ) then send_message = true end

	GameShootProjectile( who_shot, x, y, x, y, entity_id, send_message )

	edit_component( entity_id, "ProjectileComponent", function(comp,vars)
		vars.mWhoShot       = who_shot
		vars.mShooterHerdId = herd
	end)

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

local me = GetUpdatedEntityID() -- player
local x, y = EntityGetTransform(me)
local vars = EntityGetComponent(me, "VariableStorageComponent")

if (vars == nil) then

	vars = {}

end

for k,v in pairs(vars) do

	local name = ComponentGetValue(v, "name")
	local str = ComponentGetValue(v, "value_string")

	if (name == "trailstuff") then

		local tbl = {}

		for match in string.gmatch(str, "[^,]+") do

			table.insert(tbl, match)

		end

		local x2 = tonumber(tbl[1])
		local y2 = tonumber(tbl[2])
		local dir_x = x2 - x
		local dir_y = y2 - y
		local len = length(dir_x, dir_y)

		if (len == 0) then

			len = 0.001

		end
			
		dir_x = dir_x / len
		dir_y = dir_y / len

		local pos_x = x + dir_x * PLAYER_RADIUS
		local pos_y = y + dir_y * PLAYER_RADIUS
		local dist = distance(x2, y2, pos_x, pos_y)

		if (dist >= RADIUS) then

			shoot(me, "files/nuke/entities/blob_fire.xml", pos_x, pos_y - 3, nil, get_genome(me))
			ComponentSetValue(v, "value_string", pos_x .. "," .. pos_y)

		end

	end

end
