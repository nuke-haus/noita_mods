
function register_item(listname, weight, entity, offset) -- use this to register an item in spawn table
	if ( type( listname ) == "string" ) then
		local newmin = spawnlists[listname].rnd_max + 1
		local newmax = newmin + weight
		local tbl = {
			value_min = newmin,
			value_max = newmax,
			offset_y = offset,
			load_entity = entity
		}
		table.insert(spawnlists[listname].spawns, tbl)
		spawnlists[listname].rnd_max = newmax
	elseif ( type( listname ) == "table" ) then
		local newmin = listname.rnd_max + 1
		local newmax = newmin + weight
		local tbl = {
			value_min = newmin,
			value_max = newmax,
			offset_y = offset,
			load_entity = entity
		}
		table.insert(listname.spawns, tbl)
		listname.rnd_max = newmax
	end
end

function change_existing_item(listname, entity_path, new_entity_path) -- useful for mods that want to replace existing entries in item table
	if ( type( listname ) == "string" ) then
		for k, v in pairs(spawnlists[listname].spawns) do
			if v.load_entity ~= nil and v.load_entity == entity_path then
				local tbl = v
				tbl.load_entity = new_entity_path
				spawnlists[listname][k] = tbl
				return
			end
		end
	elseif ( type( listname ) == "table" ) then
		for k, v in pairs(listname.spawns) do
			if v.load_entity ~= nil and v.load_entity == entity_path then
				local tbl = v
				tbl.load_entity = new_entity_path
				listname[k] = tbl
				return
			end
		end
	end
end

register_item("potion_spawnlist", 1, "mods/nukes_more_stones/files/nuke/entities/pot_heal.xml", -2)
register_item("potion_spawnlist", 1, "mods/nukes_more_stones/files/nuke/entities/pot_precursor.xml", -2)
register_item("potion_spawnlist", 4, "mods/nukes_more_stones/files/nuke/entities/chakram_item.xml", -2)
register_item("potion_spawnlist", 5, "mods/nukes_more_stones/files/nuke/entities/stone_skull.xml", -2)
register_item("potion_spawnlist", 1, "mods/nukes_more_stones/files/nuke/entities/stone_nuke.xml", -2)
register_item("potion_spawnlist", 5, "mods/nukes_more_stones/files/nuke/entities/stone_ice.xml", -2)
register_item("potion_spawnlist", 3, "mods/nukes_more_stones/files/nuke/entities/stone_holy.xml", -2)
change_existing_item("potion_spawnlist", "data/entities/items/pickup/brimstone.xml", "mods/nukes_more_stones/files/nuke/entities/stone_fire.xml")

register_item("potion_spawnlist_liquidcave", 1, "mods/nukes_more_stones/files/nuke/entities/pot_heal.xml", -2)
register_item("potion_spawnlist_liquidcave", 1, "mods/nukes_more_stones/files/nuke/entities/pot_precursor.xml", -2)
register_item("potion_spawnlist_liquidcave", 4, "mods/nukes_more_stones/files/nuke/entities/chakram_item.xml", -2)
register_item("potion_spawnlist_liquidcave", 5, "mods/nukes_more_stones/files/nuke/entities/stone_skull.xml", -2)
register_item("potion_spawnlist_liquidcave", 1, "mods/nukes_more_stones/files/nuke/entities/stone_nuke.xml", -2)
register_item("potion_spawnlist_liquidcave", 5, "mods/nukes_more_stones/files/nuke/entities/stone_ice.xml", -2)
register_item("potion_spawnlist_liquidcave", 3, "mods/nukes_more_stones/files/nuke/entities/stone_holy.xml", -2)
change_existing_item("potion_spawnlist_liquidcave", "data/entities/items/pickup/brimstone.xml", "mods/nukes_more_stones/files/nuke/entities/stone_fire.xml")


