local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local dycOdwutil = DYCModRequire("dyc_odwutil")
local ShowObjectDetail = dycOdwutil.ShowObjectDetail
local lastItem = nil
local function UpdateCursorText(self, ...)
    if TheInput:ControllerAttached() then
        local tile = self.active_slot and self.active_slot.tile
        local cursortile = self.cursortile
        local tileItem = tile and tile.item
        local cursorItem = cursortile and cursortile.item
        local tile_ = cursortile or tile
        local item = cursorItem or tileItem
        if item ~= lastItem then
            ShowObjectDetail(item, tile_)
            lastItem = item
        end
    end
    return self.dycOldUpdateCursorText(self, ...)
end
local function dycInvbar(origin)
    origin.dycOldUpdateCursorText = origin.UpdateCursorText
    origin.UpdateCursorText = UpdateCursorText
end
return dycInvbar
