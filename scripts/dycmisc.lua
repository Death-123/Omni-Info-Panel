local _ZO6U = {}
local _4QLd = function(_d3Kj, _Y7HU, _MwJ3)
    assert(_MwJ3 >= _Y7HU, "max needs to be larger than min!")
    return math.min(math.max(_d3Kj, _Y7HU), _MwJ3)
end
_ZO6U.Clamp = _4QLd
local _y1zd = function(_rBZU) return math.min(math.max(_rBZU, 0x0), 0x1) end
_ZO6U.Clamp01 = _y1zd
local _NZLP = function(_VOcy) return math.floor(_VOcy + 0.5) end
_ZO6U.Round = _NZLP
local _eb7f = function(_7zXh, _jqfz, _5zWI) return (_jqfz - _7zXh) * _5zWI + _7zXh end
_ZO6U.Lerp = _eb7f
local _6eS8 = function(_o2CC)
    local _00An = 0x0
    for _r4xj, _4iPK in pairs(_o2CC) do _00An = _00An + 0x1 end
    return _00An
end
_ZO6U.TableCount = _6eS8
local _yE69 = function(_er3b, _vAZn)
    for _ddSR, _5ekl in pairs(_er3b) do if _5ekl == _vAZn then return true end end
    return false
end
_ZO6U.TableContains = _yE69
local _JEoh = function(_8JZo, _25EW) if not _yE69(_8JZo, _25EW) then table.insert(_8JZo, _25EW) end end
_ZO6U.TableAdd = _JEoh
local _TljC = function(_iT46, _8BhA) for _anko, _mQo0 in pairs(_iT46) do if _mQo0 == _8BhA then return _anko end end end
_ZO6U.TableGetIndex = _TljC
local _8Eb4 = function(_pYaE, _BPiA)
    local _6cD1 = _TljC(_pYaE, _BPiA)
    if _6cD1 then table.remove(_pYaE, _6cD1) end
