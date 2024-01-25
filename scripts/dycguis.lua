local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local Screen = require "widgets/screen"
local Button = require "widgets/button"
local Spinner = require "widgets/spinner"
local Uianim = require "widgets/uianim"
local dycGuis = {}
dycGuis.Init = function(self, data)
    if self.initialized then return end
    self.initialized = true
    self.localization = data.localization
    self.multiLineScale = data.multiLineScale
    self.textWidthScale = data.textWidthScale
    self.language = data.language
end

--#region tool functions
local function isWin32() return string.upper(PLATFORM) == "WIN32" end
local function isDST() return TheSim:GetGameID() == "DST" end
local function getPlayer() if isDST() then return ThePlayer else return GetPlayer() end end
local function getWorld() if isDST() then return TheWorld else return GetWorld() end end
local getLocalizationStr = function(lang, key)
    local localizationStrs = dycGuis.localization.strings or dycGuis.localization:GetStrings()
    return localizationStrs:GetString(lang, key)
end
local getWidthScal = function()
    local w, h = TheSim:GetScreenSize()
    return w / 1920
end
local getMouseScreenPos = function() return TheSim:GetScreenPos(TheInput:GetWorldPosition():Get()) end
local RGBAColor = function(r, g, b, a)
    return {
        r = r or 1,
        g = g or 1,
        b = b or 1,
        a = a or 1,
        Get = function(self) return self.r, self.g, self.b, self.a end,
        R = function(self, newR)
            self.r = newR
            return self
        end,
        G = function(self, newG)
            self.g = newG
            return self
        end,
        B = function(self, newB)
            self.b = newB
            return self
        end,
        A = function(self, newA)
            self.a = newA
            return self
        end,
    }
end
local lerp = function(a, b, t) return a + (b - a) * t end
local function StrSpl(str, separators)
    if separators == nil then separators = "%s" end
    local spls = {}
    local i = 1
    for world in string.gmatch(str, "([^" .. separators .. "]+)") do
        spls[i] = world
        i = i + 1
    end
    return spls
end
local tableContains = function(table, value)
    for _, v in pairs(table) do if v == value then return true end end
    return false
end
local tableAdd = function(tableTo, value) if not tableContains(tableTo, value) then table.insert(tableTo, value) end end
local TableGetIndex = function(table, value) for k, v in pairs(table) do if v == value then return k end end end
local TableRemoveValue = function(tableTo, value)
    local index = TableGetIndex(tableTo, value)
    if index then table.remove(tableTo, index) end
end
--#endregion

--#region dycRoot
local Root = Class(Widget, function(self, parent)
    Widget._ctor(self, "DYC_Root")
    self.keepTop = parent.keepTop
    self.moveLayerTimer = 0
    if parent.keepTop then self:StartUpdating() end
end)
function Root:OnUpdate(time)
    time = time or 0
    self.moveLayerTimer = self.moveLayerTimer + time
    if self.keepTop and self.moveLayerTimer > 0.5 then
        self.moveLayerTimer = 0
        self:MoveToFront()
    end
end

dycGuis.Root = Root
--#endregion

--#region dycText
local dycText = Class(Text,
    function(self, font, size, text, hittest)
        if font and type(font) == "table" then
            local tempFont = font
            Text._ctor(self, tempFont.font or NUMBERFONT, tempFont.fontSize or 30, tempFont.text)
            if tempFont.color then
                local color = tempFont.color
                self:SetColor(color.r or color[1] or 1, color.g or color[2] or 1, color.b or color[3] or 1, color.a or color[4] or 1)
            end
            if tempFont.regionSize then self:SetRegionSize(tempFont.regionSize.w, tempFont.regionSize.h) end
            self.alignH = tempFont.alignH
            self.alignV = tempFont.alignV
            self.focusFn = tempFont.focusFn
            self.unfocusFn = tempFont.unfocusFn
            self.hittest = tempFont.hittest
        else
            Text._ctor(self, font or NUMBERFONT, size or 30, text)
            self.hittest = hittest
            if text then self:SetText(text) end
        end
    end)
function dycText:GetImage()
    if not self.image then
        self.image = self:AddChild(Image("images/ui.xml", "button.tex"))
        self.image:MoveToBack()
        self.image:SetTint(0, 0, 0, 0)
    end
    return self.image
end

function dycText:SetText(text)
    local width = self:GetWidth()
    local height = self:GetHeight()
    local position = self:GetPosition()
    self:SetString(text)
    if self.alignH and self.alignH ~= ANCHOR_MIDDLE then
        local width_ = self:GetWidth()
        position.x = position.x + (width_ - width) / 2 * (self.alignH == ANCHOR_LEFT and 1 or -1)
    end
    if self.alignV and self.alignV ~= ANCHOR_MIDDLE then
        local height_ = self:GetHeight()
        position.y = position.y + (height_ - height) / 2 * (self.alignV == ANCHOR_BOTTOM and 1 or -1)
    end
    if self.alignH or self.alignV then self:SetPosition(position) end
    if self.hittest then self:GetImage():SetSize(self:GetSize()) end
end

function dycText:SetColor(...) self:SetColour(...) end

function dycText:GetRegionSize()
    local w, h = dycText._base.GetRegionSize(self)
    w = w * (dycGuis.textWidthScale or 1)
    return w, h
end

function dycText:GetWidth()
    local w, h = self:GetRegionSize()
    w = w < 10000 and w or 0
    return w
end

function dycText:GetHeight()
    local _, h = self:GetRegionSize()
    h = h < 10000 and h or 0
    return h
end

function dycText:GetSize()
    local w, h = self:GetRegionSize()
    w = w < 10000 and w or 0
    h = h < 10000 and h or 0
    return w, h
end

function dycText:OnGainFocus()
    dycText._base.OnGainFocus(self)
    if self.focusFn then self.focusFn(self) end
end

function dycText:OnLoseFocus()
    dycText._base.OnLoseFocus(self)
    if self.unfocusFn then self.unfocusFn(self) end
end

function dycText:AnimateIn(speed)
    self.textString = self.string
    self.animSpeed = speed or 60
    self.animIndex = 0
    self.animTimer = 0
    self:SetText("")
    self:StartUpdating()
end

function dycText:OnUpdate(time)
    time = time or 0
    if dycText._base.OnUpdate then dycText._base.OnUpdate(self, time) end
    if time > 0 and self.animIndex and self.textString and #self.textString > 0 then
        self.animTimer = self.animTimer + time
        if self.animTimer > 1 / self.animSpeed then
            self.animTimer = 0
            self.animIndex = self.animIndex + 1
            if self.animIndex > #self.textString then
                self.animIndex = nil
                self:SetText(self.textString)
            else
                local char = string.byte(string.sub(self.textString, self.animIndex, self.animIndex))
                if char and char > 127 then self.animIndex = self.animIndex + 2 end
                self:SetText(string.sub(self.textString, 1, self.animIndex))
            end
        end
    end
end

dycGuis.Text = dycText
--#endregion

