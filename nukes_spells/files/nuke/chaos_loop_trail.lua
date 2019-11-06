

local tbl_spark = {
	"spark_blue",
	"spark_white",
	"spark_red",
	"spark_purple",
	"spark_yellow",
	"spark_green",
	"spark_teal"
}

local tbl_mats = {
	"water",
	"water_swamp",
	"ice",
	"blood",
	"oil",
	"alcohol",
	"magic_liquid_charm",
	"magic_liquid_invisibility",
	"magic_liquid_teleportation",
	"magic_liquid_polymorph",
	"magic_liquid_random_polymorph",
	"magic_liquid_berserk",
	"blood_fungi",
	"blood_worm",
	"radioactive_liquid_yellow",
	"radioactive_liquid",
	"poison",
	"slime",
	"slime_green",
	"pea_soup", --lol
	"acid"
}

local rare = {
	"honey",
	"liquid_fire_weak",
	"snow",
	"meat",
	"rotten_meat",
	"rotten_meat_radioactive",
	"meat_slime_sand",
	"meat_slime",
	"meat_slime_green",
	"meat_slime_orange",
	"meat_worm",
	"coal",
	"sulphur",
	"salt",
	"burning_powder",
	"gunpowder",
	"gunpowder_explosive",
	"gunpowder_tnt",
	"gold",
	"gold_radioactive",
	"grass",
	"fungi",
	"fungi_green",
	"moss",
	"mushroom",
	"glowshroom",
	"sand_herb",
	"sand",
	"sand_blue",
	"bone",
	"soil",
	"fungisoil"
}

local function has_value(tbl, value)

	for k,v in pairs(tbl) do

		if (v == value) then

			return true

		end

	end

	return false

end





    local me = GetUpdatedEntityID() 
	local ems = EntityGetComponent(me, "ParticleEmitterComponent")

	for k,v in pairs(ems) do

		local mat = ComponentGetValue(v, "emitted_material_name")

		if (has_value(tbl_mats, mat) or has_value(rare, mat)) then

			mat = tbl_mats[Random(1, #tbl_mats)]

			if (Random(1,8) == 1) then

				mat = rare[Random(1, #rare)]

			end

			ComponentSetValue(v, "emitted_material_name", mat)

		elseif (has_value(tbl_spark, mat)) then

			mat = tbl_spark[Random(1, #tbl_spark)]
			ComponentSetValue(v, "emitted_material_name", mat)

		end

	end



