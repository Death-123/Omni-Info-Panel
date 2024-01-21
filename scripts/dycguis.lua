local _TeoQ = require "widgets/widget"
local _CHD3 = require "widgets/image"
local _AouV = require "widgets/text"
local _mdUc = require "widgets/screen"
local _gebF = require "widgets/button"
local _3XGn = require "widgets/spinner"
local _e8aF = require "widgets/uianim"
local _Pi44 = {}
_Pi44.Init = function(_8snu, _m71S)
    if _8snu.initialized then return end
    _8snu.initialized = true
    _8snu.localization = _m71S.localization
    _8snu.multiLineScale = _m71S.multiLineScale
    _8snu.textWidthScale = _m71S.textWidthScale
    _8snu.language = _m71S.language
end
local function _XraE() return string.upper(PLATFORM) == "WIN32" end
local function _LEg5() return TheSim:GetGameID() == "DST" end
local function _U91l() if _LEg5() then return ThePlayer else return GetPlayer() end end
local function _N535() if _LEg5() then return TheWorld else return GetWorld() end end
local _HaLE = function(_G8os, _uAX3)
    local _ZzZi = _Pi44.localization.strings or _Pi44.localization:GetStrings()
    return _ZzZi:GetString(_G8os, _uAX3)
end
local _ntRL = function()
    local _WcMK, sh = TheSim:GetScreenSize()
    return _WcMK / 0x780
end
local _2fVP = function() return TheSim:GetScreenPos(TheInput:GetWorldPosition():Get()) end
local _qSrc = function(_ysWl, _wwlZ, _dSjk, _Qngu)
    return {
        r = _ysWl or 0x1,
        g = _wwlZ or 0x1,
        b = _dSjk or 0x1,
        a = _Qngu or 0x1,
        Get = function(_jS7t) return _jS7t.r, _jS7t.g, _jS7t.b, _jS7t.a end,
        R = function(
            _nsiF, _ybMB)
            _nsiF.r = _ybMB
            return _nsiF
        end,
        G = function(_mIbL, _jUEH)
            _mIbL.g = _jUEH
            return _mIbL
        end,
        B = function(_NOW0, _h2Id)
            _NOW0.b = _h2Id
            return _NOW0
        end,
        A = function(_2C3O, _8BGH)
            _2C3O.a = _8BGH
            return _2C3O
        end,
    }
end
local _U7Zg = function(_jrXu, _UUNE, _RIb6) return _jrXu + (_UUNE - _jrXu) * _RIb6 end
local function _SJQF(_6hlv, _TeM6)
    if _TeM6 == nil then _TeM6 = "%s" end
    local _h7CU = {}
    local _cD0l = 0x1
    for _5yxv in string.gmatch(_6hlv, "([^" .. _TeM6 .. "]+)") do
        _h7CU[_cD0l] = _5yxv
        _cD0l = _cD0l + 0x1
    end
    return _h7CU
end
local _0Bfx = function(_pdwt, _A66z)
    for _UbLN, _VDwf in pairs(_pdwt) do if _VDwf == _A66z then return true end end
    return false
end
local _O1nX = function(_s2Cn, _RZbt) if not _0Bfx(_s2Cn, _RZbt) then table.insert(_s2Cn, _RZbt) end end
local _lvOF = function(_bYgQ, _SsFl) for _ac9a, _2nzB in pairs(_bYgQ) do if _2nzB == _SsFl then return _ac9a end end end
local _brQ9 = function(_orew, _KiMK)
    local _5Noz = _lvOF(_orew, _KiMK)
    if _5Noz then table.remove(_orew, _5Noz) end
end
local _xgL7 = Class(_TeoQ, function(_xQxv, _wbXp)
    _TeoQ._ctor(_xQxv, "DYC_Root")
    _xQxv.keepTop = _wbXp.keepTop
    _xQxv.moveLayerTimer = 0x0
    if _wbXp.keepTop then _xQxv:StartUpdating() end
end)
function _xgL7:OnUpdate(_3BvE)
    _3BvE = _3BvE or 0x0
    self.moveLayerTimer = self.moveLayerTimer + _3BvE
    if self.keepTop and self.moveLayerTimer > 0.5 then
        self.moveLayerTimer = 0x0
        self:MoveToFront()
    end
end

_Pi44.Root = _xgL7
local _AJr3 = Class(_AouV,
    function(_OOqU, _TUfJ, _Q4px, _YKNV, _LCdv)
        if _TUfJ and type(_TUfJ) == "table" then
            local _4uNm = _TUfJ
            _AouV._ctor(_OOqU, _4uNm.font or NUMBERFONT, _4uNm.fontSize or 0x1e, _4uNm.text)
            if _4uNm.color then
                local _EZCj = _4uNm.color
                _OOqU:SetColor(_EZCj.r or _EZCj[0x1] or 0x1, _EZCj.g or _EZCj[0x2] or 0x1, _EZCj.b or _EZCj[0x3] or 0x1, _EZCj.a or _EZCj[0x4] or 0x1)
            end
            if _4uNm.regionSize then _OOqU:SetRegionSize(_4uNm.regionSize.w, _4uNm.regionSize.h) end
            _OOqU.alignH = _4uNm.alignH
            _OOqU.alignV = _4uNm.alignV
            _OOqU.focusFn = _4uNm.focusFn
            _OOqU.unfocusFn = _4uNm.unfocusFn
            _OOqU.hittest = _4uNm.hittest
        else
            _AouV._ctor(_OOqU, _TUfJ or NUMBERFONT, _Q4px or 0x1e, _YKNV)
            _OOqU.hittest = _LCdv
            if _YKNV then _OOqU:SetText(_YKNV) end
        end
    end)
function _AJr3:GetImage()
    if not self.image then
        self.image = self:AddChild(_CHD3("images/ui.xml", "button.tex"))
        self.image:MoveToBack()
        self.image:SetTint(0x0, 0x0, 0x0, 0x0)
    end
    return self.image
end

function _AJr3:SetText(_Whkv)
    local _vuUS = self:GetWidth()
    local _Z1nN = self:GetHeight()
    local _LXPB = self:GetPosition()
    self:SetString(_Whkv)
    if self.alignH and self.alignH ~= ANCHOR_MIDDLE then
        local _WAAt = self:GetWidth()
        _LXPB.x = _LXPB.x + (_WAAt - _vuUS) / 0x2 * (self.alignH == ANCHOR_LEFT and 0x1 or -0x1)
    end
    if self.alignV and self.alignV ~= ANCHOR_MIDDLE then
        local _YK37 = self:GetHeight()
        _LXPB.y = _LXPB.y + (_YK37 - _Z1nN) / 0x2 * (self.alignV == ANCHOR_BOTTOM and 0x1 or -0x1)
    end
    if self.alignH or self.alignV then self:SetPosition(_LXPB) end
    if self.hittest then self:GetImage():SetSize(self:GetSize()) end
end

function _AJr3:SetColor(...) self:SetColour(...) end

function _AJr3:GetRegionSize()
    local _F69t, h = _AJr3._base.GetRegionSize(self)
    _F69t = _F69t * (_Pi44.textWidthScale or 0x1)
    return _F69t, h
end

function _AJr3:GetWidth()
    local _bep4, h = self:GetRegionSize()
    _bep4 = _bep4 < 0x2710 and _bep4 or 0x0
    return _bep4
end

function _AJr3:GetHeight()
    local _r6WJ, h = self:GetRegionSize()
    h = h < 0x2710 and h or 0x0
    return h
end

function _AJr3:GetSize()
    local _T4bE, h = self:GetRegionSize()
    _T4bE = _T4bE < 0x2710 and _T4bE or 0x0
    h = h < 0x2710 and h or 0x0
    return _T4bE, h
end

function _AJr3:OnGainFocus()
    _AJr3._base.OnGainFocus(self)
    if self.focusFn then self.focusFn(self) end
end

function _AJr3:OnLoseFocus()
    _AJr3._base.OnLoseFocus(self)
    if self.unfocusFn then self.unfocusFn(self) end
end

function _AJr3:AnimateIn(_Z56T)
    self.textString = self.string
    self.animSpeed = _Z56T or 0x3c
    self.animIndex = 0x0
    self.animTimer = 0x0
    self:SetText("")
    self:StartUpdating()
end

function _AJr3:OnUpdate(_pATg)
    _pATg = _pATg or 0x0
    if _AJr3._base.OnUpdate then _AJr3._base.OnUpdate(self, _pATg) end
    if _pATg > 0x0 and self.animIndex and self.textString and #self.textString > 0x0 then
        self.animTimer = self.animTimer + _pATg
        if self.animTimer > 0x1 / self.animSpeed then
            self.animTimer = 0x0
            self.animIndex = self.animIndex + 0x1
            if self.animIndex > #self.textString then
                self.animIndex = nil
                self:SetText(self.textString)
            else
                local _PlAd = string.byte(string.sub(self.textString, self.animIndex, self.animIndex))
                if _PlAd and _PlAd > 0x7f then self.animIndex = self.animIndex + 0x2 end
                self:SetText(string.sub(self.textString, 0x1, self.animIndex))
            end
        end
    end
