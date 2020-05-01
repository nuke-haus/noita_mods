
function spawn_potions(x, y) -- we just replace the default function with this one

	SetRandomSeed( x+425, y-243 )

	local rnd = Random(1,100) -- idk why the fuck they made this a random number between 1 and 84, let's make it nice and simple
	
	if ( rnd >= 92 ) then -- 9 percent chance

		local rnd2 = Random(1, 7)

		if (rnd2 <= 2) then

			EntityLoad( "data/entities/items/pickup/thunderstone.xml", x, y-2 )	

		elseif (rnd2 <= 4) then

			EntityLoad( "mods/nukes_more_stones/files/nuke/entities/stone_ice.xml", x, y-2 )

		elseif (rnd2 <= 6) then

			EntityLoad( "mods/nukes_more_stones/files/nuke/entities/stone_fire.xml", x, y-2 )

		else

			EntityLoad( "mods/nukes_more_stones/files/nuke/entities/stone_holy.xml", x, y-2 )

		end

	elseif ( rnd >= 85 ) then -- 7 percent chance

		EntityLoad( "data/entities/items/pickup/egg_monster.xml", x, y-2 )

	elseif ( rnd >= 80 ) then -- 5 percent chance

		EntityLoad( "data/entities/items/pickup/egg_slime.xml", x, y-2 )

	elseif ( rnd >= 77 ) then -- 3 percent chance

		EntityLoad( "data/entities/items/pickup/egg_fire.xml", x, y-2 )

	elseif ( rnd >= 75 ) then -- 2 percent chance

		EntityLoad( "data/entities/items/pickup/egg_red.xml", x, y-2 )

	elseif ( rnd >= 71 ) then -- 4 percent

		EntityLoad( "data/entities/items/pickup/broken_wand.xml", x, y-2 )

	elseif ( rnd >= 68 ) then -- 3 percent

		EntityLoad( "mods/nukes_more_stones/files/nuke/entities/stone_skull.xml", x, y-2 )

	elseif ( rnd >= 67 ) then -- 1 percent

		EntityLoad( "mods/nukes_more_stones/files/nuke/entities/stone_nuke.xml", x, y-2 )

	elseif ( rnd >= 66 ) then -- 1 percent

		local rnd3 = Random(1,2)

		if ( rnd3 == 1 ) then

			EntityLoad( "mods/nukes_more_stones/files/nuke/entities/pot_heal.xml", x, y-2 )

		else

			EntityLoad( "mods/nukes_more_stones/files/nuke/entities/pot_precursor.xml", x, y-2 )

		end

	else -- 65 percent chance

		EntityLoad( "data/entities/items/pickup/potion.xml", x, y-2 )

	end

end