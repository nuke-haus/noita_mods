
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

if ENABLE_BLEED_BERSERKIUM_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/bleed_berserk.lua" )

end

if ENABLE_LAVA_IMMUNE_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/prot_lava.lua" )

end

if ENABLE_ACID_IMMUNE_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/prot_acid.lua" )

end

if ENABLE_STOMPY_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/stompy.lua" )

end

if ENABLE_BARKSKIN_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/skin_bark.lua" )

end

if ENABLE_IRONSKIN_PERK then

	ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/more_perks/files/nuke/scripts/skin_iron.lua" )

end

print("More perks mod initialization done.")

