table.insert( actions,
{
	id          = "ICEBLAST",
	name 		= "Flash Freeze",
	description = "Unleash a concentrated burst of freezing energy",
	sprite 		= "mods/nukes_elemental_spells/files/nuke/sprites/iceblast.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "2,3,4,5",
	spawn_probability                 = "1,1,1,1",
	price = 270,
	mana = 80,
	custom_xml_file = "mods/nukes_elemental_spells/files/nuke/icewand.xml",
	action 		= function()
	    add_projectile("mods/nukes_elemental_spells/files/nuke/iceblast.xml")
		c.fire_rate_wait = c.fire_rate_wait + 50
		c.extra_entities = c.extra_entities .. "data/entities/particles/freeze_charge.xml,"
		shot_effects.recoil_knockback = 50.0
	end,
} )