--#region dycMultiLineText
local dycMultiLineText = Class(Widget,
    function(self, dataOrFont, fontSize, text, maxWidth)
        Widget._ctor(self, "DYC_MultiLineText")
        local data = nil
        if dataOrFont and type(dataOrFont) == "table" then data = dataOrFont else data = { font = dataOrFont, fontSize = fontSize, text = text, maxWidth = maxWidth } end
        self.lines = {}
        self.width = 0
        self.height = 0
        self.fontSize = data.fontSize or 30
        self.font = data.font or NUMBERFONT
        self.spacing = data.spacing or 0
        self:SetMaxWidth(data.maxWidth)
        self:SetText(data.text)
        if data.color then
            local color = data.color
            self:SetColor(color.r or color[1] or 1, color.g or color[2] or 1, color.b or color[3] or 1, color.a or color[4] or 1)
        end
    end)
function dycMultiLineText:SetText(text)
    self.string = text or self.string or ""
    local textWidget = self:AddChild(Text(self.font, self.fontSize, self.string))
    self.singleLineWidth, self.singleLineHeight = textWidget:GetRegionSize()
    if isDST() then self.singleLineHeight = self.singleLineHeight * 1.25 end
    textWidget:Kill()
    for _, line in pairs(self.lines) do line:Kill() end
    self.width = 0
    self.lines = {}
    local str = self.string
    if str and #str > 0 then
        local singleLineWidth = self.singleLineWidth
        local singleLineHeight = self.singleLineHeight
        local maxWidth = self.maxWidth
        local lineWidth = singleLineWidth / #str
        local j = 0
        local i = 1
        local flag = false
        while i <= #str do
            local char = str:byte(i)
            if char > 127 and i + 2 <= #str then
                i = i + 2
            elseif char == 32 then
                if i - j == 1 then
                    j = j + 1
                else
                    for offset = 1, 15 do
                        local charOffset = i + offset <= #str and str:byte(i + offset)
                        if not charOffset or charOffset == 32 or charOffset > 127 then
                            break
                        elseif (i + offset - j) * lineWidth > maxWidth then
                            flag = true
                            break
                        end
                    end
                end
            end
            local char_ = i + 1 <= #str and str:byte(i + 1)
            local width_ = char_ and (char_ > 127 and lineWidth * 2.9 or lineWidth) or 0
            if i - j > 0 and (flag or i >= #str or (i - j) * lineWidth + width_ > maxWidth) then
                local textWidget_ = self:AddChild(Text(self.font, self.fontSize, str:sub(j + 1, i)))
                table.insert(self.lines, textWidget_)
                local width = textWidget_:GetRegionSize()
                self.width = math.max(self.width, width)
                j = i
                flag = false
            end
            i = i + 1
        end
        self.height = singleLineHeight * #self.lines + self.spacing * (#self.lines - 1)
        local linesCount = #self.lines
        for i = 1, linesCount do
            local line = self.lines[i]
            local size = line:GetRegionSize()
            line:SetPosition(-maxWidth / 2 + size / 2, ((linesCount - 1) / 2 - i + 1) * (singleLineHeight + self.spacing), 0)
        end
    end
end

function dycMultiLineText:SetMaxWidth(width)
    self.maxWidth = width or self.maxWidth or 500
    if self.string then self:SetText() end
end

function dycMultiLineText:SetColour(...) for _, line in pairs(self.lines) do line:SetColour(...) end end

function dycMultiLineText:SetColor(...) self:SetColour(...) end

function dycMultiLineText:SetAlpha(...) for _, line in pairs(self.lines) do line:SetAlpha(...) end end

function dycMultiLineText:GetWidth() return self.width end

function dycMultiLineText:GetHeight() return self.height end

function dycMultiLineText:GetSize() return self.width, self.height end

function dycMultiLineText:GetRegionSize() return self.maxWidth or 0, self.height end

dycGuis.MultiLineText = dycMultiLineText
--#endregion

--#region dycSlicedImage
local dycSlicedImage = Class(Widget,
    function(self, textures)
        Widget._ctor(self, "DYC_SlicedImage")
        self.images = {}
        self.mode = "slice13"
        self.texScale = textures.texScale or 1
        self.width = 100
        self.height = 100
        self:SetTextures(textures)
    end)
function dycSlicedImage:__tostring() return string.format("%s (%s)", self.name, self.mode) end

function dycSlicedImage:SetTextures(textures)
    assert(textures.mode)
    self.images = {}
    self.mode = textures.mode
    if self.mode == "slice13" or self.mode == "slice31" then
        local newImage = nil
        newImage = self:AddChild(Image(textures.atlas, textures.texname .. "_1.tex"))
        newImage.oriW, newImage.oriH = newImage:GetSize()
        newImage.imgPos = 1
        self.images[1] = newImage
        newImage = self:AddChild(Image(textures.atlas, textures.texname .. "_2.tex"))
        newImage.oriW, newImage.oriH = newImage:GetSize()
        newImage.imgPos = 2
        self.images[2] = newImage
        newImage = self:AddChild(Image(textures.atlas, textures.texname .. "_3.tex"))
        newImage.oriW, newImage.oriH = newImage:GetSize()
        newImage.imgPos = 3
        self.images[3] = newImage
        if self.mode == "slice13" then
            assert(self.images[1].oriH == self.images[3].oriH, "Height must be equal!")
            assert(self.images[1].oriH == self.images[2].oriH, "Height must be equal!")
        else
            assert(self.images[1].oriW == self.images[3].oriW, "Width must be equal!")
            assert(self.images[1].oriW == self.images[2].oriW, "Width must be equal!")
        end
        return
    elseif self.mode == "slice33" then
        local newImage = nil
        for i = 1, 3 do
            for j = 1, 3 do
                newImage = self:AddChild(Image(textures.atlas, textures.texname .. "_" .. i .. j .. ".tex"))
                newImage.oriW, newImage.oriH = newImage:GetSize()
                newImage.imgPos = i * 10 + j
                self.images[i * 10 + j] = newImage
                if i > 1 then assert(self.images[i * 10 + j].oriW == self.images[(i - 1) * 10 + j].oriW, "Width must be equal!") end
                if j > 1 then assert(self.images[i * 10 + j].oriH == self.images[i * 10 + j - 1].oriH, "Height must be equal!") end
            end
        end
        return
    end
    error("Mode not supported!")
    self:SetSize()
end

function dycSlicedImage:SetSize(width, height)
    width = width or self.width
    height = height or self.height
    if self.mode == "slice13" then
        local image1 = self.images[1]
        local image2 = self.images[2]
        local image3 = self.images[3]
        local texScale = math.min(self.texScale, math.min(width / (image1.oriW + image3.oriW), height / image1.oriH))
        local w1 = math.floor(image1.oriW * texScale)
        local w2 = math.floor(image3.oriW * texScale)
        local w3 = math.max(0, width - w1 - w2)
        image1:SetSize(w1, height)
        image2:SetSize(w3, height)
        image3:SetSize(w2, height)
        local x2 = (w1 - w2) / 2
        local x1 = -w1 / 2 - w3 / 2 + x2
        local x3 = w2 / 2 + w3 / 2 + x2
        image1:SetPosition(x1, 0, 0)
        image2:SetPosition(x2, 0, 0)
        image3:SetPosition(x3, 0, 0)
        self.width = w1 + w3 + w2
        self.height = height
    elseif self.mode == "slice31" then
        local image1 = self.images[1]
        local image2 = self.images[2]
        local image3 = self.images[3]
        local texScale = math.min(self.texScale, math.min(height / (image1.oriH + image3.oriH), width / image1.oriW))
        local h1 = math.floor(image1.oriH * texScale)
        local h3 = math.floor(image3.oriH * texScale)
        local h2 = math.max(0, height - h1 - h3)
        image1:SetSize(width, h1)
        image2:SetSize(width, h2)
        image3:SetSize(width, h3)
        local y2 = (h1 - h3) / 2
        local y1 = -h1 / 2 - h2 / 2 + y2
        local y3 = h3 / 2 + h2 / 2 + y2
        image1:SetPosition(0, y1, 0)
        image2:SetPosition(0, y2, 0)
        image3:SetPosition(0, y3, 0)
        self.height = h1 + h2 + h3
        self.width = width
    elseif self.mode == "slice33" then
        local images = self.images
        local texScale = math.min(self.texScale, math.min(width / (images[11].oriW + images[13].oriW), height / (images[11].oriH + images[31].oriH)))
        local ws, hs, xs, ys = {}, {}, {}, {}
        ws[1] = math.floor(images[11].oriW * texScale)
        ws[3] = math.floor(images[13].oriW * texScale)
        ws[2] = math.max(0, width - ws[1] - ws[3])
        hs[1] = math.floor(images[11].oriH * texScale)
        hs[3] = math.floor(images[31].oriH * texScale)
        hs[2] = math.max(0, height - hs[1] - hs[3])
        xs[2] = (ws[1] - ws[3]) / 2
        xs[1] = -ws[1] / 2 - ws[2] / 2 + xs[2]
        xs[3] = ws[3] / 2 + ws[2] / 2 + xs[2]
        ys[2] = (hs[1] - hs[3]) / 2
        ys[1] = -hs[1] / 2 - hs[2] / 2 + ys[2]
        ys[3] = hs[3] / 2 + hs[2] / 2 + ys[2]
        for i = 1, 3 do
            for j = 1, 3 do
                images[i * 10 + j]:SetSize(ws[j], hs[i])
                images[i * 10 + j]:SetPosition(xs[j], ys[i], 0)
            end
        end
        self.width = ws[1] + ws[2] + ws[3]
        self.height = hs[1] + hs[2] + hs[3]
    end
end

function dycSlicedImage:GetSize() return self.width, self.height end

function dycSlicedImage:SetTint(r, g, b, a) for _, image in pairs(self.images) do image:SetTint(r, g, b, a) end end

function dycSlicedImage:SetClickable(clickable) for _, image in pairs(self.images) do image:SetClickable(clickable) end end

dycGuis.SlicedImage = dycSlicedImage
--#endregion

--#region dycSpinner
local dycSpinner = Class(Spinner, function(self, options, width, height, textinfo, editable, atlas, textures) Spinner._ctor(self, options, width, height, textinfo, editable, atlas, textures) end)
function dycSpinner:GetSelectedHint() return self.options[self.selectedIndex].hint or "" end

function dycSpinner:SetSelected(value, data)
    if value == nil and data ~= nil then return self:SetSelected(data) end
    for id, option in pairs(self.options) do
        if option.data == value then
            self:SetSelectedIndex(id)
            return true
        end
    end
    if data then return self:SetSelected(data) else return false end
end

function dycSpinner:SetSelectedIndex(id, ...)
    dycSpinner._base.SetSelectedIndex(self, id, ...)
    if self.setSelectedIndexFn then self.setSelectedIndexFn(self) end
end

function dycSpinner:OnGainFocus()
    dycSpinner._base.OnGainFocus(self)
    if self.focusFn then self.focusFn(self) end
end

function dycSpinner:OnLoseFocus()
    dycSpinner._base.OnLoseFocus(self)
    if self.unfocusFn then self.unfocusFn(self) end
end

function dycSpinner:OnMouseButton(button, down, x, y, ...)
    dycSpinner._base.OnMouseButton(self, button, down, x, y, ...)
    if not down and button == MOUSEBUTTON_LEFT then if self.mouseLeftUpFn then self.mouseLeftUpFn(self) end end
    if not self.focus then return false end
    if down and button == MOUSEBUTTON_LEFT then if self.mouseLeftDownFn then self.mouseLeftDownFn(self) end end
end

dycGuis.Spinner = dycSpinner
--#endregion

--#region dycImageButton
local dycImageButton = Class(Button,
    function(self, data)
        Button._ctor(self, "DYC_ImageButton")
        data = data or {}
        local atlas, normal, focus, disabled = data.atlas, data.normal, data.focus, data.disabled
        atlas = atlas or "images/ui.xml"
        normal = normal or "button.tex"
        focus = focus or "button_over.tex"
        disabled = disabled or "button_disabled.tex"
        self.width = data.width or 100
        self.height = data.height or 30
        self.screenScale = 0.9999
        self.moveLayerTimer = 0
        self.followScreenScale = data.followScreenScale
        self.draggable = data.draggable
        if data.draggable then self.clickoffset = Vector3(0, 0, 0) end
        self.dragging = false
        self.draggingTimer = 0
        self.draggingPos = { x = 0, y = 0 }
        self.keepTop = data.keepTop
        self.image = self:AddChild(Image())
        self.image:MoveToBack()
        self.atlas = atlas
        self.image_normal = normal
        self.image_focus = focus or normal
        self.image_disabled = disabled or normal
        self.color_normal = data.colornormal or RGBAColor()
        self.color_focus = data.colorfocus or RGBAColor()
        self.color_disabled = data.colordisabled or RGBAColor()
        if data.cb then self:SetOnClick(data.cb) end
        if data.text then
            self:SetText(data.text)
            self:SetFont(data.font or NUMBERFONT)
            self:SetTextSize(data.fontSize or self.height * 0.75)
            local r, g, b, a = 1, 1, 1, 1
            if data.textColor then
                r = data.textColor.r; g = data.textColor.g; b = data.textColor.b; a = data.textColor.a
            end
            self:SetTextColour(r, g, b, a)
        end
        self:SetTexture(self.atlas, self.image_normal)
        self:StartUpdating()
    end)
function dycImageButton:SetSize(width, height)
    width = width or self.width; height = height or self.height
    self.width = width; self.height = height
    self.image:SetSize(self.width, self.height)
end

function dycImageButton:GetSize() return self.image:GetSize() end

function dycImageButton:SetTexture(atlas, tex)
    self.image:SetTexture(atlas, tex)
    self:SetSize()
    local color = self.color_normal
    self.image:SetTint(color.r, color.g, color.b, color.a)
end

function dycImageButton:SetTextures(atlas, image_normal, image_focus, image_disabled)
    local seted = false
    if not atlas then
        atlas = atlas or "images/frontend.xml"
        image_normal = image_normal or "button_long.tex"
        image_focus = image_focus or "button_long_halfshadow.tex"
        image_disabled = image_disabled or "button_long_disabled.tex"
        seted = true
    end
    self.atlas = atlas
    self.image_normal = image_normal
    self.image_focus = image_focus or image_normal
    self.image_disabled = image_disabled or image_normal
    if self:IsEnabled() then if self.focus then self:OnGainFocus() else self:OnLoseFocus() end else self:OnDisable() end
end

function dycImageButton:OnGainFocus()
    dycImageButton._base.OnGainFocus(self)
    if self:IsEnabled() then
        self:SetTexture(self.atlas, self.image_focus)
        local color = self.color_focus
        self.image:SetTint(color.r, color.g, color.b, color.a)
    end
    if self.image_focus == self.image_normal then self.image:SetScale(1.2, 1.2, 1.2) end
    if self.focusFn then self.focusFn(self) end
end

function dycImageButton:OnLoseFocus()
    dycImageButton._base.OnLoseFocus(self)
    if self:IsEnabled() then
        self:SetTexture(self.atlas, self.image_normal)
        local color = self.color_normal
        self.image:SetTint(color.r, color.g, color.b, color.a)
    end
    if self.image_focus == self.image_normal then self.image:SetScale(1, 1, 1) end
    if self.unfocusFn then self.unfocusFn(self) end
end

function dycImageButton:OnMouseButton(button, down, x, y, ...)
    dycImageButton._base.OnMouseButton(self, button, down, x, y, ...)
    if not down and button == MOUSEBUTTON_LEFT and self.dragging then
        self.dragging = false
        if self.dragEndFn then self.dragEndFn(self) end
    end
    if not self.focus then return false end
    if self.draggable and button == MOUSEBUTTON_LEFT then
        if down then
            self.dragging = true
            self.draggingPos.x = x
            self.draggingPos.y = y
        end
    end
end

function dycImageButton:OnControl(control, down, ...)
    if self.draggingTimer <= 0.3 then
        if dycImageButton._base.OnControl(self, control, down, ...) then
            self:StartUpdating()
            return true
        end
        self:StartUpdating()
    end
    if not self:IsEnabled() or not self.focus then return end
end

function dycImageButton:Enable()
    dycImageButton._base.Enable(self)
    self:SetTexture(self.atlas, self.focus and self.image_focus or self.image_normal)
    local color = self.focus and self.color_focus or self.color_normal
    self.image:SetTint(color.r, color.g, color.b, color.a)
    if self.image_focus == self.image_normal then if self.focus then self.image:SetScale(1.2, 1.2, 1.2) else self.image:SetScale(1, 1, 1) end end
end

function dycImageButton:Disable()
    dycImageButton._base.Disable(self)
    self:SetTexture(self.atlas, self.image_disabled)
    local color = self.color_disabled or self.color_normal
    self.image:SetTint(color.r, color.g, color.b, color.a)
end

function dycImageButton:OnUpdate(t)
    t = t or 0
    local widthScale = getWidthScal()
    if self.followScreenScale and widthScale ~= self.screenScale then
        self:SetScale(widthScale)
        local position = self:GetPosition()
        position.x = position.x * widthScale / self.screenScale
        position.y = position.y * widthScale / self.screenScale
        self.o_pos = position
        self:SetPosition(position)
        self.screenScale = widthScale
    end
    if self.draggable and self.dragging then
        self.draggingTimer = self.draggingTimer + t
        local x, y = getMouseScreenPos()
        local newX = x - self.draggingPos.x
        local newY = y - self.draggingPos.y
        self.draggingPos.x = x; self.draggingPos.y = y
        local position = self:GetPosition()
        position.x = position.x + newX; position.y = position.y + newY
        self.o_pos = position
        self:SetPosition(position)
    end
    if not self.dragging then self.draggingTimer = 0 end
    self.moveLayerTimer = self.moveLayerTimer + t
    if self.keepTop and self.moveLayerTimer > 0.5 then
        self.moveLayerTimer = 0
        self:MoveToFront()
    end
end

dycGuis.ImageButton = dycImageButton
--#endregion

--#region dycWindow
local dycWindow = Class(Widget,
    function(self)
        Widget._ctor(self, "DYC_Window")
        self.width = 400
        self.height = 300
        self.paddingX = 40
        self.paddingY = 42
        self.screenScale = 0.9999
        self.currentLineY = 0
        self.currentLineX = 0
        self.lineHeight = 35
        self.lineSpacingX = 10
        self.lineSpacingY = 3
        self.fontSize = self.lineHeight * 0.9
        self.font = NUMBERFONT
        self.titleFontSize = 40
        self.titleFont = NUMBERFONT
        self.titleColor = RGBAColor(1, 0.7, 0.4)
        self.draggable = true
        self.dragging = false
        self.draggingPos = { x = 0, y = 0 }
        self.draggableChildren = {}
        self.moveLayerTimer = 0
        self.keepTop = false
        self.currentPageIndex = 1
        self.pages = {}
        self.animTargetSize = nil
        self.bg = self:AddChild(dycSlicedImage({ mode = "slice33", atlas = "images/dyc_panel_shadow.xml", texname = "dyc_panel_shadow", texScale = 1.0, }))
        self.bg:SetSize(self.width, self.height)
        self.bg:SetTint(1, 1, 1, 1)
        self:SetCenterAlignment()
        self:AddDraggableChild(self.bg, true)
        self.root = self.bg:AddChild(Widget("root"))
        self.rootTL = self.root:AddChild(Widget("rootTL"))
        self.rootT = self.root:AddChild(Widget("rootT"))
        self.rootTR = self.root:AddChild(Widget("rootTR"))
        self.rootL = self.root:AddChild(Widget("rootL"))
        self.rootM = self.root:AddChild(Widget("rootM"))
        self.rootR = self.root:AddChild(Widget("rootR"))
        self.rootB = self.root:AddChild(Widget("rootB"))
        self.rootBL = self.root:AddChild(Widget("rootBL"))
        self.rootBR = self.root:AddChild(Widget("rootBR"))
        self:SetSize()
        self:SetOffset(0, 0, 0)
        self:StartUpdating()
    end)
function dycWindow:SetBottomAlignment()
    self.bg:SetVAnchor(ANCHOR_BOTTOM)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
end

function dycWindow:SetBottomLeftAlignment()
    self.bg:SetVAnchor(ANCHOR_BOTTOM)
    self.bg:SetHAnchor(ANCHOR_LEFT)
end

function dycWindow:SetTopLeftAlignment()
    self.bg:SetVAnchor(ANCHOR_TOP)
    self.bg:SetHAnchor(ANCHOR_LEFT)
end

function dycWindow:SetCenterAlignment()
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
end

function dycWindow:SetOffset(...) self.bg:SetPosition(...) end

function dycWindow:GetOffset() return self.bg:GetPosition() end

function dycWindow:SetSize(width, height)
    width = width or self.width; height = height or self.height
    self.width = width; self.height = height
    self.bg:SetSize(width, height)
    self.rootTL:SetPosition(-width / 2, height / 2, 0)
    self.rootT:SetPosition(0, height / 2, 0)
    self.rootTR:SetPosition(width / 2, height / 2, 0)
    self.rootL:SetPosition(-width / 2, 0, 0)
    self.rootM:SetPosition(0, 0, 0)
    self.rootR:SetPosition(width / 2, 0, 0)
    self.rootBL:SetPosition(-width / 2, -height / 2, 0)
    self.rootB:SetPosition(0, -height / 2, 0)
    self.rootBR:SetPosition(width / 2, -height / 2, 0)
end

function dycWindow:GetSize() return self.width, self.height end

function dycWindow:SetTitle(title, font, size, color)
    if not self.title then self.title = self.rootT:AddChild(dycText(NUMBERFONT, 10)) end
    title = title or self.title:GetString(); font = font or self.titleFont; size = size or self.titleFontSize; color = color or self.titleColor
    self.titleFont = font; self.titleFontSize = size; self.titleColor = color
    self.title:SetString(title)
    self.title:SetFont(font)
    self.title:SetSize(size)
    self.title:SetPosition(0, -size / 2 * 1.3 - self.paddingY, 0)
    self.title:SetColor(color.r or color[1] or 1, color.g or color[2] or 1, color.b or color[3] or 1, color.a or color[4] or 1)
end

function dycWindow:GetPage(id)
    id = id or self.currentPageIndex
    id = math.max(1, math.floor(id))
    while self.pages[id] == nil do table.insert(self.pages, { root = self.rootTL:AddChild(Widget("rootPage" .. id)), contents = {}, }) end
    return self.pages[id]
end

function dycWindow:SetCurrentPage(id)
    id = math.max(1, math.floor(id))
    self.currentPageIndex = id
    self.currentLineY = 0
    self.currentLineX = 0
    return self:GetPage()
end

function dycWindow:ShowPage(id)
    id = id or self.currentPageIndex
    id = math.max(1, math.min(math.floor(id), #self.pages))
    self:SetCurrentPage(id)
    for i = 1, #self.pages do self:ToggleContents(i, i == id) end
    if self.pageChangeFn then self.pageChangeFn(self, id) end
end

function dycWindow:ShowNextPage()
    local id = self.currentPageIndex + 1
    if id > #self.pages then id = 1 end
    self:ShowPage(id)
end

function dycWindow:ShowPreviousPage()
    local id = self.currentPageIndex - 1
    if id < 1 then id = #self.pages end
    self:ShowPage(id)
end

function dycWindow:ClearPages()
    if #self.pages <= 0 then return end
    for id = 1, #self.pages do self:ClearContents(id) end
end

function dycWindow:AddContent(contentData, size)
    local page = self:GetPage()
    local newContent = page.root:AddChild(contentData)
    if not size then
        if newContent.GetRegionSize then
            size = newContent:GetRegionSize()
        elseif newContent.GetWidth then
            size = newContent:GetWidth()
        elseif newContent.GetSize then
            size = newContent:GetSize()
        elseif newContent.width then
            size =
                newContent.width
        end
    end
    size = size or 100
    newContent:SetPosition(self.paddingX + self.currentLineX + size / 2, -self.paddingY - self.currentLineY - self.lineHeight * 0.5, 0)
    self.currentLineX = self.currentLineX + size + self.lineSpacingX
    tableAdd(page.contents, newContent)
    return newContent
end

function dycWindow:ToggleContents(id, enable)
    local page = self:GetPage(id)
    if enable then page.root:Show() else page.root:Hide() end
end

function dycWindow:ClearContents(id)
    id = id or self.currentPageIndex
    for _, content in pairs(self:GetPage(id).contents) do content:Kill() end
    self:GetPage(id).contents = {}
    self.currentLineY = 0
    self.currentLineX = 0
end

function dycWindow:NewLine(scale)
    self.currentLineY = self.currentLineY + (scale or 1) * self.lineHeight + self.lineSpacingY
    self.currentLineX = 0
end

function dycWindow:AddDraggableChild(child, withChildren)
    tableAdd(self.draggableChildren, child)
    if withChildren then for _, child_ in pairs(child.children) do self:AddDraggableChild(child_, true) end end
end

function dycWindow:OnRawKey(key, down, ...)
    local flag = dycWindow._base.OnRawKey(self, key, down, ...)
    if not self.focus then return false end
    return flag
end

function dycWindow:OnControl(control, down, ...)
    local flag = dycWindow._base.OnControl(self, control, down, ...)
    if not self.focus then return false end
    return flag
end

function dycWindow:OnMouseButton(button, down, x, y, ...)
    local flag = dycWindow._base.OnMouseButton(self, button, down, x, y, ...)
    if not down and button == MOUSEBUTTON_LEFT then self.dragging = false end
    if not self.focus then return false end
    if self.draggable and button == MOUSEBUTTON_LEFT then
        if down then
            local focus = self:GetDeepestFocus()
            if focus and tableContains(self.draggableChildren, focus) then
                self.dragging = true
                self.draggingPos.x = x
                self.draggingPos.y = y
            end
        end
    end
    return flag
end

function dycWindow:Toggle(show, ok)
    show = show ~= nil and show or not self.shown
    if show then self:Show() else self:Hide() end
    if self.toggleFn then self.toggleFn(self, show) end
    if not show and ok and self.okFn then self.okFn(self) end
    if not show and not ok and self.cancelFn then self.cancelFn(self) end
end

function dycWindow:AnimateSize(w, h, speed)
    if w and h then
        self.animTargetSize = { w = w, h = h }
        self.animSpeed = speed or 5
    end
end

function dycWindow:OnUpdate(t)
    t = t or 0
    if self.animTargetSize and t > 0 then
        local w, h = self:GetSize()
        if math.abs(w - self.animTargetSize.w) < 1 then
            self:SetSize(self.animTargetSize.w, self.animTargetSize.h)
            self.animTargetSize = nil
        else
            self:SetSize(lerp(w, self.animTargetSize.w, self.animSpeed * t), lerp(h, self.animTargetSize.h, self.animSpeed * t))
        end
    end
    local widthScale = getWidthScal()
    if widthScale ~= self.screenScale then
        self.bg:SetScale(widthScale)
        local offset = self:GetOffset()
        offset.x = offset.x * widthScale / self.screenScale
        offset.y = offset.y * widthScale / self.screenScale
        self:SetOffset(offset)
        self.screenScale = widthScale
    end
    if self.draggable and self.dragging then
        local x, y = getMouseScreenPos()
        local dx = x - self.draggingPos.x
        local dy = y - self.draggingPos.y
        self.draggingPos.x = x; self.draggingPos.y = y
        local offset = self:GetOffset()
        offset.x = offset.x + dx; offset.y = offset.y + dy
        self:SetOffset(offset)
    end
    self.moveLayerTimer = self.moveLayerTimer + t
    if self.keepTop and self.moveLayerTimer > 0.5 then
        self.moveLayerTimer = 0
        self:MoveToFront()
    end
end

dycGuis.Window = dycWindow
--#endregion

--#region dycBanner
local dycBanner = Class(dycWindow,
    function(self, data)
        dycWindow._ctor(self)
        self:SetTopLeftAlignment()
        self.bg:SetClickable(false)
        self.bg:SetTint(1, 1, 1, 0)
        self.paddingX = 32
        self.paddingY = 28
        self.lineSpacingX = 0
        self.lineHeight = 32
        self.fontSize = 32
        self.font = DEFAULTFONT
        self.bannerColor = data.color or RGBAColor()
        self.bannerText = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, alignH = ANCHOR_LEFT, text = data.text or "???", color = self.bannerColor, }))
        local windowW, windowH = self.currentLineX + self.paddingX * 2, self.lineHeight + self.paddingY * 2
        self:SetSize(windowW, windowH)
        self.windowW = windowW
        self.bannerText:AnimateIn()
        self:SetOffset(700, -windowH / 2)
        self.tags = {}
        self.shouldFadeIn = true
        self.bannerOpacity = 0
        self.bannerTimer = data.duration ~= nil and math.max(data.duration, 1) or 5
        self.bannerIndex = 1
        self.updateFn = data.updateFn
        self.startFn = data.startFn
        if self.startFn then self.startFn(self) end
    end)
