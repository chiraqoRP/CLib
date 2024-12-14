CLib = CLib or {}

-- CSLua
AddCSLuaFile("clib/meta/sh_vehicles.lua")
AddCSLuaFile("clib/util/sh_util.lua")

if SERVER then
    AddCSLuaFile("clib/panels/cl_meta.lua")
end

-- Includes
include("clib/meta/sh_vehicles.lua")
include("clib/util/sh_util.lua")

if CLIENT then
    include("clib/panels/cl_meta.lua")
end