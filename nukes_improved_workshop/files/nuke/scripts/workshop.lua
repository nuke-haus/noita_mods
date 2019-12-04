function spawn_all_shopitems( x, y )

    local spawn_shop, spawn_perks = temple_random( x, y )
    
	if( spawn_shop == "0" ) then
		return
	end

	EntityLoad( "data/entities/buildings/shop_hitbox.xml", x, y )
	
    SetRandomSeed( x, y )
    
	local count = tonumber( GlobalsGetValue( "TEMPLE_SHOP_ITEM_COUNT", "5" ) )
	local width = 132
	local item_width = width / count
    local sale_item_i = Random( 1, count )
    local num_wands = Random( 2, 3 )

    for i=1,count do

        if (i <= num_wands) then

            if( i == sale_item_i ) then
				generate_shop_wand( x + (i-1)*item_width, y, true )
			else
				generate_shop_wand( x + (i-1)*item_width, y, false )
			end

        else

            if( i == sale_item_i ) then
                generate_shop_item( x + (i-1)*item_width, y, true, nil, true )
            else
                generate_shop_item( x + (i-1)*item_width, y, false, nil, true )
            end

        end
    end
end