
dofile("data/scripts/perks/perk.lua")

local get_perk_flag_name = function( perk_id )
	return "PERK_" .. perk_id
end

local function drop_perk(x, y)

	local perks = perk_get_spawn_order()
	local next_perk_index = tonumber( GlobalsGetValue( "TEMPLE_NEXT_PERK_INDEX", "1" ) )
	local perk_data = get_perk_with_id( perk_list, perks[next_perk_index] )
		
	next_perk_index = next_perk_index + 1

	if next_perk_index > #perks then
		next_perk_index = 1
	end

	GlobalsSetValue( "TEMPLE_NEXT_PERK_INDEX", tostring(next_perk_index) )
	GameAddFlagRun( get_perk_flag_name(perk_data.id) )

	perk_spawn( x, y, perks[next_perk_index] )

end

function damage_received(damage, message, entity_thats_responsible, is_fatal)

	local me = GetUpdatedEntityID()
	local comp = EntityGetFirstComponent(me, "DamageModelComponent")
	local hp = ComponentGetValueFloat(comp, "hp")
	local x, y = EntityGetTransform(me)

	if (is_fatal) then -- drop a perk

		drop_perk(x,y)
		EntityConvertToMaterial(me, "acid")
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
		EntityKill(me)

	end

	if (hp < 40 and EntityHasTag(me, "pissed_off") == false) then -- wake them up

		EntityAddTag(me, "pissed_off")

		local eff = EntityLoad("files/nuke/entities/gorgon_effect.xml", x, y)

		EntityAddChild(me, eff)

		local tbl = {
			script_source_file="files/nuke/scripts/gorgon_spawn_enemy.lua",
			execute_on_added="1",
			execute_every_n_frame="400",
			execute_times="-1" }

		EntityAddComponent(me, "LuaComponent", tbl) 

		local hbar1 = {
			_tags="health_bar_back,ui,no_hitbox",
			alpha="1", 
			has_special_scale="1", 
			image_file="data/ui_gfx/health_slider_back.png", 
			is_text_sprite="0", 
			next_rect_animation="", 
			offset_x="12", 
			offset_y="22", 
			rect_animation="", 
			special_scale_x="1", 
			special_scale_y="1", 
			ui_is_parent="0", 
			update_transform="1", 
			visible="1", 
			z_index="-9000"
		}

		local hbar2 = {
			_tags="health_bar,ui,no_hitbox", 
			alpha="1", 
			has_special_scale="1", 
			image_file="data/ui_gfx/health_slider_front.png", 
			is_text_sprite="0", 
			next_rect_animation="", 
			offset_x="11", 
			offset_y="22", 
			rect_animation="", 
			special_scale_x="1", 
			special_scale_y="1", 
			ui_is_parent="0", 
			update_transform="1", 
			visible="1", 
			z_index="-9000"
		}

		EntityAddComponent(me, "SpriteComponent", hbar1) 
		EntityAddComponent(me, "SpriteComponent", hbar2) 
		EntityAddComponent(me, "HealthBarComponent", {}) 

	end

end

local me = GetUpdatedEntityID()
local bod = EntityGetFirstComponent(me, "PhysicsBodyComponent")
local x, y = EntityGetTransform(me)

if (bod ~= nil and bod ~= 0) then

	local pix = ComponentGetValueInt(bod, "mPixelCount")
		
	if (pix < 1000) then -- they cheesed it

		local baddy = EntityLoad("files/nuke/entities/stone_physics.xml", x, y - 4)
		local hp = EntityGetFirstComponent(baddy, "DamageModelComponent")

		if (hp ~= nil and hp ~= 0) then

			ComponentSetValue(hp, "hp", "5")

		end

		EntityLoad("data/entities/items/pickup/heart.xml", x, y)
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
		EntityConvertToMaterial(me, "acid")
		EntityKill(me)

	end

end