local _iutA = DYCInfoPanel
local _v5LV = _iutA.DYCModRequire
local _F9QU = _v5LV("dyc_descutil")
local _U9cY = _iutA.RGBAColor
local _k17s = _iutA.lib.StrSpl
local _9HHT = _iutA.lib.StringStartWith
local _HZsm = {
    prefab = true,
    tags = true,
    recipe = true,
    boathealth = true,
    health = true,
    combat = true,
    weapon = true,
    armor = true,
    tool = true,
    finiteuses = true,
    fueled = true,
    perishable = true,
    edible = true,
    inventoryitem = true,
    custom = true,
}
local function _jFVK() return TheSim:GetGameID() == "DST" end
local function _cWQY(_Lnwe) return _iutA.localization:HasString(_Lnwe) end
local function _5itq(_dvMw, _i5s3) return _iutA.localization:GetString(_dvMw, _i5s3) end
local function _XHUL(_WK3F)
    if not _WK3F or not _WK3F.GetDescriptionString then return end
    local _MyLa, action2 = nil, nil
    local _ofR7 = _WK3F:GetDescriptionString()
    if _ofR7 and type(_ofR7) == "string" and #_ofR7 > 0x0 then
        local _snm6 = _k17s(_ofR7, "\n")
        if _snm6 then
            for _E3x1, _nqPl in pairs(_snm6) do
                if _nqPl and type(_nqPl) == "string" and #_nqPl > 0x0 then
                    if _9HHT(_nqPl, STRINGS.LMB) then _MyLa = _nqPl end
                    if _9HHT(_nqPl, STRINGS.RMB) then action2 = _nqPl end
                end
            end
        end
    end
    if _MyLa and type(_MyLa) == "string" and #_MyLa > 0x0 then
        local _n6en = 0x1
        for _m1XE = 0x1, #_MyLa do
            local _cfbb = string.sub(_MyLa, _m1XE, _m1XE)
            if _cfbb == ":" or _cfbb == " " then _n6en = _m1XE + 0x1 end
        end
        if _n6en <= #_MyLa then _MyLa = string.sub(_MyLa, _n6en) else _MyLa = nil end
    end
    return _MyLa, action2
end
local function _u1BG(_Gsc8) return _Gsc8 and _Gsc8.inst and _Gsc8.inst:IsValid() end
local function _NOe4(_Twy3, _k3yG)
    local _4RrQ = _iutA.objectDetailWindow
    if _4RrQ then
        local _uyYw = _u1BG(_k3yG) and _k3yG:GetWorldPosition() or TheInput:ControllerAttached() and _Twy3 and Vector3(TheSim:GetScreenPos(_Twy3.Transform:GetWorldPosition())) or
            TheInput:GetScreenPosition()
        local _rn5n, sh = TheSim:GetScreenSize()
        local _lkMN, h = _4RrQ:GetSize()
        local _B0v4, h2 = 0x0, 0x0
        if _u1BG(_k3yG) and _k3yG.bg then _B0v4, h2 = _k3yG.bg:GetSize() elseif _u1BG(_k3yG) then _B0v4, h2 = 0x64, 0x64 end
        local _oQHI = _iutA.cfgs.infopanelpos
        if _oQHI and _oQHI == "auto" then _oQHI = TheInput:ControllerAttached() and "bl" or "follow" end
        if _oQHI and _oQHI == "tl" then
            _uyYw = Vector3(0x0, sh, 0x0)
            _B0v4, h2 = 0x0, 0x0
        elseif _oQHI and _oQHI == "bl" then
            _uyYw = Vector3(0x0, 0x0, 0x0)
            _B0v4, h2 = 0x0, 0x0
        elseif _oQHI and _oQHI == "tr" then
            _uyYw = Vector3(_rn5n, sh, 0x0)
            _B0v4, h2 = 0x0, 0x0
        elseif _oQHI and _oQHI == "br" then
            _uyYw = Vector3(_rn5n, 0x0, 0x0)
            _B0v4, h2 = 0x0, 0x0
        end
        local _2jE0 = _4RrQ.screenScale
        local _D4uj, ph = (_lkMN / 0x2 + _B0v4 / 0x2 + 0x1e) * _2jE0, (h / 0x2 + h2 / 0x2 + 0x14) * _2jE0
        local _QFgM = (sh - _uyYw.y < ph * 0x2 and _uyYw.y < ph * 0x2 and (_rn5n - _uyYw.x < _D4uj * 0x2 and -_D4uj or _D4uj)) or (_rn5n - _uyYw.x < _D4uj and -_D4uj) or (_uyYw.x < _D4uj and _D4uj) or
            0x0
        local _JVmi = (sh - _uyYw.y < ph * 0x2 and _uyYw.y < ph * 0x2 and 0x0) or (sh - _uyYw.y < ph * 0x2 and -ph) or (_uyYw.y < ph and ph) or (_QFgM ~= 0x0 and 0x0) or ph
        _4RrQ:SetOffset(_uyYw + Vector3(_QFgM, _JVmi, 0x0))
    end
