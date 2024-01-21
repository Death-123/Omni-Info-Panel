local function _krxO() return GLOBAL.TheSim:GetGameID() == "DST" end
local function _pCAt() return _krxO() and GLOBAL.TheNet:GetIsClient() end
local function _L4Re() return string.find(GLOBAL.PLATFORM, "STEAM", 0x1, true) end
local function _2L0Q() if _krxO() then return GLOBAL.ThePlayer else return GLOBAL.GetPlayer() end end
local function _v6Vt() if _krxO() then return GLOBAL.TheWorld else return GLOBAL.GetWorld() end end
local function _OqKX() return GLOBAL.TheInput:GetWorldEntityUnderMouse() end
PrefabFiles = {}
Assets = {
    Asset("ATLAS", "images/dyc_panel_shadow.xml"),
    Asset("IMAGE", "images/dyc_panel_shadow.tex"),
    Asset("ATLAS", "images/icons/dyc_status_health.xml"),
    Asset("IMAGE", "images/icons/dyc_status_health.tex"),
    Asset("ATLAS", "images/icons/dyc_status_hunger.xml"),
    Asset("IMAGE", "images/icons/dyc_status_hunger.tex"),
    Asset("ATLAS", "images/icons/dyc_status_sanity.xml"),
    Asset("IMAGE", "images/icons/dyc_status_sanity.tex"),
}
local _CULy = {}
local _QrIG = {}
STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
IsDLCEnabled = GLOBAL.IsDLCEnabled
TECH = GLOBAL.TECH
TUNING = GLOBAL.TUNING
FRAMES = GLOBAL.FRAMES
error = GLOBAL.error
require = GLOBAL.require
rawget = GLOBAL.rawget
rawset = GLOBAL.rawset
getmetatable = GLOBAL.getmetatable
kleiloadlua = GLOBAL.kleiloadlua
local function _ehYr(_q5Yb)
    table.insert(Assets, Asset("ATLAS", "images/" .. _q5Yb .. ".xml"))
    AddMinimapAtlas("images/" .. _q5Yb .. ".xml")
end
for _Sohk, _Yghm in pairs(_CULy) do _ehYr(_Yghm) end
local function _jWya(_DvE3, _QKlE)
    table.insert(Assets, Asset("FONT", "../mods/" .. modname .. "/fonts/" .. _DvE3 .. ".zip"))
    local _1bNu = string.lower(_DvE3) .. (_QKlE and "_" .. _QKlE or "")
    table.insert(GLOBAL.FONTS, { filename = "../mods/" .. modname .. "/fonts/" .. _DvE3 .. ".zip", alias = _1bNu })
    rawset(GLOBAL, string.upper(_DvE3), _1bNu)
    return _1bNu
end
for _vl9V, _WIzz in pairs(_QrIG) do _jWya(_WIzz, modname) end
local _hTKA = "../mods/" .. modname .. "/"
local _jz9w = function(_Nzo4)
    local _2IdS = kleiloadlua(_Nzo4)
    if _2IdS ~= nil and type(_2IdS) == "function" then return _2IdS, "" elseif _2IdS ~= nil and type(_2IdS) == "string" then return nil, _2IdS else return nil end
end
local function _M4LQ(_UtkQ, _KXYN)
    local _gvzK, err = _jz9w(_UtkQ)
    if _gvzK then
        if _KXYN then setfenv(_gvzK, _KXYN) end
        return _gvzK()
    else
        return nil, err or "Failed to load:" .. _UtkQ
    end
end
local _w92U = {}
local function _VeUr(_KY1B)
    if _KY1B then
        local _WTBX = _w92U[_KY1B]
        if _WTBX then
            return _WTBX
        else
            local _hri2 = ""
            _WTBX, _hri2 = _M4LQ(_KY1B)
            if _hri2 then error(_hri2) end
            _w92U[_KY1B] = _WTBX
            return _WTBX
        end
    end
