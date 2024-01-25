local Widget = require "widgets/widget"
local Text = require "widgets/text"
local Spinner = require "widgets/spinner"
local _ = 2
local totalNum = 7
local function RefreshOptions(self)
    if not self.dycHoverText then
        local dycHoverText = self.root:AddChild(Text(BUTTONFONT, 22, " "))
        self.dycHoverText = dycHoverText
        dycHoverText:SetHAlign(ANCHOR_LEFT)
        dycHoverText:SetVAlign(ANCHOR_TOP)
        dycHoverText:SetPosition(0, -230, 0)
        dycHoverText:SetRegionSize(800, 50)
        dycHoverText:EnableWordWrap(true)
    end
    local dycHoverText = self.dycHoverText
    local setText = function(str)
        str = str and string.gsub(str, "\n", "")
        if dycHoverText.SetText then dycHoverText:SetText(str) else dycHoverText:SetString(str) end
        if dycHoverText.AnimateIn then dycHoverText:AnimateIn() end
    end
    if not self.dycOptions then
        self.dycOptions = {}
        if self.config and type(self.config) == "table" then
            for _, config in ipairs(self.config) do
                if config.name and config.options and (config.saved ~= nil or config.default ~= nil) then
                    local isHover = config.hover
                    isHover = isHover and type(isHover) == "string" and #isHover > 0 and isHover
                    table.insert(self.dycOptions, { name = config.name, label = config.label, options = config.options, default = config.default, value = config.saved, hover = isHover })
                end
            end
        end
    end
    local dycOptions = self.dycOptions
    local deepestFocus = self:GetDeepestFocus()
    local column = deepestFocus and deepestFocus.column
    local idx = deepestFocus and deepestFocus.idx
    for _, optionWidget in pairs(self.optionwidgets) do optionWidget.root:Kill() end
    self.optionwidgets = {}
    self.left_spinners = {}
    self.right_spinners = {}
    for i = 1, totalNum * 2 do
        local offset = self.option_offset + i
        if dycOptions[offset] then
            local options = {}
            for _, option in ipairs(dycOptions[offset].options) do
                local hover = option.hover
                hover = hover and type(hover) == "string" and #hover > 0 and hover
                table.insert(options, { text = option.description, data = option.data, hover = hover })
            end
            local optionWidget = self.optionspanel:AddChild(Widget("option"))
            local spinnerHeight = 50
            local spinnerWidth = 220
            local spinner = optionWidget:AddChild(Spinner(options, spinnerWidth, spinnerHeight))
            spinner:SetTextColour(0, 0, 0, 1)
            local optionValue = dycOptions[offset].value
            if optionValue == nil then optionValue = dycOptions[offset].default end
            local OnGainFocus = function()
                self.dycHoveredWidget = spinner
                local hover = dycOptions[offset].hover
                local selectedOption = spinner.options[spinner.selectedIndex]
                local selectedHover = selectedOption and selectedOption.hover
                setText((hover or "") .. (hover and selectedHover and " " or "") .. (selectedHover or " "))
            end
            spinner.OnChanged = function(_, value)
                dycOptions[offset].value = value
                self:MakeDirty()
                OnGainFocus()
            end
            spinner:SetSelected(optionValue)
            spinner:SetPosition(35, 0, 0)
            spinner.OnGainFocus = function() OnGainFocus() end
            spinner.OnLoseFocus = function() if self.dycHoveredWidget == spinner then setText(" ") end end
            local textHeight = 55
            local textWidth = 180
            local text = spinner:AddChild(Text(BUTTONFONT, 30, (dycOptions[offset].label or dycOptions[offset].name) or STRINGS.UI.MODSSCREEN.UNKNOWN_MOD_CONFIG_SETTING))
            text:SetPosition(-textWidth / 2 - 105, 0, 0)
            text:SetRegionSize(textWidth, 50)
            text:SetHAlign(ANCHOR_MIDDLE)
            if i <= totalNum then
                optionWidget:SetPosition(-155, (totalNum - 1) * textHeight * 0.5 - (i - 1) * textHeight - 10, 0)
                table.insert(self.left_spinners, spinner)
                spinner.column = "left"
                spinner.idx = #self.left_spinners
            else
                optionWidget:SetPosition(265, (totalNum - 1) * textHeight * 0.5 - (i - 1 - totalNum) * textHeight - 10, 0)
                table.insert(self.right_spinners, spinner)
                spinner.column = "right"
                spinner.idx = #self.right_spinners
            end
            table.insert(self.optionwidgets, { root = optionWidget })
        end
    end
    self:HookupFocusMoves()
    if column and idx then
        local spinner = column == "right" and self.right_spinners or self.left_spinners
        spinner[math.min(#spinner, idx)]:SetFocus()
    end
end
local function CollectSettings(self)
    if self.dycOptions then
        local settings = nil
        for _, option in pairs(self.dycOptions) do
            if not settings then settings = {} end
            table.insert(settings, { name = option.name, label = option.label, options = option.options, default = option.default, saved = option.value })
        end
        return settings
    end
end
local function dycMcfgscr(origin)
    origin.dycOverrided = true
    origin.CollectSettings = CollectSettings
    origin.RefreshOptions = RefreshOptions
    origin.optionspanel:SetPosition(0, 0)
    origin:RefreshOptions()
end
return dycMcfgscr
