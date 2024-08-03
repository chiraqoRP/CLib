local PANEL = FindMetaTable("Panel")

-- DLabel's think resizes every frame, so we make it only do so one time.
function PANEL:SizeToContentsY(addval)
    if self.m_bYSized then return end

    local w, h = self:GetContentSize()

    if (!w or !h) then return end

    self:SetTall(h + (addval or 0))

    self.m_bYSized = true
end