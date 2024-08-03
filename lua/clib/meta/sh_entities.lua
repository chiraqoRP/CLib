local ENTITY = FindMetaTable("Entity")

---------------------------------
-- ENTITY:IsHeld
---------------------------------
-- Desc:        Checks whether an entity is being held by a player or not.
-- State:       Shared
-- Arg One:     Entity - The entity to check.
-- Returns:     Bool - Hold status.
function ENTITY:IsHeld()
    return self:GetNWBool("IsHeld", false)
end

if SERVER then
    hook.Add("OnPlayerPhysicsPickup", "CLib.Util.ItemHeld", function(ply, ent)
        if !IsValid(ent) then
            return
        end

        ent:SetNWBool("IsHeld", true)
    end)

    hook.Add("OnPhysgunPickup", "CLib.Util.ItemHeld", function(ply, ent)
        if !IsValid(ent) then
            return
        end

        ent:SetNWBool("IsHeld", true)
    end)

    hook.Add("GravGunOnPickedUp", "CLib.Util.ItemHeld", function(ply, ent)
        if !IsValid(ent) then
            return
        end

        ent:SetNWBool("IsHeld", true)
    end)

    hook.Add("OnPlayerPhysicsDrop", "CLib.Util.ItemHeld", function(ply, ent)
        if !IsValid(ent) then
            return
        end

        ent:SetNWBool("IsHeld", false)
    end)

    hook.Add("PhysgunDrop", "CLib.Util.ItemHeld", function(ply, ent)
        if !IsValid(ent) then
            return
        end

        ent:SetNWBool("IsHeld", false)
    end)

    hook.Add("GravGunOnDropped", "CLib.Util.ItemHeld", function(ply, ent)
        if !IsValid(ent) then
            return
        end

        ent:SetNWBool("IsHeld", false)
    end)
end

local PLAYER = FindMetaTable("Player")

---------------------------------
-- PLAYER:GetNetDelay
---------------------------------
-- Desc:        Gets a players net message delay.
-- State:       Shared
-- Returns:     Float - Provided player's net message delay.
function PLAYER:GetNetDelay()
    return self:Ping() / 990
end