function dycBanner:HasTag(tag) return self.tags[string.lower(tag)] == true end

function dycBanner:AddTag(tag) self.tags[string.lower(tag)] = true end

function dycBanner:RemoveTag(tag) self.tags[string.lower(tag)] = nil end

function dycBanner:SetText(text)
    local bannerText = self.bannerText
    bannerText.textString = text
    if not bannerText.animIndex then
        bannerText:SetText(text)
        local page = self:GetPage()
        local content = page.contents[1]
        local width = content and content.GetWidth and content:GetWidth() or 0
        if width > 0 then
            local windowW, windowH = width + self.paddingX * 2, self.lineHeight + self.paddingY * 2
            self:SetSize(windowW, windowH)
        end
    end
end

function dycBanner:SetUpdateFn(updateFn) self.updateFn = updateFn end

function dycBanner:FadeOut() self.shouldFadeIn = false end

function dycBanner:IsFadingOut() return not self.shouldFadeIn end

function dycBanner:OnUpdate(t)
    dycBanner._base.OnUpdate(self, t)
    t = t or 0
    if t > 0 then
        if not IsPaused() then self.bannerTimer = self.bannerTimer - t end
        if self.shouldFadeIn then
            self.bannerOpacity = math.min(1, self.bannerOpacity + t * 3)
        else
            self.bannerOpacity = self.bannerOpacity - t
            if self.bannerOpacity <= 0 then
                if self.bannerHolder then self.bannerHolder:RemoveBanner(self) end
                self:Kill()
            end
        end
        if self.bannerOpacity > 0 then
            self.bg:SetTint(1, 1, 1, self.bannerOpacity)
            local bannerColor = self.bannerColor
            self.bannerText:SetColor(bannerColor.r or bannerColor[1] or 1, bannerColor.g or bannerColor[2] or 1, bannerColor.b or bannerColor[3] or 1, self.bannerOpacity)
            local w, h = self:GetSize()
            local offset = self:GetOffset()
            local x, y = offset.x, offset.y
            local bannerSpacing = self.bannerHolder and self.bannerHolder.bannerSpacing or 0
            local bannerIndex = self.bannerIndex
            local tX, tY = w / 2 * self.screenScale, (h / 2 - h * bannerIndex - bannerSpacing * (bannerIndex - 1)) * self.screenScale
            local lerpT = 0.15
            self:SetOffset(lerp(x, tX, lerpT), lerp(y, tY, lerpT))
            if self.updateFn then
                self.updateFnTimer = (self.updateFnTimer or 0) + t
                if self.updateFnTimer >= 0.5 then
                    self.updateFn(self, self.updateFnTimer)
                    self.updateFnTimer = self.updateFnTimer - 0.5
                end
            end
        end
    end
