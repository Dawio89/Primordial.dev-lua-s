-- made on request
local screen = render.get_screen_size()
local font = render.create_font("Verdana", 13, 600, e_font_flags.ANTIALIAS)

local function on_paint()
    if not engine.is_connected() then return end
    if not engine.is_in_game() then return end
 
    Ping = math.floor(1000 * engine.get_latency(e_latency_flows.OUTGOING) +
    engine.get_latency(e_latency_flows.INCOMING))
 
    hour, minute, second = client.get_local_time()
    time = string.format("%02d:%02d:%02d", hour, minute, second)
 
    fps = client.get_fps()

    game = "game         | "
    sense = "      sense"
    text = "game         | " .. user.name .. " | " .. fps .. "fps | " .. time

    w = render.get_text_size(font, text).x + 8
    h = 18

    x = screen.x - 2
    y = 12
    x = x - w - 10

    wh = (render.get_text_size(font, text).x * 0.5) + 4
  
    render.rect_filled(vec2_t(x - 6, y - 6), vec2_t(w + 13, h + 14), color_t(0, 0, 0, 255))
    render.rect_filled(vec2_t(x - 5, y - 5), vec2_t(w + 11, h + 12), color_t(34, 34, 34, 255))
    render.rect_filled(vec2_t(x + 1, y), vec2_t(w, h + 1), color_t(0, 0, 0, 255))

    render.rect(vec2_t(x - 1, y - 1), vec2_t(w + 3, h + 3), color_t(56, 56, 56, 255))
    render.rect(vec2_t(x - 5, y - 5), vec2_t(w + 11, h + 12), color_t(56, 56, 56, 255))

    render.rect_fade(vec2_t(x + 2, y + 1), vec2_t(wh - 1, 1), color_t(59, 175, 222, 255), color_t(202, 70, 205, 255), true)
    render.rect_fade(vec2_t(x + 1 + wh, y + 1), vec2_t(wh - 1, 1), color_t(202, 70, 205, 255), color_t(201, 227, 58, 255), true)
    render.rect_fade(vec2_t(x + 2, y + 2), vec2_t(wh - 1, 1), color_t(59, 175, 222, 130), color_t(202, 70, 205, 130), true)
    render.rect_fade(vec2_t(x + 1 + wh, y + 2), vec2_t(wh - 1, 1), color_t(202, 70, 205, 130), color_t(201, 227, 58, 130), true)

    render.text(font, text, vec2_t(x + 5, y + 4), color_t(255, 255, 255, 255))
    render.text(font, sense, vec2_t(x + 13, y + 4), color_t(160, 200, 80, 255))
end

callbacks.add(e_callbacks.PAINT, on_paint)
