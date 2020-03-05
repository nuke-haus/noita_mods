dofile( "data/scripts/lib/utilities.lua" )
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

	perk_spawn( x, y, perks[next_perk_index] )

end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

	local entity_id    = GetUpdatedEntityID()
	local x,y = EntityGetTransform( entity_id )

	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)

	drop_perk(x,y)

end

