local _EbE0 = DYCInfoPanel
local _I4WX = _EbE0.lib.TableContains
local _E3Co = function(_UtoX) return math.floor(_UtoX + 0.5) end
local _3WyE = function(_hCpt, _ghdh, _JyPY) return math.min(math.max(_hCpt, _ghdh), _JyPY) end
local function _DlrF(_1hgj) return _1hgj ~= nil and type(_1hgj) == "number" end
local function _mJDf(_EBdM) return _DlrF(_EBdM) and _EBdM > 0x0 end
local function _Rdkg(_AX7c) return _DlrF(_AX7c) and _AX7c >= 0x0 end
local function _WlTB(_0Ong) return _DlrF(_0Ong) and _0Ong < 0x0 end
local function _oOVI(_cT6V) return _DlrF(_cT6V) and _cT6V ~= 0x0 end
local function _PpsH(_9jYP) return _9jYP ~= nil and type(_9jYP) == "string" end
local function _eBAG(_oJyP) return _oJyP ~= nil and type(_oJyP) == "table" end
local function _ooTQ(_xPsI) return _xPsI ~= nil and type(_xPsI) == "function" end
local function _ww00(_PFJ8) return _PpsH(_PFJ8) and #_PFJ8 > 0x0 end
local function _gyAk(_FzdM, ...)
    local _wewy = { ... }
    if _eBAG(_wewy[0x1]) then _wewy = _wewy[0x1] end
    local _oQ2P = ""
    local _qftX = 0x0
    for _9pya, _6TlM in pairs(_wewy) do if _ww00(_6TlM) or _DlrF(_6TlM) then
            _qftX = _qftX + 0x1
            _oQ2P = _oQ2P .. (_qftX > 0x1 and _FzdM or "") .. _6TlM
        end end
    return _oQ2P
end
local _s89I = function(_1BzZ)
    local _injZ = 0x0
    for _lhut, _s4tP in pairs(_1BzZ) do _injZ = _injZ + 0x1 end
    return _injZ
end
local function _ElJK() return TheSim:GetGameID() == "DST" end
local function _lW81() if _ElJK() then return ThePlayer else return GetPlayer() end end
local function _azoV() if _ElJK() then return TheWorld else return GetWorld() end end
local function _nAtx() if _ElJK() then return TheWorld.net.components.clock else return GetClock() end end
local function _eXGW(_rcGd, _6EM2) return _EbE0.localization:GetString(_rcGd, _6EM2) end
local function _5eSc(_zGih, _zzxf, _DIZS)
    if _DIZS then
        local _8xLU = _zGih / TUNING.TOTAL_DAY_TIME
        _8xLU = math.floor(_8xLU * 0xa + 0.5) / 0xa
        return _8xLU .. _eXGW("timer_day")
    end
    local _X6oE = math.max(math.floor(_zGih / 0x3c), 0x0)
    local _xHxB = math.max(math.floor(_X6oE / 0x3c), 0x0)
    _zGih = _zGih - _X6oE * 0x3c
    _X6oE = _X6oE - _xHxB * 0x3c
    _zGih = math.floor(_zGih)
    if _zzxf then return (_xHxB > 0x0 and _xHxB .. _eXGW("timer_hour") or "") .. (_X6oE > 0x0 and _X6oE .. _eXGW("timer_minute") or "") .. (_zGih > 0x0 and _zGih .. _eXGW("timer_second") or "") else return (_xHxB > 0x0 and _xHxB .. _eXGW("timer_hour") or "") ..
        ((_X6oE > 0x0 or _xHxB > 0x0) and _X6oE .. _eXGW("timer_minute") or "") .. _zGih .. _eXGW("timer_second") end
