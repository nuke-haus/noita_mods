
local RADIUS = 30.0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local function get_valid_ents(me, x, y, rad)

	local tbl = {}
	local near = EntityGetWithTag("tablet")

	if (near == nil) then

		return tbl

	end

	for k,v in pairs(near) do

		local x2, y2 = EntityGetTransform(v)
		local dist = distance(x, y, x2, y2)
		local parent = EntityGetParent(v) 
    
		if (dist < rad and (parent == nil or parent == 0)) then

			table.insert(tbl, v)

		end

	end

	return tbl

end


local me = GetUpdatedEntityID() 
local x, y = EntityGetTransform(me)
local ents = get_valid_ents(me, x, y, RADIUS)

for k,v in pairs(ents) do

	GamePrintImportant("The gods are displeased", "")

	EntityConvertToMaterial( v, "blood")
	EntityKill( v )

	EntityLoad("data/entities/particles/image_emitters/altar_tablet_curse_symbol.xml", x, y)
	EntityLoad("files/nuke/entities/collapser.xml", x, y)

	EntityKill(me)

	return

end