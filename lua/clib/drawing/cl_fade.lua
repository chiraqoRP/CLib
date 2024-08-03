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

function PANEL:CalculatePulse(speed)
    local pulseBuf, pulseStep = self.__pulseBuf or 0, RealFrameTime() * speed

    if self.ShouldPulse and pulseBuf < 1 then
        pulseBuf = math.min(1, pulseStep + pulseBuf)
    elseif !self.ShouldPulse and pulseBuf > 0 then
        pulseBuf = math.max(0, pulseBuf - pulseStep)
    end

    self.__pulseBuf = pulseBuf

    pulseBuf = math.EaseInOut(pulseBuf, 0.2, 0.2)

    return pulseBuf
end

function PANEL:TriggerPulse()
    self.ShouldPulse = true

    -- We could use PANEL:Think but who cares :P
    timer.Simple(0.20, function()
        if IsValid(self) then
            self.ShouldPulse = false
        end
    end)
end