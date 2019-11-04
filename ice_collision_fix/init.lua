
function OnModPreInit()
	
end

function OnModInit()
	
end

function OnModPostInit()
	
end

function OnPlayerSpawned(player) 

	local x, y = EntityGetTransform(player)
	local c = EntityLoad( "files/nuke/ice_fix.xml", x, y )
	EntityAddChild(player, c)

end

print("Ice collision fix mod initialization done.")