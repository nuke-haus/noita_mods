
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

dofile( "mods/more_perks/CONFIG.lua")

if ENABLE_WAND_BUFF_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/wand_buff.lua" )
	
end

if ENABLE_BLEED_PHEROMONES_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/bleed_pheromones.lua" )

end

print("More perks mod initialization done.")

