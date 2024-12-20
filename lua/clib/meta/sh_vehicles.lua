---------------------------------
-- CLib.GetVehicle
---------------------------------
-- Desc:        Gets the "true" vehicle entity of a vehicle.
-- State:       Shared
-- Arg One:     Entity - The vehicle to get the "true" entity from.
-- Returns:     Entity - The "true" vehicle entity.
function CLib.GetVehicle(vehicle)
    if CLIENT and !vehicle then
        local client = LocalPlayer()

        if !IsValid(client) or client == NULL then
            return
        end

        vehicle = client:GetVehicle()
    end

    if !IsValid(vehicle) then
        return
    end

    local parent = vehicle:GetParent()

    if parent == NULL then
        parent = vehicle
    end

    local basesInstalled = Glide or LVS or simfphys or (SVMOD and SVMOD:GetAddonState())

    if basesInstalled then
        if IsValid(parent) and parent.IsGlideVehicle then
            return parent
        elseif IsValid(parent) and parent.LVS then
           return parent
        elseif IsValid(parent) and parent.IsSimfphyscar then
           return parent
        elseif SVMOD and SVMOD:IsVehicle(vehicle) then
            return parent
        end
    end

    return parent
end

local function GetCustomPassengers(vehicle)
    if !IsValid(vehicle) or !vehicle.IsGlideVehicle or !vehicle.LVS and !vehicle.IsSimfphyscar then
        return
    end

    local passengers = {}
    local seats = vehicle.IsGlideVehicle and vehicle.seats
        or vehicle.LVS and vehicle:GetPassengerSeats()
        or vehicle:GetChildren()

    for i = 1, #seats do
        local seat = seats[i]
        local passenger = seat:GetDriver()

        if !IsValid(passenger) then
            continue
        end

        table.insert(passengers, passenger)
    end

    return passengers
end

local ENTITY = FindMetaTable("Entity")

---------------------------------
-- ENTITY:GetPassengers
---------------------------------
-- Desc:        Gets all the passengers of a vehicle.
-- State:       Shared
-- Returns:     Table - Table containing all the passengers.
function ENTITY:GetPassengers()
    local parent = self:GetParent() or self
    local isCustom = parent.IsGlideVehicle or parent.LVS or parent.IsSimfphyscar

    if isCustom then
        return GetCustomPassengers(parent)
    elseif SVMOD and SVMOD:GetAddonState() and SVMOD:IsVehicle(parent) then
        return parent:SV_GetAllPlayers()
    else
        return self:GetDriver()
    end
end

---------------------------------
-- ENTITY:IsEngineActive
---------------------------------
-- Desc:        Returns whether a vehicle's engine is active (on) or not.
-- State:       Shared
-- Returns:     Bool - True if the vehicle's engine is active (on).
function ENTITY:IsEngineActive()
    if !self:IsVehicle() and !self.IsGlideVehicle and !self.LVS then
        return false
    end

    if self.IsGlideVehicle then
        return self:GetEngineState() == 2
    elseif self.LVS then
        return self:GetEngineActive()
    elseif simfphys.IsCar(self) then
        return SERVER and self:EngineActive() or true
    end

    if SERVER then
        local vIsEngineStarted = self.IsEngineStarted

        if isfunction(vIsEngineStarted) then
            return vIsEngineStarted(self)
        end
    end

    return true
end

local PLAYER = FindMetaTable("Player")

---------------------------------
-- PLAYER:IsDriver
---------------------------------
-- Desc:        Checks whether the player is the driver of a vehicle.
-- State:       Shared
-- Arg One:     Entity - The vehicle to check.
-- Returns:     Bool - True if the player is the driver.
function PLAYER:IsDriver(vehicle)
    -- If no vehicle is provided, default to whatever vehicle the player is in.
    if !vehicle then
        vehicle = self:GetVehicle()
    end

   vehicle = CLib.GetVehicle(vehicle)

    -- If we aren't in any vehicle or the provided vehicle is invalid, we are not driving anything.
    if !IsValid(vehicle) then
        return false
    end

    if Glide and IsValid(self:GlideGetVehicle()) then
        return self == vehicle:GetDriver()
    elseif LVS and IsValid(self:lvsGetVehicle()) then
        return self == vehicle:GetDriver()
    elseif simfphys and IsValid(self:GetSimfphys()) then
        return self:GetSimfphys() == vehicle
    elseif (SVMOD and SVMOD:GetAddonState()) and SVMOD:IsVehicle(vehicle) then
        return self == vehicle:SV_GetDriverSeat():GetDriver()
    end

    return true
end
