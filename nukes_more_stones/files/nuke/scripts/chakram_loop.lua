
local me = GetUpdatedEntityID() 
local xt,yt = GameGetVelocityCompVelocity(me)
local vars = EntityGetComponent(me, "VariableStorageComponent")

if (vars == nil) then

	vars = {}

end

for k,v in pairs(vars) do

	local name = ComponentGetValue(v, "name")
	local str = ComponentGetValue(v, "value_string")

	if (name == "chakram") then

		local tbl = {}

		for match in string.gmatch(str, "[^,]+") do

			table.insert(tbl, match)

		end

		local lastframe = tonumber(tbl[1])
		local ct = tonumber(tbl[2])

		if (xt ~= nil and xt < 2 and yt < 2) then

			ct = ct + 1

			if ct > 3 then

				EntityKill(me)

			else

				ComponentSetValue(v, "value_string", "1," .. ct)

			end
		
		else

			ComponentSetValue(v, "value_string", "0,0")

		end

	end

end

