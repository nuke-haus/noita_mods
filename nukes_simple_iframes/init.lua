
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned(player) 

	local tbl = {
		script_source_file="mods/nukes_simple_iframes/files/nuke/scripts/iframes_loop.lua",
		script_damage_received="mods/nukes_simple_iframes/files/nuke/scripts/iframes_loop.lua",
		execute_on_added="0",
		execute_every_n_frame="-1",
		execute_times="-1" }

	EntityAddComponent(player, "LuaComponent", tbl) 

end

print("Invincibility frames mod initialization done.")

