
dofile_once("data/scripts/lib/utilities.lua")

table_spells = {"mods/nukes_spells/files/nuke/entities/petrify.xml",
"data/entities/projectiles/deck/cloud_acid.xml",
"data/entities/projectiles/deck/cloud_blood.xml",
"data/entities/projectiles/deck/cloud_thunder.xml",
"data/entities/projectiles/deck/cloud_water.xml",
"data/entities/projectiles/deck/mist_alcohol.xml",
"data/entities/projectiles/deck/mist_blood.xml",
"data/entities/projectiles/deck/mist_radioactive.xml",
"data/entities/projectiles/deck/mist_slime.xml",
"data/entities/projectiles/deck/black_hole_big.xml",
"data/entities/projectiles/deck/chaos_polymorph_field.xml",
"data/entities/projectiles/deck/charm_field.xml",
"data/entities/projectiles/deck/electrocution_field.xml",
"data/entities/projectiles/deck/freeze_field.xml",
"data/entities/projectiles/deck/explosion.xml",
"data/entities/projectiles/deck/death_cross_big.xml",
"data/entities/projectiles/deck/sea_acid.xml",
"data/entities/projectiles/deck/sea_lava.xml",
"data/entities/projectiles/deck/sea_alcohol.xml",
"data/entities/projectiles/deck/sea_oil.xml",
"data/entities/projectiles/deck/sea_water.xml",
"data/entities/projectiles/deck/glitter_bomb_explosion.xml",
"data/entities/projectiles/deck/crumbling_earth.xml",
"data/entities/projectiles/iceskull_explosion.xml",
"data/entities/projectiles/freeze_circle.xml"}

function damage_received(damage, message, entity_thats_responsible, is_fatal)

	local card = random_from_array( table_spells )
	local me = GetUpdatedEntityID()
	local x, y = EntityGetTransform(me)

	EntityLoad( card, x, y )
	EntityConvertToMaterial(me, "blood")
	EntityKill( me )

end