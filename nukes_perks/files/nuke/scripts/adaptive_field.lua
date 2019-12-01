
local me = GetUpdatedEntityID()
local parent = EntityGetParent(me)
local comp = EntityGetFirstComponent(me, "ParticleEmitterComponent")
local vars = EntityGetComponent(parent, "VariableStorageComponent")

if (vars == nil) then

	vars = {}

end

local tbl = {}
	tbl["projectile"] = "spark_white_bright"
	tbl["fire"] = "fire"
	tbl["melee"] = "spark_red_bright"
	tbl["explosion"] = "spark_yellow"
	tbl["slice"] = "nuke_spark_pink"
	tbl["drill"] = "nuke_spark_pink2"
	tbl["ice"] = "nuke_spark_blue"
	tbl["electricity"] = "spark_electric"
	tbl["physicshit"] = "nuke_spark_brown"
	tbl["radioactive"] = "radioactive_gas"
	tbl["poison"] = "spark_purple_bright"

for k,v in pairs(vars) do

	local name = ComponentGetValue(v, "name")
	local str = ComponentGetValue(v, "value_string")

	if (name == "adaptive_resist") then

		for k,v in pairs(tbl) do

			if (k == str) then

				ComponentSetValue(comp, "emitted_material_name", v)

				return

			end

		end

		return

	end

end