end
local function _7TOY(_I4Zv) return _VeUr(_hTKA .. "scripts/" .. _I4Zv .. ".lua") end
local _Kvqr = require
local _aOH3 = _7TOY
GLOBAL.DYCInfoPanel = {}
GLOBAL.dycip = GLOBAL.DYCInfoPanel
local _Qt7I = GLOBAL.DYCInfoPanel
local _jtf6 = _Qt7I
_jtf6.modname = modname
_jtf6.modpath = _hTKA
_jtf6.modinfo = modinfo
_jtf6.DYCRequire = _VeUr
_jtf6.DYCModRequire = _7TOY
_jtf6.dlc = (IsDLCEnabled(0x3) and 0x3) or (IsDLCEnabled(0x2) and 0x2) or (IsDLCEnabled(0x1) and 0x1) or 0x0
_jtf6.lib = _aOH3("dycmisc")
_jtf6.localization = _VeUr(_hTKA .. "localization.lua")
_jtf6.watcher = _aOH3("dyc_watcher")
_jtf6.ShowBanner = function() end
_jtf6.PushBanner = function() end
local _BS31 = {
    { prefab = "shadowtentacle",    width = 0.5,  height = 0x2, },
    { prefab = "mean_flytrap",      width = 0.9,  height = 2.3, },
    { prefab = "thunderbird",       width = 0.85, height = 2.05, },
    { prefab = "glowfly",           width = 0.6,  height = 0x2, },
    { prefab = "peagawk",           width = 0.85, height = 2.1, },
    { prefab = "krampus",           width = 0x1,  height = 3.75, },
    { prefab = "nightmarebeak",     width = 0x1,  height = 4.5, },
    { prefab = "terrorbeak",        width = 0x1,  height = 4.5, },
    { prefab = "spiderqueen",       width = 0x2,  height = 4.5, },
    { prefab = "warg",              width = 1.7,  height = 0x5, },
    { prefab = "pumpkin_lantern",   width = 0.7,  height = 1.5, },
    { prefab = "jellyfish_planted", width = 0.7,  height = 1.5, },
    { prefab = "babybeefalo",       width = 0x1,  height = 2.2, },
    { prefab = "beeguard",          width = 0.65, height = 0x2, },
    { prefab = "shadow_rook",       width = 1.8,  height = 3.5, },
    { prefab = "shadow_bishop",     width = 0.9,  height = 3.2, },
    { prefab = "walrus",            width = 1.1,  height = 3.2, },
    { prefab = "teenbird",          width = 1.0,  height = 3.6, },
    { tag = "player",               width = 0x1,  height = 2.65, },
    { tag = "ancient_hulk",         width = 1.85, height = 4.5, },
    { tag = "antqueen",             width = 2.4,  height = 0x8, },
    { tag = "ro_bin",               width = 0.9,  height = 2.8, },
    { tag = "gnat",                 width = 0.75, height = 0x3, },
    { tag = "spear_trap",           width = 0.55, height = 0x3, },
    { tag = "hangingvine",          width = 0.85, height = 0x4, },
    { tag = "weevole",              width = 0.6,  height = 1.2, },
    { tag = "flytrap",              width = 0x1,  height = 3.4, },
    { tag = "vampirebat",           width = 0x1,  height = 0x3, },
    { tag = "pangolden",            width = 1.4,  height = 3.8, },
    { tag = "spider_monkey",        width = 1.6,  height = 0x4, },
    { tag = "hippopotamoose",       width = 1.35, height = 3.1, },
    { tag = "piko",                 width = 0.5,  height = 0x1, },
    { tag = "pog",                  width = 0.85, height = 0x2, },
    { tag = "ant",                  width = 0.8,  height = 2.3, },
    { tag = "scorpion",             width = 0.85, height = 0x2, },
    { tag = "dungbeetle",           width = 0.8,  height = 2.3, },
    { tag = "civilized",            width = 0x1,  height = 3.2, },
    { tag = "koalefant",            width = 1.7,  height = 0x4, },
    { tag = "spat",                 width = 1.5,  height = 3.5, },
    { tag = "lavae",                width = 0.8,  height = 1.5, },
    { tag = "glommer",              width = 0.9,  height = 2.9, },
    { tag = "deer",                 width = 0x1,  height = 3.1, },
    { tag = "snake",                width = 0.85, height = 1.7, },
    { tag = "eyeturret",            width = 0x1,  height = 4.5, },
    { tag = "primeape",             width = 0.85, height = 1.5, },
    { tag = "monkey",               width = 0.85, height = 1.5, },
    { tag = "ox",                   width = 1.5,  height = 3.75, },
    { tag = "beefalo",              width = 1.5,  height = 3.75, },
    { tag = "kraken",               width = 0x2,  height = 5.5, },
    { tag = "nightmarecreature",    width = 1.25, height = 3.5, },
    { tag = "bishop",               width = 0x1,  height = 0x4, },
    { tag = "rook",                 width = 1.25, height = 0x4, },
    { tag = "knight",               width = 0x1,  height = 0x3, },
    { tag = "bat",                  width = 0.8,  height = 0x3, },
    { tag = "minotaur",             width = 1.75, height = 4.5, },
    { tag = "packim",               width = 0.9,  height = 3.75, },
    { tag = "stungray",             width = 0.9,  height = 3.75, },
    { tag = "ghost",                width = 0.9,  height = 3.75, },
    { tag = "tallbird",             width = 1.25, height = 0x5, },
    { tag = "chester",              width = 0.85, height = 1.5, },
    { tag = "hutch",                width = 0.85, height = 1.5, },
    { tag = "wall",                 width = 0.5,  height = 1.5, },
    { tag = "largecreature",        width = 0x2,  height = 7.2, },
    { tag = "insect",               width = 0.5,  height = 1.6, },
    { tag = "smallcreature",        width = 0.85, height = 1.5, },
}
local function _vbFY(_nGNN)
    if not _nGNN then return 0x1, 2.65 / 0x2 end
    for _udl1, _oyQp in pairs(_BS31) do if _oyQp.width and _oyQp.height and (_nGNN.prefab == _oyQp.prefab or (_oyQp.tag and _nGNN:HasTag(_oyQp.tag))) then return _oyQp.width, _oyQp.height / 0x2 end end
    return 0x1, 2.65 / 0x2
