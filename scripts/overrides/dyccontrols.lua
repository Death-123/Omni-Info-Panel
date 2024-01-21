local _RhkC = DYCInfoPanel
local _I9Pv = _RhkC.DYCModRequire
local _uusB = _I9Pv("dyc_odwutil")
local _dB6j = _uusB.ShowObjectDetail
local _59oF = _uusB.FollowObject
local function _pdDj(_ieSu)
    local _iwg8 = _RhkC.objectDetailWindow
    if _iwg8 and _iwg8.shown and _ieSu and _iwg8.focusedObject and _iwg8.focusedObject == _ieSu then _59oF(_ieSu) end
end
local _68g1 = nil
local _HpzU, lastY, lastZ = 0x3e7, 0x3e7, 0x3e7
local function _almK(_0TLg, _TjVe, _6hkN, ...)
    if TheInput:ControllerAttached() then
        if _TjVe then
            local _NbtE = _0TLg.owner
            local _rum8 = _NbtE and _NbtE.components.playercontroller
            local _nuEf = _rum8 and _rum8.controller_target
            if _nuEf ~= _68g1 then _dB6j(_nuEf) end
            if _nuEf then
                local _ufMP, y, z = TheSim:GetScreenPos(_nuEf.Transform:GetWorldPosition())
                if _ufMP ~= _HpzU or y ~= lastY or z ~= lastZ then
                    _pdDj(_nuEf)
                    _HpzU, lastY, lastZ = _ufMP, y, z
                end
            end
            _68g1 = _nuEf
        else
            if _68g1 ~= nil then _dB6j() end
            _68g1 = nil
        end
    end
    return _0TLg.dycOldHighlightActionItem(_0TLg, _TjVe, _6hkN, ...)
end
local function _KDEd(_13sz)
    _13sz.dycOldHighlightActionItem = _13sz.HighlightActionItem
    _13sz.HighlightActionItem = _almK
end
return _KDEd
