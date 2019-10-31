table.insert( actions,
{
	id          = "GRAVITY_WELL",
	name 		= "Gravity Well",
	description = "Your projectiles pull nearby objects and projectiles towards them.",
	sprite 		= "files/nuke/spell_gfx/gravity_well.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1",
	price = 250,
	mana = 25,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 20
		c.extra_entities = c.extra_entities .. "files/nuke/entities/gravity_well.xml,"
        --draw_actions(1, true)	
	end,
} )
