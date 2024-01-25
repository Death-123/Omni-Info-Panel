local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local dycOdwutil = DYCModRequire("dyc_odwutil")
local ShowObjectDetail = dycOdwutil.ShowObjectDetail
local FollowObject = dycOdwutil.FollowObject
local function tryFollowObject(target)
    local objectDetailWindow = DYCInfoPanel.objectDetailWindow
    if objectDetailWindow and objectDetailWindow.shown and target and objectDetailWindow.focusedObject and objectDetailWindow.focusedObject == target then FollowObject(target) end
end
local lastTarget = nil
local lastX, lastY, lastZ = 999, 999, 999
local function HighlightActionItem(self, itemIndex, itemInActions, ...)
    if TheInput:ControllerAttached() then
        if itemIndex then
            local owner = self.owner
            local playercontroller = owner and owner.components.playercontroller
            local controller_target = playercontroller and playercontroller.controller_target
            if controller_target ~= lastTarget then ShowObjectDetail(controller_target) end
            if controller_target then
                local x, y, z = TheSim:GetScreenPos(controller_target.Transform:GetWorldPosition())
                if x ~= lastX or y ~= lastY or z ~= lastZ then
                    tryFollowObject(controller_target)
                    lastX, lastY, lastZ = x, y, z
                end
            end
            lastTarget = controller_target
        else
            if lastTarget ~= nil then ShowObjectDetail() end
            lastTarget = nil
        end
    end
    return self.dycOldHighlightActionItem(self, itemIndex, itemInActions, ...)
end
local function dycControls(origin)
    origin.dycOldHighlightActionItem = origin.HighlightActionItem
    origin.HighlightActionItem = HighlightActionItem
end
return dycControls
