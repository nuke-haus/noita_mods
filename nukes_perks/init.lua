
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned( player_entity ) 

end

local function addLoc(key, value)

	local content = ModTextFileGetContent("data/translations/common.csv")
	local addstr = key .. "," .. value .. ",,,,,,,,,,,,,\n"

	ModTextFileSetContent("data/translations/common.csv", content .. addstr)

end

addLoc("perkdesc_wandb", "Wands become more powerful in your hands.")
addLoc("perkdesc_phero", "You bleed pheromones and take less damage from melee attacks.")
addLoc("perkdesc_berserkb", "You bleed a lot of berserkium and take less damage from blades.")
addLoc("perkdesc_tremor", "The earth crumbles beneath your feet.")
addLoc("perkdesc_bark", "Physical damage is reduced by 20%. You have become vulnerable to fire.")
addLoc("perkdesc_irons", "Physical damage is reduced by 20%. You have become vulnerable to electricity.")
addLoc("perkdesc_lava", "You convert nearby acid and lava to alcohol.")
addLoc("perkdesc_toxaura", "You purify nearby toxins and convert harmful magical liquids to safer magical liquids.")
addLoc("perkdesc_field", "An invisible field pushes all objects and projectiles away from you.")
addLoc("perkdesc_firetrail", "You leave a trail of magical flames wherever you go.")
addLoc("perkdesc_icetrail", "You leave a trail of freezing magic wherever you go.")
addLoc("perkdesc_pact", "You receive four random perks but your maximum health is halved.")
addLoc("perkdesc_inferno", "You become immune to fire but you are constantly shrouded in flames.")
addLoc("perkdesc_p4s", "Perks are sometimes available for purchase in shops.")
addLoc("perkdesc_pixie", "Mischievous sprites are summoned to fight for you.")
addLoc("perkdesc_babygorgon", "Enemies that die near you will sometimes summon a chaotic gorgon.")
addLoc("perkdesc_polter", "Poltergeists are summoned to fight for you.")
addLoc("perkdesc_adaptresist", "Taking damage will grant a temporary resistance to that damage type.")

ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/wand_buff.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/bleed_pheromones.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/bleed_berserk.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/stompy.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/skin_bark.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/skin_iron.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/lava_aura.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/toxin_aura.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/repelling_field.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/trail_ice.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/trail_fire.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/inferno.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/blood_pact.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/perks_4_sale.lua" )
ModLuaFileAppend( "data/scripts/items/generate_shop_item.lua", "mods/nukes_perks/files/nuke/scripts/perks_shop.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/pixies.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/baby_gorgon.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/poltergeist.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nukes_perks/files/nuke/scripts/adaptive_resist.lua" )

ModMaterialsFileAdd( "mods/nukes_perks/files/nuke/perk_mats.xml" )

print("More perks mod initialization done.")