end

dycGuis.Banner = dycBanner
--#endregion

--#region dycBannerHolder
local dycBannerHolder = Class(Root,
    function(self, data)
        data = data or {}
        Root._ctor(self, data)
        self.banners = {}
        self.bannerInfos = {}
        self.bannerInterval = data.interval or 0.3
        self.bannerShowTimer = 999
        self.bannerSound = data.sound or "dontstarve/HUD/XP_bar_fill_unlock"
        self.bannerSpacing = -15
        self.maxBannerNum = data.max or 10
        self:StartUpdating()
    end)
function dycBannerHolder:PushMessage(text, duration, color, playSound, startFn) table.insert(self.bannerInfos, { text = text, duration = duration, color = color, playSound = playSound, startFn = startFn }) end

function dycBannerHolder:ShowMessage(text, duration, color, playSound, startFn)
    local newBanner = self:AddChild(dycBanner({ text = text, duration = duration, color = color, startFn = startFn }))
    self:AddBanner(newBanner)
    local player = getPlayer()
    if playSound and player and player.SoundEmitter and self.bannerSound then player.SoundEmitter:PlaySound(self.bannerSound) end
    return newBanner
end

function dycBannerHolder:AddBanner(banner)
    banner.bannerHolder = self
    local banners = self.banners
    table.insert(banners, 1, banner)
    for i = 1, #banners do banners[i].bannerIndex = i end
