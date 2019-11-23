


table.insert( perk_list,
{
	id = "DOUBLE_PERK",
	ui_name = "Perk Gamble",
	ui_description = "You receive two random perks.",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/double.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/double.png",
	func = function(entity_perk_item, player_entity, item_name)

		dofile("data/scripts/perks/perk.lua")

		local get_perk_flag_name = function( perk_id )
			return "PERK_" .. perk_id
		end

		local function drop_perk(x, y)

			local perks = perk_get_spawn_order()
			local next_perk_index = tonumber( GlobalsGetValue( "TEMPLE_NEXT_PERK_INDEX", "1" ) )
			local perk_data = get_perk_with_id( perk_list, perks[next_perk_index] )
				
			next_perk_index = next_perk_index + 1

			if next_perk_index > #perks then
				next_perk_index = 1
			end

			GlobalsSetValue( "TEMPLE_NEXT_PERK_INDEX", tostring(next_perk_index) )
			GameAddFlagRun( get_perk_flag_name(perk_data.id) )

			return perk_spawn( x, y, perks[next_perk_index] )

		end
	
		local x,y = EntityGetTransform(player_entity)
		local id1 = drop_perk(x,y)
		local id2 = drop_perk(x,y)

		perk_pickup(id1, player_entity, item_name, false, false)
		perk_pickup(id2, player_entity, item_name, false, false)
		
	end,
})
