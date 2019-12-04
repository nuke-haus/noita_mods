
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local stones = EntityGetWithTag("gorgon_stone")

if (stones == nil) then

	stones = {}

end

if (#stones < 3) then

	EntityLoad("mods/nukes_altars/files/nuke/entities/stone_physics.xml", x, y - 18)

end