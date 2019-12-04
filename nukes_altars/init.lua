
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

    --local x,y = EntityGetTransform(player_entity)
    --EntityLoad( "files/nuke/entities/gorgon.xml", x-23, y - 111 )

end

ModMaterialsFileAdd( "mods/nukes_altars/files/nuke/gorgon_mats.xml" )

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/nukes_altars/files/nuke/scripts/altar_blood_coal.lua")
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/nukes_altars/files/nuke/scripts/altar_blood_coal_alt.lua")
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/nukes_altars/files/nuke/scripts/altar_blood_exca.lua")

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/nukes_altars/files/nuke/scripts/altar_tablet_coal.lua")
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/nukes_altars/files/nuke/scripts/altar_tablet_coal_alt.lua")
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/nukes_altars/files/nuke/scripts/altar_tablet_exca.lua")

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/nukes_altars/files/nuke/scripts/altar_wand_coal.lua")
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/nukes_altars/files/nuke/scripts/altar_wand_coal_alt.lua")
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/nukes_altars/files/nuke/scripts/altar_wand_exca.lua")

ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/nukes_altars/files/nuke/scripts/altar_perk_exca.lua")

print("More altars mod initialization done.")

