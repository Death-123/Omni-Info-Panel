local function _dYv2(_W8Zx) return _W8Zx.dycSpawnTime end
local function _tof5(_dVij, _O4PR) _dVij.dycSpawnTime = GetTime() + (_O4PR or 0x0) end
local function _w9lT(_SwDp, ...)
    local _Iobl = _SwDp.dycOldGetNextSpawnTime and _SwDp.dycOldGetNextSpawnTime(_SwDp, ...)
    _tof5(_SwDp, _Iobl)
    return _Iobl
end
local function _xwQH(_XjjZ, _rNwy, ...)
    local _rZcv = _XjjZ.dycOldOnLoad and _XjjZ.dycOldOnLoad(_XjjZ, _rNwy, ...)
    if _XjjZ.nexttime then _tof5(_XjjZ, _XjjZ.nexttime) end
    return _rZcv
end
local function _sqMr(_Jxwd, _MMjA, ...)
    local _FKYe = _Jxwd.dycOldLongUpdate and _Jxwd.dycOldLongUpdate(_Jxwd, _MMjA, ...)
    local _m4IQ = _dYv2(_Jxwd)
    if _m4IQ then _tof5(_Jxwd, _m4IQ - GetTime() - _MMjA) end
    return _FKYe
end
local function _eKwE(_VZzT)
    _VZzT.dycOldGetNextSpawnTime = _VZzT.GetNextSpawnTime
    _VZzT.GetNextSpawnTime = _w9lT
    _VZzT.dycOldOnLoad = _VZzT.OnLoad
    _VZzT.OnLoad = _xwQH
    _VZzT.dycOldLongUpdate = _VZzT.LongUpdate
    _VZzT.LongUpdate = _sqMr
end
return _eKwE
