
local X_STRENGTH = 45.0
local Y_STRENGTH = 30.0
local SPIN = 10.0
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local xv = Random()
local yv = Random() * -1.0

if (Random(1,2) == 1) then

	xv = xv * -1.0

end

EntitySetTransform(me, x + (xv * 2.0), y + (yv * 2.0))
PhysicsApplyForce(me, xv * X_STRENGTH, yv * Y_STRENGTH)
PhysicsApplyTorque(me, (Random() + (Random() * -1.0) * SPIN))