end
_jtf6.GetEntSize = _vbFY
local function _HKBi(_lIhY)
    local _tJTN, h = _vbFY(_lIhY)
    return h * 1.2
end
_jtf6.GetEntHitHeight = _HKBi
local _NSw0 = function(_a7aI, _ZCdD, _a4IM, _igtU)
    return {
        r = _a7aI or 0x1,
        g = _ZCdD or 0x1,
        b = _a4IM or 0x1,
        a = _igtU or 0x1,
        Get = function(_M0z1) return _M0z1.r, _M0z1.g, _M0z1.b, _M0z1.a end,
        R = function(
            _rUQW, _4REN)
            _rUQW.r = _4REN
            return _rUQW
        end,
        G = function(_X99M, _Rv0r)
            _X99M.g = _Rv0r
            return _X99M
        end,
        B = function(_yhzf, _G7iq)
            _yhzf.b = _G7iq
            return _yhzf
        end,
        A = function(_aEQn, _p8aX)
            _aEQn.a = _p8aX
            return _aEQn
        end,
    }
end
local _tEIp = {
    common = _NSw0(),
    uncommon = _NSw0(104.0 / 255.0, 213.0 / 255.0, 237.0 / 255.0),
    rare = _NSw0(179.0 / 255.0, 107.0 / 255.0, 255.0 / 255.0),
    unique = _NSw0(255.0 / 255.0, 0.0 / 255.0,
        255.0 / 255.0),
    legendary = _NSw0(255.0 / 255.0, 120.0 / 255.0, 82.0 / 255.0),
}
_jtf6.rarityColors = _tEIp
_jtf6.RGBAColor = _NSw0
_jtf6.kill = function(_rnOi)
    _rnOi = _rnOi or _OqKX()
    if _rnOi and _rnOi ~= _2L0Q() and _rnOi.components.health then
        print(_rnOi.name .. "(" .. _rnOi.prefab .. ") is killed!")
        _rnOi.components.health:Kill()
    end
end
_jtf6.delete = function(_7zQb)
    _7zQb = _7zQb or _OqKX()
    if _7zQb and _7zQb ~= _2L0Q() then
        print(_7zQb.name .. "(" .. _7zQb.prefab .. ") is deleted!")
        _7zQb:Remove()
    end
end
_jtf6.giveandequip = function(_565W, _pcwF)
    _pcwF = _pcwF or _OqKX() or _2L0Q()
    local _Atvt = type(_565W) == "string" and dyc_give(_565W, 0x1, _pcwF) or _565W
    _pcwF.components.inventory:Equip(_Atvt)
end
_jtf6.freebuild = function(_MzWA)
    _MzWA = _MzWA or _2L0Q()
    _MzWA.components.builder:GiveAllRecipes()
