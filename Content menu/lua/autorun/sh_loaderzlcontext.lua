AddCSLuaFile("sh_zlcontext_config.lua")
AddCSLuaFile("zlcontext/cl_misc.lua")
AddCSLuaFile("zlcontext/elements/cl_admins.lua")
AddCSLuaFile("zlcontext/elements/cl_banned.lua")
AddCSLuaFile("zlcontext/cl_main.lua")
AddCSLuaFile("zlcontext/elements/cl_name.lua")
AddCSLuaFile("zlcontext/elements/cl_tickets.lua")
AddCSLuaFile("zlcontext/elements/sv_tickets.lua")


include("sh_zlcontext_config.lua")
include("zlcontext/cl_misc.lua")
include("zlcontext/elements/cl_admins.lua")
include("zlcontext/elements/cl_banned.lua")
include("zlcontext/cl_main.lua")
include("zlcontext/elements/cl_name.lua")

if DarkRP and DarkRP.finished then
    include("zlcontext/elements/cl_tickets.lua")
    include("zlcontext/elements/sv_tickets.lua")
else
    hook.Add("DarkRPFinishedLoading", "zlhud:CheckDarkRP", function()
        include("zlcontext/elements/cl_tickets.lua")
        include("zlcontext/elements/sv_tickets.lua")
    end)
end