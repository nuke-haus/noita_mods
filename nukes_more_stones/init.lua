
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

ModMaterialsFileAdd( "mods/nukes_more_stones/files/nuke/nukes_mats.xml" )
ModLuaFileAppend( "data/scripts/item_spawnlists.lua", "mods/nukes_more_stones/files/nuke/scripts/inject_stones.lua")
ModLuaFileAppend( "data/scripts/items/chest_random.lua", "mods/nukes_more_stones/files/nuke/scripts/inject_stones_chest.lua") -- i hate this shit

print("More stones mod initialization done.")