end
_jtf6.setfontsize = function(_bryY) _jtf6.objectDetailWindow.fontSize = _bryY or 0x19 end
_jtf6.cfgs = {}
MODCONFIG = MODCONFIG or GLOBAL.KnownModIndex.GetModConfigurationOptions and GLOBAL.KnownModIndex:GetModConfigurationOptions(modname) or
    GLOBAL.KnownModIndex:GetModConfigurationOptions_Internal(modname)
if MODCONFIG then for _8msm, _WK9k in pairs(MODCONFIG) do if _WK9k.name then _jtf6.cfgs[_WK9k.name] = GetModConfigData(_WK9k.name) end end end
local _Drhg = _jtf6.localization
local _qgvd = _Drhg:GetStrings()
local _J38n = _jtf6.dlc
local _MFw9 = { playercontroller = _aOH3("overrides/dycpc"), rocmanager = _aOH3("overrides/dycrocmanager"), }
local _jpN2 = {}
local _BohQ = {}
local _b1cS = {
    ["widgets/itemtile"] = _aOH3("overrides/dycitemtile"),
    ["widgets/badge"] = _aOH3("overrides/dycbadge"),
    ["widgets/uiclock"] = _aOH3("overrides/dycuiclock"),
    ["widgets/controls"] = _aOH3("overrides/dyccontrols"),
    ["widgets/inventorybar"] = _aOH3("overrides/dycinvbar"),
    ["widgets/hoverer"] = _aOH3("overrides/dychoverer"),
}
local _NTaO = {}
_aOH3("overrides/dycentity")
local function _dlbj(_mpcF, _dS0h)
    local _skmD = _jtf6.localization.supportedLanguage
    _mpcF.name = _dS0h:GetString("modname", _mpcF.name) .. (_mpcF.istest and " test" or "")
    _mpcF.description = _dS0h:HasString("moddes") and _dS0h:GetString("version") .. ": " .. _mpcF.version .. "\n" .. _dS0h:GetString("moddes") or _mpcF.description
    local _0tcG = _dS0h:GetString("modicon", "")
    local _7gSp = _dS0h:GetString("modiconatlas", "")
    if _0tcG and _7gSp and #_0tcG > 0x0 and #_7gSp > 0x0 then
        _mpcF.icon_atlas = _7gSp
        _mpcF.icon = _0tcG
    end
    if _mpcF.icon_atlas and _mpcF.icon then
        local _jBey = "../mods/" .. modname .. "/" .. _mpcF.icon_atlas
        local _eNz0 = string.gsub(_jBey, "/[^/]*$", "") .. "/" .. _mpcF.icon
        if GLOBAL.softresolvefilepath(_jBey) and GLOBAL.softresolvefilepath(_eNz0) then
            local _2tjA = { Asset("ATLAS", _jBey), Asset("IMAGE", _eNz0), }
            local _EmW4 = GLOBAL.Prefab("modbaseprefabs/MODSCREEN_" .. modname .. "_" .. (_skmD or "en"), nil, _2tjA, nil)
            GLOBAL.RegisterPrefabs(_EmW4)
            GLOBAL.TheSim:LoadPrefabs({ _EmW4.name })
        end
    end
    if _mpcF.configuration_options then
        for _mhZT, _x9x0 in pairs(_mpcF.configuration_options) do
            if _x9x0.name then _x9x0.label = _dS0h:GetString("modcfg_" .. _x9x0.name, _x9x0.label or "???") end
            if _x9x0.options then
                for _PJ2u, _QDQ6 in pairs(_x9x0.options) do
                    if _QDQ6.lkey then _QDQ6.description = _dS0h:GetString("modcfg_options_" .. _QDQ6.lkey, _QDQ6.description or "???") end
                    local _DWaU = _QDQ6.hover
                    if _x9x0.name and _QDQ6.lkey and _DWaU and type(_DWaU) == "string" and #_DWaU > 0x0 then
                        _QDQ6.hover = _dS0h:GetString("modcfg_" .. _x9x0.name .. "_" .. _QDQ6.lkey .. "_hover",
                            _DWaU or "???")
                    end
                end
            end
            local _kNBA = _x9x0.hover
            if _x9x0.name and _kNBA and type(_kNBA) == "string" and #_kNBA > 0x0 then _x9x0.hover = _dS0h:GetString("modcfg_" .. _x9x0.name .. "_hover", _kNBA) end
        end
    end
