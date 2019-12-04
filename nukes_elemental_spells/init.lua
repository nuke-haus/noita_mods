function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_elemental_spells/files/nuke/magmablast.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_elemental_spells/files/nuke/iceblast.lua")

print("Elemental spell mod initialization done.")

