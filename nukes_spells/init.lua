
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModMaterialsFileAdd( "mods/nukes_spells/files/nuke/petrify_mats.xml" )
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_spells/files/nuke/gravity_well.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_spells/files/nuke/repelling_field.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_spells/files/nuke/petrify.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_spells/files/nuke/cloud_chaos.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_spells/files/nuke/trail_chaos.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/nukes_spells/files/nuke/bomb_cluster.lua")

print("More spells mod initialization done.")

