dofile( "data/scripts/lib/utilities.lua" )

--[[local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local ents = {}
local how_many = 25
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 40

for i=1,how_many do

	local pos_x = math.cos( theta ) * length
	local pos_y = math.sin( theta ) * length
	theta = theta + angle_inc
	
	local ent2 = EntityGetClosest(pos_x, pos_y, entity_id)
	local ent = EntityGetClosestWithTag( pos_x, pos_y, "teleportable_NOT" )
	local px, py = EntityGetTransform( ent )
	local distance = math.abs( x - px ) + math.abs( y - py )
	local shouldbreak = false
	
	print("debug ent2 " .. EntityGetName(ent2) .. " x " .. x .. " y " .. y .. " name " .. EntityGetName(ent) .. " px " .. px .. " py " .. py .. " dist " .. distance)
	
	for key, value in pairs(EntityGetTags(ent)) do
	
		print("TAG" .. value)
	
	end
	
	if distance > 40 then
	
		shouldbreak = true
		goto escape
	
	end
	
	print("close enough to " .. ent)
	
	for key, value in pairs(ents) do
	
		if ent == value then
		
			shouldbreak = true
			goto escape
			
		end
		
	end
	
	::escape::
	
	if not shouldbreak then
	
		table.insert(ents, ent)
		
		print("freezed em")
		
		shoot_projectile( projectile_id, "files/nuke/hackyfreeze.xml", px, py, 0, 1, false )
	
	end
	
end
--]]--

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

shoot_projectile( entity_id, "files/nuke/hackyfreeze.xml", x, y, 0, 0, false )