end
local function _PGNQ(_kg55) return "" .. (_kg55 >= 0x14 and _E3Co(_kg55) or _E3Co(_kg55 * 0xa) / 0xa) end
local function _RmwR(_sm8P) return (_sm8P >= 0.2 and _E3Co(_sm8P * 0x64) or _E3Co(_sm8P * 0x3e8) / 0xa) .. "%" end
local function _ABtS(_nXeI)
    local _31e9 = _ww00(_nXeI) and STRINGS.UI and STRINGS.UI.SANDBOXMENU and STRINGS.UI.SANDBOXMENU[string.upper(_nXeI)]
    return _31e9
end
local function _ZnO2(_iRB2)
    local _VR4w = _ww00(_iRB2) and STRINGS.NAMES[string.upper(_iRB2)]
    for _N3bW = 0x1, 0x9 do
        if _VR4w then break end
        _VR4w = _VR4w or (_ww00(_iRB2) and STRINGS.NAMES[string.upper(_iRB2) .. _N3bW])
    end
    return _VR4w
end
local function _b3CL(_8Je5)
    local _nPn1 = 0x0
    for _BfWt, _b6gD in ipairs(_8Je5.batcaves) do
        local _HDIK = GetWorld().components.interiorspawner
        local _Uf3T = _HDIK and _HDIK:GetInteriorByName(_b6gD)
        if _Uf3T and _Uf3T.prefabs and #_Uf3T.prefabs > 0x0 then for _H6ft = #_Uf3T.prefabs, 0x1, -0x1 do
                local _WsG9 = _Uf3T.prefabs[_H6ft]
                if _WsG9.name == "vampirebat" then _nPn1 = _nPn1 + 0x1 end
            end end
        if _Uf3T and _Uf3T.object_list and #_Uf3T.object_list > 0x0 then for _yCbp = #_Uf3T.object_list, 0x1, -0x1 do
                local _jTOD = _Uf3T.object_list[_yCbp]
                if _jTOD.prefab == "vampirebat" then _nPn1 = _nPn1 + 0x1 end
            end end
    end
    return _nPn1
end
local function _DJBP(_4LuQ, _XHoI)
    local _v102 = math.floor(_4LuQ / 0x2) % (0x8)
    if _v102 == 0x4 then return 0x0 end
    local _Quyq = 0x8
    while _Quyq - _4LuQ - _XHoI <= 0x0 do _Quyq = _Quyq + 0x10 end
    return (_Quyq - _4LuQ - _XHoI) * TUNING.TOTAL_DAY_TIME
