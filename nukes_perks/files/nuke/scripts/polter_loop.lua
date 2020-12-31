
local RADIUS = 100.0
local MINDIST = 20.0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function get_phys_ents(me, x, y, rad)

	local tbl = {}
	local near = EntityGetInRadius(x, y, rad)

	if (near == nil) then

		return tbl

	end

	for k,v in pairs(near) do

        local body = EntityGetFirstComponent(v, "PhysicsBodyComponent")
        local body2 = EntityGetFirstComponent(v, "PhysicsBody2Component")
        local x2, y2 = EntityGetTransform(v)
        local valid = (body ~= nil and body ~= 0) or (body2 ~= nil and body2 ~= 0)
        
        if (valid and distance(x, y, x2, y2) > MINDIST) then
    
            table.insert(tbl, v)
                
        end

	end

	return tbl

end

local function summon(me, x, y, ent)

    EntityLoad("mods/nukes_perks/files/nuke/entities/polter_portal.xml", x, y)
    EntityLoad("mods/nukes_perks/files/nuke/entities/poltergeist.xml", x, y)

end

local me = GetUpdatedEntityID()
local x,y = EntityGetTransform(me)
local alive = EntityGetWithTag( "poltergeist" ) or {}

if (#alive < 1) then

    local tbl = get_phys_ents(me, x, y, RADIUS);

    if (#tbl ~= 0) then

        local ent = tbl[math.random(#tbl)]
        local px, py = EntityGetTransform(ent)
        summon(me, px, py, ent)

    end

end


