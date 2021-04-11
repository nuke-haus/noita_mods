
local function summon(me, x, y, ent)

    local tbl = {
        script_source_file="mods/nukes_perks/files/nuke/scripts/baby_gorg_portal.lua",
        execute_on_added="0",
        execute_every_n_frame="200",
        execute_times="1" }

    local portal = EntityLoad("mods/nukes_perks/files/nuke/entities/gorgonbaby_portal.xml", x, y)
    EntityAddComponent(portal, "LuaComponent", tbl) 

end

local me = GetUpdatedEntityID()
local x,y = EntityGetTransform(me)
local alive = EntityGetWithTag("gorgon_stonebaby") or {}

if (#alive < 1) then

    summon(me, x, y, ent)

end