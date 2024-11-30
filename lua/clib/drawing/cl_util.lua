local gradientLeftMat = Material("vgui/gradient-l")
local gradientRightMat = Material("vgui/gradient-r")

function CLib.DrawGradientOutline(x, y, w, h, clr1, clr2, thickness)
    surface.SetDrawColor(clr1:Unpack())
    surface.SetMaterial(gradientLeftMat)
    surface.DrawTexturedRectUV(x, y, w, thickness, 0, 0, 1, 0) -- top
    surface.DrawTexturedRectUV(x, h - thickness, w, thickness, 0, 1, 1, 1) -- bottom
    surface.DrawTexturedRectUV(x, y + thickness, thickness, h - thickness, 0, 0.1, 0, 1) -- left
    surface.DrawTexturedRectUV(w - thickness, 0 + thickness, thickness, h - thickness, 1, 0.1, 1, 1) -- right

    surface.SetDrawColor(clr2:Unpack())
    surface.SetMaterial(gradientRightMat)
    surface.DrawTexturedRectUV(x, y, w, thickness, 0, 0, 1, 0) -- top
    surface.DrawTexturedRectUV(x, h - thickness, w, thickness, 0, 1, 1, 1) -- bottom
    surface.DrawTexturedRectUV(x, y + thickness, thickness, h - thickness, 0, 0, 0, 1) -- left
    surface.DrawTexturedRectUV(w - thickness, 0 + thickness, thickness, h - thickness, 1, 0.1, 1, 1) -- right
end

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