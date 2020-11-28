
function drop_random_reward( x, y, entity_id, rand_x, rand_y, set_rnd_  )
	local set_rnd = false 
	if( set_rnd_ ~= nil ) then set_rnd = set_rnd_ end

	if( set_rnd ) then
		SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	end
	
	local good_item_dropped = true
	
	-- using deferred loading of entities, since loading some of them (e.g. potion.xml) will call SetRandomSeed(...)
	-- if position is not given (in entities table), will load the entity to rand_x, rand_y and then move it to chest position
	-- reason for this is that then the SetRandomSeed() of those entities will be deterministic 
	-- but for some reason it cannot be done to random_card.xml, since I'm guessing
	local entities = {}

	local count = 1
	while( count > 0 ) do
		count = count - 1
		local rnd = Random(1,100)

		if( rnd <= 7 ) then
			-------------------------------------------------------------------
			-- Bomb
			-------------------------------------------------------------------
			table.insert( entities, { "data/entities/projectiles/bomb_small.xml" } )
			-- EntityLoad( "data/entities/projectiles/bomb_small.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
			good_item_dropped = false
			
		elseif( rnd <= 40 ) then
			-------------------------------------------------------------------
			-- Gold (I think the reason there's empty is chests is goldnuggets)
			-------------------------------------------------------------------
			local remove_gold_timer = false
	
			local comp_worldstate = EntityGetFirstComponent( GameGetWorldStateEntity(), "WorldStateComponent" )
			if( comp_worldstate ~= nil ) then
				if( ComponentGetValue2( comp_worldstate, "perk_gold_is_forever" ) ) then
					remove_gold_timer = true
				end
			end

			local amount = 5
			rnd = Random(0,100)
			if (rnd <= 80) then
				amount = 7
			elseif (rnd <= 95) then
				amount = 10
			elseif (rnd <= 100) then
				amount = 20
			end

			rnd = Random(0,100)
			if( rnd > 30 and rnd <= 80 ) then
				chest_load_gold_entity( "data/entities/items/pickup/goldnugget_50.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
			elseif (rnd <= 95) then
				chest_load_gold_entity( "data/entities/items/pickup/goldnugget_200.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
			elseif (rnd <= 99) then
				chest_load_gold_entity( "data/entities/items/pickup/goldnugget_1000.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
			else
				local tamount = Random( 1, 3 )
				for i=1,tamount do
					chest_load_gold_entity( "data/entities/items/pickup/goldnugget_50.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
				end
				if( Random(0, 100 ) > 50 ) then
					tamount = Random( 1, 3 )
					for i=1,tamount do
						chest_load_gold_entity( "data/entities/items/pickup/goldnugget_200.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
					end
				end
				if( Random(0, 100 ) > 80 ) then
					tamount = Random( 1, 3 )
					for i=1,tamount do
						chest_load_gold_entity( "data/entities/items/pickup/goldnugget_1000.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
					end
				end
			end


			for i=1,amount do
				chest_load_gold_entity( "data/entities/items/pickup/goldnugget.xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
			end
		elseif( rnd <= 50 ) then
			-------------------------------------------------------------------
			-- Potion
			-------------------------------------------------------------------
			rnd = Random(0,100)
			if (rnd <= 98) then
				table.insert( entities, { "data/entities/items/pickup/potion.xml" } )
			elseif (rnd <= 100) then
				rnd = Random(0,100)
				if( rnd <= 98 ) then
					table.insert( entities, { "data/entities/items/pickup/potion_secret.xml" } )
				elseif( rnd <= 100 ) then
					table.insert( entities, { "data/entities/items/pickup/potion_random_material.xml" } )
				end
			end
		elseif( rnd <= 54 ) then
			-------------------------------------------------------------------
			-- Spell refresh
			-------------------------------------------------------------------
			table.insert( entities, { "data/entities/items/pickup/spell_refresh.xml" } )
		
		elseif( rnd <= 60 ) then
			-------------------------------------------------------------------
			-- Misc items
			-------------------------------------------------------------------
			local opts = { "data/entities/items/pickup/moon.xml", 
			"data/entities/items/pickup/thunderstone.xml", 
			"mods/nukes_more_stones/files/nuke/entities/stone_fire.xml", 
			"mods/nukes_more_stones/files/nuke/entities/stone_ice.xml",
			"mods/nukes_more_stones/files/nuke/entities/stone_holy.xml",
			"mods/nukes_more_stones/files/nuke/entities/stone_skull.xml",
			"mods/nukes_more_stones/files/nuke/entities/stone_nuke.xml",
			"mods/nukes_more_stones/files/nuke/entities/pot_heal.xml",
			"mods/nukes_more_stones/files/nuke/entities/pot_precursor.xml",
			"mods/nukes_more_stones/files/nuke/entities/chakram_item.xml",
			"runestone", 
			"die" }

			rnd = Random( 1, #opts )
			local opt = opts[rnd]
			
			if ( opt == "die" ) then
				local flag_status = HasFlagPersistent( "card_unlocked_duplicate" )
				
				if flag_status then
					opt = "data/entities/items/pickup/physics_die.xml"
				else
					opt = "data/entities/items/pickup/potion.xml"
				end
			elseif ( opt == "runestone" ) then
				local r_opts = { "laser", "fireball", "lava", "slow", "null", "disc" }
				rnd = Random( 1, #r_opts )
				local r_opt = r_opts[rnd]
				
				opt = "data/entities/items/pickup/runestones/runestone_" .. r_opt .. ".xml"
			end
			
			table.insert( entities, { opt, x, y - 10 } )
			
		elseif( rnd <= 65 ) then
			-------------------------------------------------------------------
			-- Random card
			-------------------------------------------------------------------
			-- NOTE( Petri ): random_card.xml is bad, it leaves an empty entity hanging around
			-- table.insert( entities, { "data/entities/items/pickup/random_card.xml",  x + Random(-10,10), y - 4 + Random(-5,5) } )
			-- this does NOT call SetRandomSeed() on purpouse
			local amount = 1
			rnd = Random(0,100)
			if (rnd <= 50) then
				amount = 1
			elseif (rnd <= 70) then
				amount = amount + 1
			elseif (rnd <= 80) then
				amount = amount + 2
			elseif (rnd <= 90) then
				amount = amount + 3
			else
				amount = amount + 4
			end

			for i=1,amount do
				make_random_card( x + (i - (amount / 2)) * 8, y - 4 + Random(-5,5) )
			end
		elseif( rnd <= 84 ) then
			-------------------------------------------------------------------
			-- Wand
			-------------------------------------------------------------------

			rnd = Random(0,100)
			
			if( rnd <= 25 ) then
				table.insert( entities, { "data/entities/items/wand_level_01.xml" } )
			elseif( rnd <= 50 ) then
				table.insert( entities, { "data/entities/items/wand_unshuffle_01.xml" } )
			elseif( rnd <= 75 ) then
				table.insert( entities, { "data/entities/items/wand_level_02.xml" } )
			elseif( rnd <= 90 ) then
				table.insert( entities, { "data/entities/items/wand_unshuffle_02.xml" } )
			elseif( rnd <= 96 ) then
				table.insert( entities, { "data/entities/items/wand_level_03.xml" } )
			elseif( rnd <= 98 ) then
				table.insert( entities, { "data/entities/items/wand_unshuffle_03.xml" } )
			elseif( rnd <= 99 ) then
				table.insert( entities, { "data/entities/items/wand_level_04.xml" } )
			elseif( rnd <= 100 ) then
				table.insert( entities, { "data/entities/items/wand_unshuffle_04.xml" } )
			end
		elseif( rnd <= 95 ) then
			-------------------------------------------------------------------
			-- Heart(s)
			-------------------------------------------------------------------
			rnd = Random(0,100)
			
			if (rnd <= 89) then
				table.insert( entities, { "data/entities/items/pickup/heart.xml" } )
			elseif (rnd <= 99) then
				table.insert( entities, { "data/entities/items/pickup/heart_better.xml" } )
			else
				table.insert( entities, { "data/entities/items/pickup/heart_fullhp.xml" } )
			end
		elseif( rnd <= 98 ) then
			-------------------------------------------------------------------
			-- Converts the chest into gold
			-------------------------------------------------------------------
			EntityConvertToMaterial( entity_id, "gold")
		elseif( rnd <= 99 ) then
			-------------------------------------------------------------------
			-- exploding "dice"
			-------------------------------------------------------------------

			-- explode the random table
			-- do random reward 2 times...
			count = count + 2
		elseif( rnd <= 100 ) then
			-- explode the random table
			-- do random reward 3 times...
			count = count + 3
		end
	end

	for i,entity in ipairs(entities) do
		local eid = 0 
		if( entity[2] ~= nil and entity[3] ~= nil ) then 
			eid = EntityLoad( entity[1], entity[2], entity[3] ) 
		else
			eid = EntityLoad( entity[1], rand_x, rand_y )
			EntityApplyTransform( eid, x + Random(-10,10), y - 4 + Random(-5,5)  )
		end

		local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

		-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
		if item_comp ~= nil then
			if( ComponentGetValue2( item_comp, "auto_pickup") ) then
				ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
			end
		end
	end


	return good_item_dropped
end