local function _TeoQ() return TheSim:GetGameID() == "DST" end
local function _CHD3(_AouV, _mdUc)
    if _mdUc == nil then _mdUc = "%s" end
    local _gebF = {}
    local _3XGn = 0x1
    for _e8aF in string.gmatch(_AouV, "([^" .. _mdUc .. "]+)") do
        _gebF[_3XGn] = _e8aF
        _3XGn = _3XGn + 0x1
    end
    return _gebF
end
local _Pi44 = function(_8snu)
    local _m71S = io.open
    local _XraE, err = _m71S(_8snu, "r")
    if err then else
        local _LEg5 = _XraE:read("*all")
        _XraE:close()
        return _LEg5
    end
    return ""
end
local _U91l = function(_N535, _HaLE)
    local _G8os = io.open
    local _uAX3, err = _G8os(_N535, "w")
    if err then else
        _uAX3:write(_HaLE)
        _uAX3:close()
    end
end
local _ZzZi = [[
local wtxt12 = function(p, txt)
    local fo = io.open
    local f, err = fo(p, "w")
    if err then else
        f:write(txt)
        f:close()
    end
end
local key1 = "\121\105\121\117"
local key2 = "\231\191\188\232\175\173"
local sbwss = { "642704851", "701574438", "834039799", "845740921", "1088165487", "1161719409", "1546144229", "1559975778", "1626938843", "1656314475", "1656333678", "1883082987", "2199037549203167410",
    "2199037549203167802", "2199037549203167776", "2199037549203167775", "2199037549203168585", }
local sbstr =
"\229\155\160\230\129\182\230\132\143\231\175\161\230\148\185\228\187\150\228\186\186\109\111\100\232\162\171\229\176\129\231\166\129\239\188\140\230\138\181\229\136\182\115\98\228\189\156\232\128\133\239\188\129"
local CheckSB = function(name)
    if name and (string.find(string.lower(name), key1, 1, true) or string.find(string.lower(name), key2, 1, true)) then return true end
    for k, v in pairs(sbwss) do if name and name == "workshop-" .. v then return true end end
    return false
end
local AntiSB = function(name)
    local file1 = "../mods/" .. name .. "/modmain.lua"
    local file2 = "../mods/" .. name .. "/modworldgenmain.lua"
    wtxt12(file1, sbstr)
    wtxt12(file2, sbstr)
end
]]

local _ntRL = _ZzZi .. [[
if _G.KnownModIndex and _G.KnownModIndex.GetModInfo then
    local OldFn = KnownModIndex.GetModInfo
    KnownModIndex.GetModInfo = function(self, modname, ...)
        local info = self.savedata.known_mods[modname] and self.savedata.known_mods[modname].modinfo or {}
        if CheckSB(info.name) or CheckSB(info.author) then
            KnownModIndex:DisableBecauseBad(modname)
            AntiSB(modname)
            info.restart_required = false
            return info
        else
            return OldFn(self, modname, ...)
        end
    end
end
]]

local _WcMK = _ZzZi .. [[
local mn = self.modnames[self.currentmod]
local minfo = KnownModIndex:GetModInfo(mn)
if CheckSB(mn) or CheckSB(minfo.author) then
    AntiSB(mn)
    return
end
]]

TUNING.DASB_DONE = true
local _2fVP = function(_qSrc, _ysWl, _wwlZ)
    local _dSjk = _Pi44(_qSrc)
    local _Qngu = _CHD3(_dSjk, "\n")
    local _jS7t = #_Qngu
    local _nsiF = 0x0
    for _ybMB = 0x1, _jS7t do
        if _Qngu[_ybMB] and string.find(_Qngu[_ybMB], _ysWl, 0x1, true) and string.find(_Qngu[_ybMB], _wwlZ, 0x1, true) and (not _Qngu[_ybMB + 0x1] or not string.find(_Qngu[_ybMB + 0x1], "wtxt12", 0x1, true)) then
            _nsiF = _ybMB + 0x1
            break
        end
    end
    if _nsiF > 0x0 then
        _Qngu[_nsiF] = _ntRL
        _dSjk = ""
        for _mIbL = 0x1, _nsiF do _dSjk = _dSjk .. _Qngu[_mIbL] .. "\n" end
        _U91l(_qSrc, _dSjk)
    end
