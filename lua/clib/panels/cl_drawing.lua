local PANEL = FindMetaTable("Panel")

function PANEL:CalculateFade(speed, customHover)
    local hovered = self:IsHovered()

    -- This is a bool that can be provided for panels that have a custom hover method.
    if customHover != nil then
        hovered = customHover
    end

    local buf, step = self.__hoverBuf or 0, RealFrameTime() * speed

    if hovered and buf < 1 then
        buf = math.min(1, step + buf)
    elseif !hovered and buf > 0 then
        buf = math.max(0, buf - step)
    end

    self.__hoverBuf = buf
    buf = math.EaseInOut(buf, 0.2, 0.2)

    return buf
end

function PANEL:FadeIn(length, callback)
    self:SetAlpha(0)

    self:AlphaTo(255, length or 1, 0, function(data, pnl)
        if callback then
            callback(data, pnl)
        end
    end)
end

function PANEL:FadeOut(length, callback)
    self:AlphaTo(0, length or 1, 0, function(data, pnl)
        if callback then
            callback(data, pnl)
        end
    end)
end

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