
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModMaterialsFileAdd( "files/nuke/nukes_mats.xml" )
ModLuaFileAppend( "data/scripts/biome_scripts.lua", "files/nuke/scripts/inject_stones.lua")

print("More stones mod initialization done.")

