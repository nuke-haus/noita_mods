table.insert( actions,
{
	id          = "REPELLING_FIELD",
	name 		= "Repelling Field",
	description = "Your projectiles repel nearby objects and projectiles.",
	sprite 		= "mods/nukes_spells/files/nuke/spell_gfx/repeller.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level        = "2,3,4,6",
	spawn_probability  = "1,1,1,1",
	price = 250,
	mana = 20,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 15
		current_reload_time = current_reload_time + 5
		c.extra_entities = c.extra_entities .. "mods/nukes_spells/files/nuke/entities/repeller.xml,"
		draw_actions(1, true)
	end,
} )

