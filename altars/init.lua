
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "files/nuke/scripts/altar_blood_coal.lua")
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "files/nuke/scripts/altar_blood_coal_alt.lua")
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "files/nuke/scripts/altar_blood_exca.lua")

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "files/nuke/scripts/altar_tablet_coal.lua")
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "files/nuke/scripts/altar_tablet_coal_alt.lua")
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "files/nuke/scripts/altar_tablet_exca.lua")

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "files/nuke/scripts/altar_wand_coal.lua")
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "files/nuke/scripts/altar_wand_coal_alt.lua")
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "files/nuke/scripts/altar_wand_exca.lua")

print("More altars mod initialization done.")

