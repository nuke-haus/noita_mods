
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned(player) 

end

ModLuaFileAppend( "data/scripts/biomes/temple_altar_right.lua", "mods/nukes_peaceful_shopping/files/nuke/scripts/workshop_right.lua")
ModLuaFileAppend( "data/scripts/biomes/temple_altar_right_snowcastle.lua", "mods/nukes_peaceful_shopping/files/nuke/scripts/workshop_right.lua")
ModLuaFileAppend( "data/scripts/biomes/temple_altar_right_snowcave.lua", "mods/nukes_peaceful_shopping/files/nuke/scripts/workshop_right.lua")

print("Peaceful shopping mod initialization done.")