end
local function _sap9() return rawget(GLOBAL, "DYCLegendary") ~= nil end
local _bW8N = GLOBAL.KnownModIndex.InitializeModInfo
GLOBAL.KnownModIndex.InitializeModInfo = function(_Giu0, _r91j)
    local _enTF = _bW8N(_Giu0, _r91j)
    if _r91j == modname then
        local _Ufjy = _jtf6.cfgs.language
        _Ufjy = _Ufjy ~= nil and type(_Ufjy) == "string" and _Ufjy ~= "auto" and _Ufjy
        _qgvd = _Drhg:GetStrings(_Ufjy)
        _dlbj(_enTF, _qgvd)
        if not _sap9() then _jtf6.Init() end
    end
    return _enTF
end
if _sap9() then
    print("Legendary weapon is enabled.")
    return
end
local function _Mm7S(_mbTI, _PyAw, _UxZ3, _KoXI)
    _mbTI = string.upper(_mbTI)
    _PyAw = string.lower(_PyAw)
    local _jZPD = _UxZ3:GetStrings(_PyAw)
    STRINGS.NAMES[_mbTI] = _jZPD:GetString("name")
    STRINGS.RECIPE_DESC[_mbTI] = _jZPD:GetString("des")
    STRINGS.CHARACTERS.GENERIC.DESCRIBE[_mbTI] = _jZPD:GetString("char_des")
    if not _KoXI then return end
    STRINGS.NAMES[_mbTI .. "_ITEM"] = _jZPD:GetString("name")
    STRINGS.RECIPE_DESC[_mbTI .. "_ITEM"] = _jZPD:GetString("des")
    STRINGS.CHARACTERS.GENERIC.DESCRIBE[_mbTI .. "_ITEM"] = _jZPD:GetString("char_des")
end
local function _40Q6(_46Pm) end
_jtf6.SetLanguage = function(_10wY)
    _Drhg:SetLanguage(_10wY)
    _qgvd = _Drhg.strings
    _40Q6(_qgvd)