end

function dycBannerHolder:RemoveBanner(bannerToRemove)
    for i, banner in pairs(self.banners) do
        if banner == bannerToRemove then
            table.remove(self.banners, i)
            break
        end
    end
    for i, banner in pairs(self.banners) do banner.bannerIndex = i end
end

function dycBannerHolder:FadeOutBanners(tag) for _, banner in pairs(self.banners) do if not tag or banner:HasTag(tag) then banner:FadeOut() end end end

function dycBannerHolder:OnUpdate(time)
    time = time or 0
    local banners = self.banners
    local bannerInfos = self.bannerInfos
    if time > 0 and #banners > 0 then
        for i = 1, #banners do
            local banner = banners[i]
            if i > self.maxBannerNum then banner:FadeOut() elseif banner.bannerTimer <= 0 then banner:FadeOut() end
        end
    end
    if time > 0 and #bannerInfos > 0 then
        self.bannerShowTimer = self.bannerShowTimer + time
        if self.bannerShowTimer >= self.bannerInterval then
            self.bannerShowTimer = 0
            local bannerInfo = bannerInfos[1]
            table.remove(bannerInfos, 1)
            if #bannerInfos <= 0 then self.bannerShowTimer = 999 end
            self:ShowMessage(bannerInfo.text, bannerInfo.duration, bannerInfo.color, bannerInfo.playSound, bannerInfo.startFn)
        end
    end
