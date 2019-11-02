
dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/gun/gun_actions.lua" )

local RADIUS = 30.0

local function make_random_card(me)

	local x, y = EntityGetTransform(me)

	local item = ""
	local valid = false

	while ( valid == false ) do

		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then

			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then

				valid = true

			end

		else

			valid = true

		end

	end

	if ( string.len(item) > 0 ) then

		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity

	else

		print( "No valid action entity found!" )

	end

	return nil

end

local function get_valid_ents(me, x, y, rad)

	local bad = {}
	local wands = {}
	local cards = {}
	local near = EntityGetInRadius(x, y, rad)

	if (near == nil) then

		return bad

	end

	for k,v in pairs(near) do

		if (EntityHasTag(v, "ignore_altar")) then

			goto skips

		end

		local itemcomp = EntityGetComponent(v, "ItemComponent")
		local lightcomp = EntityGetComponent(v, "LightComponent")
		local velcomp = EntityGetComponent(v, "VelocityComponent")
		local itemacomp = EntityGetComponent(v, "ItemActionComponent")
		local parent = EntityGetParent(v) 

		--if (EntityHasTag(v, "wand") and itemcomp ~= nil and velcomp ~= nil) then
		if (itemcomp ~= nil and velcomp ~= nil and lightcomp ~= nil) then -- hax

			table.insert(wands, v)
			goto skips

		end

		if (EntityHasTag(v, "card_action") and (parent == nil or parent == 0)) then

			table.insert(cards, v)
			goto skips

		end

		local body = EntityGetComponent(v, "PhysicsBodyComponent")

		if ((parent == nil or parent == 0) and (EntityHasTag(v, "tablet") or (body ~= nil or EntityHasTag(v, "item_physics")))) then

			table.insert(bad, v)

		end

		::skips::
		
	end

	return wands, cards, bad

end

local function get_actions(wand)

    local actions = {};
	local children = EntityGetAllChildren(wand);

	if (children == nil) then

		return actions

	end
	
	for i,v in ipairs(children) do
		
        local all_comps = EntityGetAllComponents(v);
		
		for i, c in ipairs(all_comps) do
			
			local action_id = ComponentGetValue(c, "action_id");
			
			if action_id ~= nil and action_id ~= "" then
			
				table.insert(actions, action_id);
				
			end
			
		end

	end
	
	return actions;
	
end

local me = GetUpdatedEntityID() 
local x, y = EntityGetTransform(me)
local wands, cards, bad = get_valid_ents(me, x, y, RADIUS)

for k,v in pairs(wands) do

	local x2, y2 = EntityGetTransform(v)
	local actions = get_actions(v)
	local count = math.max(math.floor(#actions / 4), 1)

	print("gonna give you a pile of shit " .. count)

	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x2, y2)

	for i = 1, count do

		local idx = Random(1, #actions)
		local str = actions[idx]

		if (Random(1,8) == 1 or str == nil or str == "") then

			local card = make_random_card(v)
			EntityAddTag(card, "ignore_altar")

		else

			print("generating a " .. tostring(str))

			local card = CreateItemActionEntity( str, x2, y2 )
			EntityAddTag(card, "ignore_altar")

		end

	end	
	
	EntityConvertToMaterial(v, "spark_purple_bright")
	EntityKill(v)

end

for k,v in pairs(cards) do

	local x2, y2 = EntityGetTransform(v)

	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x2, y2)

	for i=1,8 do

		local gold = EntityLoad( "data/entities/items/pickup/goldnugget.xml", x2 + Random(-10,10), y2 - 4 + Random(-10,10) )

		EntityAddTag(gold, "ignore_altar")

		edit_component( gold_entity_id, "ItemComponent", function(comp,vars)
			vars.next_frame_pickable = GameGetFrameNum() + 30
		end)

	end

	EntityConvertToMaterial(v, "spark_purple_bright")
	EntityKill(v)

end

for k,v in pairs(bad) do

	GamePrintImportant("The gods are displeased", "")

	EntityLoad("data/entities/particles/image_emitters/altar_tablet_curse_symbol.xml", x, y)
	EntityLoad("files/nuke/entities/collapser.xml", x, y)

	EntityConvertToMaterial(v, "blood")
	EntityKill(v)

	EntityKill(me)

	return

end