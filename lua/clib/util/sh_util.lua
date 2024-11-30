local string = string
local math = math
local emptyString = ""

---------------------------------
-- string.IsValid
---------------------------------
-- Desc:        Returns whether a string is valid or not. Empty strings are considered invalid.
-- State:       Shared
-- Arg One:     String - The string to be validated.
-- Returns:     Bool - True if the string is valid.
function string.IsValid(str)
    return str != nil and str != emptyString
end

local tableConcat = table.concat

---------------------------------
-- string.concat
---------------------------------
-- Desc:        Concatenates the provided strings together.
-- State:       Shared
-- Arg(s):      String(s) - The strings to concatenates together.
-- Returns:     String - Concatenated string.
function string.concat(...)
    return tableConcat({...}, emptyString)
end

if CLIENT then
    -- Hide HUD system
    local shouldHideHUD = false

    hook.Add("HUDShouldDraw", "CLib.Util.HideHUD", function()
        if shouldHideHUD then
            return false
        end
    end)

    function CLib.SetHideHUD(bool)
        shouldHideHUD = bool
    end
end