end

dycGuis.BannerHolder = dycBannerHolder
--#endregion

--#region dycMessageBox
local dycMessageBox = Class(dycWindow,
    function(self, fontSize)
        dycWindow._ctor(self)
        self.messageText = self.rootM:AddChild(dycText({ font = self.font, fontSize = fontSize.fontSize or self.fontSize, color = RGBAColor(0.9, 0.9, 0.9, 1), }))
        self.strings = fontSize.strings
        self.callback = fontSize.callback
        local dycImageButtonTR = self.rootTR:AddChild(dycImageButton({
            width = 40,
            height = 40,
            normal = "button_checkbox1.tex",
            focus = "button_checkbox1.tex",
            disabled = "button_checkbox1.tex",
            colornormal = RGBAColor(
                1, 1, 1, 1),
            colorfocus = RGBAColor(1, 0.2, 0.2, 0.7),
            colordisabled = RGBAColor(0.4, 0.4, 0.4, 1),
            cb = function()
                if self.callback then self.callback(self, false) end
                self:Kill()
            end,
        }))
        dycImageButtonTR:SetPosition(-self.paddingX - dycImageButtonTR.width / 2, -self.paddingY - dycImageButtonTR.height / 2, 0)
        local dycImageButtonB = self.rootB:AddChild(dycImageButton({
            width = 100,
            height = 50,
            text = self.strings:GetString("ok"),
            cb = function()
                if self.callback then self.callback(self, true) end
                self:Kill()
            end,
        }))
        dycImageButtonB:SetPosition(0, self.paddingY + dycImageButtonB.height / 2, 0)
        if fontSize.message then self:SetMessage(fontSize.message) end
        if fontSize.title then self:SetTitle(fontSize.title, nil, (fontSize.fontSize or self.fontSize) * 1.3) end
    end)
