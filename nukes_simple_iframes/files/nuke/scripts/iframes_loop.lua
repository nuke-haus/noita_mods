
dofile("mods/nukes_simple_iframes/files/nuke/scripts/CONFIG_IFRAMES.lua")

function damage_received(damage, message, entity_thats_responsible, is_fatal)

	local real_dmg = damage * 25.0

	if (real_dmg > IFRAME_THRESHOLD and is_fatal == false) then -- give iframes

		local player = GetUpdatedEntityID()
		local comp = EntityGetFirstComponent(player, "DamageModelComponent")

		if (comp ~= nil and comp ~= 0) then

			ComponentSetValue(comp, "invincibility_frames", NUMBER_OF_IFRAMES)

		end

	end

end