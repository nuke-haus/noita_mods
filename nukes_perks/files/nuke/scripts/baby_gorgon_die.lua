
local me = GetUpdatedEntityID()
local bod = EntityGetFirstComponent(me, "PhysicsBodyComponent")
local x, y = EntityGetTransform(me)

if (bod ~= nil and bod ~= 0) then

	EntityConvertToMaterial(me, "acid")
	EntityKill(me)
	EntityLoad("mods/nukes_spells/files/nuke/entities/petrify.xml", x, y)

end