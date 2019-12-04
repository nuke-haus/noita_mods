table.insert( actions,
{
	id          = "GRAVITY_WELL",
	name 		= "Gravity Well",
	description = "Your projectiles pull nearby objects and projectiles towards them.",
	sprite 		= "mods/nukes_spells/files/nuke/spell_gfx/gravity_well.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level        = "2,3,4,6",
	spawn_probability  = "1,1,1,1",
	price = 250,
	mana = 25,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 25
		current_reload_time = current_reload_time + 15
		c.extra_entities = c.extra_entities .. "mods/nukes_spells/files/nuke/entities/gravity_well.xml,"
		draw_actions(1, true)
	end,
} )

