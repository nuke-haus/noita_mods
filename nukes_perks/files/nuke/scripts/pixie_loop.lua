
local function shoot(me, x, y)

    local portal = EntityLoad("mods/nukes_perks/files/nuke/entities/pixie_portal.xml", x, y)

    local tbl = {
        script_source_file="mods/nukes_perks/files/nuke/scripts/pixie_portal.lua",
        execute_on_added="0",
        execute_every_n_frame="200",
        execute_times="1" }

    EntityAddComponent(portal, "LuaComponent", tbl) 

end

local me = GetUpdatedEntityID()
local x,y = EntityGetTransform(me)

local tbl1 = EntityGetWithTag( "pixie_fire" ) or {}
local tbl2 = EntityGetWithTag( "pixie_ice" ) or {}
local tbl3 = EntityGetWithTag( "pixie_electric" ) or {}
local tbl4 = EntityGetWithTag( "pixie_poison" ) or {}

if (#tbl1 == 0 or #tbl2 == 0 or #tbl3 == 0 or #tbl4 == 0) then

    shoot(me, x, y - 2.5)

end
