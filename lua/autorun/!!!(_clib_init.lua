CLib = CLib or {}

-- CSLua
AddCSLuaFile("clib/meta/sh_entities.lua")
AddCSLuaFile("clib/meta/sh_vehicles.lua")
AddCSLuaFile("clib/util/sh_util.lua")

if SERVER then
    AddCSLuaFile("clib/panels/cl_drawing.lua")
    AddCSLuaFile("clib/panels/cl_meta.lua")
end

-- Includes
include("clib/meta/sh_entities.lua")
include("clib/meta/sh_vehicles.lua")
include("clib/util/sh_util.lua")

if CLIENT then
    include("clib/panels/cl_drawing.lua")
    include("clib/panels/cl_meta.lua")
else
    include("clib/util/sv_playerload.lua")
end