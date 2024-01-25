local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local dycOdwutil = DYCModRequire("dyc_odwutil")
local ShowObjectDetail = dycOdwutil.ShowObjectDetail
local ClearUpdateOdwTask = dycOdwutil.ClearUpdateOdwTask
local CreateUpdateOdwTask = dycOdwutil.CreateUpdateOdwTask
local function getWorld() return rawget(_G, "GetWorld") and rawget(_G, "GetWorld")() or rawget(_G, "TheWorld") end
local function OnGainFocus(self, ...)
    local world = getWorld()
    if world then
        ShowObjectDetail(world, self)
        ClearUpdateOdwTask(self)
        CreateUpdateOdwTask(self, world)
    end
    return self.dycOldOnGainFocus(self, ...)
end
local function OnLoseFocus(self, ...)
    ShowObjectDetail(nil, self)
    ClearUpdateOdwTask(self)
    return self.dycOldOnLoseFocus(self, ...)
end
local function dycUiclock(origin)
    origin.dycOldOnGainFocus = origin.OnGainFocus
    origin.OnGainFocus = OnGainFocus
    origin.dycOldOnLoseFocus = origin.OnLoseFocus
    origin.OnLoseFocus = OnLoseFocus
    if origin.face then origin.face:SetClickable(true) end
end
return dycUiclock
