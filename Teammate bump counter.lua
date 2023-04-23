local screen = render.get_screen_size()
local screenHalfX = screen.x * 0.5
local screenHalfY = screen.y * 0.5
local bumpCounter = 0
local lastBumpTime = 0
local sp15 = render.create_font("Smallest Pixel-7", 15, 20, e_font_flags.OUTLINE)

local function on_paint()
    local pLocal = entity_list.get_local_player()
    if pLocal == nil then
        return
    end
    
    local teammates = entity_list.get_players()
    for _, teammate in ipairs(teammates) do
        if teammate ~= pLocal and teammate:get_prop("m_iTeamNum") == pLocal:get_prop("m_iTeamNum") then
            local currentTime = globals.real_time()
            local distance = pLocal:get_prop("m_vecAbsOrigin"):dist(teammate:get_prop("m_vecAbsOrigin"))
            if distance < 45 and currentTime - lastBumpTime > 0.5 then
                bumpCounter = bumpCounter + 1
                lastBumpTime = currentTime
            end
        end
    end
    render.text(sp15, "BUMP COUNTER: "..bumpCounter, vec2_t(10, screenHalfY), color_t(255, 255, 255, 255))
end

callbacks.add(e_callbacks.PAINT, on_paint)
