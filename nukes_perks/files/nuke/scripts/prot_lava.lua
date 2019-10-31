dofile("data/scripts/lib/utilities.lua")

table.insert( perk_list,
{
	id = "PROT_LAVA",
	ui_name = "Lava Immunity",
	ui_description = "You take no damage from lava.",
	ui_icon = "mods/more_perks/files/nuke/perks_gfx/ui/prot_lava.png",
	perk_icon = "mods/more_perks/files/nuke/perks_gfx/ig/prot_lava.png",
	--not_in_default_perk_pool = cfg_disable_wandbuff,
	func = function(entity_perk_item, player_entity, item_name)
	
		local dmg = EntityGetFirstComponent(player_entity, "DamageModelComponent") 
		local mats = tostring( ComponentGetValue( dmg, "materials_that_damage" ) )
		local howmuch = tostring( ComponentGetValue( dmg, "materials_how_much_damage" ) )
		
		local mat_split = split_str(mats, ",", 0)
		local cts_split = split_str(howmuch, ",", 0)
		
		for k,v in pairs(mat_split) do
		
			if (v == "lava") then
			
				table.remove(mat_split, k)
				table.remove(cts_split, k)
			
				break
			
			end
		
		end
		
		local mats_fix = table.concat(mat_split, ",")
		local cts_fix = table.concat(cts_split, ",")
		
		ComponentSetValue(dmg, "materials_that_damage", mats_fix)
		ComponentSetValue(dmg, "materials_how_much_damage", cts_fix)
		ComponentSetValue(dmg, "fire_damage_amount", 0.0)
		
	end,
})

function split_str(str, delim, maxNb)
   -- Eliminate bad cases...
   if string.find(str, delim) == nil then
      return { str }
   end
   if maxNb == nil or maxNb < 1 then
      maxNb = 0    -- No limit
   end
   local result = {}
   local pat = "(.-)" .. delim .. "()"
   local nb = 0
   local lastPos
   for part, pos in string.gfind(str, pat) do
      nb = nb + 1
      result[nb] = part
      lastPos = pos
      if nb == maxNb then
         break
      end
   end
   -- Handle the last field
   if nb ~= maxNb then
      result[nb + 1] = string.sub(str, lastPos)
   end
   return result
end