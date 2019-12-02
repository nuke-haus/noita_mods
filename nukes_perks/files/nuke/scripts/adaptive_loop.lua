
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

function damage_received(damage, message, entity, is_fatal)

	local me = GetUpdatedEntityID()
	
	local vars = EntityGetComponent(me, "VariableStorageComponent")
	local comp = nil
	local compt = nil
	local value = ""
	local frame = 0
	local tbl = {}
	tbl["$damage_projectile"] = "projectile"
	tbl["$damage_fire"] = "fire"
	tbl["$damage_melee"] = "melee"
	tbl["$damage_explosion"] = "explosion"
	tbl["$damage_slice"] = "slice"
	tbl["$damage_drill"] = "drill"
	tbl["$damage_ice"] = "ice"
	tbl["$damage_electricity"] = "electricity"
	tbl["$damage_physicshit"] = "physics_hit"
	tbl["$damage_radioactive"] = "radioactive"
	tbl["$damage_poison"] = "poison"

	if (vars == nil) then

		vars = {}

	end

	for k,v in pairs(vars) do

		local name = ComponentGetValue(v, "name")
		local str = ComponentGetValue(v, "value_string")

		if (name == "adaptive_resist") then

			value = str
			comp = v

		elseif (name == "adaptive_resist_time") then

			frame = tonumber(str)
			compt = v

		end

	end

	if (frame ~= 0 and frame > GameGetFrameNum()) then

		return

	end
	
	add_resist(me, value, -0.2)
	ComponentSetValue(comp, "value_string", "")

	if (comp ~= nil) then

		for k,v in pairs(tbl) do

			if (k == message) then

				add_resist(me, v, 0.2) -- 80 percent resistance
				
				ComponentSetValue(compt, "value_string", tostring(GameGetFrameNum() + 300))
				ComponentSetValue(comp, "value_string", v)

				local x,y = EntityGetTransform(me)
				local child_id = EntityLoad("files/nuke/entities/adaptive_field.xml", x, y - 18)
		
				EntityAddChild(me, child_id)

				local lua = { 
					script_source_file="files/nuke/scripts/adaptive_field.lua",
					execute_on_added="1",
					execute_every_n_frame="-1",
					execute_times="-1" }

				local lua2 = { 
					script_source_file="files/nuke/scripts/adaptive_field_die.lua",
					execute_on_added="0",
					execute_every_n_frame="297",
					execute_times="1" }

				EntityAddComponent(child_id, "LuaComponent", lua)
				EntityAddComponent(child_id, "LuaComponent", lua2)

				return

			end

		end

	end

end

