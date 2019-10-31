dofile( "data/scripts/lib/utilities.lua" )

local projectile = GetUpdatedEntityID() -- the projectile

--local mouseX, mouseY = DEBUG_GetMouseWorld()
local x, y = EntityGetTransform(projectile)

--local directionX = (mouseX + Random(-5, 5)) - x

--local directionY = (mouseY + Random(-5, 5)) - y

local Speed = 100

local vel_comp = EntityGetComponent(projectile, "VelocityComponent")
local proj_comp = EntityGetComponent(projectile, "ProjectileComponent")[1]

if (vel_comp ~= nil) then
	
	edit_component( projectile, "VelocityComponent", function(comp,vars)
		
		local velocityX, velocityY = ComponentGetValueVector2( comp, "mVelocity")

		local vel_x = directionX

		local vel_y = directionY
		
		local len = math.sqrt((vel_x*vel_x) + (vel_y*vel_y))

		local dir_x = vel_x / len
		local dir_y = vel_y / len

		local force_x = (velocityX*0.96) + (dir_x * Speed)
		local force_y = (velocityY*0.96) + (dir_y * Speed)
		
		--shoot_projectile( player, "files/entities/physbeam.xml", playerX + (dir_x2 * 10), playerY + (dir_y2 * 10), dir_x2 * 20, dir_y2 * 20 )
		ComponentSetValue( comp, "gravity_x", 0 )
		ComponentSetValue( comp, "gravity_y", 0 )
		ComponentSetValueVector2( comp, "mVelocity", force_x, force_y )
		--ComponentSetValueVector2( comp, "mVelocity", force_x, force_y)

	end)	

end