function dycMessageBox:SetMessage(text) self.messageText:SetText(text) end

function dycMessageBox.ShowMessage(message, title, parent, strings, callback, fontSize, animateWidth, animateHeight, width, height, ifAnimateIn)
    local messageBox = parent:AddChild(dycMessageBox({ message = message, title = title, callback = callback, strings = strings, fontSize = fontSize }))
    if ifAnimateIn then messageBox.messageText:AnimateIn() end
    if animateWidth and animateHeight and width and height then
        messageBox:SetSize(width, height)
        messageBox:AnimateSize(animateWidth, animateHeight, 10)
    elseif animateWidth and animateHeight then
        messageBox:SetSize(animateWidth, animateHeight)
    end
end

dycGuis.MessageBox = dycMessageBox
--#endregion

--#region dycBuffTile
local dycBuffTile = Class(Widget,
    function(self, buffTile)
        Widget._ctor(self, "DYC_BuffTile")
        assert(buffTile.buffInfo, "Buff info required!")
        self.bg = self:AddChild(Image(HUD_ATLAS, "inv_slot.tex"))
        self.oriWidth, self.oriHeight = self.bg:GetSize()
        if buffTile.buffInfo.buff.atlas and buffTile.buffInfo.buff.image then
            self.image = self:AddChild(Image(buffTile.buffInfo.buff.atlas, buffTile.buffInfo.buff.image))
            self.image:SetClickable(false)
        end
        self.frame = self:AddChild(Image("images/dyc_buffframe.xml", "dyc_buffframe.tex"))
        self.frame:SetClickable(false)
        self.cdAnim = self:AddChild(Uianim())
        self.cdAnim:GetAnimState():SetBank("recharge_meter")
        self.cdAnim:GetAnimState():SetBuild("dyc_recharge_meter")
        self.cdAnim:GetAnimState():SetMultColour(0, 0, 0, 1)
        self.cdAnim:Hide()
        self.cdAnim:SetClickable(false)
        self.stackText = self:AddChild(Text(NUMBERFONT, buffTile.width and buffTile.width / self.oriWidth * 38 or 15))
        self.stackText:SetString(buffTile.buffInfo.buff.maxStack > 1 and buffTile.buffInfo.stack or "")
        self.buffInfo = buffTile.buffInfo
        self.cdCb = function(_, _, percent) self:SetCooldownPercent(percent) end
        self.stackCb = function(_, str) self.stackText:SetString(buffTile.buffInfo.buff.maxStack > 1 and str or "") end
        self.buffInfo:RegisterEvent("cooldownchange", self.cdCb)
        self.buffInfo:RegisterEvent("stackchange", self.stackCb)
        if self.buffInfo.percent then self:SetCooldownPercent(self.buffInfo.percent) end
        self.buffInfo:RegisterEvent("dispose", function(_) self:Kill() end)
        if self.buffInfo.buff.type == "positive" then self.frame:SetTint(0, 1, 0, 0.5) elseif self.buffInfo.buff.type == "negative" then self.frame:SetTint(1, 0, 0, 0.5) end
        if buffTile.width and buffTile.height then self:SetSize(buffTile.width, buffTile.height) end
    end)
function dycBuffTile:SetCooldownPercent(percent)
    percent = percent or 1
    percent = math.max(0, math.min(percent, 1))
    if not self.cdAnim.shown then self.cdAnim:Show() end
    self.cdAnim:GetAnimState():SetPercent("recharge", percent)
    if percent == 1 then if self.buffInfo.buff.constant then else self.cdAnim:GetAnimState():PlayAnimation("frame_pst") end end
end

function dycBuffTile:SetSize(w, h)
    w = w or self.width or self.oriWidth; h = h or self.height or self.oriHeight
    self.width = w; self.height = h
    self.bg:SetSize(self.width, self.height)
    self.frame:SetSize(self.width, self.height)
    self.stackText:SetRegionSize(self.width, self.height)
    self.stackText:SetHAlign(ANCHOR_RIGHT)
    self.stackText:SetVAlign(ANCHOR_BOTTOM)
    if self.image then self.image:SetSize(self.width, self.height) end
    self.cdAnim:SetScale(-self.width / self.oriWidth, self.height / self.oriHeight, 1)
end

function dycBuffTile:GetSize() return self.width or self.oriWidth, self.height or self.oriHeight end

function dycBuffTile:SetClickable(clickable)
    self.bg:SetClickable(clickable)
    self.frame:SetClickable(clickable)
    self.cdAnim:SetClickable(clickable)
    if self.image then self.image:SetClickable(clickable) end
end

function dycBuffTile:OnGainFocus() if self.gainFocusFn then self.gainFocusFn(self) end end

function dycBuffTile:OnLoseFocus() if self.loseFocusFn then self.loseFocusFn(self) end end

function dycBuffTile:Kill()
    if self.buffInfo.DeregisterEvent then
        self.buffInfo:DeregisterEvent("cooldownchange", self.cdCb)
        self.buffInfo:DeregisterEvent("stackchange", self.stackCb)
    end
    if self.killFn then self.killFn(self) end
    dycBuffTile._base.Kill(self)
end

dycGuis.BuffTile = dycBuffTile
--#endregion

--#region ObjectDetailWindow
local ObjectDetailWindow = Class(dycWindow,
    function(self, data)
        dycWindow._ctor(self)
        self:SetBottomLeftAlignment()
        self.bg:SetClickable(false)
        self.rootTR:MoveToBack()
        self.bg:MoveToBack()
        self:SetSize(400, 250)
        data = data or {}
        self.fontSize = data.fontSize or 25
        self.opacity = data.opacity or 1
        self.nameFont = data.nameFont
        self.hintFont = data.hintFont
    end)
