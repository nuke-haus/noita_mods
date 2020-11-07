dofile("data/scripts/perks/perk.lua")

function item_pickup( entity_item, player, name )

	local x, y = EntityGetTransform( player )
	local stor = EntityGetFirstComponent( entity_item, "VariableStorageComponent", "perk_id" )
	local id = ComponentGetValue( stor, "value_string" )
	local pu = perk_spawn( x, y, id )

	perk_pickup( pu, player, name, true, false )
	EntityKill(entity_item)
	
end
 