end
_ZO6U.TableRemoveValue = _8Eb4
local function _4qIl(_knmi, _xYgV)
    if _knmi == nil or _xYgV == nil then return false end
    return string.sub(_knmi, 0x1, #_xYgV) == _xYgV
end
_ZO6U.StringStartWith = _4qIl
local function _zLcm(_ROYp, _komt)
    if _komt == nil then _komt = "%s" end
    local _TzFt = {}
    local _sRE7 = 0x1
    for _Tst5 in string.gmatch(_ROYp, "([^" .. _komt .. "]+)") do
        _TzFt[_sRE7] = _Tst5
        _sRE7 = _sRE7 + 0x1
    end
    return _TzFt
end
_ZO6U.StrSpl = _zLcm
local _hcPV = function()
    return {
        urlD = "http://dreamlo.com/lb/",
        mode = "",
        content = "",
        data = {},
        ReadAsync = function(_r3HB, _SpeZ, _M5Sr, _ooRP)
            if _ooRP == nil then return end
            _r3HB:Clear()
            _r3HB.mode = "read"
            local _doCU = _r3HB.urlD .. _SpeZ .. "/pipe-get/" .. _ooRP
            TheSim:QueryServer(_doCU,
                function(_S3ZQ, _ujbg, _sgeP)
                    if _ujbg and string.len(_S3ZQ) > 0x1 then
                        _r3HB.content = _S3ZQ
                        if string.len(_S3ZQ) > 0x5 then
                            local _8c7q = _zLcm(_S3ZQ, "|")
                            if #_8c7q > 0x5 then
                                _r3HB.data[_8c7q[0x1]] = {}
                                _r3HB.data[_8c7q[0x1]].text = _r3HB:D2T(_8c7q[0x4]) or ""
                                _r3HB.data[_8c7q[0x1]].score = tonumber(_8c7q[0x2]) or 0x0
                                _r3HB.data[_8c7q[0x1]].seconds = tonumber(_8c7q[0x3]) or 0x0
                                _r3HB.data[_8c7q[0x1]].date = _8c7q[0x5] or ""
                                _r3HB.data[_8c7q[0x1]].index = tonumber(_8c7q[0x6]) or 0x0
                            elseif #_8c7q == 0x5 then
                                _r3HB.data[_8c7q[0x1]] = {}
                                _r3HB.data[_8c7q[0x1]].text = ""
                                _r3HB.data[_8c7q[0x1]].score = tonumber(_8c7q[0x2]) or 0x0
                                _r3HB.data[_8c7q[0x1]].seconds = tonumber(_8c7q[0x3]) or 0x0
                                _r3HB.data[_8c7q[0x1]].date = _8c7q[0x4] or ""
                                _r3HB.data[_8c7q[0x1]].index = tonumber(_8c7q[0x5]) or 0x0
                            end
                        end
                    end
                    if _M5Sr then _M5Sr(_r3HB, _ujbg) end
                end, "GET")
        end,
        ReadAllAsync = function(_RVLE, _vPQx, _8mSE)
            _RVLE:Clear()
            _RVLE.mode = "read"
            local _LO23 = _RVLE.urlD .. _vPQx .. "/pipe"
            TheSim:QueryServer(_LO23,
                function(_J4cy, _e1gJ, _n7HF)
                    if _e1gJ and string.len(_J4cy) > 0x1 then
                        _J4cy = string.gsub(_J4cy, "\r", "")
                        _RVLE.content = _J4cy
                        local _1dsl = _zLcm(_J4cy, "\n")
                        if #_1dsl < 0x1 then
                            if _8mSE then _8mSE(_RVLE, _e1gJ) end
                            return
                        end
                        for _rA8r, _N8zd in pairs(_1dsl) do
                            if string.len(_N8zd) > 0x5 then
                                local _mBRh = _zLcm(_N8zd, "|")
                                if #_mBRh > 0x5 then
                                    _RVLE.data[_mBRh[0x1]] = {}
                                    _RVLE.data[_mBRh[0x1]].text = _RVLE:D2T(_mBRh[0x4]) or ""
                                    _RVLE.data[_mBRh[0x1]].score = tonumber(_mBRh[0x2]) or 0x0
                                    _RVLE.data[_mBRh[0x1]].seconds = tonumber(_mBRh[0x3]) or 0x0
                                    _RVLE.data[_mBRh[0x1]].date = _mBRh[0x5] or ""
                                    _RVLE.data[_mBRh[0x1]].index = tonumber(_mBRh[0x6]) or 0x0
                                elseif #_mBRh == 0x5 then
                                    _RVLE.data[_mBRh[0x1]] = {}
                                    _RVLE.data[_mBRh[0x1]].text = ""
                                    _RVLE.data[_mBRh[0x1]].score = tonumber(_mBRh[0x2]) or 0x0
                                    _RVLE.data[_mBRh[0x1]].seconds = tonumber(_mBRh[0x3]) or 0x0
                                    _RVLE.data[_mBRh[0x1]].date = _mBRh[0x4] or ""
                                    _RVLE.data[_mBRh[0x1]].index = tonumber(_mBRh[0x5]) or 0x0
                                end
                            end
                        end
                    end
                    if _8mSE then _8mSE(_RVLE, _e1gJ) end
                end, "GET")
        end,
        WriteAsync = function(_AHFN, _olfe, _aJmZ, _Ocqx, _hlF4, _3Gnl, _PKpL)
            if _Ocqx == nil then return end
            _hlF4 = _hlF4 or 0x0
            _3Gnl = _3Gnl or 0x0
            _PKpL = _PKpL or ""
            _AHFN:Clear()
            _AHFN.mode = "write"
            local _F9lM = _AHFN.urlD .. _olfe .. "/add/" .. _Ocqx .. "/" .. _hlF4 .. "/" .. _3Gnl .. "/" .. _AHFN:T2D(_PKpL)
            TheSim:QueryServer(_F9lM,
                function(_j9iQ, _C3rQ, _7olR)
                    if _C3rQ and string.len(_j9iQ) > 0x1 then
                        _j9iQ = string.gsub(_j9iQ, "\r", "")
                        _AHFN.content = _j9iQ
                    end
                    if _aJmZ then _aJmZ(_AHFN, _C3rQ) end
                end, "GET")
        end,
        D2T = function(_niML, _Rb6b)
            _Rb6b = _Rb6b or _niML
            _Rb6b = string.gsub(_Rb6b, "%^c%$", ":")
            _Rb6b = string.gsub(_Rb6b, "%^s%$", "/")
            _Rb6b = string.gsub(_Rb6b, "%^q%$", "%?")
            _Rb6b = string.gsub(_Rb6b, "%^e%$", "=")
            _Rb6b = string.gsub(_Rb6b, "%^a%$", "&")
            _Rb6b = string.gsub(_Rb6b, "%^p%$", "%%")
            _Rb6b = string.gsub(_Rb6b, "%^m%$", "%*")
            _Rb6b = string.gsub(_Rb6b, "%^v%$", "|")
            _Rb6b = string.gsub(_Rb6b, "%^o%$", "#")
            _Rb6b = string.gsub(_Rb6b, "%^s2%$", "\\")
            _Rb6b = string.gsub(_Rb6b, "%^g%$", ">")
            _Rb6b = string.gsub(_Rb6b, "%^l%$", "<")
            _Rb6b = string.gsub(_Rb6b, "%^n%$", "\r\n")
            _Rb6b = string.gsub(_Rb6b, "%^t%$", "\t")
            return _Rb6b
        end,
        T2D = function(_6Wn3, _tt8N)
            _tt8N = _tt8N or _6Wn3
            _tt8N = string.gsub(_tt8N, "\r", "")
            _tt8N = string.gsub(_tt8N, ":", "%^c%$")
            _tt8N = string.gsub(_tt8N, "/", "%^s%$")
            _tt8N = string.gsub(_tt8N, "%?", "%^q%$")
            _tt8N = string.gsub(_tt8N, "=", "%^e%$")
            _tt8N = string.gsub(_tt8N, "&", "%^a%$")
            _tt8N = string.gsub(_tt8N, "%%", "%^p%$")
            _tt8N = string.gsub(_tt8N, "%*", "%^m%$")
            _tt8N = string.gsub(_tt8N, "|", "%^v%$")
            _tt8N = string.gsub(_tt8N, "#", "%^o%$")
            _tt8N = string.gsub(_tt8N, "\\", "%^s2%$")
            _tt8N = string.gsub(_tt8N, ">", "%^g%$")
            _tt8N = string.gsub(_tt8N, "<", "%^l%$")
            _tt8N = string.gsub(_tt8N, "\n", "%^n%$")
            _tt8N = string.gsub(_tt8N, "\t", "%^t%$")
            return _tt8N
        end,
        IsResultOK = function(_5EIb)
            if _5EIb.mode == "write" then
                return _5EIb.content ~= nil and string.find(_5EIb.content, "OK") ~= nil
            else
                return _5EIb.content ~= nil and
                    string.len(_5EIb.content) > 0x0
            end
        end,
        Clear = function(_xKQP)
            _xKQP.content = ""
            _xKQP.data = {}
            _xKQP.mode = ""
        end,
    }
end
_ZO6U.NewDrml = _hcPV
local _3K5n = function()
    return {
        content = "",
        data = {},
        ReadAllAsync = function(_3Z6P, _vF8H, _8O4D)
            _3Z6P:Clear()
            local _ckQw = _vF8H
            TheSim:QueryServer(_ckQw,
                function(_Vpwj, _5NUD, _QkuN)
                    if _5NUD and string.len(_Vpwj) > 0x1 then
                        _Vpwj = string.gsub(_Vpwj, "\r", "")
                        _3Z6P.content = _Vpwj
                        local _C7Rg = _zLcm(_Vpwj, "\n")
                        if #_C7Rg < 0x1 then
                            if _8O4D then _8O4D(_3Z6P, _5NUD) end
                            return
                        end
                        for _gThg, _0IIX in pairs(_C7Rg) do
                            if string.len(_0IIX) > 0x2 then
                                _0IIX = string.gsub(_0IIX, "\t", "|")
                                local _uBPr = _zLcm(_0IIX, "|")
                                if #_uBPr > 0x1 then
                                    _3Z6P.data[_uBPr[0x1]] = {}
                                    _3Z6P.data[_uBPr[0x1]].text = _uBPr[0x2] or ""
                                    if string.len(_uBPr[0x2]) > 0x1 then
                                        local _Kf8n = _zLcm(_uBPr[0x2], ",")
                                        if #_Kf8n > 0x0 then
                                            for _3t3N, _oVrq in pairs(_Kf8n) do
                                                if string.len(_oVrq) > 0x2 then
                                                    local _fC9k = _zLcm(_oVrq, "-")
                                                    if #_fC9k > 0x1 then _3Z6P.data[_uBPr[0x1]][_fC9k[0x1]] = _fC9k[0x2] end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if _8O4D then _8O4D(_3Z6P, _5NUD) end
                end, "GET")
        end,
        Clear = function(_lueb)
            _lueb.content = ""
            _lueb.data = {}
        end,
    }
end
_ZO6U.GTData = _3K5n
local _6Xwt = function()
    return {
        path = "mod_config_data/",
        name = "dyc",
        SetName = function(_cJGn, _RJYE) _cJGn.name = _RJYE end,
        SetString = function(_8C3K, _mgTj, _de2v)
            TheSim:SetPersistentString(
                _8C3K.path .. _8C3K.name .. "_" .. _mgTj, _de2v, ENCODE_SAVES, function(_B1bx, _JxL9) end)
        end,
        GetString = function(_wOvW, _SOku, _WQ6P)
            TheSim:GetPersistentString(
                _wOvW.path .. _wOvW.name .. "_" .. _SOku, function(_7WsM, _Jy8f) if _WQ6P then _WQ6P(_7WsM and _Jy8f) end end)
        end,
        EraseString = function(_L572, _5b2l)
            TheSim:ErasePersistentString(
                _L572.path .. _L572.name .. "_" .. _5b2l, function(_HjOt) end)
        end,
    }
end
_ZO6U.LocalData = _6Xwt
local function _7Yiu(_gh2I)
    if _gh2I and _gh2I.AnimState and _gh2I.entity then
        local _6yww = _gh2I.entity:GetDebugString()
        local _hnxO, _hnxO, bank, build, anim, frame1, frame2 = _6yww:find("bank:%s?(%S*)%s?build:%s?(%S*)%s?anim:[^:]*:(%S*)%s?Frame:%s?([0-9%.]*)/([0-9%.]*)")
        bank = bank ~= "OUTOFSPACE" and bank or nil
        build = build ~= "OUTOFSPACE" and build or nil
        frame1 = frame1 and #frame1 > 0x0 and tonumber(frame1) or 0x0
        frame2 = frame2 and #frame2 > 0x0 and tonumber(frame2) or 0x0
        local _IyYk = frame2 > 0x0 and frame1 % frame2 / frame2 or 0x0
        return { bank = bank, build = build, anim = anim, frame1 = frame1, frame2 = frame2, percent = _IyYk }
    end
end
_ZO6U.GetAnimInfo = _7Yiu
return _ZO6U
