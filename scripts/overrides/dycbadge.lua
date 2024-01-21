local _RhkC = DYCInfoPanel
local _I9Pv = _RhkC.DYCModRequire
local _uusB = _I9Pv("dyc_odwutil")
local _dB6j = _uusB.ShowObjectDetail
local _59oF = _uusB.ClearUpdateOdwTask
local _pdDj = _uusB.CreateUpdateOdwTask
local function _ieSu(_iwg8, ...)
    local _68g1 = _iwg8.owner
    _dB6j(_68g1, _iwg8)
    _59oF(_iwg8)
    _pdDj(_iwg8, _68g1)
    return _iwg8.dycOldOnGainFocus(_iwg8, ...)
end
local function _HpzU(_almK, ...)
    _dB6j(nil, _almK)
    _59oF(_almK)
    return _almK.dycOldOnLoseFocus(_almK, ...)
end
local function _0TLg(_TjVe)
    _TjVe.dycOldOnGainFocus = _TjVe.OnGainFocus
    _TjVe.OnGainFocus = _ieSu
    _TjVe.dycOldOnLoseFocus = _TjVe.OnLoseFocus
    _TjVe.OnLoseFocus = _HpzU
end
return _0TLg
