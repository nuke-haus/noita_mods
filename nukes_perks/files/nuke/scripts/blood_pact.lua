
table.insert( perk_list,
{
	id = "BLOOD_PACT",
	ui_name = "Blood Pact",
	ui_description = "$perkdesc_pact",
	ui_icon = "mods/nukes_perks/files/nuke/perks_gfx/ui/bloodpact.png",
	perk_icon = "mods/nukes_perks/files/nuke/perks_gfx/ig/bloodpact.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = false,
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
		local id3 = drop_perk(x,y)
		local id4 = drop_perk(x,y)

		perk_pickup(id1, player_entity, item_name, false, false)
		perk_pickup(id2, player_entity, item_name, false, false)
		perk_pickup(id3, player_entity, item_name, false, false)
		perk_pickup(id4, player_entity, item_name, false, false)

		local damagemodels = EntityGetComponent(player_entity, "DamageModelComponent" )

		if (damagemodels ~= nil) then

			for i,damagemodel in ipairs(damagemodels) do

				local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) ) * 0.5

				max_hp = math.ceil( max_hp * 25 ) / 25
					
				ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )

			end

		end
		
	end,
})
