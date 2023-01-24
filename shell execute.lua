--ducarii where ffi.load :(

ffi.cdef [[
    typedef void*(__thiscall* shell_execute_t)(void*, const char*, const char*); 
]] 

cp = ffi.typeof('void***')
vgui = memory.create_interface('vgui2.dll', 'VGUI_System010')
ivgui = ffi.cast(cp,vgui)
ShellExecuteA = ffi.cast("shell_execute_t", ivgui[0][3])

open = menu.add_button("test", "test", function()
    ShellExecuteA(ivgui, 'open', "https://discord.com/invite/tjjEuCc4Uf")
end)
