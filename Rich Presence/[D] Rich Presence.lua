--this is all done in a ghetto way cuz it was never supposed to see the light of day, but some people apparently want it soooo... here u go ¯\_(ツ)_/¯

local panorama = require("primordial/Panorama Library.248") -- https://community.primordial.dev/resources/panorama-library.248/
local json = require("primordial/JSON Library.97") -- https://community.primordial.dev/resources/json-library.97/

ffi.cdef [[
    typedef void*(__thiscall* shell_execute_t)(void*, const char*, const char*); 
]] 

cp = ffi.typeof('void***')
vgui = memory.create_interface('vgui2.dll', 'VGUI_System010')
ivgui = ffi.cast(cp,vgui)
ShellExecuteA = ffi.cast("shell_execute_t", ivgui[0][3])

kad_enable = menu.add_checkbox("Rich Presence", "Show player stats", true)

ShellExecuteA(ivgui, 'open', "C:/Windows/SysWOW64/primordialrpc.exe") -- u can change the directory if u want to


--FILESYSTEM . pasted from forum
local filesystem = {} filesystem.__index = {}

filesystem.class = ffi.cast(ffi.typeof("void***"), memory.create_interface("filesystem_stdio.dll", "VBaseFileSystem011"))
filesystem.v_table = filesystem.class[0]

filesystem.casts = {
    read_file = ffi.cast("int (__thiscall*)(void*, void*, int, void*)", filesystem.v_table[0]),
    write_file = ffi.cast("int (__thiscall*)(void*, void const*, int, void*)", filesystem.v_table[1]),
    open_file = ffi.cast("void* (__thiscall*)(void*, const char*, const char*, const char*)", filesystem.v_table[2]),
    close_file = ffi.cast("void (__thiscall*)(void*, void*)", filesystem.v_table[3]),
    file_size = ffi.cast("unsigned int (__thiscall*)(void*, void*)", filesystem.v_table[7]),
    file_exists = ffi.cast("bool (__thiscall*)(void*, const char*, const char*)", filesystem.v_table[10]),
}

filesystem.modes = {
    ["r"] = "r", ["w"] = "w", ["a"] = "a",
    ["r+"] = "r+", ["w+"] = "w+", ["a+"] = "a+",
    ["rb"] = "rb", ["wb"] = "wb", ["ab"] = "ab",
    ["rb+"] = "rb+", ["wb+"] = "wb+", ["ab+"] = "ab+",
}

filesystem.open = function(file, mode, id)
    if (not filesystem.modes[mode]) then error("Invalid Mode!") end

    local self = setmetatable({
        file = file,
        mode = mode,
        path_id = id,
        handle = filesystem.casts.open_file(filesystem.class, file, mode, id)
    }, filesystem)

    return self
end

filesystem.close = function(fs)
    filesystem.casts.close_file(filesystem.class, fs.handle)
end

filesystem.exists = function(file, id)
    return filesystem.casts.file_exists(filesystem.class, file, id)
end

filesystem.get_size = function(fs)
    return filesystem.casts.file_size(filesystem.class, fs.handle)
end

function filesystem.write(path, buffer)
    local fs = filesystem.open(path, "w", "MOD")
    filesystem.casts.write_file(filesystem.class, buffer, #buffer, fs.handle)
    filesystem.close(fs)
end

function filesystem.append(path, buffer)
    local fs = filesystem.open(path, "a", "MOD")
    filesystem.casts.write_file(filesystem.class, buffer, #buffer, fs.handle)
    filesystem.close(fs)
end

function filesystem.read(path)
    local fs = filesystem.open(path, "r", "MOD")
    local size = filesystem.get_size(fs)
    local output = ffi.new("char[?]", size + 1)
    filesystem.casts.read_file(filesystem.class, output, size, fs.handle)
    filesystem.close(fs)

    return ffi.string(output)
end

filesystem.write("rpc_data.Autism", "In Main Menu\n   ")

-- end of filesystem

local js = panorama.open()
local LobbyAPI, PartyListAPI, GameStateAPI, FriendsListAPI = js.LobbyAPI, js.PartyListAPI, js.GameStateAPI, js.FriendsListAPI

 -- this was pasted from some gamesense lua
  local localize_impl = panorama.loadstring([[
    return {
      localize: (str, params) => {
        if(params == null)
          return $.Localize(str)
  
        var panel = $.CreatePanel("Panel", $.GetContextPanel(), "")
  
        for(key in params) {
          panel.SetDialogVariable(key, params[key])
        }
  
        var result = $.Localize(str, panel)
  
        panel.DeleteAsync(0.0)
  
        return result
      }
    }
  ]])().localize
  
  local localize_cache = {}
  local function localize(str, params)
    if str == nil then return "" end

    if localize_cache[str] == nil then
      localize_cache[str] = {}
    end

    local params_key = params ~= nil and tostring(params) or true
    if localize_cache[str][params_key] == nil then
      localize_cache[str][params_key] = localize_impl(str, params)
    end

    return localize_cache[str][params_key]
end

local w1 = 0

local function on_paint()

  if w1 < 300 then
    w1 = w1 + 1
  else
    w1 = 0
  end
  
if kad_enable:get() == true and engine.is_connected() then
  local kills = player_resource.get_prop("m_iKills", 1) or 0
  local assists = player_resource.get_prop("m_iAssists", 1) or 0
  local deaths = player_resource.get_prop("m_iDeaths", 1) or 0
  PLAYER_STATS = string.format("CS:GO [ K:%d | A:%d | D:%d ]", kills, assists, deaths)
else
  PLAYER_STATS = "Counter-Strike: Global Offensive\n   "
end

if engine.is_connected() and w1 == 99 then
    SERVER_MATCH = "^" .. localize("SFUI_Scoreboard_ServerName", {s1 = "(.*)"}) .. "$"
    SERVER_NAME = GameStateAPI.GetServerName():match(SERVER_MATCH)
    filesystem.write("rpc_data.Autism", string.format("%s\n%s", SERVER_NAME, PLAYER_STATS))
elseif engine.is_connected() and game_rules.get_prop("m_bIsValveDS") and w1 == 99 then
    SERVER_NAME = "Official Matchmaking\n   "
    filesystem.write("rpc_data.Autism", SERVER_NAME)
elseif w1 == 99 then
    SERVER_NAME = "In Main Menu\n   "
    filesystem.write("rpc_data.Autism", SERVER_NAME)
  end
  
end


callbacks.add(e_callbacks.PAINT, on_paint)