
local function add_resist(me, dmg_type, scale)

	if (dmg_type == "") then

		return

    end
    
    --print("update " .. dmg_type.. " " .. tostring(scale))

	local damagemodels = EntityGetComponent(me, "DamageModelComponent")
		
	if (damagemodels ~= nil) then
		
		for i,damagemodel in ipairs(damagemodels) do

			local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", dmg_type ))

			if (scale > 0.0) then

				resistance = resistance * scale

			else

				scale = scale * -1.0
				resistance = resistance / scale

			end

			ComponentObjectSetValue(damagemodel, "damage_multipliers", dmg_type, tostring(resistance))
				
		end

	end

end

local me = GetUpdatedEntityID()
local parent = EntityGetParent(me)
local comp = EntityGetFirstComponent(me, "ParticleEmitterComponent")
local vars = EntityGetComponent(parent, "VariableStorageComponent")

if (vars == nil) then

	vars = {}

end

ComponentSetValue(comp, "lifetime_min", "5.0")
ComponentSetValue(comp, "lifetime_max", "6.0")
ComponentSetValue(comp, "airflow_force", "0.25")
ComponentSetValue(comp, "airflow_scale", "0.25")
ComponentSetValue(comp, "count_min", "20")
ComponentSetValue(comp, "count_max", "24")
ComponentSetValue(comp, "image_animation_emission_probability", "0.99")

for k,v in pairs(vars) do

	local name = ComponentGetValue(v, "name")
	local str = ComponentGetValue(v, "value_string")

	if (name == "adaptive_resist") then

        add_resist(parent, str, -0.2)
	    ComponentSetValue(v, "value_string", "")
        
		return

	end

end