end
local function _J3fj(_IX4J)
    if not _EbE0.cfgs.notifications then return end
    local _50tY = _EbE0.bannerSystem
    local _Yfhk = { 0x1, 0x0, 0x0 }
    local _OnZ5 = { 0x1, 0.5, 0x0 }
    local _MyGo = { 0x1, 0x1, 0x1 }
    local _d8OG = _azoV()
    local _LiJZ = _nAtx()
    local _ux4J = _d8OG and _d8OG.components
    local _Erhg = _ux4J and _ux4J.hounded
    local _QVV6 = false
    local _oATq = 0x3c
    local _UQoC = false
    local _FCOk = 0x258
    local _x1fK = false
    local _iy7W = _ux4J and _ux4J.batted
    local _rEDA = false
    local _kHQw = 0x3c
    local _gSo0 = false
    local _NK9N = 0x258
    local _pyW5 = 0xf423f
    local _3gt1 = 0x0
    local _TTmM = _ux4J and _ux4J.volcanomanager
    local _lG7s = false
    local _Y8PT = 0x1e
    local _6sfm = false
    local _91wX = 0x78
    local _oYHW = false
    local _1CuU = 0x1e0
    local _Lb3k = 0xf423f
    local _lLRB = false
    local _vekJ = _ux4J and _ux4J.basehassler
    local _U6cO = {}
    local _4qQ7 = {}
    local _sJ6c = {}
    local _UFN4 = { 0x3c, 0x1e0, 0x2a30 }
    local _mzUT = _ux4J and _ux4J.periodicthreat
    local _mnQW = {}
    local _fEIv = {}
    local _KN14 = { 0x3c, 0x1e0, 0x2a30 }
    local _QWdr = _ux4J and _ux4J.rocmanager
    local _V22L = { false, false, false }
    local _VxBc = { 0x78, 0x1e0, 0x2a30 }
    local _e1zP = 0xf423f
    local _7Wp6 = _LiJZ.bloodmoon_active
    local _tBxH = false
    _d8OG:ListenForEvent("daycomplete",
        function(_ppIA, _RvwP)
            if _tBxH then return end
            _tBxH = true
            _ppIA:DoTaskInTime(FRAMES,
                function()
                    _tBxH = false
                    local _Sbv8 = _LiJZ and _LiJZ.numcycles
                    local _Cwjt = _LiJZ and _LiJZ:GetNormTime()
                    local _Hj8Y = _DJBP(_Sbv8, _Cwjt)
                    if _Hj8Y == 0x0 then _EbE0.PushBanner(_eXGW("fullmoontimer2"), 0xc, _MyGo) end
                end)
        end)
    local _VORo = false
    local _f3xX = ""
    _d8OG:ListenForEvent("phasechange",
        function(_y4Lp, _yFcG)
            if _VORo then return end
            _VORo = true
            _y4Lp:DoTaskInTime(FRAMES,
                function()
                    _VORo = false
                    local _tC3z = _eBAG(_y4Lp.components.nightmareclock) and _y4Lp.components.nightmareclock
                    local _aWtd = _tC3z and _tC3z.phase
                    local _FBmL = _tC3z and _ooTQ(_tC3z.GetTimeLeftInEra) and _tC3z:GetTimeLeftInEra()
                    if _ww00(_aWtd) then
                        if _f3xX ~= "warn" and _aWtd == "warn" and _mJDf(_FBmL) then _EbE0.PushBanner(string.format(_eXGW("watcher_nightmareclock1"), _5eSc(_FBmL)), 0xc, _OnZ5, true) elseif _f3xX ~= "nightmare" and _aWtd == "nightmare" then
                            _EbE0.PushBanner(_eXGW("watcher_nightmareclock2"), 0xc, _Yfhk, true) elseif _f3xX == "nightmare" and _aWtd ~= "nightmare" then _EbE0.PushBanner(
                            _eXGW("watcher_nightmareclock3"), 0xc, _MyGo) end
                        _f3xX = _aWtd
                    end
                end)
        end)
    local _N5yj = 0.5
    local _CJWK = 0x0
    _d8OG:DoPeriodicTask(FRAMES,
        function()
            _CJWK = _CJWK + FRAMES
            if _CJWK >= _N5yj then
                _CJWK = 0x0
                if _LiJZ.bloodmoon_active ~= _7Wp6 then
                    _7Wp6 = _LiJZ.bloodmoon_active
                    if _7Wp6 then _EbE0.PushBanner(_eXGW("watcher_bloodmoon1"), 0xc, _Yfhk, true) else _EbE0.PushBanner(_eXGW("watcher_bloodmoon2"), 0xc, _MyGo) end
                end
                if _Erhg then
                    local _HuuY = "houndedtimer"
                    local _8JqX = _Erhg.timetoattack
                    _8JqX = _Rdkg(_8JqX) and _8JqX or 0x0
                    local _AfJ7 = _Erhg.houndstorelease
                    _AfJ7 = _DlrF(_AfJ7) and _AfJ7 or 0x0
                    local _tM9f = false
                    local _pJX8 = false
                    if not _QVV6 and _8JqX <= _oATq then _tM9f = true elseif not _UQoC and _8JqX <= _FCOk then _tM9f = true end
                    if _tM9f then
                        _pJX8 = _8JqX <= 0x3c
                        local _uOSN = function()
                            _8JqX = _Erhg.timetoattack
                            _8JqX = _Rdkg(_8JqX) and _8JqX or 0x0
                            _AfJ7 = _Erhg.houndstorelease
                            _AfJ7 = _DlrF(_AfJ7) and _AfJ7 or 0x0
                            return _eXGW("timer_warning") .. ": " .. string.format(_eXGW("houndtimer"), _E3Co(_AfJ7), _5eSc(_8JqX))
                        end
                        local _QVjD = _uOSN()
                        local _GBXZ = function(_TB89, _hfBB) _TB89:SetText(_uOSN()) end
                        local _GFMA = function(_1prb)
                            _1prb:AddTag(_HuuY)
                            _1prb:SetUpdateFn(_GBXZ)
                        end
                        _50tY:FadeOutBanners(_HuuY)
                        _EbE0.PushBanner(_QVjD, _pJX8 and _8JqX or 0xc, _OnZ5, true, _GFMA)
                    end
                    if not _x1fK and _8JqX <= 0x0 then
                        _50tY:FadeOutBanners(_HuuY)
                        _EbE0.PushBanner(_eXGW("watcher_houndattack"), 0xc, _Yfhk, true)
                    end
                    if _8JqX > _oATq then _QVV6 = false else _QVV6 = true end
                    if _8JqX > _FCOk then _UQoC = false else _UQoC = true end
                    if _8JqX > 0x0 then _x1fK = false else _x1fK = true end
                end
                if _iy7W then
                    local _5t43 = "battedtimer"
                    local _VXp3 = _iy7W.timetoattack
                    _VXp3 = _Rdkg(_VXp3) and _VXp3 or 0x0
                    local _LQim = _b3CL(_iy7W)
                    _LQim = _DlrF(_LQim) and _LQim or 0x0
                    local _AWr8 = false
                    local _sUn2 = false
                    if not _rEDA and _VXp3 <= _kHQw then _AWr8 = true elseif not _gSo0 and _VXp3 <= _NK9N then _AWr8 = true end
                    if _AWr8 then
                        _sUn2 = _VXp3 <= 0x3c
                        local _Oa8k = function()
                            _VXp3 = _iy7W.timetoattack
                            _VXp3 = _Rdkg(_VXp3) and _VXp3 or 0x0
                            _LQim = _b3CL(_iy7W)
                            _LQim = _DlrF(_LQim) and _LQim or 0x0
                            return _eXGW("timer_warning") .. ": " .. string.format(_eXGW("battimer"), _E3Co(_LQim), _5eSc(_VXp3))
                        end
                        local _iwBZ = _Oa8k()
                        local _bsWA = function(_EiHm, _H3d6) _EiHm:SetText(_Oa8k()) end
                        local _lfxA = function(_7obU)
                            _7obU:AddTag(_5t43)
                            _7obU:SetUpdateFn(_bsWA)
                        end
                        _50tY:FadeOutBanners(_5t43)
                        _EbE0.PushBanner(_iwBZ, _sUn2 and _VXp3 or 0xc, _OnZ5, true, _lfxA)
                    end
                    if _pyW5 < _VXp3 and _3gt1 > 0x0 then
                        _50tY:FadeOutBanners(_5t43)
                        _EbE0.PushBanner(_eXGW("watcher_batattack"), 0xc, _Yfhk, true)
                    end
                    if _VXp3 > _kHQw then _rEDA = false else _rEDA = true end
                    if _VXp3 > _NK9N then _gSo0 = false else _gSo0 = true end
                    _pyW5 = _VXp3
                    _3gt1 = _LQim
                end
                if _TTmM then
                    local _oNhh = "volcanomanagertimer"
                    local _czx5 = _ooTQ(_TTmM.GetNumSegmentsUntilEruption) and _TTmM:GetNumSegmentsUntilEruption()
                    local _vTVz = _Rdkg(TUNING.SEG_TIME) and TUNING.SEG_TIME
                    local _vA1t = _Rdkg(TUNING.TOTAL_DAY_TIME) and TUNING.TOTAL_DAY_TIME
                    if _Rdkg(_czx5) and _vTVz and _vA1t then
                        local _4RSr = math.floor(_vA1t * _nAtx():GetNormTime() / _vTVz) * _vTVz
                        _4RSr = _vA1t * _nAtx():GetNormTime() - _4RSr
                        local _oeBy = _czx5 * _vTVz - _4RSr
                        local _QrQI = false
                        local _NHn3 = false
                        if _lLRB then _QrQI = true elseif not _lG7s and _oeBy <= _Y8PT then _QrQI = true elseif not _6sfm and _oeBy <= _91wX then _QrQI = true elseif not _oYHW and _oeBy <= _1CuU then _QrQI = true end
                        if _QrQI then
                            _NHn3 = _oeBy <= 0x78
                            local _vRKy = function()
                                _czx5 = _ooTQ(_TTmM.GetNumSegmentsUntilEruption) and _TTmM:GetNumSegmentsUntilEruption()
                                _4RSr = math.floor(_vA1t * _nAtx():GetNormTime() / _vTVz) * _vTVz
                                _4RSr = _vA1t * _nAtx():GetNormTime() - _4RSr
                                _oeBy = _Rdkg(_czx5) and _czx5 * _vTVz - _4RSr
                                return _eXGW("timer_warning") .. ": " .. string.format(_eXGW("volcanotimer"), _Rdkg(_oeBy) and _5eSc(_oeBy) or "?")
                            end
                            local _lPye = _vRKy()
                            local _VM1X = function(_iOKU, _odFp)
                                _iOKU:SetText(_vRKy())
                                _czx5 = _ooTQ(_TTmM.GetNumSegmentsUntilEruption) and _TTmM:GetNumSegmentsUntilEruption()
                                if not _Rdkg(_czx5) then _iOKU:FadeOut() end
                            end
                            local _GTFj = function(_lSAV)
                                _lSAV:AddTag(_oNhh)
                                _lSAV:SetUpdateFn(_VM1X)
                            end
                            _50tY:FadeOutBanners(_oNhh)
                            _EbE0.PushBanner(_lPye, _NHn3 and _oeBy or 0xc, _OnZ5, true, _GTFj)
                        end
                        if _Lb3k < _oeBy and _Lb3k <= 0x2 then
                            _50tY:FadeOutBanners(_oNhh)
                            _EbE0.PushBanner(_eXGW("watcher_volcano"), 0xc, _Yfhk, true)
                        end
                        if _oeBy > _Y8PT then _lG7s = false else _lG7s = true end
                        if _oeBy > _91wX then _6sfm = false else _6sfm = true end
                        if _oeBy > _1CuU then _oYHW = false else _oYHW = true end
                        _Lb3k = _oeBy
                        _lLRB = false
                    else
                        _Lb3k = 0xf423f
                        _lLRB = true
                    end
                end
                if _vekJ then
                    local _TYrX = "basehasslertimer"
                    local _G1dO = _vekJ.hasslers
                    if _eBAG(_G1dO) and next(_G1dO) then for _ZDip, _sNGM in pairs(_G1dO) do
                            local _nOpc = _sNGM.chance
                            local _Q5tJ = _eBAG(_sNGM) and _sNGM.timer
                            local _c7wM = _eBAG(_sNGM) and _sNGM.prefab
                            local _mBmC = _ZnO2(_c7wM) or ""
                            local _pNv6 = _ooTQ(_vekJ.GetHasslerState) and _vekJ:GetHasslerState(_ZDip)
                            local _udqq = _ww00(_pNv6) and (_pNv6 == "WAITING" or _pNv6 == "WARNING") and
                            "(" .. _eXGW("timer_" .. _pNv6) .. (_mJDf(_nOpc) and _pNv6 ~= "WARNING" and "," .. _RmwR(_nOpc) or "") .. ")" or ""
                            if not _U6cO[_sNGM] then
                                _U6cO[_sNGM] = {}
                                for _K54V = 0x1, #_UFN4 do table.insert(_U6cO[_sNGM], false) end
                            end
                            local _5q63 = _U6cO[_sNGM]
                            if _DlrF(_Q5tJ) and _mJDf(_nOpc) and _ww00(_mBmC) and _ww00(_udqq) then
                                local _m25H = false
                                local _CxeX = false
                                for _ESVJ = 0x1, #_UFN4 do
                                    if not _5q63[_ESVJ] and _Q5tJ <= _UFN4[_ESVJ] and _pNv6 ~= "WARNING" then _m25H = true end
                                    if _Q5tJ > _UFN4[_ESVJ] then _5q63[_ESVJ] = false else _5q63[_ESVJ] = true end
                                end
                                if not _4qQ7[_sNGM] and _sJ6c[_sNGM] ~= _pNv6 and _pNv6 == "WARNING" then
                                    _4qQ7[_sNGM] = true
                                    _m25H = true
                                    _CxeX = true
                                elseif _4qQ7[_sNGM] and _pNv6 ~= "WARNING" then _4qQ7[_sNGM] = false end
                                if _m25H then
                                    local _FBBy = function()
                                        _Q5tJ = _eBAG(_sNGM) and _sNGM.timer
                                        return _mBmC .. _udqq .. ":" .. (_Rdkg(_Q5tJ) and _5eSc(_Q5tJ) or "?")
                                    end
                                    local _qQaP = _FBBy()
                                    local _sKrj = function(_y9BU, _aINV) _y9BU:SetText(_FBBy()) end
                                    local _aCAt = function(_FP91)
                                        _FP91:AddTag(_TYrX .. _mBmC)
                                        _FP91:SetUpdateFn(_sKrj)
                                    end
                                    _50tY:FadeOutBanners(_TYrX .. _mBmC)
                                    _EbE0.PushBanner(_qQaP, _CxeX and _Q5tJ or 0xc, _OnZ5, true, _aCAt)
                                end
                            elseif _eBAG(_sNGM) and _ww00(_mBmC) then for _IHBL = 0x1, #_5q63 do if _5q63[_IHBL] == true then _5q63[_IHBL] = false end end end
                            if _eBAG(_sNGM) and _ww00(_mBmC) then if _sJ6c[_sNGM] == "WARNING" and _pNv6 ~= "WARNING" then
                                    _50tY:FadeOutBanners(_TYrX .. _mBmC)
                                    _EbE0.PushBanner(string.format(_eXGW("watcher_hassler"), _mBmC), 0xc, _Yfhk, true)
                                elseif _sJ6c[_sNGM] == "WAITING" and _pNv6 ~= "WAITING" and _pNv6 ~= "WARNING" then
                                    _50tY:FadeOutBanners(_TYrX .. _mBmC)
                                    _EbE0.PushBanner(string.format(_eXGW("watcher_hasslerskipped"), _mBmC), 0xc, _MyGo, false)
                                end end
                            _sJ6c[_sNGM] = _pNv6
                        end end
                end
                if _mzUT then
                    local _sRUj = "periodicthreattimer"
                    local _DGEp = _mzUT.threats
                    if _eBAG(_DGEp) and next(_DGEp) then for _pqKL, _KWiD in pairs(_DGEp) do
                            local _5tW6 = _eBAG(_KWiD) and _KWiD.timer
                            local _e9Ic = _pqKL
                            local _bi2L = _ZnO2(_e9Ic) or ""
                            local _QjhU = _ooTQ(_mzUT.GetCurrentState) and _mzUT:GetCurrentState(_pqKL)
                            local _iP0Q = _ww00(_QjhU) and "(" .. _eXGW("periodicthreat_" .. _QjhU, _QjhU) .. ")" or ""
                            if not _mnQW[_KWiD] then
                                _mnQW[_KWiD] = {}
                                for _osrE = 0x1, #_KN14 do table.insert(_mnQW[_KWiD], false) end
                            end
                            local _eyFT = _mnQW[_KWiD]
                            if _mJDf(_5tW6) and _ww00(_bi2L) and _ww00(_iP0Q) then
                                local _2YTT = false
                                local _GF5p = false
                                for _VFHt = 0x1, #_KN14 do
                                    if not _eyFT[_VFHt] and _5tW6 <= _KN14[_VFHt] then
                                        _2YTT = true
                                        _GF5p = _5tW6 <= 0x3c
                                    end
                                    if _5tW6 > _KN14[_VFHt] then _eyFT[_VFHt] = false else _eyFT[_VFHt] = true end
                                end
                                if _2YTT then
                                    local _jShv = function()
                                        _5tW6 = _eBAG(_KWiD) and _KWiD.timer
                                        return _bi2L .. _iP0Q .. ":" .. (_Rdkg(_5tW6) and _5eSc(_5tW6) or "?")
                                    end
                                    local _O2Ig = _jShv()
                                    local _j0C4 = function(_5BpN, _cs2P) _5BpN:SetText(_jShv()) end
                                    local _DYkn = function(_yifl)
                                        _yifl:AddTag(_sRUj .. _bi2L)
                                        _yifl:SetUpdateFn(_j0C4)
                                    end
                                    _50tY:FadeOutBanners(_sRUj .. _bi2L)
                                    _EbE0.PushBanner(_O2Ig, _GF5p and _5tW6 or 0xc, _OnZ5, true, _DYkn)
                                end
                                if _fEIv[_KWiD] == "warn" and _QjhU == "event" then
                                    _50tY:FadeOutBanners(_sRUj .. _bi2L)
                                    _EbE0.PushBanner(string.format(_eXGW("watcher_hassler"), _bi2L), 0xc, _Yfhk, true)
                                elseif _fEIv[_KWiD] == "event" and _QjhU == "wait" then for _n29N = 0x1, #_eyFT do _eyFT[_n29N] = false end end
                            end
                            _fEIv[_KWiD] = _QjhU
                        end end
                end
                if _QWdr then
                    local _iHHF = "rocmanagertimer"
                    local _k50l = _QWdr.dycSpawnTime
                    local _0zKc = _DlrF(_k50l) and _k50l - GetTime() or 0x0
                    local _vYYe = _QWdr.disabled
                    local _qsmC = STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.ROC or ""
                    if _ww00(_qsmC) and not _vYYe and _0zKc >= 0x0 then
                        local _N10u = false
                        for _H47F = 0x1, #_V22L do if not _V22L[_H47F] and _DlrF(_VxBc[_H47F]) and _0zKc <= _VxBc[_H47F] and _0zKc >= 0x1 then
                                _N10u = true
                                break
                            end end
                        for _Ww3r = 0x1, #_V22L do if _DlrF(_VxBc[_Ww3r]) and _0zKc > _VxBc[_Ww3r] then _V22L[_Ww3r] = false else _V22L[_Ww3r] = true end end
                        if _N10u then
                            local _0ZWx = function()
                                _0zKc = _DlrF(_k50l) and _k50l - GetTime() or 0x0
                                return _qsmC .. ":" .. (_Rdkg(_0zKc) and _5eSc(_0zKc) or "?")
                            end
                            local _3TCh = _0ZWx()
                            local _CQZe = function(_oi2J, _tb55) _oi2J:SetText(_0ZWx()) end
                            local _PGar = function(_Rm8q)
                                _Rm8q:AddTag(_iHHF)
                                _Rm8q:SetUpdateFn(_CQZe)
                            end
                            _50tY:FadeOutBanners(_iHHF)
                            _EbE0.PushBanner(_3TCh, 0xc, _MyGo, false, _PGar)
                        end
                        if _0zKc < _N5yj and _0zKc ~= _e1zP and _e1zP <= 0x2 then
                            _50tY:FadeOutBanners(_iHHF)
                            _EbE0.PushBanner(string.format(_eXGW("watcher_hassler"), _qsmC), 0xc, _MyGo)
                        end
                        _e1zP = _0zKc
                    else _e1zP = 0xf423f end
                end
            end
        end)
end
local _7uyD = {}
function _7uyD:Start() _J3fj(self) end

return _7uyD
