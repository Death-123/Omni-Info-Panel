local _dYv2 = DYCInfoPanel
local _W8Zx = _dYv2.DYCModRequire
local _tof5 = _W8Zx("dyc_odwutil")
local _dVij = _tof5.ShowMouseObjectDetail
local function _O4PR() return TheSim:GetGameID() == "DST" end
local function _w9lT() if _O4PR() then return ThePlayer else return GetPlayer() end end
local function _SwDp(_Iobl, ...)
    local _xwQH = _Iobl.dycOldGetLeftMouseAction(_Iobl, ...)
    local _XjjZ = _Iobl.RMBaction
    local _rNwy = TheInput:GetWorldEntityUnderMouse()
    if _O4PR() then _Iobl.enabled = true end
    if _Iobl.enabled and _xwQH and _xwQH.target then
        _dVij(_xwQH.target, _xwQH, _XjjZ)
    elseif _Iobl.enabled and _XjjZ and _XjjZ.target then
        _dVij(_XjjZ.target, _xwQH, _XjjZ)
    elseif _rNwy and _rNwy == _w9lT() then
        _dVij(_rNwy, nil, nil)
    else
        _dVij()
    end
    return _Iobl.enabled and _xwQH
end
local function _rZcv(_sqMr)
    _sqMr.dycOldGetLeftMouseAction = _sqMr.GetLeftMouseAction
    _sqMr.GetLeftMouseAction = _SwDp
end
return _rZcv
