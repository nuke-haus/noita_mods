
local me = GetUpdatedEntityID() -- the player
local x, y = EntityGetTransform(me)

EntityLoad( "files/nuke/ice_kill.xml", x, y - 5 )
EntityLoad( "files/nuke/ice_kill.xml", x, y - 1 )
--EntityLoad( "files/nuke/ice_kill.xml", x, y )



