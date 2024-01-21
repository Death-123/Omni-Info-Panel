local _RhkC = {}
local function _I9Pv(_uusB)
    _RhkC[_uusB] = _RhkC[_uusB] or { des = {}, longDes = {} }
    return _RhkC[_uusB]
end
local function _dB6j(_59oF, _pdDj, _ieSu, _iwg8)
    _ieSu = _iwg8 and _ieSu and tostring(_ieSu) or _ieSu and string.gsub(tostring(_ieSu), "\n", "") or nil
    local _68g1 = _I9Pv(_59oF)
    local _HpzU = _iwg8 and _68g1.longDes or _68g1.des
    if _pdDj then
        _pdDj = tostring(_pdDj)
        local _almK = false
        if #_HpzU > 0x0 then
            for _0TLg = 0x1, #_HpzU do
                if _HpzU[_0TLg].index == _pdDj then
                    _almK = true
                    if _ieSu then _HpzU[_0TLg].text = _ieSu else table.remove(_HpzU, _0TLg) end
                    break
                end
            end
            if not _almK and _ieSu then table.insert(_HpzU, { index = _pdDj, text = _ieSu }) end
        else
            if _ieSu then table.insert(_HpzU, { index = _pdDj, text = _ieSu }) end
        end
    end
end
function EntityScript:SetPanelDescription(_TjVe, _6hkN) _dB6j(self, _TjVe, _6hkN, false) end

function EntityScript:SetPanelLongDescription(_NbtE, _rum8) _dB6j(self, _NbtE, _rum8, true) end

function EntityScript:GetPanelDescriptions()
    local _nuEf = _I9Pv(self)
    return _nuEf.des
end

function EntityScript:GetPanelLongDescription()
    local _ufMP = _I9Pv(self)
    local _KDEd = ""
    if #_ufMP.longDes > 0x0 then for _13sz = 0x1, #_ufMP.longDes do _KDEd = _KDEd .. (#_KDEd > 0x0 and " " or "") .. _ufMP.longDes[_13sz].text end end
    return _KDEd
end
