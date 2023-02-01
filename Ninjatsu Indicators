--damn, you've somehow crashed...

--This got declined on Primo market??? I assume it's due to the google drive / mega download, so here u have it.
--this is just a recreation based on what i saw in the original [i think its the original https://www.youtube.com/watch?v=CxAxYsm9N1Q]
--Also yes, this code is not ideal, but who cares..

ffi.cdef [[
    typedef void*(__thiscall* shell_execute_t)(void*, const char*, const char*); 
]] 

cp = ffi.typeof('void***')
vgui = memory.create_interface('vgui2.dll', 'VGUI_System010')
ivgui = ffi.cast(cp,vgui)
ShellExecuteA = ffi.cast("shell_execute_t", ivgui[0][3])

Menu = {
Slowwalk = menu.find("misc", "main", "movement", "slow walk")[2],
DoubleTap = menu.find("aimbot", "general", "exploits", "doubletap", "enable")[2],
HideShots = menu.find("aimbot", "general", "exploits", "hideshots", "enable")[2],
}

local position_y = menu.add_slider("Ninjatsu Indicators", "Position Y", -600, 600)

local q100 = menu.add_button("Ninjatsu Indicators", "quick 100", function()
    position_y:set(100)
end)
local q200 = menu.add_button("Ninjatsu Indicators", "quick 200", function()
    position_y:set(200)
end)
local q200 = menu.add_button("Ninjatsu Indicators", "quick 400", function()
    position_y:set(400)
end)

local info1 = menu.add_text("Info", "Ninjatsu Indicators by Dawio89#9849")
local info2 = menu.add_text("Info", "Visit our Discord for giveaway's and new lua releases!")

local open = menu.add_button("Info", "AUTISTIC Discord", function()
    ShellExecuteA(ivgui, 'open', "https://discord.com/invite/tjjEuCc4Uf")
end)

local info3 = menu.add_text("Images", "   Download the images and put them into")
local info4 = menu.add_text("Images", "[/Counter-Strike Global Offensive/primordial]")

local mirror1 = menu.add_button("Images", "Download mirror [Google Drive]", function()
    ShellExecuteA(ivgui, 'open', "https://drive.google.com/file/d/152mEUfkwbQzsXszam2uf5r13LEczUIfV/view?usp=sharing")
end)
local mirror2 = menu.add_button("Images", "Download mirror [Mega.nz]", function()
    ShellExecuteA(ivgui, 'open', "https://mega.nz/file/3lwl0Iqa#6s6VBtI1_VEyjPtgnlLlHPjrLmSuqm8H3FhOBNsauNE")
end)
local tutorial = menu.add_button("Images", "Tutorial", function()
    ShellExecuteA(ivgui, 'open', "https://www.youtube.com/watch?v=bMecR8pBefA")
end)


local screen_size = render.get_screen_size()
local screen_half_x = screen_size.x * 0.5
local screen_half_y = screen_size.y * 0.5

local dtop = 256
local dtint = 0

local hsop = 256
local hsint = 0

local swop = 256
local swint = 0

local fdop = 256
local fdint = 0


    doubletaplogo = render.load_image("primordial/dt.png")
    hideshotslogo = render.load_image("primordial/hs.png")
    slowwalklogo = render.load_image("primordial/sw.png")
    fakeducklogo = render.load_image("primordial/fd.png")

    if doubletaplogo == nil then
        print("Couldn't find the DT logo, makes sure its in the correct location")
    end
    if hideshotslogo == nil then
        print("Couldn't find the HS logo, makes sure its in the correct location")
    end
    if slowwalklogo == nil then
        print("Couldn't find the SW logo, makes sure its in the correct location")
    end
    if fakeducklogo == nil then
        print("Couldn't find the FD logo, makes sure its in the correct location")
    end

function paint_callback()

    local pLocal = entity_list.get_local_player()
    if not pLocal then
        return
    end

--dt
if Menu.DoubleTap:get() and dtint < 25 then
    dtint = dtint + 1
elseif dtint > 0 and not Menu.DoubleTap:get()  then
    dtint = 0
end


if dtint >= 25 and dtop > 0 then 
    dtop = dtop - 5
elseif dtint <= 0 then
    dtop = 255
end

--hs
if Menu.HideShots:get() and hsint < 25 then
    hsint = hsint + 1
elseif hsint > 0 and not Menu.HideShots:get()  then
    hsint = 0
end

if hsint >= 25 and hsop > 0 then 
    hsop = hsop - 5
elseif hsint <= 0 then
    hsop = 255
end

--sw
if Menu.Slowwalk:get() and swint < 25 then
    swint = swint + 1
elseif swint > 0 and not Menu.Slowwalk:get()  then
    swint = 0
end


if swint >= 25 and swop > 0 then 
    swop = swop - 5
elseif swint <= 0 then
    swop = 255
end

--fd
if antiaim.is_fakeducking() and fdint < 25 then
    fdint = fdint + 1
elseif fdint > 0 and not antiaim.is_fakeducking()  then
    fdint = 0
end


if fdint >= 25 and fdop > 0 then 
    fdop = fdop - 5
elseif fdint <= 0 then
    fdop = 255
end

    if Menu.DoubleTap:get() then 
        render.texture(doubletaplogo.id, vec2_t(screen_half_x-(doubletaplogo.size.x)/2+2, screen_half_y-position_y:get()-dtint-(doubletaplogo.size.y)/2), vec2_t(doubletaplogo.size.x, screen_half_y-450-(doubletaplogo.size.y)/2), color_t(255,255,255,dtop))
    end

    if Menu.HideShots:get() and not Menu.Slowwalk:get() then 
        render.texture(hideshotslogo.id, vec2_t(screen_half_x-(hideshotslogo.size.x)/2+2, screen_half_y-position_y:get()-hsint-(hideshotslogo.size.y)/2), vec2_t(hideshotslogo.size.x, screen_half_y-450-(hideshotslogo.size.y)/2), color_t(255,255,255,hsop))
    end

    if Menu.Slowwalk:get() then 
        render.texture(slowwalklogo.id, vec2_t(screen_half_x-(slowwalklogo.size.x)/2+2, screen_half_y-position_y:get()-swint-(slowwalklogo.size.y)/2), vec2_t(slowwalklogo.size.x, screen_half_y-450-(slowwalklogo.size.y)/2), color_t(255,255,255,swop))
    end

    if antiaim.is_fakeducking() then 
        render.texture(fakeducklogo.id, vec2_t(screen_half_x-(fakeducklogo.size.x)/2+2, screen_half_y-position_y:get()-fdint-(fakeducklogo.size.y)/2), vec2_t(fakeducklogo.size.x, screen_half_y-450-(fakeducklogo.size.y)/2), color_t(255,255,255,fdop))
    end

end

callbacks.add(e_callbacks.PAINT,paint_callback)

--adios


