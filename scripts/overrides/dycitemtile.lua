local Uianim = require "widgets/uianim"
local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local dycOdwutil = DYCModRequire("dyc_odwutil")
local ShowObjectDetail = dycOdwutil.ShowObjectDetail
local ClearUpdateOdwTask = dycOdwutil.ClearUpdateOdwTask
local CreateUpdateOdwTask = dycOdwutil.CreateUpdateOdwTask
local StrSpl = DYCInfoPanel.lib.StrSpl
local StringStartWith = DYCInfoPanel.lib.StringStartWith
local function OnGainFocus(self, ...)
    local item = self.item
    ShowObjectDetail(item, self)
    ClearUpdateOdwTask(self)
    CreateUpdateOdwTask(self, item)
    return self.dycOldOnGainFocus(self, ...)
end
local function OnLoseFocus(self, ...)
    ShowObjectDetail(nil, self)
    ClearUpdateOdwTask(self)
    return self.dycOldOnLoseFocus(self, ...)
end
local function Kill(self, ...)
    ShowObjectDetail(nil, self)
    return self.dycOldKill(self, ...)
end
local function dycItemTile(origin)
    local item = origin.item
    origin.dycOldOnGainFocus = origin.OnGainFocus
    origin.OnGainFocus = OnGainFocus
    origin.dycOldOnLoseFocus = origin.OnLoseFocus
    origin.OnLoseFocus = OnLoseFocus
    origin.dycOldKill = origin.Kill
    origin.Kill = Kill
end
return dycItemTile
