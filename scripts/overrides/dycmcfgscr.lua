local _dYv2 = require "widgets/widget"
local _W8Zx = require "widgets/text"
local _tof5 = require "widgets/spinner"
local _dVij = 0x2
local _O4PR = 0x7
local function _w9lT(_SwDp)
    if not _SwDp.dycHoverText then
        local _Iobl = _SwDp.root:AddChild(_W8Zx(BUTTONFONT, 0x16, " "))
        _SwDp.dycHoverText = _Iobl
        _Iobl:SetHAlign(ANCHOR_LEFT)
        _Iobl:SetVAlign(ANCHOR_TOP)
        _Iobl:SetPosition(0x0, -0xe6, 0x0)
        _Iobl:SetRegionSize(0x320, 0x32)
        _Iobl:EnableWordWrap(true)
    end
    local _xwQH = _SwDp.dycHoverText
    local _XjjZ = function(_rNwy)
        _rNwy = _rNwy and string.gsub(_rNwy, "\n", "")
        if _xwQH.SetText then _xwQH:SetText(_rNwy) else _xwQH:SetString(_rNwy) end
        if _xwQH.AnimateIn then _xwQH:AnimateIn() end
    end
    if not _SwDp.dycOptions then
        _SwDp.dycOptions = {}
        if _SwDp.config and type(_SwDp.config) == "table" then
            for _rZcv, _sqMr in ipairs(_SwDp.config) do
                if _sqMr.name and _sqMr.options and (_sqMr.saved ~= nil or _sqMr.default ~= nil) then
                    local _Jxwd = _sqMr.hover
                    _Jxwd = _Jxwd and type(_Jxwd) == "string" and #_Jxwd > 0x0 and _Jxwd
                    table.insert(_SwDp.dycOptions, { name = _sqMr.name, label = _sqMr.label, options = _sqMr.options, default = _sqMr.default, value = _sqMr.saved, hover = _Jxwd })
                end
            end
        end
    end
    local _MMjA = _SwDp.dycOptions
    local _FKYe = _SwDp:GetDeepestFocus()
    local _m4IQ = _FKYe and _FKYe.column
    local _eKwE = _FKYe and _FKYe.idx
    for _VZzT, _MWC2 in pairs(_SwDp.optionwidgets) do _MWC2.root:Kill() end
    _SwDp.optionwidgets = {}
    _SwDp.left_spinners = {}
    _SwDp.right_spinners = {}
    for _th6s = 0x1, _O4PR * 0x2 do
        local _MTM9 = _SwDp.option_offset + _th6s
        if _MMjA[_MTM9] then
            local _aM5l = {}
            for _9SuR, _Yslx in ipairs(_MMjA[_MTM9].options) do
                local _qwrR = _Yslx.hover
                _qwrR = _qwrR and type(_qwrR) == "string" and #_qwrR > 0x0 and _qwrR
                table.insert(_aM5l, { text = _Yslx.description, data = _Yslx.data, hover = _qwrR })
            end
            local _4hGU = _SwDp.optionspanel:AddChild(_dYv2("option"))
            local _8NB0 = 0x32
            local _jrhy = 0xdc
            local _NGBD = _4hGU:AddChild(_tof5(_aM5l, _jrhy, _8NB0))
            _NGBD:SetTextColour(0x0, 0x0, 0x0, 0x1)
            local _sIQB = _MMjA[_MTM9].value
            if _sIQB == nil then _sIQB = _MMjA[_MTM9].default end
            local _PkFc = function()
                _SwDp.dycHoveredWidget = _NGBD
                local _FS4u = _MMjA[_MTM9].hover
                local _KfL6 = _NGBD.options[_NGBD.selectedIndex]
                local _0pyE = _KfL6 and _KfL6.hover
                _XjjZ((_FS4u or "") .. (_FS4u and _0pyE and " " or "") .. (_0pyE or " "))
            end
            _NGBD.OnChanged = function(_n1bw, _lfbS)
                _MMjA[_MTM9].value = _lfbS
                _SwDp:MakeDirty()
                _PkFc()
            end
            _NGBD:SetSelected(_sIQB)
            _NGBD:SetPosition(0x23, 0x0, 0x0)
            _NGBD.OnGainFocus = function() _PkFc() end
            _NGBD.OnLoseFocus = function() if _SwDp.dycHoveredWidget == _NGBD then _XjjZ(" ") end end
            local _L6ds = 0x37
            local _0SfR = 0xb4
            local _QZcT = _NGBD:AddChild(_W8Zx(BUTTONFONT, 0x1e, (_MMjA[_MTM9].label or _MMjA[_MTM9].name) or STRINGS.UI.MODSSCREEN.UNKNOWN_MOD_CONFIG_SETTING))
            _QZcT:SetPosition(-_0SfR / 0x2 - 0x69, 0x0, 0x0)
            _QZcT:SetRegionSize(_0SfR, 0x32)
            _QZcT:SetHAlign(ANCHOR_MIDDLE)
            if _th6s <= _O4PR then
                _4hGU:SetPosition(-0x9b, (_O4PR - 0x1) * _L6ds * .5 - (_th6s - 0x1) * _L6ds - 0xa, 0x0)
                table.insert(_SwDp.left_spinners, _NGBD)
                _NGBD.column = "left"
                _NGBD.idx = #_SwDp.left_spinners
            else
                _4hGU:SetPosition(0x109, (_O4PR - 0x1) * _L6ds * .5 - (_th6s - 0x1 - _O4PR) * _L6ds - 0xa, 0x0)
                table.insert(_SwDp.right_spinners, _NGBD)
                _NGBD.column = "right"
                _NGBD.idx = #_SwDp.right_spinners
            end
            table.insert(_SwDp.optionwidgets, { root = _4hGU })
        end
    end
    _SwDp:HookupFocusMoves()
    if _m4IQ and _eKwE then
        local _MDpq = _m4IQ == "right" and _SwDp.right_spinners or _SwDp.left_spinners
        _MDpq[math.min(#_MDpq, _eKwE)]:SetFocus()
    end
end
local function _Sgpe(_PkHy)
    if _PkHy.dycOptions then
        local _h7pA = nil
        for _HtqK, _jXBJ in pairs(_PkHy.dycOptions) do
            if not _h7pA then _h7pA = {} end
            table.insert(_h7pA, { name = _jXBJ.name, label = _jXBJ.label, options = _jXBJ.options, default = _jXBJ.default, saved = _jXBJ.value })
        end
        return _h7pA
    end
end
local function _OME2(_a4qb)
    _a4qb.dycOverrided = true
    _a4qb.CollectSettings = _Sgpe
    _a4qb.RefreshOptions = _w9lT
    _a4qb.optionspanel:SetPosition(0x0, 0x0)
    _a4qb:RefreshOptions()
end
return _OME2