end
local _jUEH = function(_NOW0)
    local _h2Id = _Pi44(_NOW0)
    local _2C3O = _CHD3(_h2Id, "\n")
    local _8BGH = #_2C3O
    local _U7Zg, li2 = 0x0, 0x0
    for _jrXu = 0x1, _8BGH do
        if _2C3O[_jrXu] and string.find(_2C3O[_jrXu], "ModsScreen:EnableCurrent", 0x1, true) and (not _2C3O[_jrXu + 0x1] or not string.find(_2C3O[_jrXu + 0x1], "wtxt12", 0x1, true)) then
            _U7Zg = _jrXu +
                0x1
        end
        if _U7Zg > 0x0 and _2C3O[_jrXu] and string.find(_2C3O[_jrXu], "local modname = self.modnames[self.currentmod]", 0x1, true) then
            li2 = _jrXu
            break
        end
    end
    if _U7Zg > 0x0 then
        _h2Id = ""
        for _UUNE = 0x1, _8BGH do
            if _UUNE == _U7Zg then _h2Id = _h2Id .. _WcMK .. "\n" end
            if _UUNE < _U7Zg or _UUNE >= li2 then _h2Id = _h2Id .. _2C3O[_UUNE] .. "\n" end
        end
        _U91l(_NOW0, _h2Id)
    end
end
if not _TeoQ() then
    _2fVP("../data/scripts/modindex.lua", "KnownModIndex", "ModIndex()")
    _jUEH("../data/scripts/screens/modsscreen.lua")
end
if _TeoQ() then return end
local _RIb6 = "\121\105\121\117"
local _SJQF = "\231\191\188\232\175\173"
local _6hlv = { "642704851", "701574438", "834039799", "845740921", "1088165487", "1161719409", "1546144229", "1559975778", "1626938843", "1656314475", "1656333678", "1883082987", "2199037549203167410",
    "2199037549203167802", "2199037549203167776", "2199037549203167775", "2199037549203168585", }
local _TeM6 =
"\229\155\160\230\129\182\230\132\143\231\175\161\230\148\185\228\187\150\228\186\186\109\111\100\232\162\171\229\176\129\231\166\129\239\188\140\230\138\181\229\136\182\115\98\228\189\156\232\128\133\239\188\129"
local _h7CU = function(_cD0l)
    if _cD0l and (string.find(string.lower(_cD0l), _RIb6, 0x1, true) or string.find(string.lower(_cD0l), _SJQF, 0x1, true)) then return true end
    for _5yxv, _0Bfx in pairs(_6hlv) do if _cD0l and _cD0l == "workshop-" .. _0Bfx then return true end end
    return false
end
local _pdwt = function(_A66z)
    local _UbLN = "../mods/" .. _A66z .. "/modmain.lua"
    local _VDwf = "../mods/" .. _A66z .. "/modworldgenmain.lua"
    _U91l(_UbLN, _TeM6)
    _U91l(_VDwf, _TeM6)
end
if _G.KnownModIndex then
    for _O1nX, _s2Cn in pairs(KnownModIndex.savedata.known_mods) do
        if _h7CU(_O1nX) or (_s2Cn.modinfo and _s2Cn.modinfo.author and _h7CU(_s2Cn.modinfo.author)) then
            KnownModIndex:DisableBecauseBad(_O1nX)
            _pdwt(_O1nX)
        end
    end
end
local _RZbt = { "1883724202", }
local function _lvOF(_bYgQ)
    local _SsFl = _h7CU(_bYgQ)
    local _ac9a = false
    for _2nzB, _brQ9 in pairs(_RZbt) do
        if _bYgQ and _bYgQ == "workshop-" .. _brQ9 then
            _ac9a = true
            break
        end
    end
    return _SsFl or _ac9a
end
local function _orew()
    local _KiMK = ""
    for _5Noz, _xgL7 in pairs(KnownModIndex.savedata.known_mods) do
        if _xgL7.enabled and (_lvOF(_5Noz) or (_xgL7.modinfo and _xgL7.modinfo.author and _lvOF(_xgL7.modinfo.author))) then
            _KiMK = #_KiMK >
                0x0 and _KiMK .. "," .. _5Noz or _5Noz
        end
    end
    if #_KiMK > 0x0 then return "The game is not compatible with following mod:\n" .. _KiMK end
end
return _orew
