local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local dycOdwutil = DYCModRequire("dyc_odwutil")
local ShowObjectDetail = dycOdwutil.ShowObjectDetail
local ClearUpdateOdwTask = dycOdwutil.ClearUpdateOdwTask
local CreateUpdateOdwTask = dycOdwutil.CreateUpdateOdwTask
local function OnGainFocus(self, ...)
    local owner = self.owner
    ShowObjectDetail(owner, self)
    ClearUpdateOdwTask(self)
    CreateUpdateOdwTask(self, owner)
    return self.dycOldOnGainFocus(self, ...)
end
local function OnLoseFocus(self, ...)
    ShowObjectDetail(nil, self)
    ClearUpdateOdwTask(self)
    return self.dycOldOnLoseFocus(self, ...)
end
local function dycBadge(origin)
    origin.dycOldOnGainFocus = origin.OnGainFocus
    origin.OnGainFocus = OnGainFocus
    origin.dycOldOnLoseFocus = origin.OnLoseFocus
    origin.OnLoseFocus = OnLoseFocus
end
return dycBadge
