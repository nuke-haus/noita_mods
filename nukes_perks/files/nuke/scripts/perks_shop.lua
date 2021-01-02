
dofile( "data/scripts/perks/perk.lua" )
dofile( "data/scripts/perks/perk_list.lua" )

local get_perk_flag_name = function( perk_id )
	return "PERK_" .. perk_id
end

local function get_perk_id()

	local perks = perk_get_spawn_order()
	local next_perk_index = tonumber( GlobalsGetValue( "TEMPLE_NEXT_PERK_INDEX", "1" ) )
	local perk_data = get_perk_with_id( perk_list, perks[next_perk_index] )
		
	next_perk_index = next_perk_index + 1

	if next_perk_index > #perks then
		next_perk_index = 1
	end

	GlobalsSetValue( "TEMPLE_NEXT_PERK_INDEX", tostring(next_perk_index) )
	GameAddFlagRun( get_perk_flag_name(perk_data.id) )

	return perks[next_perk_index]

end

local function generate_shop_perk(x, y, cheap)

	local entity_id = EntityLoad( "mods/nukes_perks/files/nuke/entities/shop_perk.xml", x, y - 4 )
	local perk_id = get_perk_id()
	local perk_data = get_perk_with_id( perk_list, perk_id )

	-- init perk item
	EntityAddComponent( entity_id, "SpriteComponent", 
	{ 
		_tags="enabled_in_world", 
		image_file = perk_data.perk_icon or "data/items_gfx/perk.xml",  
		offset_x = "7", 
		offset_y = "9", 
		update_transform = "1" ,
		update_transform_rotation = "0",
	} )

	EntityAddComponent( entity_id, "UIInfoComponent", 
	{ 
		name = perk_data.ui_name,
	} )

	EntityAddComponent( entity_id, "ItemComponent", 
	{ 
		item_name = perk_data.ui_name,
		ui_description = perk_data.ui_description,
		play_spinning_animation = "0",
		play_hover_animation = "0",
		play_pick_sound = "0",
	} )

	EntityAddComponent( entity_id, "SpriteOffsetAnimatorComponent", 
	{ 
      sprite_id="-1" ,
      x_amount="0" ,
      x_phase="0" ,
      x_phase_offset="0" ,
      x_speed="0" ,
      y_amount="1.5" ,
      y_speed="2",
	} )

	EntityAddComponent( entity_id, "VariableStorageComponent", 
	{ 
		_tags="perk_id",
		name = "perk_id",
		value_string = perk_data.id,
	} )

	EntityAddComponent( entity_id, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml", 
		is_text_sprite="1", 
		offset_x="7", 
		offset_y="18", 
		update_transform="1" ,
		update_transform_rotation="0",
		text="111",
		} )

	local stealable_value = "0"
	local cost = 800 + 10 * Random(0, 20)

	if (cheap) then

		cost = 400 + 10 * Random(0, 20)
		EntityLoad( "data/entities/misc/sale_indicator.xml", x, y )

	end
	
	EntityAddComponent( entity_id, "ItemCostComponent", { 
		_tags="shop_cost,enabled_in_world", 
		cost=cost,
		stealable=stealable_value
		} )
		
	--EntityAddComponent( entity_id, "LuaComponent", { 
		--script_item_picked_up="data/scripts/items/shop_effect.lua",
		--} )

	EntityAddComponent( entity_id, "LuaComponent", { 
		script_item_picked_up="mods/nukes_perks/files/nuke/scripts/buy_perk.lua",
		} )

end

