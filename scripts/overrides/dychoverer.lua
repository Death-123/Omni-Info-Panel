local DYCInfoPanel = DYCInfoPanel
local function OnUpdate(self, ...)
    local returns = self.dycOldOnUpdate and self.dycOldOnUpdate(self, ...)
    local owner = self.owner
    local playercontroller = owner and owner.components and owner.components.playercontroller
    local target = playercontroller and (playercontroller.LMBaction and playercontroller.LMBaction.target or playercontroller.RMBaction and playercontroller.RMBaction.target)
    local controls = owner and owner.HUD and owner.HUD.controls
    local toolTip = controls and controls:GetTooltip()
    local objectDetailWindow = DYCInfoPanel.objectDetailWindow
    if not DYCInfoPanel.cfgs.hovertext and (target or (objectDetailWindow and objectDetailWindow.hoveredWidget)) and self.text and self.text.shown then
        self.text:Hide()
    end
    if not DYCInfoPanel.cfgs.hovertext and (target or (objectDetailWindow and objectDetailWindow.hoveredWidget)) and self.secondarytext and self.secondarytext.shown then
        self.secondarytext:Hide()
    end
    return returns
end
local function dycHoverer(origin)
    origin.dycOldOnUpdate = origin.OnUpdate
    origin.OnUpdate = OnUpdate
end
return dycHoverer
