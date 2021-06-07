
table.insert( actions,
{
	id          = "SNOWBALL",
	name 		= "Snowball",
	description = "A freezing ball of snow",
	sprite 		= "mods/nukes_spells/files/nuke/spell_gfx/snowball.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,1,2,3", 
	spawn_probability                 = "1,1,1,1", 
	price = 110,
	mana = 5,
	action 		= function()
		add_projectile("mods/nukes_spells/files/nuke/entities/snowball.xml")
		c.screenshake = c.screenshake + 0.5
		c.fire_rate_wait = c.fire_rate_wait + 4
	end,
} )

table.insert( actions,
{
	id          = "SNOWBALL_TRIGGER",
	name 		= "Snowball with trigger",
	description = "A freezing ball of snow that casts another spell upon collision",
	sprite 		= "mods/nukes_spells/files/nuke/spell_gfx/snowball_trigger.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,1,2,3", 
	spawn_probability                 = "1,1,1,1", 
	price = 150,
	mana = 10,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 4
		c.screenshake = c.screenshake + 0.5
		add_projectile_trigger_hit_world("mods/nukes_spells/files/nuke/entities/snowball.xml", 1)
	end,
} )

table.insert( actions,
{
	id          = "SNOWBALL_TIMER",
	name 		= "Snowball with timer",
	description = "A freezing ball of snow that casts another spell after a timer runs out",
	sprite 		= "mods/nukes_spells/files/nuke/spell_gfx/snowball_timer.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,1,2,3", 
	spawn_probability                 = "1,1,1,1", 
	price = 150,
	mana = 10,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 4
		c.screenshake = c.screenshake + 0.5
		add_projectile_trigger_timer("mods/nukes_spells/files/nuke/entities/snowball.xml", 10, 1)
	end,
} )

