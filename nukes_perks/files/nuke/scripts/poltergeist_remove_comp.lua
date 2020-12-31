
local me = GetUpdatedEntityID()
local comp1 = EntityGetFirstComponent(me, "DamageModelComponent")
local comp2 = EntityGetFirstComponent(me, "HitboxComponent")

if comp1 ~= nil and comp1 ~= 0 then

    EntityRemoveComponent(me, comp1)

end

if comp2 ~= nil and comp2 ~= 0 then

    --EntityRemoveComponent(me, comp2)

end