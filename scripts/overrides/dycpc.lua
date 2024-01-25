local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local dycOdwutil = DYCModRequire("dyc_odwutil")
local ShowMouseObjectDetail = dycOdwutil.ShowMouseObjectDetail
local function isDST() return TheSim:GetGameID() == "DST" end
local function getPlayer() if isDST() then return ThePlayer else return GetPlayer() end end
local function GetLeftMouseAction(self, ...)
    local dycOldGetLeftMouseAction = self.dycOldGetLeftMouseAction(self, ...)
    local RMBaction = self.RMBaction
    local entity = TheInput:GetWorldEntityUnderMouse()
    if isDST() then self.enabled = true end
    if self.enabled and dycOldGetLeftMouseAction and dycOldGetLeftMouseAction.target then
        ShowMouseObjectDetail(dycOldGetLeftMouseAction.target, dycOldGetLeftMouseAction, RMBaction)
    elseif self.enabled and RMBaction and RMBaction.target then
        ShowMouseObjectDetail(RMBaction.target, dycOldGetLeftMouseAction, RMBaction)
    elseif entity and entity == getPlayer() then
        ShowMouseObjectDetail(entity, nil, nil)
    else
        ShowMouseObjectDetail()
    end
    return self.enabled and dycOldGetLeftMouseAction
end
local function dycPc(origin)
    origin.dycOldGetLeftMouseAction = origin.GetLeftMouseAction
    origin.GetLeftMouseAction = GetLeftMouseAction
end
return dycPc