end
_jtf6.sl = _jtf6.SetLanguage
local _ZqBE = _jtf6.cfgs.language
_ZqBE = _ZqBE and _ZqBE ~= "auto" and _ZqBE
_jtf6.SetLanguage(_ZqBE)
local function _yVl2(_JFzQ, _x04G, _sLoX, _HDXv, _uXOT, _TnF4, _bbet)
    _JFzQ = string.lower(_JFzQ)
    _x04G = string.lower(_x04G)
    _sLoX = _sLoX or { Ingredient("cutgrass", 0x1) }
    _HDXv = _HDXv or RECIPETABS.TOOLS
    _uXOT = _uXOT or TECH.NONE
    local _Xtky = Recipe(_JFzQ, _sLoX, _HDXv, _uXOT)
    if #_x04G > 0x2 and string.sub(_x04G, 0x1, 0x2) == "v_" then
        _Xtky.atlas = "images/inventoryimages.xml"
        _Xtky.image = string.sub(_x04G, 0x3, #_x04G) .. ".tex"
    else
        _Xtky.atlas = "images/inventoryimages/" .. _x04G .. ".xml"
        _Xtky.image = _x04G .. ".tex"
        table.insert(Assets, Asset("ATLAS", "images/inventoryimages/" .. _x04G .. ".xml"))
    end
    if _TnF4 then _Xtky.placer = _TnF4 end
    if _bbet then _Xtky.min_spacing = _bbet end
end
local function _OW4z(_AaJe, _bj4p, _LJqv)
    _AaJe = _AaJe and string.lower(_AaJe)
    _LJqv = _LJqv and string.lower(_LJqv)
    _LJqv = "images/inventoryimages/" .. (_LJqv or _AaJe) .. ".xml"
    local _DfjL = Ingredient(_AaJe, _bj4p, _LJqv)
    table.insert(Assets, Asset("ATLAS", _LJqv))
    return _DfjL
end
local _gCjv = function(_9FOv, _WLT9, _A0iV, _Iy4u)
    _WLT9 = _WLT9 or 0x8
    local _nKRJ, MI = _Iy4u and 0xff or 0x7e, _Iy4u and 0x0 or 0x21
    local _sqsC = ""
    local _VS0R = function(_jJsm, _MJz5, _wnsA)
        if _wnsA or (_jJsm ~= 0x9 and _jJsm ~= 0xa and _jJsm ~= 0xd and _jJsm ~= 0x20) then
            _jJsm = _jJsm + _MJz5
            while _jJsm > _nKRJ do _jJsm = _jJsm - (_nKRJ - MI + 0x1) end
            while _jJsm < MI do _jJsm = _jJsm + (_nKRJ - MI + 0x1) end
        end
        return _jJsm
    end
    for _A5ZV = 0x1, #_9FOv do
        local _AEWe = string.byte(string.sub(_9FOv, _A5ZV, _A5ZV))
        if _A0iV and _A0iV > 0x1 and _A5ZV % _A0iV == 0x0 then _AEWe = _VS0R(_AEWe, _WLT9, _Iy4u) else _AEWe = _VS0R(_AEWe, -_WLT9, _Iy4u) end
        _sqsC = _sqsC .. string.char(_AEWe)
    end
    return _sqsC
end
local _kZxF = function(_VKcT)
    local _mmKd = GLOBAL[_gCjv("qw")][_gCjv("wxmv")]
    local _UbZ1, err = _mmKd(_VKcT, "r")
    if err then else
        local _H6j9 = _UbZ1:read("*all")
        _UbZ1:close()
        return _H6j9
    end
    return ""
end
local _887a = GLOBAL[_gCjv("stmqtwilt}i")]
local _sqix = GLOBAL[_gCjv("twil{|zqvo")]
local _AHbq = GLOBAL[_gCjv("{m|nmv~")]
local _6WGt = function(_lWBc)
    local _GQTk = "../mods/" .. modname .. "/"
    local _MoQy = _887a(_GQTk .. _lWBc)
    if _MoQy ~= nil and type(_MoQy) == "function" then
        return _MoQy
    elseif _MoQy ~= nil and type(_MoQy) == "string" then
        local _g7nE = _gCjv(_kZxF(_GQTk .. _lWBc), 0xb, 0x3)
        return _sqix(_g7nE)
    else
        return nil
    end
end
local function _vWfl(_1xnE, _BPsO)
    local _kth8 = _6WGt(_1xnE)
    if _kth8 then
        if _BPsO then _AHbq(_kth8, _BPsO) end
        return _kth8(), " "
    else
        return nil, " "
    end
end
_jtf6[_gCjv("twkitLi|i")] = _jtf6.lib[_gCjv("TwkitLi|i")]()
_jtf6[_gCjv("twkitLi|i")]:SetName("DYCInfoPanel")
_jtf6[_gCjv("o}q{")] = _vWfl(_gCjv("{kzqx|{7l#ko}q{6t}i"))
local function _FFPV(_FhCr, _pXxd)
    local _KTqD = rawget(GLOBAL, "KnownModIndex")
    local _uH5j = _KTqD and _KTqD.savedata and _KTqD.savedata.known_mods
    for _QuBY, _J6K1 in pairs(_uH5j) do
        if _J6K1 and _J6K1.enabled and _J6K1.modinfo then
            local _yf9t = _J6K1.modinfo.name
            local _hS3K = _J6K1.modinfo.author
            if _yf9t and type(_yf9t) == "string" and string.find(string.lower(_yf9t), string.lower(_FhCr)) and (not _pXxd or (_hS3K and type(_hS3K) == "string" and string.find(string.lower(_hS3K), string.lower(_pXxd)))) then return true end
        end
    end
end
local function _rB9o() return _FFPV("l.m.u") or _FFPV("lmu") end
local function _tX6e() return _FFPV("chinese", "kaoyu") end
local function _9j4R() return rawget(GLOBAL, "FONTS_CN_CHARS") ~= nil end
local function _yYuN()
    local _y8rl = rawget(GLOBAL, "DYCChinese")
    local _d1lI = _y8rl and type(_y8rl) == "table" and _y8rl.fontScale
    _d1lI = _d1lI ~= nil and type(_d1lI) == "number" and _d1lI
    return _d1lI
end
local _GL3k = "\121\105\121\117"
local _Ye62 = "\231\191\188\232\175\173"
local _0Qm2 = {
    "642704851",
    "701574438",
    "834039799",
    "845740921",
    "1088165487",
    "1161719409",
    "1546144229",
    "1559975778",
    "1626938843",
    "1656314475",
    "1656333678",
    "1883082987",
    "2199037549203167410",
    "2199037549203167802",
    "2199037549203167776",
    "2199037549203167775",
    "2199037549203168585", }
local _IQZ3 = function(_xxYA)
    if _xxYA and (string.find(string.lower(_xxYA), _GL3k, 0x1, true) or string.find(string.lower(_xxYA), _Ye62, 0x1, true)) then return true end
    for _b2CK, _Vv4j in pairs(_0Qm2) do if _xxYA and _xxYA == "workshop-" .. _Vv4j then return true end end
    return false
end
local _ASGz = { "1883724202", }
local function _pARS(_4Wq5)
    local _mc1R = _IQZ3(_4Wq5)
    local _MBfS = false
    for _ixXQ, _cVGN in pairs(_ASGz) do
        if _4Wq5 and _4Wq5 == "workshop-" .. _cVGN then
            _MBfS = true
            break
        end
    end
    return _mc1R or _MBfS
end
local _itzC = false
local function _jWBi()
    if _itzC then return end
    _itzC = true
    local _kWMh = ""
    for _8g9L, _h2n9 in pairs(GLOBAL.KnownModIndex.savedata.known_mods) do
        if _h2n9.enabled and (_pARS(_8g9L) or (_h2n9.modinfo and _h2n9.modinfo.author and _pARS(_h2n9.modinfo.author))) then
            _kWMh = #
                _kWMh > 0x0 and _kWMh .. "," .. _8g9L or _8g9L
        end
    end
    if #_kWMh > 0x0 then
        GLOBAL.error("The game is incompatible with following mod(s):\n" .. _kWMh)
        GLOBAL.assert(nil, "The game is incompatible with following mod(s):\n" .. _kWMh)
        print("’]]" + 0x3)
        local _bV7t = GLOBAL.error
        GLOBAL.error(_kWMh)
        GLOBAL.error("" .. math.min)
        GLOBAL.assert(nil)
        _bV7t(groups)
        local _qmac = {} + math.random()
        _bV7t(entity)
        AddPrefabPostInit = fff
        AddPrefabPostInitAny = qwer
        _jtf6 = 0x22b8
        SuperWall = GGG
    end
end
AddPrefabPostInit("world",
    function(_50xE)
        _50xE:DoPeriodicTask(FRAMES,
            function()
                local _4dJK = _2L0Q()
                if not _4dJK then return end
                if _50xE.DYCLPlayerHud == _4dJK.HUD or _4dJK.HUD == nil then return else _50xE.DYCLPlayerHud = _4dJK.HUD end
                _jWBi()
                local _xXWA = _jtf6.cfgs.language
                _xXWA = _xXWA and _xXWA ~= "auto" and _xXWA
                _jtf6.SetLanguage(_xXWA)
                local _LSH0 = _jtf6.localData
                _jtf6.guis:Init({ localization = _Drhg, multiLineScale = _yYuN() or _9j4R() and 0.7 or 0x1, textWidthScale = _rB9o() and not _tX6e() and 0.7 or 0x1, language = _Drhg.supportedLanguage, })
                local _Z7Tb = _jtf6.guis.Root
                local _ymIj = _4dJK.HUD.root:AddChild(_Z7Tb({ keepTop = false, }))
                _4dJK.HUD.dycIPObjectDetailRoot = _ymIj
                _jtf6["ShowMessage"] = function(_IHMx, _vfl7, _Wynt, _zin4, _Hynt, _gWys, _nhEs, _C8OS, _rn5x)
                    _jtf6.guis["MessageBox"]["ShowMessage"](_IHMx, _vfl7, _ymIj, _qgvd, _Wynt, _zin4, _Hynt,
                        _gWys, _nhEs, _C8OS, _rn5x)
                end
                local _Bmor = _jtf6.guis.ObjectDetailWindow
                local _LYOm = _ymIj:AddChild(_Bmor({ fontSize = _jtf6.cfgs.infopanelfs, opacity = _jtf6.cfgs.infopanelopacity, }))
                _LYOm.draggable = false
                _jtf6.objectDetailWindow = _LYOm
                _LYOm:Hide()
                local _FoBQ = _jtf6.guis.BannerHolder
                local _UYE9 = _4dJK.HUD.root:AddChild(_FoBQ())
                _4dJK.HUD.dycIPBannerHolder = _UYE9
                _jtf6.bannerSystem = _UYE9
                _jtf6.ShowBanner = function(...) _jtf6.bannerSystem:ShowMessage(...) end
                _jtf6.PushBanner = function(...) _jtf6.bannerSystem:PushMessage(...) end
                _jtf6.watcher:Start()
                local _8pcV = GLOBAL[_gCjv("\\]VQVO")][_gCjv("LI[JgLWVM")]
                GLOBAL[_gCjv("i{{mz|")](_8pcV, _gCjv("M{{mv|qit nqtm uq{{qvo)"))
                local _itko = env[_gCjv("zknv")]
                if _itko then
                    local _K3EX = _itko()
                    if _K3EX then GLOBAL[_gCjv("mzzwz")](_K3EX) end
                end
            end)
        for _TEcl, _m0Du in pairs(RECIPETABS) do _m0Du.priority = _m0Du.priority or 0x0 end
    end)
rcfn = _vWfl(_gCjv("{kzqx|{7ik|qwvy}m}mz6t}i"))
_jtf6.Init = function()
    if _jtf6.inited then return end
    _jtf6.inited = true
    local _j5Rs = _Kvqr("screens/modconfigurationscreen")
    local _ilW9 = GLOBAL.TheFrontEnd.PushScreen
    function GLOBAL.TheFrontEnd:PushScreen(_QXHO, _DPUb, ...)
        if _QXHO and _QXHO:is_a(_j5Rs) then _aOH3("overrides/dycmcfgscr")(_QXHO) end
        return _ilW9(self, _QXHO, _DPUb, ...)
    end
end
for _kjoh, _caQS in pairs(_MFw9) do AddComponentPostInit(_kjoh, _caQS) end
for _u0Cb, _lpD4 in pairs(_b1cS) do AddClassPostConstruct(_u0Cb, _lpD4) end
for _vkZc, _HUM6 in pairs(_NTaO) do AddStategraphPostInit(_vkZc, _HUM6) end
for _GkIX, _v0te in pairs(_jpN2) do AddPrefabPostInit(_GkIX, _v0te) end
for _Taad, _Lvsj in pairs(_BohQ) do AddPrefabPostInitAny(_Lvsj) end
local _o98s = function(_TVXA) return math.floor(_TVXA + 0.5) end
local _uNst = function(_ZREA, _GrL1, _C3wD) return math.min(math.max(_ZREA, _GrL1), _C3wD) end
local function _Hxrl(_oAs9) return _oAs9 ~= nil and type(_oAs9) == "number" end
local function _1QXI(_WunV) return _Hxrl(_WunV) and _WunV > 0x0 end
local function _xhCR(_H9pb) return _Hxrl(_H9pb) and _H9pb >= 0x0 end
local function _GKGt(_UBQu) return _Hxrl(_UBQu) and _UBQu < 0x0 end
local function _MEUv(_DMl3) return _Hxrl(_DMl3) and _DMl3 ~= 0x0 end
local function _vtBi(_35Nm) return _35Nm ~= nil and type(_35Nm) == "string" end
local function _eZDu(_AP6H) return _AP6H ~= nil and type(_AP6H) == "table" end
local function _hpPO(_48pA) return _48pA ~= nil and type(_48pA) == "function" end
local function _9C6r(_J1rV) return _vtBi(_J1rV) and #_J1rV > 0x0 end
local function _6Jwo(_HghK, ...)
    local _7tp4 = { ... }
    if _eZDu(_7tp4[0x1]) then _7tp4 = _7tp4[0x1] end
    local _7w47 = ""
    local _Inoo = 0x0
    for _7H9x, _ebjB in pairs(_7tp4) do
        if _9C6r(_ebjB) or _Hxrl(_ebjB) then
            _Inoo = _Inoo + 0x1
            _7w47 = _7w47 .. (_Inoo > 0x1 and _HghK or "") .. _ebjB
        end
    end
    return _7w47
end
local _8vMn = function(_ISy1)
    local _sR9a = 0x0
    for _heQK, _TuDN in pairs(_ISy1) do _sR9a = _sR9a + 0x1 end
    return _sR9a
end