function generate_shop_item( x, y, cheap_item, biomeid_, is_stealable )
	-- this makes the shop items deterministic
	SetRandomSeed( x, y )

	if (GlobalsGetValue("PERKS_4_SALE") == "true" and Random(1,20) <= 6) then -- 30% chance items are replaced with perks

		generate_shop_perk(x, y, cheap_item)
		return

	end

	local biomes =
	{
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 1,
		[5] = 1,
		[6] = 1,
		[7] = 2,
		[8] = 2,
		[9] = 2,
		[10] = 2,
		[11] = 2,
		[12] = 2,
		[13] = 3,
		[14] = 3,
		[15] = 3,
		[16] = 3,
		[17] = 4,
		[18] = 4,
		[19] = 4,
		[20] = 4,
		[21] = 5,
		[22] = 5,
		[23] = 5,
		[24] = 5,
		[25] = 6,
		[26] = 6,
		[27] = 6,
		[28] = 6,
		[29] = 6,
		[30] = 6,
		[31] = 6,
		[32] = 6,
		[33] = 6,
	}


	local biomepixel = math.floor(y / 512)
	local biomeid = biomes[biomepixel] or 0
	
	if (biomepixel > 35) then
		biomeid = 7
	end
	
	if (biomes[biomepixel] == nil) and (biomeid_ == nil) then
		print("Unable to find biomeid for chunk at depth " .. tostring(biomepixel))
	end
	
	if (biomeid_ ~= nil) then
		biomeid = biomeid_
	end

	if( is_stealable == nil ) then
		is_stealable = false
	end

	local item = ""
	local cardcost = 0

	-- Note( Petri ): Testing how much squaring the biomeid for prices affects things
	local level = biomeid
	biomeid = biomeid * biomeid

	item = GetRandomAction( x, y, level, 0 )
	cardcost = 0

	for i,thisitem in ipairs( actions ) do
		if ( string.lower( thisitem.id ) == string.lower( item ) ) then
			price = math.max(math.floor( ( (thisitem.price * 0.30) + (70 * biomeid) ) / 10 ) * 10, 10)
			cardcost = price
			
			if ( thisitem.spawn_requires_flag ~= nil ) then
				local flag = thisitem.spawn_requires_flag
				
				if ( HasFlagPersistent( flag ) == false ) then
					print( "Trying to spawn " .. tostring( thisitem.id ) .. " even though flag " .. tostring( flag ) .. " not set!!" )
				end
			end
		end
	end
	
	if( cheap_item ) then
		cardcost = 0.5 * cardcost
	end
	
	if ( biomeid >= 10 ) then
		price = price * 5.0
		cardcost = cardcost * 5.0
	end

	local eid = CreateItemActionEntity( item, x, y )

	if( cheap_item ) then
		EntityLoad( "data/entities/misc/sale_indicator.xml", x, y )
	end

	-- local x, y = EntityGetTransform( entity_id )
	-- SetRandomSeed( x, y )
	
	local offsetx = 6
	local text = tostring(cardcost)
	local textwidth = 0
	
	for i=1,#text do
		local l = string.sub( text, i, i )
		
		if ( l ~= "1" ) then
			textwidth = textwidth + 6
		else
			textwidth = textwidth + 3
		end
	end
	
	offsetx = textwidth * 0.5 - 0.5

	EntityAddComponent( eid, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml", 
		is_text_sprite="1", 
		offset_x=tostring(offsetx), 
		offset_y="25", 
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(cardcost),
		z_index="-1",
		} )

	local stealable_value = "0"
	if( is_stealable ) then 
		stealable_value = "1"
	end
	
	EntityAddComponent( eid, "ItemCostComponent", { 
		_tags="shop_cost,enabled_in_world", 
		cost=cardcost,
		stealable=stealable_value
		} )
		
	EntityAddComponent( eid, "LuaComponent", { 
		script_item_picked_up="data/scripts/items/shop_effect.lua",
		} )
	-- shop_item_pickup2.lua

	-- display uses remaining, if any
	--  NOTE(Olli): removed this because it didn't work with low resolution rendering
	--[[edit_component( eid, "ItemComponent", function(comp,vars)
		local uses_remaining = tonumber( ComponentGetValue(comp, "uses_remaining" ) )
		if uses_remaining > -1 then
			EntityAddComponent( eid, "SpriteComponent", { 
				_tags="shop_cost,enabled_in_world",
				image_file="data/fonts/font_pixel_white.xml", 
				is_text_sprite="1", 
				offset_x="16", 
				offset_y="32", 
				has_special_scale="1",
				special_scale_x="0.5",
				special_scale_y="0.5",
				update_transform="1" ,
				update_transform_rotation="0",
				text=tostring(uses_remaining),
				} )
		end
	end)]]--
end