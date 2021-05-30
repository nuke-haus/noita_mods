dofile_once("data/scripts/lib/utilities.lua")

local function summon(me, x, y)

    local tbl = {
        script_source_file="mods/nukes_perks/files/nuke/scripts/baby_gorg_portal.lua",
        execute_on_added="0",
        execute_every_n_frame="200",
        execute_times="1" }

    local portal = EntityLoad("mods/nukes_perks/files/nuke/entities/gorgonbaby_portal.xml", x, y)
    EntityAddComponent(portal, "LuaComponent", tbl) 

end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

    local flag_name = "BABYGORGON_PERK_TOTAL_COUNT"
    local count = tonumber( GlobalsGetValue( flag_name, "0" ) )
    
    if (count < 4) then
        count = count + 1
        GlobalsSetValue( flag_name, count )
        return
    end

    GlobalsSetValue( flag_name, 0 )

    local alive = EntityGetWithTag("gorgon_stonebaby") or {}

    if (#alive < 1) then

        local entity_id = GetUpdatedEntityID()
        local x, y = EntityGetTransform( entity_id )

        SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
        summon(entity_id, x, y)

    end

end