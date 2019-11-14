
dofile( "data/scripts/lib/utilities.lua" )

local RADIUS = 75.0

local function distance(x, y, x2, y2)

	return math.sqrt(((x - x2)^2) + ((y - y2)^2))

end

local function length(x, y)

	return math.sqrt((x * x) + (y * y))

end

local me = GetUpdatedEntityID() 
local x,y = EntityGetTransform(me)
local cur_rad = 0

for k,v in pairs(EntityGetAllComponents(me)) do

	local value = tonumber(ComponentGetValue(v, "radius"))

	if (value ~= nil) then

		value = math.min(value + 1, RADIUS)
		cur_rad = value

		if (value > RADIUS - 8) then

			local lt = EntityGetFirstComponent(me, "LifetimeComponent")

			if (lt ~= nil or lt ~= 0) then

				EntityAddComponent(me, "LifetimeComponent", {lifetime="10"})

			end

		end

		ComponentSetValue(v, "radius", tostring(value))

	end

end

local par = EntityGetFirstComponent(me, "ParticleEmitterComponent")
local spr = EntityGetFirstComponent(me, "SpriteComponent")

if (par ~= nil and par ~= 0) then

	local lower = cur_rad * 0.8

	ComponentSetValue(par, "x_pos_offset_min", lower * -1)
	ComponentSetValue(par, "x_pos_offset_max", lower)
	ComponentSetValue(par, "y_pos_offset_min", lower * -1)
	ComponentSetValue(par, "y_pos_offset_max", lower)

end

if (spr ~= nil and spr ~= 0) then

	local size = (cur_rad / RADIUS) * 2.0
	local a = 1.0 - ((cur_rad / RADIUS) * 1.0)

	ComponentSetValue(spr, "special_scale_x", size)
	ComponentSetValue(spr, "special_scale_y", size)
	ComponentSetValue(spr, "alpha", a)

end

local fix_rad = math.min(cur_rad + 8, RADIUS)
local ents = EntityGetInRadius(x, y, fix_rad)

for k,v in pairs(ents) do

	local dmg = EntityGetComponent(v, "DamageModelComponent")
	local exdmg = EntityGetFirstComponent(v, "ExplodeOnDamageComponent")
	local proj = EntityGetComponent(v, "ProjectileComponent")

	if (exdmg ~= nil and exdmg ~= 0) then

		EntityRemoveComponent(v, exdmg)

	end

	local is_alive = false
	local hit_me_already = false
	local valid_dmg = true

	if (dmg == nil) then

		dmg = {}
		valid_dmg = false

	end

	for b,n in pairs(dmg) do

		ComponentSetValue(n, "drop_items_on_death", "0")
		ComponentSetValue(n, "blood_multiplier", "0")

	end

	local px, py = EntityGetTransform(v)

	edit_component_with_tag(me, "VariableStorageComponent", ("hit_once_" .. v), function(comp, vars) hit_me_already = true end )

	if (hit_me_already == false and valid_dmg) then -- using some var storage tricks to make sure we dont instakill enemies like the boss

		EntityAddComponent(me, "VariableStorageComponent", {name=("hit_once_" .. v), _tags=("hit_once_" .. v)})

		EntityAddComponent(v, "VariableStorageComponent", {name="no_gold_drop", _tags="no_gold_drop"})
		EntityLoad("files/nuke/entities/instagib.xml", px, py)

	end

	if (proj ~= nil and proj ~= 0) then

		local shooter = ComponentGetValue( proj[1], "mWhoShot")	

		if (shooter ~= nil) then

			if (IsPlayer(shooter) == false) then

				EntityConvertToMaterial(v, "rock_static_petrify2_breakable")
				EntityKill(v)

			end

		end

	end

	::skip::

end

