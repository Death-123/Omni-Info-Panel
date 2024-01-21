local _dYv2 = DYCInfoPanel
local _W8Zx = _dYv2.DYCModRequire
local _tof5 = _W8Zx("dyc_odwutil")
local _dVij = _tof5.ShowObjectDetail
local _O4PR = _tof5.ClearUpdateOdwTask
local _w9lT = _tof5.CreateUpdateOdwTask
local function _SwDp() return rawget(_G, "GetWorld") and rawget(_G, "GetWorld")() or rawget(_G, "TheWorld") end
local function _Iobl(_xwQH, ...)
    local _XjjZ = _SwDp()
    if _XjjZ then
        _dVij(_XjjZ, _xwQH)
        _O4PR(_xwQH)
        _w9lT(_xwQH, _XjjZ)
    end
    return _xwQH.dycOldOnGainFocus(_xwQH, ...)
end
local function _rNwy(_rZcv, ...)
    _dVij(nil, _rZcv)
    _O4PR(_rZcv)
    return _rZcv.dycOldOnLoseFocus(_rZcv, ...)
end
local function _sqMr(_Jxwd)
    _Jxwd.dycOldOnGainFocus = _Jxwd.OnGainFocus
    _Jxwd.OnGainFocus = _Iobl
    _Jxwd.dycOldOnLoseFocus = _Jxwd.OnLoseFocus
    _Jxwd.OnLoseFocus = _rNwy
    if _Jxwd.face then _Jxwd.face:SetClickable(true) end
end
return _sqMr
