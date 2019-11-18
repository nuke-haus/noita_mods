
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModMaterialsFileAdd( "files/nuke/petrify_mats.xml" )
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/gravity_well.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/repelling_field.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/petrify.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/cloud_chaos.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/trail_chaos.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "files/nuke/bomb_cluster.lua")

print("More spells mod initialization done.")

