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

---------------------------------
-- string.concat
---------------------------------
-- Desc:        Concatenates the provided strings together.
-- State:       Shared
-- Arg(s):      String(s) - The strings to concatenates together.
-- Returns:     String - Concatenated string.
function string.concat(...)
    return table.concat({...}, emptyString)
end