end

_Pi44.Text = _AJr3
local _yjum = Class(_TeoQ,
    function(_omZy, _uBQV, _LswP, _bfR2, _y6D2)
        _TeoQ._ctor(_omZy, "DYC_MultiLineText")
        local _OjSf = nil
        if _uBQV and type(_uBQV) == "table" then _OjSf = _uBQV else _OjSf = { font = _uBQV, fontSize = _LswP, text = _bfR2, maxWidth = _y6D2 } end
        _omZy.lines = {}
        _omZy.width = 0x0
        _omZy.height = 0x0
        _omZy.fontSize = _OjSf.fontSize or 0x1e
        _omZy.font = _OjSf.font or NUMBERFONT
        _omZy.spacing = _OjSf.spacing or 0x0
        _omZy:SetMaxWidth(_OjSf.maxWidth)
        _omZy:SetText(_OjSf.text)
        if _OjSf.color then
            local _m2NZ = _OjSf.color
            _omZy:SetColor(_m2NZ.r or _m2NZ[0x1] or 0x1, _m2NZ.g or _m2NZ[0x2] or 0x1, _m2NZ.b or _m2NZ[0x3] or 0x1, _m2NZ.a or _m2NZ[0x4] or 0x1)
        end
    end)
function _yjum:SetText(_OlFh)
    self.string = _OlFh or self.string or ""
    local _LKvG = self:AddChild(_AouV(self.font, self.fontSize, self.string))
    self.singleLineWidth, self.singleLineHeight = _LKvG:GetRegionSize()
    if _LEg5() then self.singleLineHeight = self.singleLineHeight * 1.25 end
    _LKvG:Kill()
    for _eNjy, _okh6 in pairs(self.lines) do _okh6:Kill() end
    self.width = 0x0
    self.lines = {}
    local _eefJ = self.string
    if _eefJ and #_eefJ > 0x0 then
        local _DHPB = self.singleLineWidth
        local _QCIe = self.singleLineHeight
        local _EUlC = self.maxWidth
        local _X1gz = _DHPB / #_eefJ
        local _WpeA = 0x0
        local _UlXV = 0x1
        local _XfOD = false
        while _UlXV <= #_eefJ do
            local _bWbi = _eefJ:byte(_UlXV)
            if _bWbi > 0x7f and _UlXV + 0x2 <= #_eefJ then
                _UlXV = _UlXV + 0x2
            elseif _bWbi == 0x20 then
                if _UlXV - _WpeA == 0x1 then
                    _WpeA = _WpeA + 0x1
                else
                    for _Wdvg = 0x1, 0xf do
                        local _GeBi = _UlXV + _Wdvg <= #_eefJ and _eefJ:byte(_UlXV + _Wdvg)
                        if not _GeBi or _GeBi == 0x20 or _GeBi > 0x7f then
                            break
                        elseif (_UlXV + _Wdvg - _WpeA) * _X1gz > _EUlC then
                            _XfOD = true
                            break
                        end
                    end
                end
            end
            local _bqcu = _UlXV + 0x1 <= #_eefJ and _eefJ:byte(_UlXV + 0x1)
            local _BQLx = _bqcu and (_bqcu > 0x7f and _X1gz * 2.9 or _X1gz) or 0x0
            if _UlXV - _WpeA > 0x0 and (_XfOD or _UlXV >= #_eefJ or (_UlXV - _WpeA) * _X1gz + _BQLx > _EUlC) then
                local _dRjY = self:AddChild(_AouV(self.font, self.fontSize, _eefJ:sub(_WpeA + 0x1, _UlXV)))
                table.insert(self.lines, _dRjY)
                local _aOZs = _dRjY:GetRegionSize()
                self.width = math.max(self.width, _aOZs)
                _WpeA = _UlXV
                _XfOD = false
            end
            _UlXV = _UlXV + 0x1
        end
        self.height = _QCIe * #self.lines + self.spacing * (#self.lines - 0x1)
        local _T4OK = #self.lines
        for _XfdS = 0x1, _T4OK do
            local _SdPT = self.lines[_XfdS]
            local _Fa3S = _SdPT:GetRegionSize()
            _SdPT:SetPosition(-_EUlC / 0x2 + _Fa3S / 0x2, ((_T4OK - 0x1) / 0x2 - _XfdS + 0x1) * (_QCIe + self.spacing), 0x0)
        end
    end
end

function _yjum:SetMaxWidth(_Y5zE)
    self.maxWidth = _Y5zE or self.maxWidth or 0x1f4
    if self.string then self:SetText() end
end

function _yjum:SetColour(...) for _iDtg, _Erzt in pairs(self.lines) do _Erzt:SetColour(...) end end

function _yjum:SetColor(...) self:SetColour(...) end

function _yjum:SetAlpha(...) for _Nmhh, _odwL in pairs(self.lines) do _odwL:SetAlpha(...) end end

function _yjum:GetWidth() return self.width end

function _yjum:GetHeight() return self.height end

function _yjum:GetSize() return self.width, self.height end

function _yjum:GetRegionSize() return self.maxWidth or 0x0, self.height end

_Pi44.MultiLineText = _yjum
local _z0v6 = Class(_TeoQ,
    function(_muLx, _b21d)
        _TeoQ._ctor(_muLx, "DYC_SlicedImage")
        _muLx.images = {}
        _muLx.mode = "slice13"
        _muLx.texScale = _b21d.texScale or 0x1
        _muLx.width = 0x64
        _muLx.height = 0x64
        _muLx:SetTextures(_b21d)
    end)
function _z0v6:__tostring() return string.format("%s (%s)", self.name, self.mode) end

function _z0v6:SetTextures(_YAaf)
    assert(_YAaf.mode)
    self.images = {}
    self.mode = _YAaf.mode
    if self.mode == "slice13" or self.mode == "slice31" then
        local _pujq = nil
        _pujq = self:AddChild(_CHD3(_YAaf.atlas, _YAaf.texname .. "_1.tex"))
        _pujq.oriW, _pujq.oriH = _pujq:GetSize()
        _pujq.imgPos = 0x1
        self.images[0x1] = _pujq
        _pujq = self:AddChild(_CHD3(_YAaf.atlas, _YAaf.texname .. "_2.tex"))
        _pujq.oriW, _pujq.oriH = _pujq:GetSize()
        _pujq.imgPos = 0x2
        self.images[0x2] = _pujq
        _pujq = self:AddChild(_CHD3(_YAaf.atlas, _YAaf.texname .. "_3.tex"))
        _pujq.oriW, _pujq.oriH = _pujq:GetSize()
        _pujq.imgPos = 0x3
        self.images[0x3] = _pujq
        if self.mode == "slice13" then
            assert(self.images[0x1].oriH == self.images[0x3].oriH, "Height must be equal!")
            assert(self.images[0x1].oriH == self.images[0x2].oriH, "Height must be equal!")
        else
            assert(self.images[0x1].oriW == self.images[0x3].oriW, "Width must be equal!")
            assert(self.images[0x1].oriW == self.images[0x2].oriW, "Width must be equal!")
        end
        return
    elseif self.mode == "slice33" then
        local _KIgG = nil
        for _PTfF = 0x1, 0x3 do
            for _5HEC = 0x1, 0x3 do
                _KIgG = self:AddChild(_CHD3(_YAaf.atlas, _YAaf.texname .. "_" .. _PTfF .. _5HEC .. ".tex"))
                _KIgG.oriW, _KIgG.oriH = _KIgG:GetSize()
                _KIgG.imgPos = _PTfF * 0xa + _5HEC
                self.images[_PTfF * 0xa + _5HEC] = _KIgG
                if _PTfF > 0x1 then assert(self.images[_PTfF * 0xa + _5HEC].oriW == self.images[(_PTfF - 0x1) * 0xa + _5HEC].oriW, "Width must be equal!") end
                if _5HEC > 0x1 then assert(self.images[_PTfF * 0xa + _5HEC].oriH == self.images[_PTfF * 0xa + _5HEC - 0x1].oriH, "Height must be equal!") end
            end
        end
        return
    end
    error("Mode not supported!")
    self:SetSize()
end

function _z0v6:SetSize(_Nrt7, _KCrY)
    _Nrt7 = _Nrt7 or self.width
    _KCrY = _KCrY or self.height
    if self.mode == "slice13" then
        local _15fM = self.images[0x1]
        local _zvFm = self.images[0x2]
        local _mc23 = self.images[0x3]
        local _3ga1 = math.min(self.texScale, math.min(_Nrt7 / (_15fM.oriW + _mc23.oriW), _KCrY / _15fM.oriH))
        local _TYqC = math.floor(_15fM.oriW * _3ga1)
        local _ofCD = math.floor(_mc23.oriW * _3ga1)
        local _xzzG = math.max(0x0, _Nrt7 - _TYqC - _ofCD)
        _15fM:SetSize(_TYqC, _KCrY)
        _zvFm:SetSize(_xzzG, _KCrY)
        _mc23:SetSize(_ofCD, _KCrY)
        local _hcEX = (_TYqC - _ofCD) / 0x2
        local _duyP = -_TYqC / 0x2 - _xzzG / 0x2 + _hcEX
        local _DEhu = _ofCD / 0x2 + _xzzG / 0x2 + _hcEX
        _15fM:SetPosition(_duyP, 0x0, 0x0)
        _zvFm:SetPosition(_hcEX, 0x0, 0x0)
        _mc23:SetPosition(_DEhu, 0x0, 0x0)
        self.width = _TYqC + _xzzG + _ofCD
        self.height = _KCrY
    elseif self.mode == "slice31" then
        local _o2t2 = self.images[0x1]
        local _PKIH = self.images[0x2]
        local _qBnV = self.images[0x3]
        local _lYJV = math.min(self.texScale, math.min(_KCrY / (_o2t2.oriH + _qBnV.oriH), _Nrt7 / _o2t2.oriW))
        local _DLo9 = math.floor(_o2t2.oriH * _lYJV)
        local _58fj = math.floor(_qBnV.oriH * _lYJV)
        local _He0I = math.max(0x0, _KCrY - _DLo9 - _58fj)
        _o2t2:SetSize(_Nrt7, _DLo9)
        _PKIH:SetSize(_Nrt7, _He0I)
        _qBnV:SetSize(_Nrt7, _58fj)
        local _Rvyp = (_DLo9 - _58fj) / 0x2
        local _Q6ow = -_DLo9 / 0x2 - _He0I / 0x2 + _Rvyp
        local _VJYX = _58fj / 0x2 + _He0I / 0x2 + _Rvyp
        _o2t2:SetPosition(0x0, _Q6ow, 0x0)
        _PKIH:SetPosition(0x0, _Rvyp, 0x0)
        _qBnV:SetPosition(0x0, _VJYX, 0x0)
        self.height = _DLo9 + _He0I + _58fj
        self.width = _Nrt7
    elseif self.mode == "slice33" then
        local _12pP = self.images
        local _YTLo = math.min(self.texScale, math.min(_Nrt7 / (_12pP[0xb].oriW + _12pP[0xd].oriW), _KCrY / (_12pP[0xb].oriH + _12pP[0x1f].oriH)))
        local _UMl1, hs, xs, ys = {}, {}, {}, {}
        _UMl1[0x1] = math.floor(_12pP[0xb].oriW * _YTLo)
        _UMl1[0x3] = math.floor(_12pP[0xd].oriW * _YTLo)
        _UMl1[0x2] = math.max(0x0, _Nrt7 - _UMl1[0x1] - _UMl1[0x3])
        hs[0x1] = math.floor(_12pP[0xb].oriH * _YTLo)
        hs[0x3] = math.floor(_12pP[0x1f].oriH * _YTLo)
        hs[0x2] = math.max(0x0, _KCrY - hs[0x1] - hs[0x3])
        xs[0x2] = (_UMl1[0x1] - _UMl1[0x3]) / 0x2
        xs[0x1] = -_UMl1[0x1] / 0x2 - _UMl1[0x2] / 0x2 + xs[0x2]
        xs[0x3] = _UMl1[0x3] / 0x2 + _UMl1[0x2] / 0x2 + xs[0x2]
        ys[0x2] = (hs[0x1] - hs[0x3]) / 0x2
        ys[0x1] = -hs[0x1] / 0x2 - hs[0x2] / 0x2 + ys[0x2]
        ys[0x3] = hs[0x3] / 0x2 + hs[0x2] / 0x2 + ys[0x2]
        for _qhyq = 0x1, 0x3 do
            for _XkvK = 0x1, 0x3 do
                _12pP[_qhyq * 0xa + _XkvK]:SetSize(_UMl1[_XkvK], hs[_qhyq])
                _12pP[_qhyq * 0xa + _XkvK]:SetPosition(xs[_XkvK], ys[_qhyq], 0x0)
            end
        end
        self.width = _UMl1[0x1] + _UMl1[0x2] + _UMl1[0x3]
        self.height = hs[0x1] + hs[0x2] + hs[0x3]
    end
end

function _z0v6:GetSize() return self.width, self.height end

function _z0v6:SetTint(_U9Z4, _d8ep, _Kna4, _XBid) for _TzuY, _DLYe in pairs(self.images) do _DLYe:SetTint(_U9Z4, _d8ep, _Kna4, _XBid) end end

function _z0v6:SetClickable(_kG9J) for _I8IL, _nnc1 in pairs(self.images) do _nnc1:SetClickable(_kG9J) end end

_Pi44.SlicedImage = _z0v6
local _cuL0 = Class(_3XGn, function(_OvOH, _MqeY, _8uHx, _0Ghi, _lVUG, _9FRM, _OyQK, _yqby) _3XGn._ctor(_OvOH, _MqeY, _8uHx, _0Ghi, _lVUG, _9FRM, _OyQK, _yqby) end)
function _cuL0:GetSelectedHint() return self.options[self.selectedIndex].hint or "" end

function _cuL0:SetSelected(_XDkh, _7qC3)
    if _XDkh == nil and _7qC3 ~= nil then return self:SetSelected(_7qC3) end
    for _CkKn, _BlUR in pairs(self.options) do
        if _BlUR.data == _XDkh then
            self:SetSelectedIndex(_CkKn)
            return true
        end
    end
    if _7qC3 then return self:SetSelected(_7qC3) else return false end
end

function _cuL0:SetSelectedIndex(_f3Qr, ...)
    _cuL0._base.SetSelectedIndex(self, _f3Qr, ...)
    if self.setSelectedIndexFn then self.setSelectedIndexFn(self) end
end

function _cuL0:OnGainFocus()
    _cuL0._base.OnGainFocus(self)
    if self.focusFn then self.focusFn(self) end
end

function _cuL0:OnLoseFocus()
    _cuL0._base.OnLoseFocus(self)
    if self.unfocusFn then self.unfocusFn(self) end
end

function _cuL0:OnMouseButton(_Kf1i, _Oc2n, _JDAR, _tiJw, ...)
    _cuL0._base.OnMouseButton(self, _Kf1i, _Oc2n, _JDAR, _tiJw, ...)
    if not _Oc2n and _Kf1i == MOUSEBUTTON_LEFT then if self.mouseLeftUpFn then self.mouseLeftUpFn(self) end end
    if not self.focus then return false end
    if _Oc2n and _Kf1i == MOUSEBUTTON_LEFT then if self.mouseLeftDownFn then self.mouseLeftDownFn(self) end end
end

_Pi44.Spinner = _cuL0
local _v9l4 = Class(_gebF,
    function(_s0eY, _4DlD)
        _gebF._ctor(_s0eY, "DYC_ImageButton")
        _4DlD = _4DlD or {}
        local _O9EE, normal, focus, disabled = _4DlD.atlas, _4DlD.normal, _4DlD.focus, _4DlD.disabled
        _O9EE = _O9EE or "images/ui.xml"
        normal = normal or "button.tex"
        focus = focus or "button_over.tex"
        disabled = disabled or "button_disabled.tex"
        _s0eY.width = _4DlD.width or 0x64
        _s0eY.height = _4DlD.height or 0x1e
        _s0eY.screenScale = 0.9999
        _s0eY.moveLayerTimer = 0x0
        _s0eY.followScreenScale = _4DlD.followScreenScale
        _s0eY.draggable = _4DlD.draggable
        if _4DlD.draggable then _s0eY.clickoffset = Vector3(0x0, 0x0, 0x0) end
        _s0eY.dragging = false
        _s0eY.draggingTimer = 0x0
        _s0eY.draggingPos = { x = 0x0, y = 0x0 }
        _s0eY.keepTop = _4DlD.keepTop
        _s0eY.image = _s0eY:AddChild(_CHD3())
        _s0eY.image:MoveToBack()
        _s0eY.atlas = _O9EE
        _s0eY.image_normal = normal
        _s0eY.image_focus = focus or normal
        _s0eY.image_disabled = disabled or normal
        _s0eY.color_normal = _4DlD.colornormal or _qSrc()
        _s0eY.color_focus = _4DlD.colorfocus or _qSrc()
        _s0eY.color_disabled = _4DlD.colordisabled or _qSrc()
        if _4DlD.cb then _s0eY:SetOnClick(_4DlD.cb) end
        if _4DlD.text then
            _s0eY:SetText(_4DlD.text)
            _s0eY:SetFont(_4DlD.font or NUMBERFONT)
            _s0eY:SetTextSize(_4DlD.fontSize or _s0eY.height * 0.75)
            local _KUXS, g, b, a = 0x1, 0x1, 0x1, 0x1
            if _4DlD.textColor then
                _KUXS = _4DlD.textColor.r; g = _4DlD.textColor.g; b = _4DlD.textColor.b; a = _4DlD.textColor.a
            end
            _s0eY:SetTextColour(_KUXS, g, b, a)
        end
        _s0eY:SetTexture(_s0eY.atlas, _s0eY.image_normal)
        _s0eY:StartUpdating()
    end)
function _v9l4:SetSize(_MbD4, _you9)
    _MbD4 = _MbD4 or self.width; _you9 = _you9 or self.height
    self.width = _MbD4; self.height = _you9
    self.image:SetSize(self.width, self.height)
end

function _v9l4:GetSize() return self.image:GetSize() end

function _v9l4:SetTexture(_U34s, _Lxvf)
    self.image:SetTexture(_U34s, _Lxvf)
    self:SetSize()
    local _RW8U = self.color_normal
    self.image:SetTint(_RW8U.r, _RW8U.g, _RW8U.b, _RW8U.a)
end

function _v9l4:SetTextures(_acok, _1zJK, _85hI, _u1Ut)
    local _GrFe = false
    if not _acok then
        _acok = _acok or "images/frontend.xml"
        _1zJK = _1zJK or "button_long.tex"
        _85hI = _85hI or "button_long_halfshadow.tex"
        _u1Ut = _u1Ut or "button_long_disabled.tex"
        _GrFe = true
    end
    self.atlas = _acok
    self.image_normal = _1zJK
    self.image_focus = _85hI or _1zJK
    self.image_disabled = _u1Ut or _1zJK
    if self:IsEnabled() then if self.focus then self:OnGainFocus() else self:OnLoseFocus() end else self:OnDisable() end
end

function _v9l4:OnGainFocus()
    _v9l4._base.OnGainFocus(self)
    if self:IsEnabled() then
        self:SetTexture(self.atlas, self.image_focus)
        local _Gfeb = self.color_focus
        self.image:SetTint(_Gfeb.r, _Gfeb.g, _Gfeb.b, _Gfeb.a)
    end
    if self.image_focus == self.image_normal then self.image:SetScale(1.2, 1.2, 1.2) end
    if self.focusFn then self.focusFn(self) end
end

function _v9l4:OnLoseFocus()
    _v9l4._base.OnLoseFocus(self)
    if self:IsEnabled() then
        self:SetTexture(self.atlas, self.image_normal)
        local _I21q = self.color_normal
        self.image:SetTint(_I21q.r, _I21q.g, _I21q.b, _I21q.a)
    end
    if self.image_focus == self.image_normal then self.image:SetScale(0x1, 0x1, 0x1) end
    if self.unfocusFn then self.unfocusFn(self) end
end

function _v9l4:OnMouseButton(_NzXY, _WdRJ, _Xsd9, _PTaZ, ...)
    _v9l4._base.OnMouseButton(self, _NzXY, _WdRJ, _Xsd9, _PTaZ, ...)
    if not _WdRJ and _NzXY == MOUSEBUTTON_LEFT and self.dragging then
        self.dragging = false
        if self.dragEndFn then self.dragEndFn(self) end
    end
    if not self.focus then return false end
    if self.draggable and _NzXY == MOUSEBUTTON_LEFT then
        if _WdRJ then
            self.dragging = true
            self.draggingPos.x = _Xsd9
            self.draggingPos.y = _PTaZ
        end
    end
end

function _v9l4:OnControl(_Vv7U, _NcIA, ...)
    if self.draggingTimer <= 0.3 then
        if _v9l4._base.OnControl(self, _Vv7U, _NcIA, ...) then
            self:StartUpdating()
            return true
        end
        self:StartUpdating()
    end
    if not self:IsEnabled() or not self.focus then return end
end

function _v9l4:Enable()
    _v9l4._base.Enable(self)
    self:SetTexture(self.atlas, self.focus and self.image_focus or self.image_normal)
    local _q3n5 = self.focus and self.color_focus or self.color_normal
    self.image:SetTint(_q3n5.r, _q3n5.g, _q3n5.b, _q3n5.a)
    if self.image_focus == self.image_normal then if self.focus then self.image:SetScale(1.2, 1.2, 1.2) else self.image:SetScale(0x1, 0x1, 0x1) end end
end

function _v9l4:Disable()
    _v9l4._base.Disable(self)
    self:SetTexture(self.atlas, self.image_disabled)
    local _8nL8 = self.color_disabled or self.color_normal
    self.image:SetTint(_8nL8.r, _8nL8.g, _8nL8.b, _8nL8.a)
end

function _v9l4:OnUpdate(_Hs7J)
    _Hs7J = _Hs7J or 0x0
    local _htWr = _ntRL()
    if self.followScreenScale and _htWr ~= self.screenScale then
        self:SetScale(_htWr)
        local _jkGo = self:GetPosition()
        _jkGo.x = _jkGo.x * _htWr / self.screenScale
        _jkGo.y = _jkGo.y * _htWr / self.screenScale
        self.o_pos = _jkGo
        self:SetPosition(_jkGo)
        self.screenScale = _htWr
    end
    if self.draggable and self.dragging then
        self.draggingTimer = self.draggingTimer + _Hs7J
        local _nGzW, y = _2fVP()
        local _eppm = _nGzW - self.draggingPos.x
        local _5hNL = y - self.draggingPos.y
        self.draggingPos.x = _nGzW; self.draggingPos.y = y
        local _0wI2 = self:GetPosition()
        _0wI2.x = _0wI2.x + _eppm; _0wI2.y = _0wI2.y + _5hNL
        self.o_pos = _0wI2
        self:SetPosition(_0wI2)
    end
    if not self.dragging then self.draggingTimer = 0x0 end
    self.moveLayerTimer = self.moveLayerTimer + _Hs7J
    if self.keepTop and self.moveLayerTimer > 0.5 then
        self.moveLayerTimer = 0x0
        self:MoveToFront()
    end
end

_Pi44.ImageButton = _v9l4
local _ZVLK = Class(_TeoQ,
    function(_QfCw)
        _TeoQ._ctor(_QfCw, "DYC_Window")
        _QfCw.width = 0x190
        _QfCw.height = 0x12c
        _QfCw.paddingX = 0x28
        _QfCw.paddingY = 0x2a
        _QfCw.screenScale = 0.9999
        _QfCw.currentLineY = 0x0
        _QfCw.currentLineX = 0x0
        _QfCw.lineHeight = 0x23
        _QfCw.lineSpacingX = 0xa
        _QfCw.lineSpacingY = 0x3
        _QfCw.fontSize = _QfCw.lineHeight * 0.9
        _QfCw.font = NUMBERFONT
        _QfCw.titleFontSize = 0x28
        _QfCw.titleFont = NUMBERFONT
        _QfCw.titleColor = _qSrc(0x1, 0.7, 0.4)
        _QfCw.draggable = true
        _QfCw.dragging = false
        _QfCw.draggingPos = { x = 0x0, y = 0x0 }
        _QfCw.draggableChildren = {}
        _QfCw.moveLayerTimer = 0x0
        _QfCw.keepTop = false
        _QfCw.currentPageIndex = 0x1
        _QfCw.pages = {}
        _QfCw.animTargetSize = nil
        _QfCw.bg = _QfCw:AddChild(_z0v6({ mode = "slice33", atlas = "images/dyc_panel_shadow.xml", texname = "dyc_panel_shadow", texScale = 1.0, }))
        _QfCw.bg:SetSize(_QfCw.width, _QfCw.height)
        _QfCw.bg:SetTint(0x1, 0x1, 0x1, 0x1)
        _QfCw:SetCenterAlignment()
        _QfCw:AddDraggableChild(_QfCw.bg, true)
        _QfCw.root = _QfCw.bg:AddChild(_TeoQ("root"))
        _QfCw.rootTL = _QfCw.root:AddChild(_TeoQ("rootTL"))
        _QfCw.rootT = _QfCw.root:AddChild(_TeoQ("rootT"))
        _QfCw.rootTR = _QfCw.root:AddChild(_TeoQ("rootTR"))
        _QfCw.rootL = _QfCw.root:AddChild(_TeoQ("rootL"))
        _QfCw.rootM = _QfCw.root:AddChild(_TeoQ("rootM"))
        _QfCw.rootR = _QfCw.root:AddChild(_TeoQ("rootR"))
        _QfCw.rootB = _QfCw.root:AddChild(_TeoQ("rootB"))
        _QfCw.rootBL = _QfCw.root:AddChild(_TeoQ("rootBL"))
        _QfCw.rootBR = _QfCw.root:AddChild(_TeoQ("rootBR"))
        _QfCw:SetSize()
        _QfCw:SetOffset(0x0, 0x0, 0x0)
        _QfCw:StartUpdating()
    end)
function _ZVLK:SetBottomAlignment()
    self.bg:SetVAnchor(ANCHOR_BOTTOM)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
end

function _ZVLK:SetBottomLeftAlignment()
    self.bg:SetVAnchor(ANCHOR_BOTTOM)
    self.bg:SetHAnchor(ANCHOR_LEFT)
end

function _ZVLK:SetTopLeftAlignment()
    self.bg:SetVAnchor(ANCHOR_TOP)
    self.bg:SetHAnchor(ANCHOR_LEFT)
end

function _ZVLK:SetCenterAlignment()
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
end

function _ZVLK:SetOffset(...) self.bg:SetPosition(...) end

function _ZVLK:GetOffset() return self.bg:GetPosition() end

function _ZVLK:SetSize(_WARC, _JQKC)
    _WARC = _WARC or self.width; _JQKC = _JQKC or self.height
    self.width = _WARC; self.height = _JQKC
    self.bg:SetSize(_WARC, _JQKC)
    self.rootTL:SetPosition(-_WARC / 0x2, _JQKC / 0x2, 0x0)
    self.rootT:SetPosition(0x0, _JQKC / 0x2, 0x0)
    self.rootTR:SetPosition(_WARC / 0x2, _JQKC / 0x2, 0x0)
    self.rootL:SetPosition(-_WARC / 0x2, 0x0, 0x0)
    self.rootM:SetPosition(0x0, 0x0, 0x0)
    self.rootR:SetPosition(_WARC / 0x2, 0x0, 0x0)
    self.rootBL:SetPosition(-_WARC / 0x2, -_JQKC / 0x2, 0x0)
    self.rootB:SetPosition(0x0, -_JQKC / 0x2, 0x0)
    self.rootBR:SetPosition(_WARC / 0x2, -_JQKC / 0x2, 0x0)
end

function _ZVLK:GetSize() return self.width, self.height end

function _ZVLK:SetTitle(_GunT, _EB0T, _7ydz, _OwTV)
    if not self.title then self.title = self.rootT:AddChild(_AJr3(NUMBERFONT, 0xa)) end
    _GunT = _GunT or self.title:GetString(); _EB0T = _EB0T or self.titleFont; _7ydz = _7ydz or self.titleFontSize; _OwTV = _OwTV or self.titleColor
    self.titleFont = _EB0T; self.titleFontSize = _7ydz; self.titleColor = _OwTV
    self.title:SetString(_GunT)
    self.title:SetFont(_EB0T)
    self.title:SetSize(_7ydz)
    self.title:SetPosition(0x0, -_7ydz / 0x2 * 1.3 - self.paddingY, 0x0)
    self.title:SetColor(_OwTV.r or _OwTV[0x1] or 0x1, _OwTV.g or _OwTV[0x2] or 0x1, _OwTV.b or _OwTV[0x3] or 0x1, _OwTV.a or _OwTV[0x4] or 0x1)
end

function _ZVLK:GetPage(_U4Bx)
    _U4Bx = _U4Bx or self.currentPageIndex
    _U4Bx = math.max(0x1, math.floor(_U4Bx))
    while self.pages[_U4Bx] == nil do table.insert(self.pages, { root = self.rootTL:AddChild(_TeoQ("rootPage" .. _U4Bx)), contents = {}, }) end
    return self.pages[_U4Bx]
end

function _ZVLK:SetCurrentPage(_J5Ii)
    _J5Ii = math.max(0x1, math.floor(_J5Ii))
    self.currentPageIndex = _J5Ii
    self.currentLineY = 0x0
    self.currentLineX = 0x0
    return self:GetPage()
end

function _ZVLK:ShowPage(_ecaO)
    _ecaO = _ecaO or self.currentPageIndex
    _ecaO = math.max(0x1, math.min(math.floor(_ecaO), #self.pages))
    self:SetCurrentPage(_ecaO)
    for _IWNp = 0x1, #self.pages do self:ToggleContents(_IWNp, _IWNp == _ecaO) end
    if self.pageChangeFn then self.pageChangeFn(self, _ecaO) end
end

function _ZVLK:ShowNextPage()
    local _GleG = self.currentPageIndex + 0x1
    if _GleG > #self.pages then _GleG = 0x1 end
    self:ShowPage(_GleG)
end

function _ZVLK:ShowPreviousPage()
    local _jYxy = self.currentPageIndex - 0x1
    if _jYxy < 0x1 then _jYxy = #self.pages end
    self:ShowPage(_jYxy)
end

function _ZVLK:ClearPages()
    if #self.pages <= 0x0 then return end
    for _42Mr = 0x1, #self.pages do self:ClearContents(_42Mr) end
end

function _ZVLK:AddContent(_bcSz, _Q5RP)
    local _on3K = self:GetPage()
    local _WeOC = _on3K.root:AddChild(_bcSz)
    if not _Q5RP then
        if _WeOC.GetRegionSize then
            _Q5RP = _WeOC:GetRegionSize()
        elseif _WeOC.GetWidth then
            _Q5RP = _WeOC:GetWidth()
        elseif _WeOC.GetSize then
            _Q5RP = _WeOC:GetSize()
        elseif _WeOC.width then
            _Q5RP =
                _WeOC.width
        end
    end
    _Q5RP = _Q5RP or 0x64
    _WeOC:SetPosition(self.paddingX + self.currentLineX + _Q5RP / 0x2, -self.paddingY - self.currentLineY - self.lineHeight * 0.5, 0x0)
    self.currentLineX = self.currentLineX + _Q5RP + self.lineSpacingX
    _O1nX(_on3K.contents, _WeOC)
    return _WeOC
end

function _ZVLK:ToggleContents(_Amll, _VX2C)
    local _rnL6 = self:GetPage(_Amll)
    if _VX2C then _rnL6.root:Show() else _rnL6.root:Hide() end
end

function _ZVLK:ClearContents(_GcCQ)
    _GcCQ = _GcCQ or self.currentPageIndex
    for _sqgc, _tK7M in pairs(self:GetPage(_GcCQ).contents) do _tK7M:Kill() end
    self:GetPage(_GcCQ).contents = {}
    self.currentLineY = 0x0
    self.currentLineX = 0x0
end

function _ZVLK:NewLine(_e8at)
    self.currentLineY = self.currentLineY + (_e8at or 0x1) * self.lineHeight + self.lineSpacingY
    self.currentLineX = 0x0
end

function _ZVLK:AddDraggableChild(_sETe, _j58S)
    _O1nX(self.draggableChildren, _sETe)
    if _j58S then for _RBGo, _jpiD in pairs(_sETe.children) do self:AddDraggableChild(_jpiD, true) end end
end

function _ZVLK:OnRawKey(_tVil, _UmsF, ...)
    local _8MiZ = _ZVLK._base.OnRawKey(self, _tVil, _UmsF, ...)
    if not self.focus then return false end
    return _8MiZ
end

function _ZVLK:OnControl(_oIgX, _XJkW, ...)
    local _DGWK = _ZVLK._base.OnControl(self, _oIgX, _XJkW, ...)
    if not self.focus then return false end
    return _DGWK
end

function _ZVLK:OnMouseButton(_eU90, _U22e, _CEss, _ZYJf, ...)
    local _mogH = _ZVLK._base.OnMouseButton(self, _eU90, _U22e, _CEss, _ZYJf, ...)
    if not _U22e and _eU90 == MOUSEBUTTON_LEFT then self.dragging = false end
    if not self.focus then return false end
    if self.draggable and _eU90 == MOUSEBUTTON_LEFT then
        if _U22e then
            local _XiEi = self:GetDeepestFocus()
            if _XiEi and _0Bfx(self.draggableChildren, _XiEi) then
                self.dragging = true
                self.draggingPos.x = _CEss
                self.draggingPos.y = _ZYJf
            end
        end
    end
    return _mogH
end

function _ZVLK:Toggle(_vTAK, _fv9W)
    _vTAK = _vTAK ~= nil and _vTAK or not self.shown
    if _vTAK then self:Show() else self:Hide() end
    if self.toggleFn then self.toggleFn(self, _vTAK) end
    if not _vTAK and _fv9W and self.okFn then self.okFn(self) end
    if not _vTAK and not _fv9W and self.cancelFn then self.cancelFn(self) end
end

function _ZVLK:AnimateSize(_9Iha, _nBUf, _UexT)
    if _9Iha and _nBUf then
        self.animTargetSize = { w = _9Iha, h = _nBUf }
        self.animSpeed = _UexT or 0x5
    end
end

function _ZVLK:OnUpdate(_qX78)
    _qX78 = _qX78 or 0x0
    if self.animTargetSize and _qX78 > 0x0 then
        local _afKo, h = self:GetSize()
        if math.abs(_afKo - self.animTargetSize.w) < 0x1 then
            self:SetSize(self.animTargetSize.w, self.animTargetSize.h)
            self.animTargetSize = nil
        else
            self:SetSize(_U7Zg(_afKo, self.animTargetSize.w, self.animSpeed * _qX78), _U7Zg(h, self.animTargetSize.h, self.animSpeed * _qX78))
        end
    end
    local _AoW6 = _ntRL()
    if _AoW6 ~= self.screenScale then
        self.bg:SetScale(_AoW6)
        local _p0Fb = self:GetOffset()
        _p0Fb.x = _p0Fb.x * _AoW6 / self.screenScale
        _p0Fb.y = _p0Fb.y * _AoW6 / self.screenScale
        self:SetOffset(_p0Fb)
        self.screenScale = _AoW6
    end
    if self.draggable and self.dragging then
        local _Bs9g, y = _2fVP()
        local _EFtq = _Bs9g - self.draggingPos.x
        local _RI2U = y - self.draggingPos.y
        self.draggingPos.x = _Bs9g; self.draggingPos.y = y
        local _DbXT = self:GetOffset()
        _DbXT.x = _DbXT.x + _EFtq; _DbXT.y = _DbXT.y + _RI2U
        self:SetOffset(_DbXT)
    end
    self.moveLayerTimer = self.moveLayerTimer + _qX78
    if self.keepTop and self.moveLayerTimer > 0.5 then
        self.moveLayerTimer = 0x0
        self:MoveToFront()
    end
end

_Pi44.Window = _ZVLK
local _UU2H = Class(_ZVLK,
    function(_VBJ9, _UVwU)
        _ZVLK._ctor(_VBJ9)
        _VBJ9:SetTopLeftAlignment()
        _VBJ9.bg:SetClickable(false)
        _VBJ9.bg:SetTint(0x1, 0x1, 0x1, 0x0)
        _VBJ9.paddingX = 0x20
        _VBJ9.paddingY = 0x1c
        _VBJ9.lineSpacingX = 0x0
        _VBJ9.lineHeight = 0x20
        _VBJ9.fontSize = 0x20
        _VBJ9.font = DEFAULTFONT
        _VBJ9.bannerColor = _UVwU.color or _qSrc()
        _VBJ9.bannerText = _VBJ9:AddContent(_AJr3({ font = _VBJ9.font, fontSize = _VBJ9.fontSize, alignH = ANCHOR_LEFT, text = _UVwU.text or "???", color = _VBJ9.bannerColor, }))
        local _VkUx, windowH = _VBJ9.currentLineX + _VBJ9.paddingX * 0x2, _VBJ9.lineHeight + _VBJ9.paddingY * 0x2
        _VBJ9:SetSize(_VkUx, windowH)
        _VBJ9.windowW = _VkUx
        _VBJ9.bannerText:AnimateIn()
        _VBJ9:SetOffset(0x2bc, -windowH / 0x2)
        _VBJ9.tags = {}
        _VBJ9.shouldFadeIn = true
        _VBJ9.bannerOpacity = 0x0
        _VBJ9.bannerTimer = _UVwU.duration ~= nil and math.max(_UVwU.duration, 0x1) or 0x5
        _VBJ9.bannerIndex = 0x1
        _VBJ9.updateFn = _UVwU.updateFn
        _VBJ9.startFn = _UVwU.startFn
        if _VBJ9.startFn then _VBJ9.startFn(_VBJ9) end
    end)
function _UU2H:HasTag(_5TNB) return self.tags[string.lower(_5TNB)] == true end

function _UU2H:AddTag(_frpU) self.tags[string.lower(_frpU)] = true end

function _UU2H:RemoveTag(_EQrB) self.tags[string.lower(_EQrB)] = nil end

function _UU2H:SetText(_m0Vy)
    local _BdmF = self.bannerText
    _BdmF.textString = _m0Vy
    if not _BdmF.animIndex then
        _BdmF:SetText(_m0Vy)
        local _78qa = self:GetPage()
        local _S9vT = _78qa.contents[0x1]
        local _iIFG = _S9vT and _S9vT.GetWidth and _S9vT:GetWidth() or 0x0
        if _iIFG > 0x0 then
            local _YFYU, windowH = _iIFG + self.paddingX * 0x2, self.lineHeight + self.paddingY * 0x2
            self:SetSize(_YFYU, windowH)
        end
    end
end

function _UU2H:SetUpdateFn(_xvNC) self.updateFn = _xvNC end

function _UU2H:FadeOut() self.shouldFadeIn = false end

function _UU2H:IsFadingOut() return not self.shouldFadeIn end

function _UU2H:OnUpdate(_Ehce)
    _UU2H._base.OnUpdate(self, _Ehce)
    _Ehce = _Ehce or 0x0
    if _Ehce > 0x0 then
        if not IsPaused() then self.bannerTimer = self.bannerTimer - _Ehce end
        if self.shouldFadeIn then
            self.bannerOpacity = math.min(0x1, self.bannerOpacity + _Ehce * 0x3)
        else
            self.bannerOpacity = self.bannerOpacity - _Ehce
            if self.bannerOpacity <= 0x0 then
                if self.bannerHolder then self.bannerHolder:RemoveBanner(self) end
                self:Kill()
            end
        end
        if self.bannerOpacity > 0x0 then
            self.bg:SetTint(0x1, 0x1, 0x1, self.bannerOpacity)
            local _jiX4 = self.bannerColor
            self.bannerText:SetColor(_jiX4.r or _jiX4[0x1] or 0x1, _jiX4.g or _jiX4[0x2] or 0x1, _jiX4.b or _jiX4[0x3] or 0x1, self.bannerOpacity)
            local _97sR, h = self:GetSize()
            local _8oz7 = self:GetOffset()
            local _DNTg, y = _8oz7.x, _8oz7.y
            local _5FL5 = self.bannerHolder and self.bannerHolder.bannerSpacing or 0x0
            local _lVMR = self.bannerIndex
            local _bbbg, tY = _97sR / 0x2 * self.screenScale, (h / 0x2 - h * _lVMR - _5FL5 * (_lVMR - 0x1)) * self.screenScale
            local _ATaZ = 0.15
            self:SetOffset(_U7Zg(_DNTg, _bbbg, _ATaZ), _U7Zg(y, tY, _ATaZ))
            if self.updateFn then
                self.updateFnTimer = (self.updateFnTimer or 0x0) + _Ehce
                if self.updateFnTimer >= 0.5 then
                    self.updateFn(self, self.updateFnTimer)
                    self.updateFnTimer = self.updateFnTimer - 0.5
                end
            end
        end
    end
end

_Pi44.Banner = _UU2H
local _5l0J = Class(_xgL7,
    function(_mATk, _pXHK)
        _pXHK = _pXHK or {}
        _xgL7._ctor(_mATk, _pXHK)
        _mATk.banners = {}
        _mATk.bannerInfos = {}
        _mATk.bannerInterval = _pXHK.interval or 0.3
        _mATk.bannerShowTimer = 0x3e7
        _mATk.bannerSound = _pXHK.sound or "dontstarve/HUD/XP_bar_fill_unlock"
        _mATk.bannerSpacing = -0xf
        _mATk.maxBannerNum = _pXHK.max or 0xa
        _mATk:StartUpdating()
    end)
function _5l0J:PushMessage(_f1qU, _MHG8, _Gg2y, _Ff38, _6mrp) table.insert(self.bannerInfos, { text = _f1qU, duration = _MHG8, color = _Gg2y, playSound = _Ff38, startFn = _6mrp }) end

function _5l0J:ShowMessage(_nJbs, _Wj4F, _WAPy, _ncLj, _UqE2)
    local _mbtY = self:AddChild(_UU2H({ text = _nJbs, duration = _Wj4F, color = _WAPy, startFn = _UqE2 }))
    self:AddBanner(_mbtY)
    local _sCeg = _U91l()
    if _ncLj and _sCeg and _sCeg.SoundEmitter and self.bannerSound then _sCeg.SoundEmitter:PlaySound(self.bannerSound) end
    return _mbtY
end

function _5l0J:AddBanner(_GVod)
    _GVod.bannerHolder = self
    local _FswG = self.banners
    table.insert(_FswG, 0x1, _GVod)
    for _Z87C = 0x1, #_FswG do _FswG[_Z87C].bannerIndex = _Z87C end
end

function _5l0J:RemoveBanner(_Nbmf)
    for _BEkD, _DUoP in pairs(self.banners) do
        if _DUoP == _Nbmf then
            table.remove(self.banners, _BEkD)
            break
        end
    end
    for _Sydl, _pn9u in pairs(self.banners) do _pn9u.bannerIndex = _Sydl end
end

function _5l0J:FadeOutBanners(_fX8b) for _mM25, _QftV in pairs(self.banners) do if not _fX8b or _QftV:HasTag(_fX8b) then _QftV:FadeOut() end end end

function _5l0J:OnUpdate(_tbpk)
    _tbpk = _tbpk or 0x0
    local _ZoxX = self.banners
    local _rKNW = self.bannerInfos
    if _tbpk > 0x0 and #_ZoxX > 0x0 then
        for _HIuh = 0x1, #_ZoxX do
            local _okqM = _ZoxX[_HIuh]
            if _HIuh > self.maxBannerNum then _okqM:FadeOut() elseif _okqM.bannerTimer <= 0x0 then _okqM:FadeOut() end
        end
    end
    if _tbpk > 0x0 and #_rKNW > 0x0 then
        self.bannerShowTimer = self.bannerShowTimer + _tbpk
        if self.bannerShowTimer >= self.bannerInterval then
            self.bannerShowTimer = 0x0
            local _9MwZ = _rKNW[0x1]
            table.remove(_rKNW, 0x1)
            if #_rKNW <= 0x0 then self.bannerShowTimer = 0x3e7 end
            self:ShowMessage(_9MwZ.text, _9MwZ.duration, _9MwZ.color, _9MwZ.playSound, _9MwZ.startFn)
        end
    end
end

_Pi44.BannerHolder = _5l0J
local _dl2Y = Class(_ZVLK,
    function(_MoXy, _ACwQ)
        _ZVLK._ctor(_MoXy)
        _MoXy.messageText = _MoXy.rootM:AddChild(_AJr3({ font = _MoXy.font, fontSize = _ACwQ.fontSize or _MoXy.fontSize, color = _qSrc(0.9, 0.9, 0.9, 0x1), }))
        _MoXy.strings = _ACwQ.strings
        _MoXy.callback = _ACwQ.callback
        local _j2wb = _MoXy.rootTR:AddChild(_v9l4({
            width = 0x28,
            height = 0x28,
            normal = "button_checkbox1.tex",
            focus = "button_checkbox1.tex",
            disabled = "button_checkbox1.tex",
            colornormal = _qSrc(
                0x1, 0x1, 0x1, 0x1),
            colorfocus = _qSrc(0x1, 0.2, 0.2, 0.7),
            colordisabled = _qSrc(0.4, 0.4, 0.4, 0x1),
            cb = function()
                if _MoXy.callback then _MoXy.callback(_MoXy, false) end
                _MoXy:Kill()
            end,
        }))
        _j2wb:SetPosition(-_MoXy.paddingX - _j2wb.width / 0x2, -_MoXy.paddingY - _j2wb.height / 0x2, 0x0)
        local _ZldE = _MoXy.rootB:AddChild(_v9l4({
            width = 0x64,
            height = 0x32,
            text = _MoXy.strings:GetString("ok"),
            cb = function()
                if _MoXy.callback then _MoXy.callback(_MoXy, true) end
                _MoXy:Kill()
            end,
        }))
        _ZldE:SetPosition(0x0, _MoXy.paddingY + _ZldE.height / 0x2, 0x0)
        if _ACwQ.message then _MoXy:SetMessage(_ACwQ.message) end
        if _ACwQ.title then _MoXy:SetTitle(_ACwQ.title, nil, (_ACwQ.fontSize or _MoXy.fontSize) * 1.3) end
    end)
function _dl2Y:SetMessage(_klDO) self.messageText:SetText(_klDO) end

function _dl2Y.ShowMessage(_rVQF, _YRWR, _PzhN, _vIlc, _Xpwe, _mO7w, _XpXX, _J1P1, _RoG0, _HrJT, _PObU)
    local _UTQq = _PzhN:AddChild(_dl2Y({ message = _rVQF, title = _YRWR, callback = _Xpwe, strings = _vIlc, fontSize = _mO7w }))
    if _PObU then _UTQq.messageText:AnimateIn() end
    if _XpXX and _J1P1 and _RoG0 and _HrJT then
        _UTQq:SetSize(_RoG0, _HrJT)
        _UTQq:AnimateSize(_XpXX, _J1P1, 0xa)
    elseif _XpXX and _J1P1 then
        _UTQq:SetSize(_XpXX, _J1P1)
    end
end

_Pi44.MessageBox = _dl2Y
local _aaR5 = Class(_TeoQ,
    function(_ZyBN, _XuSJ)
        _TeoQ._ctor(_ZyBN, "DYC_BuffTile")
        assert(_XuSJ.buffInfo, "Buff info required!")
        _ZyBN.bg = _ZyBN:AddChild(_CHD3(HUD_ATLAS, "inv_slot.tex"))
        _ZyBN.oriWidth, _ZyBN.oriHeight = _ZyBN.bg:GetSize()
        if _XuSJ.buffInfo.buff.atlas and _XuSJ.buffInfo.buff.image then
            _ZyBN.image = _ZyBN:AddChild(_CHD3(_XuSJ.buffInfo.buff.atlas, _XuSJ.buffInfo.buff.image))
            _ZyBN.image:SetClickable(false)
        end
        _ZyBN.frame = _ZyBN:AddChild(_CHD3("images/dyc_buffframe.xml", "dyc_buffframe.tex"))
        _ZyBN.frame:SetClickable(false)
        _ZyBN.cdAnim = _ZyBN:AddChild(_e8aF())
        _ZyBN.cdAnim:GetAnimState():SetBank("recharge_meter")
        _ZyBN.cdAnim:GetAnimState():SetBuild("dyc_recharge_meter")
        _ZyBN.cdAnim:GetAnimState():SetMultColour(0x0, 0x0, 0x0, 0x1)
        _ZyBN.cdAnim:Hide()
        _ZyBN.cdAnim:SetClickable(false)
        _ZyBN.stackText = _ZyBN:AddChild(_AouV(NUMBERFONT, _XuSJ.width and _XuSJ.width / _ZyBN.oriWidth * 0x26 or 0xf))
        _ZyBN.stackText:SetString(_XuSJ.buffInfo.buff.maxStack > 0x1 and _XuSJ.buffInfo.stack or "")
        _ZyBN.buffInfo = _XuSJ.buffInfo
        _ZyBN.cdCb = function(_39iX, _Tq5g, _cuEG) _ZyBN:SetCooldownPercent(_cuEG) end
        _ZyBN.stackCb = function(_PMzH, _MnLe) _ZyBN.stackText:SetString(_XuSJ.buffInfo.buff.maxStack > 0x1 and _MnLe or "") end
        _ZyBN.buffInfo:RegisterEvent("cooldownchange", _ZyBN.cdCb)
        _ZyBN.buffInfo:RegisterEvent("stackchange", _ZyBN.stackCb)
        if _ZyBN.buffInfo.percent then _ZyBN:SetCooldownPercent(_ZyBN.buffInfo.percent) end
        _ZyBN.buffInfo:RegisterEvent("dispose", function(_IGXI) _ZyBN:Kill() end)
        if _ZyBN.buffInfo.buff.type == "positive" then _ZyBN.frame:SetTint(0x0, 0x1, 0x0, 0.5) elseif _ZyBN.buffInfo.buff.type == "negative" then _ZyBN.frame:SetTint(0x1, 0x0, 0x0, 0.5) end
        if _XuSJ.width and _XuSJ.height then _ZyBN:SetSize(_XuSJ.width, _XuSJ.height) end
    end)
function _aaR5:SetCooldownPercent(_kUbs)
    _kUbs = _kUbs or 0x1
    _kUbs = math.max(0x0, math.min(_kUbs, 0x1))
    if not self.cdAnim.shown then self.cdAnim:Show() end
    self.cdAnim:GetAnimState():SetPercent("recharge", _kUbs)
    if _kUbs == 0x1 then if self.buffInfo.buff.constant then else self.cdAnim:GetAnimState():PlayAnimation("frame_pst") end end
end

function _aaR5:SetSize(_X3dn, _JaZQ)
    _X3dn = _X3dn or self.width or self.oriWidth; _JaZQ = _JaZQ or self.height or self.oriHeight
    self.width = _X3dn; self.height = _JaZQ
    self.bg:SetSize(self.width, self.height)
    self.frame:SetSize(self.width, self.height)
    self.stackText:SetRegionSize(self.width, self.height)
    self.stackText:SetHAlign(ANCHOR_RIGHT)
    self.stackText:SetVAlign(ANCHOR_BOTTOM)
    if self.image then self.image:SetSize(self.width, self.height) end
    self.cdAnim:SetScale(-self.width / self.oriWidth, self.height / self.oriHeight, 0x1)
end

function _aaR5:GetSize() return self.width or self.oriWidth, self.height or self.oriHeight end

function _aaR5:SetClickable(_GoaE)
    self.bg:SetClickable(_GoaE)
    self.frame:SetClickable(_GoaE)
    self.cdAnim:SetClickable(_GoaE)
    if self.image then self.image:SetClickable(_GoaE) end
end

function _aaR5:OnGainFocus() if self.gainFocusFn then self.gainFocusFn(self) end end

function _aaR5:OnLoseFocus() if self.loseFocusFn then self.loseFocusFn(self) end end

function _aaR5:Kill()
    if self.buffInfo.DeregisterEvent then
        self.buffInfo:DeregisterEvent("cooldownchange", self.cdCb)
        self.buffInfo:DeregisterEvent("stackchange", self.stackCb)
    end
    if self.killFn then self.killFn(self) end
    _aaR5._base.Kill(self)
end

_Pi44.BuffTile = _aaR5
local _XKoP = Class(_ZVLK,
    function(_Fkpm, _94aK)
        _ZVLK._ctor(_Fkpm)
        _Fkpm:SetBottomLeftAlignment()
        _Fkpm.bg:SetClickable(false)
        _Fkpm.rootTR:MoveToBack()
        _Fkpm.bg:MoveToBack()
        _Fkpm:SetSize(0x190, 0xfa)
        _94aK = _94aK or {}
        _Fkpm.fontSize = _94aK.fontSize or 0x19
        _Fkpm.opacity = _94aK.opacity or 0x1
        _Fkpm.nameFont = _94aK.nameFont
        _Fkpm.hintFont = _94aK.hintFont
    end)
function _XKoP:RefreshPage(_SNaw)
    if self.icon then
        self.icon:Kill()
        self.icon = nil
    end
    self:ClearPages()
    _SNaw = _SNaw or {}
    local _mJM9 = self.opacity
    self.bg:SetTint(0x1, 0x1, 0x1, _mJM9)
    local _pNti = _qSrc(0.76, 0.76, 0.76):A(_mJM9)
    local _rq7P = _qSrc():A(_mJM9)
    local _XTay = _qSrc(0xff / 0xff, 0x0 / 0xff, 0x0 / 0xff):A(_mJM9)
    local _nhr8 = _qSrc(0xaa / 0xff, 0xee / 0xff, 0xff / 0xff):A(_mJM9)
    local _shca = _qSrc(0xff / 0xff, 0xf5 / 0xff, 0xbb / 0xff):A(_mJM9)
    self.lineHeight = self.fontSize
    local _EYt3 = math.min(self.lineHeight / 0x19 * 0x2ee, 0x4b0)
    self.paddingX = 0x23
    self.paddingY = 0x23
    self.lineSpacingX = 0x0
    self.lineSpacingY = not _LEg5() and -self.fontSize / 0x5 or -self.fontSize / 3.3
    self.font = DEFAULTFONT
    local _2CF5 = not _XraE() and not _LEg5() and _Pi44.language and _Pi44.language == "en" and self.nameFont or self.font
    local _aCD6 = not _XraE() and not _LEg5() and _Pi44.language and _Pi44.language == "en" and self.hintFont or TALKINGFONT
    local _Lbpj = 1.3
    local _qfyp = 1.3
    local _nKzq, calcHeight = 0x0, 0x0
    local _3MxK = false
    local _wbee = function(_HMEA) self:NewLine(_HMEA) end
    if _SNaw.icon and _SNaw.icon.atlas and _SNaw.icon.image then
        local _uzqY = _CHD3(_SNaw.icon.atlas, _SNaw.icon.image)
        local _VbOu = self.lineHeight * 0x2
        _uzqY:SetSize(_VbOu, _VbOu)
        _uzqY:SetTint(_rq7P:Get())
        _uzqY:SetClickable(false)
        _uzqY:SetPosition(-self.paddingX + 0x5 - _VbOu / 0x2, -self.paddingY + 0x5 - _VbOu / 0x2, 0x0)
        self.rootTR:AddChild(_uzqY)
        self.icon = _uzqY
    end
    if _SNaw.action and #_SNaw.action > 0x0 then
        local _peWm = self:AddContent(_AJr3({ font = _aCD6, fontSize = self.fontSize * _Lbpj, text = _SNaw.action or "???", color = _SNaw.actionColor or _shca, }))
        self.currentLineX = self.currentLineX + self.fontSize / 2.5
    end
    if _SNaw.prefix and #_SNaw.prefix > 0x0 then local _2hRm = self:AddContent(_AJr3({ font = _2CF5, fontSize = self.fontSize * _Lbpj, text = _SNaw.prefix or "???", color = _SNaw.prefixColor or _rq7P, })) end
    if _SNaw.name and #_SNaw.name > 0x0 then
        local _TXW4 = self:AddContent(_AJr3({
            font = _2CF5,
            fontSize = self.fontSize * _qfyp,
            text = _SNaw.name or "???",
            color = _SNaw.nameColor and
                _SNaw.nameColor:A(_mJM9) or _rq7P,
        }))
    end
    if _SNaw.suffix and #_SNaw.suffix > 0x0 then local _zc9p = self:AddContent(_AJr3({ font = _2CF5, fontSize = self.fontSize * _Lbpj, text = _SNaw.suffix or "???", color = _SNaw.suffixColor or _rq7P, })) end
    local _f5J8 = self.icon and self.icon:GetSize() or 0x0
    _nKzq = math.max(_nKzq, self.currentLineX + _f5J8)
    calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    _wbee(0.7)
    calcHeight = calcHeight + self.lineHeight * 0.7 + self.lineSpacingY
    if _SNaw.action2 and #_SNaw.action2 > 0x0 then
        _3MxK = true
        _wbee(0x1)
        local _yyz9 = self:AddContent(_AJr3({ font = _aCD6, fontSize = self.fontSize, text = _SNaw.action2 or "???", color = _SNaw.action2Color or _shca, }))
        _nKzq = math.max(_nKzq, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    end
    if _SNaw.buffSource and #_SNaw.buffSource > 0x0 then
        _3MxK = true
        _wbee(0x1)
        local _GYZ0 = self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _SNaw.buffSource or "???", color = _SNaw.action2Color or _pNti, }))
        _nKzq = math.max(_nKzq, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    end
    if _SNaw.rarity and #_SNaw.rarity > 0x0 then
        _3MxK = true
        _wbee(0x1)
        local _ZJDm = self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _SNaw.rarity or "", color = _rq7P }))
        _nKzq = math.max(_nKzq, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
        if _SNaw.quality then
            local _5eaZ = self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _SNaw.quality or "", color = _rq7P }))
            _nKzq = math.max(_nKzq, self.currentLineX)
        end
    end
    if _SNaw.lines then
        for _0lRo, _t1vU in pairs(_SNaw.lines) do
            _3MxK = true
            _wbee(0x1)
            if _t1vU.richtext then
                for _ZKar, _AaT0 in pairs(_t1vU.richtext) do
                    if _AaT0.text then
                        self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _AaT0.text or "", color = _AaT0.color and _AaT0.color:A(_mJM9) or _pNti }))
                    elseif _AaT0.icon then
                        local _BQ60 = _AaT0.color or _rq7P
                        local _OWPd = _CHD3(_AaT0.icon.atlas, _AaT0.icon.image)
                        local _r1xj = math.max(0x1, self.lineHeight - self.fontSize / 0x8)
                        _OWPd:SetSize(_r1xj, _r1xj)
                        _OWPd:SetTint(_BQ60:Get())
                        _OWPd:SetClickable(false)
                        self:AddContent(_OWPd)
                        self.currentLineX = self.currentLineX + self.fontSize / 0xa
                    end
                    _nKzq = math.max(_nKzq, self.currentLineX)
                end
            else
                local _tK8v = self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _t1vU.text or "", color = _t1vU.color and _t1vU.color:A(_mJM9) or _pNti }))
                _nKzq = math.max(_nKzq, self.currentLineX)
            end
            calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
        end
    end
    if _SNaw.buffInfos and next(_SNaw.buffInfos) then
        _3MxK = true
        _wbee(0x1)
        for _bkz4, _nuPG in pairs(_SNaw.buffInfos) do
            if not _nuPG.buff.isHidden then
                local _dPj6 = self.lineHeight + self.lineSpacingY
                local _YIAZ = self:AddContent(_aaR5({ buffInfo = _nuPG, width = _dPj6, height = _dPj6, }))
                _YIAZ:SetClickable(false)
                self.currentLineX = self.currentLineX + self.fontSize / 0xa
            end
        end
        _nKzq = math.max(_nKzq, self.currentLineX)
        calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
    end
    if _SNaw.encLines then
        for _0NUp, _ikkd in pairs(_SNaw.encLines) do
            if not _ikkd.isHidden and _ikkd.text and #_ikkd.text > 0x0 then
                _3MxK = true
                _wbee(0x1)
                if _ikkd.icon then
                    local _FN7C = _CHD3(_ikkd.icon.atlas, _ikkd.icon.image)
                    local _ElAp = math.max(0x1, self.lineHeight - self.fontSize / 3.33)
                    _FN7C:SetSize(_ElAp, _ElAp)
                    _FN7C:SetTint(_rq7P:Get())
                    _FN7C:SetClickable(false)
                    self:AddContent(_FN7C)
                end
                local _LPpp = self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _ikkd.text, color = _ikkd.color and _ikkd.color:A(_mJM9) or _XTay }))
                _nKzq = math.max(_nKzq, self.currentLineX)
                calcHeight = calcHeight + self.lineHeight + self.lineSpacingY
            end
        end
    end
    local _LYMh = nil
    if _SNaw.des and #_SNaw.des > 0x0 then
        _3MxK = true
        _LYMh = self:AddContent(_AJr3({ font = self.font, fontSize = self.fontSize, text = _SNaw.des or "", color = _SNaw.desColor and _SNaw.desColor:A(_mJM9) or _nhr8 }))
        local _bzW9 = _LYMh:GetWidth()
        local _NTpT = 0xe6
        if _bzW9 > _nKzq then if _bzW9 >= _NTpT and _nKzq < _NTpT then _nKzq = _NTpT elseif _bzW9 < _NTpT and _nKzq < _NTpT then _nKzq = _bzW9 end end
    end
    _nKzq = math.min(_nKzq, _EYt3)
    local _AHtQ = _nKzq + self.paddingX * 0x2
    local _0Tm1 = calcHeight + self.paddingY * 0x2
    if _LYMh then
        _LYMh:Kill()
        _LYMh = self:AddContent(_yjum({
            font = self.font,
            fontSize = self.fontSize,
            text = _SNaw.des or "",
            color = _SNaw.desColor and _SNaw.desColor:A(_mJM9) or _nhr8,
            maxWidth = _nKzq,
            spacing = self
                .lineSpacingY
        }))
        _LYMh:SetPosition(_AHtQ / 0x2, -calcHeight - self.paddingY - _LYMh:GetHeight() / 0x2, 0x0)
        _0Tm1 = _0Tm1 + _LYMh:GetHeight() - self.fontSize * 0.25
    end
    self:SetSize(_AHtQ, _0Tm1)
end

function _XKoP:SetObjectDetail(_avyJ) self:RefreshPage(_avyJ) end

function _XKoP:OnUpdate(_xmc2)
    _XKoP._base.OnUpdate(self, _xmc2)
    _xmc2 = _xmc2 or 0x0
end

_Pi44.ObjectDetailWindow = _XKoP
return _Pi44
