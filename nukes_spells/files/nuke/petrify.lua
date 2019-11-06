table.insert( actions,
{
	id          = "PETRIFY",
	name 		= "Petrify",
	description = "A terrifying spell that turns almost everything nearby to stone.",
	sprite 		= "files/nuke/spell_gfx/petrify.png",
	type 		= ACTION_TYPE_STATIC_PROJECTILE,
	spawn_level                       = "3,4,5,6",
	spawn_probability                 = "1,1,1,1",
	price = 450,
	mana = 120,
	max_uses = 1,
	action = function()
		add_projectile("files/nuke/entities/petrify.xml")
		c.fire_rate_wait = c.fire_rate_wait + 80
		current_reload_time = current_reload_time + 80
	end,
} )

