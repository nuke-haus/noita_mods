

local tbl_spark = {
	"spark_blue",
	"spark_white",
	"spark_red",
	"spark_purple",
	"spark_yellow",
	"spark_green",
	"spark_teal",
	"lava"
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
	"magic_liquid_mana_regeneration",
	"magic_liquid_worm_attractor",
	"magic_liquid_protection_all",
	"magic_liquid_movement_faster",
	"material_confusion",
	"blood_fungi",
	"blood_worm",
	"radioactive_liquid_yellow",
	"radioactive_liquid",
	"poison",
	"pea_soup", --lol
	"slime",
	"slime_green",
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
	"sand_herb",
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
local childs = EntityGetAllChildren(me)

for i, child in pairs(childs) do
	
	local ems = EntityGetComponent(child, "ParticleEmitterComponent")

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

end

