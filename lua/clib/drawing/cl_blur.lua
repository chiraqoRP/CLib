local PANEL = FindMetaTable("Panel")
local blurMat = Material("pp/blurscreen")

function PANEL:BlurBackground(dark)
    self.BlurDynamic = self.BlurDynamic or 0

    local layers, density = 1, 1
    local x, y = self:LocalToScreen(0, 0)
    local frameTime, Num = 1 / RealFrameTime(), 5

    surface.SetDrawColor(255, 255, 255, 100)
    surface.SetMaterial(blurMat)

    for i = 1, Num do
        blurMat:SetFloat("$blur", (i / layers) * density * self.BlurDynamic)
        blurMat:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
    end

    surface.SetDrawColor(0, 0, 0, (dark or 150) * self.BlurDynamic)
    surface.DrawRect(0, 0, self:GetSize())

    self.BlurDynamic = math.Clamp(self.BlurDynamic + (1 / frameTime) * 7, 0, 1)
end

function PANEL:BlurSurroundings(dark)
    self.BlurDynamic = self.BlurDynamic or 0

    local layers, density = 1, 1
    local x, y = 0, 0
    local scrW, scrH = ScrW(), ScrH()
    local frameTime, Num = 1 / RealFrameTime(), 5

    DisableClipping(true)
    surface.SetDrawColor(255, 255, 255, 100)
    surface.SetMaterial(blurMat)

    for i = 1, Num do
        blurMat:SetFloat("$blur", (i / layers) * density * self.BlurDynamic)
        blurMat:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(-x, -y, scrW, scrH)
    end

    surface.SetDrawColor(0, 0, 0, (dark or 150) * self.BlurDynamic)
    surface.DrawRect(0, 0, scrW, scrH)
    DisableClipping(false)

    self.BlurDynamic = math.Clamp(self.BlurDynamic + (1 / frameTime) * 7, 0, 1)
end