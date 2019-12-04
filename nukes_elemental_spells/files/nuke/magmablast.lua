table.insert( actions,
{
	id          = "MAGMABLAST",
	name 		= "Magma Blast",
	description = "Unleash a molten meteor that quickly explodes into a shower of magma.",
	sprite 		= "mods/nukes_elemental_spells/files/nuke/sprites/magmablast.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "2,3,4,6",
	spawn_probability                 = "1,1,1,1",
	price = 260,
	mana = 80,
	custom_xml_file = "mods/nukes_elemental_spells/files/nuke/magmawand.xml",
	action 		= function()
	    add_projectile("mods/nukes_elemental_spells/files/nuke/magmablast.xml")
		c.fire_rate_wait = c.fire_rate_wait + 50
		shot_effects.recoil_knockback = 80.0
	end,
} )
