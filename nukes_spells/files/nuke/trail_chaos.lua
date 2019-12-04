table.insert( actions,
{
	id          = "CHAOS_TRAIL",
	name 		= "Chaotic Trail",
	description = "Projectiles leave a trail of random materials.",
	sprite 		= "mods/nukes_spells/files/nuke/spell_gfx/trail_chaos.png",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "2,3,4,5", 
	spawn_probability                 = "1,1,1,1", 
	price = 220,
	mana = 25,
	--max_uses = 50,
	custom_xml_file = "mods/nukes_spells/files/nuke/entities/chaos_trail_wand.xml",
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 25
		current_reload_time = current_reload_time + 5
		c.extra_entities = c.extra_entities .. "mods/nukes_spells/files/nuke/entities/chaos_trail.xml,"
		draw_actions(1, true)
	end,
} )