end
local function _EPRA(_T0TI) return _T0TI.buff:GetDisplayName(_T0TI) end
local function _TUBt(_HDso) return _HDso.buff:GetSuffix(_HDso) .. "      " end
local function _jSXk(_483x) return _483x.buff:GetSourceString(_483x) end
local function _2VGQ(_e9dQ)
    return _e9dQ.buff.type == "positive" and _iutA.RGBAColor(0x0, 0x1, 0x0, 0x1) or _e9dQ.buff.type == "negative" and _iutA.RGBAColor(0x1, 0x0, 0x0, 0x1) or
        _iutA.RGBAColor(0x1, 0x1, 0x1, 0x1)
end
local function _OnAI(_9hZb) return _9hZb.buff:GetDescription(_9hZb) end
local _A5gS = nil
_A5gS = function(_CbLn, _n2D0, _7bnG, _WuI7)
    local _ucET = _iutA.objectDetailWindow
    if _ucET then
        _ucET.focusedObject = _CbLn
        if not _CbLn then
            if not _n2D0 or _n2D0 == _ucET.hoveredWidget then
                if _ucET.shown then _ucET:Toggle(false) end
                _ucET.hoveredWidget = nil
            end
            return
        end
        if _ucET.hoveredWidget ~= _n2D0 and _n2D0 and _CbLn then
            local _QVOu = rawget(_G, "DYCDataSyncer")
            if _QVOu and _QVOu.SendSyncDataRPC then
                _QVOu.SendSyncDataRPC(_CbLn)
                _CbLn.dycOnSyncFinish = function()
                    if _ucET.hoveredWidget == _n2D0 and not _CbLn.dycTask_SyncFinish then
                        _CbLn.dycTask_SyncFinish = _CbLn:DoTaskInTime(0x0,
                            function()
                                _A5gS(_CbLn, _n2D0, _7bnG, _WuI7)
                                _CbLn.dycTask_SyncFinish = nil
                            end)
                    end
                end
            end
        end
        _ucET.hoveredWidget = _n2D0
        local _dToc = _CbLn.components.stackable
        local _3WU8 = _jFVK() and _CbLn.replica.inventoryitem or _CbLn.components.inventoryitem
        local _1k41 = _CbLn.components.equippable
        local _ksCm = _CbLn.components.unwrappable
        local _GnSN = _3WU8 and _3WU8.GetEnchanter and _3WU8:GetEnchanter()
        local _93WP = _iutA.cfgs.rarity and (_1k41 ~= nil or _ksCm ~= nil)
        local _J1Qx = nil
        if _GnSN and _GnSN.GetIcon then
            local _AxbR, image = _GnSN:GetIcon()
            if _AxbR and image then _J1Qx = { atlas = _AxbR, image = image } end
        end
        if not _J1Qx and _3WU8 and _3WU8.GetAtlas and _3WU8.GetImage then
            local _wrjE, image = _3WU8:GetAtlas(), _3WU8:GetImage()
            _J1Qx = { atlas = _wrjE, image = image }
        end
        local _NB7l = _CbLn:GetAdjective()
        _NB7l = _NB7l and type(_NB7l) == "string" and string.gsub(_NB7l, "\n", "")
        local _rpPL = _CbLn:GetDisplayName()
        _rpPL = _rpPL and type(_rpPL) == "string" and string.gsub(_rpPL, "\n", "")
        if _CbLn.prefab and _rpPL and string.find(string.lower(_rpPL), "missing name") then _rpPL = _5itq("world_" .. _CbLn.prefab, _rpPL) end
        local _zQXb = _dToc and _dToc.stacksize > 0x1 and "x" .. tostring(_dToc.stacksize) or nil
        local _KsnD, action2 = _XHUL(_n2D0)
        _KsnD = _KsnD or _7bnG
        action2 = action2 or _WuI7
        _KsnD = _KsnD and type(_KsnD) == "string" and string.gsub(_KsnD, "\n", "")
        action2 = action2 and type(action2) == "string" and string.gsub(action2, "\n", "")
        local _cbuj = _CbLn.GetRarity and _CbLn:GetRarity() or 0x0
        local _7JDc = _cbuj > 0x0 and _CbLn.GetRarityString and _CbLn:GetRarityString() or nil
        local _fwHD = _CbLn.GetRarityColor and _CbLn:GetRarityColor()
        local _jmE2 = _7JDc and _CbLn.GetQualityString and _CbLn:GetQualityString()
        if not _93WP then
            _7JDc = nil
            _fwHD = nil
            _jmE2 = nil
        end
        local _j8Ie = _CbLn.prefab and STRINGS.RECIPE_DESC[string.upper(_CbLn.prefab)] or nil
        _j8Ie = _j8Ie and type(_j8Ie) == "string" and string.gsub(_j8Ie, "\n", "")
        local _qHvU = _CbLn.GetPanelLongDescription and _CbLn:GetPanelLongDescription() or nil
        _j8Ie = (_j8Ie or "") .. (_j8Ie and _qHvU and " " or "") .. (_qHvU or "")
        _qHvU = _CbLn.GetEnchantmentLongDescription and _CbLn:GetEnchantmentLongDescription() or nil
        _j8Ie = (_j8Ie or "") .. (_j8Ie and _qHvU and " " or "") .. (_qHvU or "")
        _j8Ie = #_j8Ie > 0x0 and _j8Ie or nil
        _j8Ie = _j8Ie and type(_j8Ie) == "string" and _5itq("longdesnospace") == "true" and string.gsub(_j8Ie, " ", "") or _j8Ie
        local _okp2 = _F9QU(_CbLn, _iutA.cfgs.prefab, _iutA.cfgs.tags, _iutA.cfgs.recipe, _iutA.cfgs.richtext)
        local _dPXi, inst2Type = nil, ""
        if _CbLn and _CbLn.components.rider and _CbLn.components.rider.mount then
            _dPXi = _CbLn.components.rider.mount
            inst2Type = _5itq("mount")
        elseif _CbLn and _CbLn.components.driver and _CbLn.components.driver.vehicle then
            _dPXi = _CbLn.components.driver.vehicle
            inst2Type = _5itq("vehicle")
        end
        if _dPXi then
            local _jHOv = _F9QU(_dPXi, _iutA.cfgs.prefab, _iutA.cfgs.tags, _iutA.cfgs.recipe, _iutA.cfgs.richtext)
            if #_jHOv > 0x0 then
                local _6aGd = inst2Type .. ": " .. (_dPXi:GetDisplayName() or "")
                _6aGd = _6aGd and type(_6aGd) == "string" and string.gsub(_6aGd, "\n", "")
                table.insert(_okp2, { text = _6aGd, color = _U9cY() })
                for _84f4, _RlCm in pairs(_jHOv) do table.insert(_okp2, _RlCm) end
            end
        end
        if not _CbLn:HasTag("ground") and _iutA.cfgs.content and _iutA.cfgs.content == "concise" then
            local _m42M = {}
            for _TjnF, _PK5W in pairs(_okp2) do if _PK5W and _PK5W.component and _HZsm[_PK5W.component] then table.insert(_m42M, _PK5W) end end
            _okp2 = _m42M
            _j8Ie = nil
        end
        _ucET:SetObjectDetail({
            action = _KsnD,
            action2 = action2,
            icon = _n2D0 and _n2D0.buffInfo and { atlas = _n2D0.buffInfo.buff.atlas, image = _n2D0.buffInfo.buff.image } or _J1Qx,
            prefix = _NB7l,
            name =
                _n2D0 and _n2D0.buffInfo and _EPRA(_n2D0.buffInfo) or _rpPL,
            nameColor = _n2D0 and _n2D0.buffInfo and _2VGQ(_n2D0.buffInfo) or _fwHD,
            suffix = _n2D0 and _n2D0.buffInfo and _TUBt(_n2D0.buffInfo) or
                _zQXb,
            des = _n2D0 and _n2D0.buffInfo and _OnAI(_n2D0.buffInfo) or _j8Ie,
            desColor = _n2D0 and _n2D0.buffInfo and _iutA.RGBAColor(),
            rarity = _7JDc and (_5itq("rarity") .. ":" .. _7JDc) or nil,
            quality =
                _jmE2 and (" " .. _5itq("quality") .. ":" .. _jmE2) or nil,
            lines = _okp2,
            encLines = _CbLn.GetEnchantmentLines and _CbLn:GetEnchantmentLines(),
            buffInfos = _CbLn.GetSortedBuffs and
                _CbLn:GetSortedBuffs(),
            buffSource = _n2D0 and _n2D0.buffInfo and _jSXk(_n2D0.buffInfo),
        })
        _NOe4(_CbLn, _n2D0)
        if not _ucET.shown then _ucET:Toggle(true) end
    end
