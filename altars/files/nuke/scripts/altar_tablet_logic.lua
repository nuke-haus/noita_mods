
local RADIUS = 30.0

local function get_valid_ents(me, x, y, rad)

	local bad = {}
	local good = {}
	local near = EntityGetInRadius(x, y, rad)

	if (near == nil) then

		return good

	end

	for k,v in pairs(near) do

		local is_good = false
		local parent = EntityGetParent(v) 

		if (EntityHasTag(v, "tablet") and (parent == nil or parent == 0)) then

			table.insert(good, v)
			is_good = true

		end
		
		local body = EntityGetComponent(v, "PhysicsBodyComponent")
    
		if ((parent == nil or parent == 0) and is_good == false and (body ~= nil or EntityHasTag(v, "item_physics"))) then

			table.insert(bad, v)

		end

	end

	return good, bad

end


local me = GetUpdatedEntityID() 
local x, y = EntityGetTransform(me)
local good, bad = get_valid_ents(me, x, y, RADIUS)

for k,v in pairs(good) do

	local x2, y2 = EntityGetTransform(v)

	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x2, y2)
	EntityLoad("data/entities/items/pickup/heart.xml", x2, y2)

	EntityConvertToMaterial(v, "sand_herb")
	EntityKill(v)

end

for k,v in pairs(bad) do

	GamePrintImportant("The gods are displeased", "")

	EntityLoad("data/entities/particles/image_emitters/altar_tablet_curse_symbol.xml", x, y)
	EntityLoad("files/nuke/entities/collapser.xml", x, y)

	EntityConvertToMaterial(v, "blood")
	EntityKill(v)

	EntityKill(me)

	return

end