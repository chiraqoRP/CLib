--[[
    gm_playerload - Copyright Notice
    © 2024 CFC Servers - All rights reserved

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
--]]

local loadQueue = {}
local conflictChecked = false

hook.Add("PlayerInitialSpawn", "CLib.PlayerLoad.Setup", function(ply)
    loadQueue[ply] = true

    -- Bit hacky, but if the players server has gm_playerload too then the collision needs to be fixed.
    if !conflictChecked then
        hook.Remove("SetupMove", "GM_FullLoadTrigger")

        conflictChecked = true
    end
end)

hook.Add("SetupMove", "CLib.PlayerLoad.Trigger", function(ply, mv, cmd)
    if !loadQueue[ply] or cmd:IsForced() then
        return
    end

    loadQueue[ply] = nil

    -- Wrapped in a ProtectedCall so one bad hook.Add doesn't kill the whole script.
    ProtectedCall(function()
        hook.Run("PlayerFullLoad", ply)
    end)
end)