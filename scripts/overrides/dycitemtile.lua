local _dYv2 = require "widgets/uianim"
local _W8Zx = DYCInfoPanel
local _tof5 = _W8Zx.DYCModRequire
local _dVij = _tof5("dyc_odwutil")
local _O4PR = _dVij.ShowObjectDetail
local _w9lT = _dVij.ClearUpdateOdwTask
local _SwDp = _dVij.CreateUpdateOdwTask
local _Iobl = _W8Zx.lib.StrSpl
local _xwQH = _W8Zx.lib.StringStartWith
local function _XjjZ(_rNwy, ...)
    local _rZcv = _rNwy.item
    _O4PR(_rZcv, _rNwy)
    _w9lT(_rNwy)
    _SwDp(_rNwy, _rZcv)
    return _rNwy.dycOldOnGainFocus(_rNwy, ...)
end
local function _sqMr(_Jxwd, ...)
    _O4PR(nil, _Jxwd)
    _w9lT(_Jxwd)
    return _Jxwd.dycOldOnLoseFocus(_Jxwd, ...)
end
local function _MMjA(_FKYe, ...)
    _O4PR(nil, _FKYe)
    return _FKYe.dycOldKill(_FKYe, ...)
end
local function _m4IQ(_eKwE)
    local _VZzT = _eKwE.item
    _eKwE.dycOldOnGainFocus = _eKwE.OnGainFocus
    _eKwE.OnGainFocus = _XjjZ
    _eKwE.dycOldOnLoseFocus = _eKwE.OnLoseFocus
    _eKwE.OnLoseFocus = _sqMr
    _eKwE.dycOldKill = _eKwE.Kill
    _eKwE.Kill = _MMjA
end
return _m4IQ