end
local _uK9A = false
local function _JzuL()
    _uK9A = true
    TheInput:AddMoveHandler(function(_Ij6j, _BEgv)
        local _BAdd = _iutA.objectDetailWindow
        if _BAdd and _BAdd.hoveredWorldInst then _NOe4() end
    end)
end
local _RcQi = nil
local _Wkza = nil
local _tiPw = nil
local _eTTx = nil
local _5Ovs = nil
local _01Oc = nil
local function _8Tlo(_c2eo, _H2fr, _40Oy)
    local _atrz = _iutA.objectDetailWindow
    if not _atrz then return end
    if not _uK9A then _JzuL() end
    if _atrz.hoveredWidget then
        _atrz.hoveredWorldInst = nil
        return
    end
    _c2eo = _c2eo ~= nil and not _c2eo:HasTag("Fx") and _c2eo
    if _atrz.hoveredWorldInst ~= _c2eo and _c2eo then
        local _DKeR = rawget(_G, "DYCDataSyncer")
        if _DKeR and _DKeR.SendSyncDataRPC then _DKeR.SendSyncDataRPC(_c2eo) end
    end
    _atrz.hoveredWorldInst = _c2eo
    if not _c2eo then
        if _atrz.shown then _atrz:Toggle(false) end
        _RcQi = nil
        return
    end
    if not _atrz.shown then _atrz:Toggle(true) end
    local _VSAW = _c2eo.components.stackable
    local _fVm0 = _c2eo:GetDisplayName()
    local _xNkc = _H2fr and _H2fr:GetActionString()
    local _9k7B = _40Oy and _40Oy:GetActionString()
    _9k7B = _9k7B and STRINGS.RMB .. ":" .. _9k7B
    local _eAYm = _c2eo.components.health
    local _OCCe = _eAYm and _eAYm.currenthealth
    _OCCe = _OCCe ~= nil and type(_OCCe) == "number" and _OCCe
    local _a6rG = _c2eo.dycSyncTime
    _c2eo.dycMouseHoverTimer = _c2eo.dycMouseHoverTimer and _c2eo.dycMouseHoverTimer + FRAMES or 0x0
    if _01Oc == _a6rG and _Wkza == _fVm0 and _RcQi == _c2eo and _tiPw == _xNkc and _eTTx == _9k7B and _5Ovs == _OCCe and _c2eo.dycMouseHoverTimer < 0.5 then
        return
    else
        _01Oc = _a6rG
        _Wkza = _fVm0
        _RcQi = _c2eo
        _tiPw = _xNkc
        _eTTx = _9k7B
        _5Ovs = _OCCe
    end
    _c2eo.dycMouseHoverTimer = 0x0
    _A5gS(_c2eo, nil, _xNkc, _9k7B)
end
local function _JoIy(_PDDt)
    if _PDDt.inst.dycUpdateOdwTask then
        _PDDt.inst.dycUpdateOdwTask:Cancel()
        _PDDt.inst.dycUpdateOdwTask = nil
    end
end
local function _CrjW(_Qo3q, _QLyZ)
    _Qo3q.inst.dycUpdateOdwTask = _Qo3q.inst:DoPeriodicTask(0.5,
        function()
            local _w0vd = _iutA.objectDetailWindow
            if _w0vd and _w0vd.hoveredWidget == _Qo3q and _QLyZ and _QLyZ:IsValid() then _A5gS(_QLyZ, _Qo3q) else _JoIy(_Qo3q) end
        end)
end
local _V2ct = {
    ShowObjectDetail = _A5gS,
    ShowMouseObjectDetail = _8Tlo,
    FollowObject = _NOe4,
    ClearUpdateOdwTask = _JoIy,
    CreateUpdateOdwTask = _CrjW,
}
return _V2ct