function ObjectDetailWindow:RefreshPage(page)
    if self.icon then
        self.icon:Kill()
        self.icon = nil
    end
    self:ClearPages()
    page = page or {}
    local opacity = self.opacity
    self.bg:SetTint(1, 1, 1, opacity)
    local defaultColor = RGBAColor(0.76, 0.76, 0.76):A(opacity)
    local whiteColor = RGBAColor():A(opacity)
    local redColor = RGBAColor(255 / 255, 0 / 255, 0 / 255):A(opacity)
    local lightBlueColor = RGBAColor(170 / 255, 238 / 255, 255 / 255):A(opacity)
    local lightYellowColor = RGBAColor(255 / 255, 245 / 255, 187 / 255):A(opacity)
    self.lineHeight = self.fontSize
    local maxWidth = math.min(self.lineHeight / 25 * 750, 1200)
    self.paddingX = 35
    self.paddingY = 35
    self.lineSpacingX = 0
    self.lineSpacingY = not isDST() and -self.fontSize / 5 or -self.fontSize / 3.3
    self.font = DEFAULTFONT
    local nameFont = not isWin32() and not isDST() and dycGuis.language and dycGuis.language == "en" and self.nameFont or self.font
    local hintFont = not isWin32() and not isDST() and dycGuis.language and dycGuis.language == "en" and self.hintFont or TALKINGFONT
    local nameFontScale = 1.3
    local hintFontScale = 1.3
    local calcWidth, calcHeight = 0, 0
    local flag = false
    local addLine = function(scale) self:NewLine(scale) end
    if page.icon and page.icon.atlas and page.icon.image then
        local icon = Image(page.icon.atlas, page.icon.image)
        local size = self.lineHeight * 2
        icon:SetSize(size, size)
        icon:SetTint(whiteColor:Get())
        icon:SetClickable(false)
        icon:SetPosition(-self.paddingX + 5 - size / 2, -self.paddingY + 5 - size / 2, 0)
        self.rootTR:AddChild(icon)
        self.icon = icon
    end
    if page.action and #page.action > 0 then
        local actionText = self:AddContent(dycText({ font = hintFont, fontSize = self.fontSize * nameFontScale, text = page.action or "???", color = page.actionColor or lightYellowColor, }))
        self.currentLineX = self.currentLineX + self.fontSize / 2.5
    end
    if page.prefix and #page.prefix > 0 then local prefixText = self:AddContent(dycText({ font = nameFont, fontSize = self.fontSize * nameFontScale, text = page.prefix or "???", color = page.prefixColor or whiteColor, })) end
    if page.name and #page.name > 0 then
        local nameText = self:AddContent(dycText({
            font = nameFont,
            fontSize = self.fontSize * hintFontScale,
            text = page.name or "???",
            color = page.nameColor and
                page.nameColor:A(opacity) or whiteColor,
        }))
    end
    if page.suffix and #page.suffix > 0 then local suffixText = self:AddContent(dycText({ font = nameFont, fontSize = self.fontSize * nameFontScale, text = page.suffix or "???", color = page.suffixColor or whiteColor, })) end
    local iconSize = self.icon and self.icon:GetSize() or 0
    calcWidth = math.max(calcWidth, self.currentLineX + iconSize)
    calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    addLine(0.7)
    calcHeight = calcHeight + self.lineHeight * 0.7 + self.lineSpacingY
    if page.action2 and #page.action2 > 0 then
        flag = true
        addLine(1)
        local action2Text = self:AddContent(dycText({ font = hintFont, fontSize = self.fontSize, text = page.action2 or "???", color = page.action2Color or lightYellowColor, }))
        calcWidth = math.max(calcWidth, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    end
    if page.buffSource and #page.buffSource > 0 then
        flag = true
        addLine(1)
        local buffSourceText = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = page.buffSource or "???", color = page.action2Color or defaultColor, }))
        calcWidth = math.max(calcWidth, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    end
    if page.rarity and #page.rarity > 0 then
        flag = true
        addLine(1)
        local rarityText = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = page.rarity or "", color = whiteColor }))
        calcWidth = math.max(calcWidth, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
        if page.quality then
            local qualityText = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = page.quality or "", color = whiteColor }))
            calcWidth = math.max(calcWidth, self.currentLineX)
        end
    end
    if page.lines then
        for _, line in pairs(page.lines) do
            flag = true
            addLine(1)
            if line.richtext then
                for _, richtextItem in pairs(line.richtext) do
                    if richtextItem.text then
                        self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = richtextItem.text or "", color = richtextItem.color and richtextItem.color:A(opacity) or defaultColor }))
                    elseif richtextItem.icon then
                        local color = richtextItem.color or whiteColor
                        local image = Image(richtextItem.icon.atlas, richtextItem.icon.image)
                        local size = math.max(1, self.lineHeight - self.fontSize / 8)
                        image:SetSize(size, size)
                        image:SetTint(color:Get())
                        image:SetClickable(false)
                        self:AddContent(image)
                        self.currentLineX = self.currentLineX + self.fontSize / 10
                    end
                    calcWidth = math.max(calcWidth, self.currentLineX)
                end
            else
                local lineText = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = line.text or "", color = line.color and line.color:A(opacity) or defaultColor }))
                calcWidth = math.max(calcWidth, self.currentLineX)
            end
            calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
        end
    end
    if page.buffInfos and next(page.buffInfos) then
        flag = true
        addLine(1)
        for _, buffInfo in pairs(page.buffInfos) do
            if not buffInfo.buff.isHidden then
                local size = self.lineHeight + self.lineSpacingY
                local buffTile = self:AddContent(dycBuffTile({ buffInfo = buffInfo, width = size, height = size, }))
                buffTile:SetClickable(false)
                self.currentLineX = self.currentLineX + self.fontSize / 10
            end
        end
        calcWidth = math.max(calcWidth, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    end
    if page.encLines then
        for _, encLine in pairs(page.encLines) do
            if not encLine.isHidden and encLine.text and #encLine.text > 0 then
                flag = true
                addLine(1)
                if encLine.icon then
                    local icon = Image(encLine.icon.atlas, encLine.icon.image)
                    local size = math.max(1, self.lineHeight - self.fontSize / 3.33)
                    icon:SetSize(size, size)
                    icon:SetTint(whiteColor:Get())
                    icon:SetClickable(false)
                    self:AddContent(icon)
                end
                local lineText = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = encLine.text, color = encLine.color and encLine.color:A(opacity) or redColor }))
                calcWidth = math.max(calcWidth, self.currentLineX)
                calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
            end
        end
    end
    local des = nil
    if page.des and #page.des > 0 then
        flag = true
        des = self:AddContent(dycText({ font = self.font, fontSize = self.fontSize, text = page.des or "", color = page.desColor and page.desColor:A(opacity) or lightBlueColor }))
        local desWidth = des:GetWidth()
        local maxWidth_ = 230
        if desWidth > calcWidth then if desWidth >= maxWidth_ and calcWidth < maxWidth_ then calcWidth = maxWidth_ elseif desWidth < maxWidth_ and calcWidth < maxWidth_ then calcWidth = desWidth end end
    end
    calcWidth = math.min(calcWidth, maxWidth)
    local width = calcWidth + self.paddingX * 2
    local height = calcHeight + self.paddingY * 2
    if des then
        des:Kill()
        des = self:AddContent(dycMultiLineText({
            font = self.font,
            fontSize = self.fontSize,
            text = page.des or "",
            color = page.desColor and page.desColor:A(opacity) or lightBlueColor,
            maxWidth = calcWidth,
            spacing = self
                .lineSpacingY
        }))
        des:SetPosition(width / 2, -calcHeight - self.paddingY - des:GetHeight() / 2, 0)
        height = height + des:GetHeight() - self.fontSize * 0.25
    end
    self:SetSize(width, height)
end

function ObjectDetailWindow:SetObjectDetail(page) self:RefreshPage(page) end

function ObjectDetailWindow:OnUpdate(time)
    ObjectDetailWindow._base.OnUpdate(self, time)
    time = time or 0
end

dycGuis.ObjectDetailWindow = ObjectDetailWindow
--#endregion

return dycGuis
