local _RhkC = DYCInfoPanel
local _I9Pv = _RhkC.DYCModRequire
local _uusB = _I9Pv("dyc_odwutil")
local _dB6j = _uusB.ShowObjectDetail
local _59oF = nil
local function _pdDj(_ieSu, ...)
    if TheInput:ControllerAttached() then
        local _iwg8 = _ieSu.active_slot and _ieSu.active_slot.tile
        local _68g1 = _ieSu.cursortile
        local _HpzU = _iwg8 and _iwg8.item
        local _almK = _68g1 and _68g1.item
        local _0TLg = _68g1 or _iwg8
        local _TjVe = _almK or _HpzU
        if _TjVe ~= _59oF then
            _dB6j(_TjVe, _0TLg)
            _59oF = _TjVe
        end
    end
    return _ieSu.dycOldUpdateCursorText(_ieSu, ...)
end
local function _6hkN(_NbtE)
    _NbtE.dycOldUpdateCursorText = _NbtE.UpdateCursorText
    _NbtE.UpdateCursorText = _pdDj
end
return _6hkN
