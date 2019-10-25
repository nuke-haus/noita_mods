function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/magmablast.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/iceblast.lua")

print("Elemental spell mod initialization done.")

