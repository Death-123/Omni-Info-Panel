local _mvhj = DYCInfoPanel
local _hPVf = require("cooking")
local _bXxO = _mvhj.RGBAColor
local function _YrUT() return TheSim:GetGameID() == "DST" end
local function _vrag() if _YrUT() then return ThePlayer else return GetPlayer() end end
local function _FXhO() if _YrUT() then return TheWorld else return GetWorld() end end
local function _0TKP() if _YrUT() then return _G.AllRecipes else return _G.GetAllRecipes() end end
local _dSG2 = {
    pigman = {
        GetValue = function(_mdNf)
            if _mdNf and _mdNf.components and (not _mdNf.components.werebeast or not _mdNf.components.werebeast:IsInWereState()) then return 0x3 end
        end,
    },
    ballphin = {
        GetValue = function(_t5Rk)
            if _t5Rk and _t5Rk.components and _t5Rk.components.follower and _t5Rk.components.follower.previousleader == _vrag() then return 0x3 end
        end,
    },
    babybeefalo = { value = 0x6 },
    teenbird = { value = 0x2 },
    smallbird = { value = 0x6 },
    beefalo = { value = 0x4 },
    crow = { value = 0x1 },
    robin = { value = 0x2 },
    robin_winter = { value = 0x2 },
    butterfly = { value = 0x1 },
    rabbit = { value = 0x1 },
    mole = { value = 0x1 },
    tallbird = { value = 0x2 },
    bunnyman = { value = 0x3 },
    penguin = { value = 0x2 },
    glommer = { value = 0x32 },
    catcoon = { value = 0x5 },
    toucan = { value = 0x1 },
    parrot = { value = 0x2 },
    parrot_pirate = { value = 0x6 },
    seagull = { value = 0x1 },
    crab = { value = 0x1 },
    solofish = { value = 0x2 },
    swordfish = { value = 0x4 },
    whale_white = { value = 0x6 },
    whale_blue = { value = 0x7 },
    jellyfish_planted = { value = 0x1 },
    rainbowjellyfish_planted = { value = 0x1 },
    ox = { value = 0x4 },
    lobster = { value = 0x2 },
    primeape = { value = 0x2 },
    doydoy = {
        GetValue = function(_p076)
            local _KwGO = _FXhO()
            if _KwGO and _KwGO.components and _KwGO.components.doydoyspawner then return _KwGO.components.doydoyspawner:GetInnocenceValue() end
        end,
    },
    twister_seal = { value = 0x32 },
    glowfly = { value = 0x1 },
    pog = { value = 0x2 },
    pangolden = { value = 0x4 },
    kingfisher = { value = 0x2 },
    pigeon = { value = 0x1 },
    dungbeetle = { value = 0x3 },
    shopkeep = { value = 0x6 },
    piko = { value = 0x1 },
    piko_orange = { value = 0x2 },
    hippopotamoose = { value = 0x4 },
    mandrakeman = { value = 0x3 },
    peagawk = { value = 0x3 },
}
local _EGNV = {
    "player",
    "character",
    "companion",
    "pet",
    "hostile",
    "monster",
    "prey",
    "epic",
    "largecreature",
    "smallcreature",
    "seacreature",
    "shadowcreature",
    "animal",
    "flying",
    "amphibious",
    "insect",
    "bee",
    "spider",
    "hound",
    "beefalo",
    "pig",
    "manrabbit",
    "merm",
    "snake",
    "ant",
    "ghost",
    "structure",
    "prototyper",
    "shelter",
    "fridge",
    "tree",
    "plant",
    "molebait",
    "poisonous",
    "irreplaceable"
}
local _Ju5z = function(_nDsy) return math.floor(_nDsy + 0.5) end
local _egct = function(_rEBU, _OOzz, _KZ0P) return math.min(math.max(_rEBU, _OOzz), _KZ0P) end
local function _0ldE(_m5lG) return _m5lG ~= nil and type(_m5lG) == "number" end
local function _eUt1(_hn10) return _0ldE(_hn10) and _hn10 > 0x0 end
local function _Msfj(_YNOg) return _0ldE(_YNOg) and _YNOg >= 0x0 end
local function _4Va0(_golT) return _0ldE(_golT) and _golT < 0x0 end
local function _EqJc(_zYmi) return _0ldE(_zYmi) and _zYmi ~= 0x0 end
local function _4FoG(_lJMA) return _lJMA ~= nil and type(_lJMA) == "string" end
local function _WJWr(_TR0m) return _TR0m ~= nil and type(_TR0m) == "table" end
local function _G7JA(_5vz0) return _5vz0 ~= nil and type(_5vz0) == "function" end
local function _JJx1(_OZAY) return _4FoG(_OZAY) and #_OZAY > 0x0 end
local function _f6os(_zi4v, ...)
    local _jKdH = { ... }
    if _WJWr(_jKdH[0x1]) then _jKdH = _jKdH[0x1] end
    local _B39W = ""
    local _zwGC = 0x0
    for _oWnJ, _gx6L in pairs(_jKdH) do
        if _JJx1(_gx6L) or _0ldE(_gx6L) then
            _zwGC = _zwGC + 0x1
            _B39W = _B39W .. (_zwGC > 0x1 and _zi4v or "") .. _gx6L
        end
    end
    return _B39W
end
local _lVV7 = function(_i8lW)
    local _DIWy = 0x0
    for _corv, _r1zP in pairs(_i8lW) do _DIWy = _DIWy + 0x1 end
    return _DIWy
end
local function _JLCs(_s7Kt) return _mvhj.localization:HasString(_s7Kt) end
local function _TOlb(_lskx, _YgyD) return _mvhj.localization:GetString(_lskx, _YgyD) end
local function _Rns1(_JhAa, _E1so, _8qcJ)
    if _8qcJ then
        local _tDOl = _JhAa / TUNING.TOTAL_DAY_TIME
        _tDOl = math.floor(_tDOl * 0xa + 0.5) / 0xa
        return _tDOl .. _TOlb("timer_day")
    end
    local _x2dY = math.max(math.floor(_JhAa / 0x3c), 0x0)
    local _wVnT = math.max(math.floor(_x2dY / 0x3c), 0x0)
    _JhAa = _JhAa - _x2dY * 0x3c
    _x2dY = _x2dY - _wVnT * 0x3c
    _JhAa = math.floor(_JhAa)
    if _E1so then
        return (_wVnT > 0x0 and _wVnT .. _TOlb("timer_hour") or "") .. (_x2dY > 0x0 and _x2dY .. _TOlb("timer_minute") or "") .. (_JhAa > 0x0 and _JhAa .. _TOlb("timer_second") or "")
    else
        return (_wVnT > 0x0 and _wVnT .. _TOlb("timer_hour") or "") ..
            ((_x2dY > 0x0 or _wVnT > 0x0) and _x2dY .. _TOlb("timer_minute") or "") .. _JhAa .. _TOlb("timer_second")
    end
end
local function _e3Gk(_D68w) return "" .. (math.abs(_D68w) >= 0x14 and _Ju5z(_D68w) or _Ju5z(_D68w * 0xa) / 0xa) end
local function _sKSk(_HKY1) return (math.abs(_HKY1) >= 0.2 and _Ju5z(_HKY1 * 0x64) or _Ju5z(_HKY1 * 0x3e8) / 0xa) .. "%" end
local function _w7d4(_qKev)
    local _BnfZ = _JJx1(_qKev) and STRINGS.UI and STRINGS.UI.SANDBOXMENU and STRINGS.UI.SANDBOXMENU[string.upper(_qKev)]
    return _BnfZ
end
local function _jEEY(_4R6L)
    local _vhVb = _JJx1(_4R6L) and STRINGS.NAMES[string.upper(_4R6L)]
    for _sQrS = 0x1, 0x9 do
        if _vhVb then break end
        _vhVb = _vhVb or (_JJx1(_4R6L) and STRINGS.NAMES[string.upper(_4R6L) .. _sQrS])
    end
    return _vhVb
end
local function _UDNX(_dlBz) return _JJx1(_dlBz) and STRINGS.ACTIONS[string.upper(_dlBz)] end
local function _RtCD(_YlTp, _1imY)
    local _g3q0 = _YlTp and (_YlTp.components and _YlTp.components[_1imY] or _YlTp.dycComponents and _YlTp.dycComponents[_1imY])
    return _g3q0
end
local function _OnGp(_lbLK)
    local _swK7 = _0TKP()
    if _WJWr(_swK7) and _WJWr(_swK7[_lbLK]) then return _swK7[_lbLK].ingredients end
end
local _JrV8 = {}
local function _cfhL(_oCWk)
    local _yFkj = _JrV8[_oCWk] and _JrV8[_oCWk].products
    if _yFkj then
        if #_yFkj > 0x0 then return _yFkj end
        return
    end
    local _DDM1 = _0TKP()
    _yFkj = {}
    for _nXj0, _PmnP in pairs(_DDM1) do
        if _WJWr(_PmnP.ingredients) then
            for _S2kC, _KVQJ in pairs(_PmnP.ingredients) do
                if _WJWr(_KVQJ) and _KVQJ.type == _oCWk then
                    table.insert(_yFkj, _nXj0)
                end
            end
        end
    end
    _JrV8[_oCWk] = _JrV8[_oCWk] or {}
    _JrV8[_oCWk].products = _yFkj
    if #_yFkj > 0x0 then return _yFkj end
end
local function _woVa(_WPMl, _Aw1P)
    local _1BgZ = 0x1
    _1BgZ = _1BgZ * (_WPMl.GetDamageModifier and _WPMl:GetDamageModifier() or _WPMl.damagemultiplier or 0x1)
    local _UTUV = type(_WPMl.defaultdamage) == "number" and _WPMl.defaultdamage or 0x0
    local _i5s0 = _WPMl.damagebonus or 0x0
    if _Aw1P and _Aw1P.components.weapon then
        local _1B3v = 0x0
        if _Aw1P.components.weapon.variedmodefn then
            local _ruJM = _Aw1P.components.weapon.variedmodefn(_Aw1P)
            _1B3v = _ruJM.damage
        else
            _1B3v = _Aw1P.components.weapon.GetDamage and _Aw1P.components.weapon:GetDamage() or _Aw1P.components.weapon.damage
        end
        if not _1B3v then _1B3v = 0x0 end
        return _1B3v * _1BgZ + _i5s0
    else
        if _WPMl.inst.components.rider and _WPMl.inst.components.rider:IsRiding() then
            local _ZLXp = _WPMl.inst.components.rider:GetMount()
            if _ZLXp and _ZLXp.components.combat then
                _UTUV = _ZLXp.components.combat.defaultdamage
                _i5s0 = _ZLXp.components.combat.damagebonus or 0x0
            end
            local _RLeI = _WPMl.inst.components.rider:GetSaddle()
            if _RLeI ~= nil and _RLeI.components.saddler ~= nil then
                _UTUV = _UTUV + _RLeI.components.saddler:GetBonusDamage()
            end
        end
    end
    return _UTUV * _1BgZ + _i5s0
end
local function _l7zs(_vHYq)
    local _WvR0 = 0x0
    for _a4AB, _55iv in ipairs(_vHYq.batcaves) do
        local _Wq4f = GetWorld().components.interiorspawner
        local _Wo0q = _Wq4f and _Wq4f:GetInteriorByName(_55iv)
        if _Wo0q and _Wo0q.prefabs and #_Wo0q.prefabs > 0x0 then
            for _O1hj = #_Wo0q.prefabs, 0x1, -0x1 do
                local _PmKl = _Wo0q.prefabs[_O1hj]
                if _PmKl.name == "vampirebat" then _WvR0 = _WvR0 + 0x1 end
            end
        end
        if _Wo0q and _Wo0q.object_list and #_Wo0q.object_list > 0x0 then
            for _F9Eu = #_Wo0q.object_list, 0x1, -0x1 do
                local _MMJ5 = _Wo0q.object_list[_F9Eu]
                if _MMJ5.prefab == "vampirebat" then _WvR0 = _WvR0 + 0x1 end
            end
        end
    end
    return _WvR0
end
local function _MSM4(_kvtW)
    local _CTW5 = _kvtW and _kvtW.components
    local _ctGg = _CTW5 and _CTW5.heater
    local _QIM4 = _CTW5 and _CTW5.burnable
    if not _ctGg and _QIM4 and _kvtW.children then
        for _nIlY, _up55 in pairs(_kvtW.children) do
            if _nIlY and _nIlY.components.heater then
                _ctGg = _nIlY.components.heater
                break
            end
        end
    end
    return _ctGg
end
local function _AYSj(_R8Dd)
    local _M6fs = math.floor(_R8Dd / 0x2) % (0x8)
    if _M6fs >= 0x4 then _M6fs = 0x8 - _M6fs end
    return _M6fs
end
local function _HvQ6(_zPil, _DyNe)
    local _aOSe = math.floor(_zPil / 0x2) % (0x8)
    if _aOSe == 0x4 then return 0x0 end
    local _GXJ4 = 0x8
    while _GXJ4 - _zPil - _DyNe <= 0x0 do _GXJ4 = _GXJ4 + 0x10 end
    return (_GXJ4 - _zPil - _DyNe) * TUNING.TOTAL_DAY_TIME
end
local function _AyvO(_aMne)
    if _aMne and _aMne.prefab then
        if _dSG2[_aMne.prefab] and _dSG2[_aMne.prefab].GetValue then
            return _dSG2[_aMne.prefab].GetValue(_aMne) or 0x0
        end
        return _dSG2[_aMne.prefab] and _dSG2[_aMne.prefab].value or 0x0
    end
    return 0x0
end
local function _0CEU(_Ctx1, _2pyP, _hTBc) table.insert(_Ctx1, { text = _2pyP, component = _hTBc }) end
local function _lOjc(_qyGZ, _wl2j, _ab5X) table.insert(_qyGZ, { richtext = _wl2j, component = _ab5X }) end
local function _Beub(_42LQ, _r0mr, _y4WQ)
    if _JJx1(_r0mr) then
        local _6tDv = #_42LQ > 0x0 and _42LQ[#_42LQ]
        if _6tDv and _6tDv.text and not _6tDv.color and not _y4WQ then
            _6tDv.text = _6tDv.text .. _r0mr
        else
            table.insert(_42LQ, { text = _r0mr, color = _y4WQ, })
        end
    end
end
local function _ClXC(_5Oxr, _Bn10, _uLod) table.insert(_5Oxr, { icon = { atlas = "images/icons/" .. _Bn10 .. ".xml", image = _Bn10 .. ".tex" }, color = _uLod, }) end
local function _yAhs(_cDVz, _mpAC, _ymmQ, _IJuq, _q2fp)
    local _Fupd = {}
    if not _cDVz or not _cDVz.IsValid then return _Fupd end
    local _8w7X = _cDVz.prefab
    local _QTrF = _cDVz:HasTag("sail")
    local _lls9 = _cDVz and _cDVz.components
    local _zxqP = _lls9.inventoryitem or _RtCD(_cDVz, "inventoryitem")
    local _o42o = _zxqP and _zxqP.owner or nil
    local _bkrU = _lls9.boathealth
    local _q7WG = _lls9.health or _RtCD(_cDVz, "health")
    local _v2WS = _lls9.sanity or _RtCD(_cDVz, "sanity")
    local _nRA0 = _lls9.hunger or _RtCD(_cDVz, "hunger")
    local _sNWP = _lls9.combat or _RtCD(_cDVz, "combat")
    local _4REx = _lls9.aura
    local _qv02 = _lls9.locomotor
    local _MzbK = _lls9.drivable
    local _CacY = _lls9.eater
    local _emGS = _lls9.follower or _RtCD(_cDVz, "follower")
    local _6Vkt = _lls9.leader
    local _yKVR = _lls9.domesticatable
    local _7AxK = _lls9.weapon
    local _imtt = _lls9.obsidiantool
    local _P4D4 = _lls9.explosive
    local _h435 = _lls9.armor
    local _1mqm = _lls9.workable
    local _PMVf = _lls9.pickable
    local _geTj = _lls9.hackable
    local _Gl9Q = _lls9.shearable
    local _Ji5m = _lls9.tool
    local _cACp = _lls9.finiteuses
    local _QSik = _lls9.sewing
    local _TLLb = _lls9.fueled
    local _1oBm = _lls9.fuel
    local _tIcu = _lls9.perishable
    local _OrDe = _lls9.repairable
    local _CkXE = _lls9.repairer
    local _4Wv8 = _lls9.cooldown
    local _8R3A = _lls9.healer
    local _UaG7 = _lls9.stewer
    local _ELvE = _lls9.dryer
    local _DSsr = _lls9.edible
    local _TXwa = _lls9.dryable
    local _gLHU = _lls9.cookable
    local _6xXG = _lls9.growable
    local _5Np7 = _lls9.crop
    local _qMdj = _lls9.harvestable
    local _vbBt = _lls9.hatchable
    local _cfZd = _lls9.teacher
    local _59LU = _lls9.waterproofer
    local _1FUh = _lls9.insulator
    local _zu1x = _MSM4(_cDVz)
    local _jjDw = _lls9.temperature
    local _m9b0 = _lls9.dapperness
    local _vyo0 = _lls9.equippable or _RtCD(_cDVz, "equippable")
    local _Oi6S = _lls9.burnable
    local _vd8b = _lls9.propagator
    local _VEY7 = _lls9.appeasement
    local _WdOz = _lls9.tradable
    local _3hH6 = _lls9.inventory
    local _VPal = _lls9.container or _RtCD(_cDVz, "container")
    local _Hfgd = _lls9.unwrappable
    local _d8RH = _lls9.childspawner
    local _VUfT = _lls9.spawner
    local _IbWw = _lls9.clock
    local _wZLO = _lls9.seasonmanager
    local _uFJj = _lls9.hounded
    local _uL7o = _lls9.batted
    local _1rf9 = _lls9.quaker
    local _iVlp = _lls9.volcanomanager
    local _648X = _lls9.basehassler
    local _Xrmb = _lls9.tigersharker
    local _8512 = _lls9.clock and _vrag() and _vrag().components.krakener
    local _ukJ5 = _lls9.rocmanager
    local _ev1b = _lls9.nightmareclock
    local _F7TB = _lls9.periodicthreat
    if _mpAC and _JJx1(_8w7X) then
        local _bDPD = _TOlb("prefab") .. ":" .. _8w7X
        _0CEU(_Fupd, _bDPD, "prefab")
    end
    if _ymmQ and _G7JA(_cDVz.HasTag) then
        local _PfKX = {}
        for _0HAB, _1Y1d in pairs(_EGNV) do if _cDVz:HasTag(_1Y1d) then table.insert(_PfKX, _TOlb("tags_" .. _1Y1d, _1Y1d)) end end
        if #_PfKX > 0x0 then
            local _tHly = _TOlb("tags") .. ":" .. _f6os(",", _PfKX)
            _0CEU(_Fupd, _tHly, "tags")
        end
    end
    if _IJuq and _JJx1(_8w7X) then
        local _Ue3Q = _OnGp(_8w7X)
        if _WJWr(_Ue3Q) and #_Ue3Q > 0x0 then
            local _Rk5X = {}
            for _4jT9, _lHVt in pairs(_Ue3Q) do
                if _WJWr(_lHVt) and _JJx1(_lHVt.type) and _eUt1(_lHVt.amount) then
                    table.insert(_Rk5X, (_jEEY(_lHVt.type) or _lHVt.type) .. " x" .. _e3Gk(_lHVt.amount))
                end
            end
            if #_Rk5X > 0x0 and #_Rk5X <= 0x5 then
                local _LTw2 = _TOlb("ingredients") .. ":" .. _f6os(", ", _Rk5X)
                _0CEU(_Fupd, _LTw2, "recipe")
            elseif #_Rk5X > 0x5 then
                local _vebX = _TOlb("ingredients") .. ":" .. #_Rk5X .. _TOlb("ingredients2")
                _0CEU(_Fupd, _vebX, "recipe")
            end
        end
        local _Uidp = _cfhL(_8w7X)
        if _WJWr(_Uidp) and #_Uidp > 0x0 then
            local _DXS8 = {}
            for _WuQ6, _J9VF in pairs(_Uidp) do
                local _kX3Q = _jEEY(_J9VF) or _J9VF
                if _JJx1(_kX3Q) then table.insert(_DXS8, _kX3Q) end
            end
            if #_DXS8 > 0x0 and #_DXS8 <= 0x7 then
                local _XAqu = _TOlb("ingredientof") .. ":" .. _f6os(", ", _DXS8)
                _0CEU(_Fupd, _XAqu, "recipe")
            elseif #_DXS8 > 0x7 then
                local _cHCJ = _TOlb("ingredientof") .. ":" .. #_DXS8 .. _TOlb("products")
                _0CEU(_Fupd, _cHCJ, "recipe")
            end
        end
    end
    if _bkrU then
        local _lsdQ, max = _bkrU.currenthealth, _bkrU.maxhealth
        local _cf5J = _G7JA(_bkrU.IsLeaking) and _bkrU:IsLeaking()
        if _0ldE(_lsdQ) and _eUt1(max) then
            local _gPtg = _TOlb("health") .. ":" .. _Ju5z(_lsdQ) .. "/" .. _Ju5z(max) .. (_cf5J and " " .. _TOlb("leaking") or "")
            _0CEU(_Fupd, _gPtg, "boathealth")
        end
    end
    if _q7WG then
        local _BVn0, max = _q7WG.currenthealth, _G7JA(_q7WG.GetMax) and _q7WG:GetMax() or _q7WG.maxhealth
        if _0ldE(_BVn0) and _eUt1(max) then
            local _0ZTL = _TOlb("health") .. ":" .. _Ju5z(_BVn0) .. "/" .. _Ju5z(max)
            _0CEU(_Fupd, _0ZTL, "health")
        end
    end
    if _v2WS then
        local _70RH, max = _v2WS.current, _v2WS.max
        if _0ldE(_70RH) and _eUt1(max) then
            local _lvau = _TOlb("sanity") .. ":" .. _Ju5z(_70RH) .. "/" .. _Ju5z(max)
            _0CEU(_Fupd, _lvau, "sanity")
        end
    end
    if _nRA0 then
        local _1Tm5, max = _nRA0.current, _nRA0.max
        if _0ldE(_1Tm5) and _eUt1(max) then
            local _viWD = _TOlb("hunger") .. ":" .. _Ju5z(_1Tm5) .. "/" .. _Ju5z(max)
            _0CEU(_Fupd, _viWD, "hunger")
        end
    end
    if _sNWP then
        local _ra3E, damage_1, damage_2 = 0x0, 0x0, 0x0
        local _dmzF = _G7JA(_sNWP.GetWeapon) and _sNWP:GetWeapon()
        if _G7JA(_sNWP.CalcEstimatedDamage) then
            _ra3E, damage_1, damage_2 = _sNWP:CalcEstimatedDamage(_dmzF)
            _ra3E = _0ldE(_ra3E) and _ra3E or 0x0
            damage_1 = _0ldE(damage_1) and damage_1 or 0x0
            damage_2 = _0ldE(damage_2) and damage_2 or 0x0
        end
        if _ra3E <= 0x0 then _ra3E = _woVa(_sNWP, _dmzF) end
        if _ra3E <= 0x0 then
            local _EWpb = _dmzF and _dmzF.components.weapon
            local _nzDn = _eUt1(_sNWP.defaultdamage) and _sNWP.defaultdamage or 0x0
            _ra3E = _EWpb and _G7JA(_EWpb.GetDamage) and _EWpb:GetDamage() or (_EWpb and _EWpb.damage) or 0x0
            _ra3E = _eUt1(_ra3E) and _ra3E or 0x0
            _ra3E = _ra3E > 0x0 and _ra3E or _nzDn
        end
        local _X0Mu = _G7JA(_sNWP.GetAttackRange) and _sNWP:GetAttackRange()
        _X0Mu = _eUt1(_X0Mu) and _X0Mu or 0x0
        local _LGER, rangeStr = nil, nil
        if _ra3E ~= 0x0 then _LGER = damage_2 ~= 0x0 and _e3Gk(damage_1) .. (damage_2 > 0x0 and "+" or "") .. _e3Gk(damage_2) or _e3Gk(_ra3E) end
        if _X0Mu > 0x0 then rangeStr = _e3Gk(_X0Mu) end
        if _LGER then
            local _fLRx = ""
            _fLRx = _fLRx .. (_LGER ~= nil and (_TOlb("attackdamage") .. ":" .. _LGER) or "") .. (rangeStr ~= nil and (" " .. _TOlb("range") .. ":" .. rangeStr) or "")
            _0CEU(_Fupd, _fLRx, "combat")
        end
        if _cDVz.GetCharacterBonus then
            local _DxVs = {}
            local _8TJZ = _4REx or _WJWr(_cDVz.sg) and _WJWr(_cDVz.sg.sg) and _cDVz.sg.sg.isAttackSpeedApplied
            local _5pIV = _cDVz:GetCharacterBonus("attackspeed_percent")
            if _8TJZ and _0ldE(_5pIV) then
                local _Bmdy = _TOlb("attackspeed") .. ":" .. _sKSk(_5pIV + 0x1)
                table.insert(_DxVs, _Bmdy)
            end
            if _sNWP.GetEncReduction then
                local _f8gC, percent = _sNWP:GetEncReduction()
                _f8gC = _eUt1(_f8gC) and _f8gC or 0x0
                percent = _cDVz:GetCharacterBonus("invincible") > 0x0 and 0x1 or percent
                percent = _eUt1(percent) and percent or 0x0
                local _p8hF = _TOlb("damagereduction") .. ":" .. _e3Gk(_f8gC) .. "+" .. _sKSk(percent)
                table.insert(_DxVs, _p8hF)
            end
            local _GC1V = _f6os(" ", _DxVs)
            if _JJx1(_GC1V) then _0CEU(_Fupd, _GC1V, "combat") end
        end
    end
    if _qv02 then
        local _GlyB, walkspeed_1, walkspeed_2 = nil, nil, nil
        if _G7JA(_qv02.DYCGetWalkSpeed) then
            _GlyB, walkspeed_1, walkspeed_2 = _qv02:DYCGetWalkSpeed()
        elseif _G7JA(_qv02.GetWalkSpeed) then
            _GlyB = _qv02:GetWalkSpeed()
        end
        _GlyB = _eUt1(_GlyB) and _e3Gk(_GlyB)
        walkspeed_1 = _eUt1(walkspeed_1) and _e3Gk(walkspeed_1)
        walkspeed_2 = _EqJc(walkspeed_2) and _e3Gk(walkspeed_2)
        local _Eccg, runspeed_1, runspeed_2 = nil, nil, nil
        if _G7JA(_qv02.DYCGetRunSpeed) then
            _Eccg, runspeed_1, runspeed_2 = _qv02:DYCGetRunSpeed()
        elseif _G7JA(_qv02.GetRunSpeed) then
            _Eccg = _qv02:GetRunSpeed()
        end
        _Eccg = _eUt1(_Eccg) and _e3Gk(_Eccg)
        runspeed_1 = _eUt1(runspeed_1) and _e3Gk(runspeed_1)
        runspeed_2 = _EqJc(runspeed_2) and _e3Gk(runspeed_2)
        if _GlyB or _Eccg then
            local _b7cD = _GlyB and _TOlb("walkspeed") .. ":" .. (walkspeed_1 and walkspeed_2 and walkspeed_1 .. (not string.find(walkspeed_2, "-") and "+" or "") .. walkspeed_2 or _GlyB) or ""
            local _0OsI = _Eccg and _TOlb("runspeed") .. ":" .. (runspeed_1 and runspeed_2 and runspeed_1 .. (not string.find(runspeed_2, "-") and "+" or "") .. runspeed_2 or _Eccg) or ""
            local _r02z = _f6os(" ", _b7cD, _0OsI)
            _0CEU(_Fupd, _r02z, "locomotor")
        end
        local _DgMh = _qv02.speed_modifiers_add
        local _FphE = _qv02.speed_modifiers_add_timer
        local _qpWG = _qv02.speed_modifiers_mult
        local _2YtT = _qv02.speed_modifiers_mult_timer
        local _1grz, tbl2 = {}, {}
        if _WJWr(_DgMh) and _WJWr(_FphE) then
            for _j6xi, _5NMK in pairs(_DgMh) do
                local _QJnQ = _0ldE(_5NMK) and _5NMK or 0x0
                local _JCsA = _eUt1(_FphE[_j6xi]) and _FphE[_j6xi] or 0x0
                if _JJx1(_j6xi) and _QJnQ ~= 0x0 then
                    local _Ir6p = string.lower(_j6xi)
                    _j6xi = _JLCs(_Ir6p) and _TOlb(_Ir6p) or _j6xi
                    _j6xi = _JLCs("speedboost_" .. _Ir6p) and _TOlb("speedboost_" .. _Ir6p) or _j6xi
                    local _4H0V = _j6xi .. (_QJnQ > 0x0 and "+" or "") .. _e3Gk(_QJnQ) .. (_JCsA > 0x0 and "(" .. _Rns1(_JCsA) .. ")" or "")
                    if _JCsA > 0x0 then
                        table.insert(tbl2, _4H0V)
                    else
                        table.insert(_1grz, _4H0V)
                    end
                end
            end
        end
        if _WJWr(_qpWG) and _WJWr(_2YtT) then
            for _lGLc, _vIQl in pairs(_qpWG) do
                local _JDpG = _0ldE(_vIQl) and _vIQl or 0x0
                local _SEl1 = _eUt1(_2YtT[_lGLc]) and _2YtT[_lGLc] or 0x0
                _SEl1 = _JJx1(_lGLc) and _lGLc == "WX_CHARGE" and _0ldE(_cDVz.charge_time) and _cDVz.charge_time or _SEl1
                if _JJx1(_lGLc) and _JDpG ~= 0x0 then
                    local _NGYQ = string.lower(_lGLc)
                    _lGLc = _JLCs(_NGYQ) and _TOlb(_NGYQ) or _lGLc
                    _lGLc = _JLCs("speedboost_" .. _NGYQ) and _TOlb("speedboost_" .. _NGYQ) or _lGLc
                    local _cg6z = _lGLc .. (_JDpG > 0x0 and "+" or "") .. _sKSk(_JDpG) .. (_SEl1 > 0x0 and "(" .. _Rns1(_SEl1) .. ")" or "")
                    if _SEl1 > 0x0 then
                        table.insert(tbl2, _cg6z)
                    else
                        table.insert(_1grz, _cg6z)
                    end
                end
            end
        end
        if #_1grz > 0x0 then
            local _G3kK = _TOlb("speed") .. ":" .. _f6os(" ", _1grz)
            _0CEU(_Fupd, _G3kK, "locomotor")
        end
        if #tbl2 > 0x0 then
            local _jcFL = _TOlb("speed") .. ":" .. _f6os(" ", tbl2)
            _0CEU(_Fupd, _jcFL, "locomotor")
        end
    end
    if _MzbK then
        local _gL6z = _MzbK.runspeed
        if _EqJc(_gL6z) then
            local _bKph = _TOlb("speed") .. ":" .. (_gL6z > 0x0 and "+" or "") .. _gL6z
            _0CEU(_Fupd, _bKph, "drivable")
        end
    end
    if _QTrF then
        local _3bgg = _cDVz.sail_speed_mult
        _3bgg = _eUt1(_3bgg) and _3bgg
        local _nVRe = _cDVz.sail_accel_mult
        _nVRe = _eUt1(_nVRe) and _nVRe
        if _3bgg or _nVRe then
            local _ffMx = _TOlb("sail") ..
                ":" .. (_3bgg and _TOlb("speed") .. _Ju5z(_3bgg * 0x64) .. "%" or "") .. (_3bgg and _nVRe and " " or "") .. (_nVRe and _TOlb("acceleration") .. _Ju5z(_nVRe * 0x64) .. "%" or "")
            _0CEU(_Fupd, _ffMx)
        end
    end
    if _CacY then
        local _TjTf = _CacY.foodprefs
        if _WJWr(_TjTf) and #_TjTf > 0x0 then
            local _JmFC = _TOlb("eater")
            local _xfcH = #_TjTf
            if _xfcH <= 0x6 then
                _JmFC = _JmFC .. "("
                for _8NAh = 0x1, _xfcH do
                    local _HW0d = _TjTf[_8NAh]
                    if _JJx1(_HW0d) then
                        _JmFC = _JmFC .. _TOlb("foodtype_" .. string.lower(_HW0d), _HW0d)
                        if _8NAh < _xfcH then _JmFC = _JmFC .. "," end
                    end
                end
                _JmFC = _JmFC .. ")"
            else
                _JmFC = _JmFC .. "(" .. _xfcH .. _TOlb("foodtypes") .. ")"
            end
            _0CEU(_Fupd, _JmFC, "eater")
        end
    end
    if _emGS then
        local _rRXa = _WJWr(_emGS.leader) and _emGS.leader.components and _emGS.leader or nil
        local _90mU = _rRXa and _G7JA(_rRXa.GetDisplayName) and _rRXa:GetDisplayName() or nil
        _90mU = _JJx1(_90mU) and string.gsub(_90mU, "\n", "") or nil
        if _rRXa and _90mU then
            local _lgEe = _emGS.targettime
            local _Ah26 = _emGS.maxfollowtime
            local _11ZZ = _0ldE(_lgEe) and math.max(0x0, _lgEe - GetTime()) or -0x1
            local _eXTX = _11ZZ > 0x0 and "(" .. _Rns1(_11ZZ, nil, true) .. ")" or ""
            local _9JiJ = _eUt1(_Ah26) and _11ZZ >= 0x0 and _TOlb("loyalty") .. ":" .. _e3Gk(_11ZZ) .. _eXTX .. "/" .. _e3Gk(_Ah26) or nil
            local _vKGt = _TOlb("leader") .. ":" .. _90mU .. (_9JiJ ~= nil and " " .. _9JiJ or "")
            _0CEU(_Fupd, _vKGt, "follower")
        end
    end
    if _6Vkt then
        local _pIgc = _6Vkt.followers
        if _WJWr(_pIgc) then
            local _wTfT = _lVV7(_pIgc)
            if _wTfT > 0x0 then
                local _9Vqr = ""
                if _wTfT <= 0x3 then
                    local _K8h0 = 0x1
                    for _VDpP, _6a8D in pairs(_pIgc) do
                        local _7aaz = _WJWr(_VDpP) and _G7JA(_VDpP.GetDisplayName) and _VDpP:GetDisplayName() or nil
                        if _JJx1(_7aaz) then
                            _7aaz = string.gsub(_7aaz, "\n", "")
                            _9Vqr = _9Vqr .. _7aaz .. (_K8h0 < _wTfT and "," or "")
                        end
                        _K8h0 = _K8h0 + 0x1
                    end
                else
                    _9Vqr = _wTfT
                end
                local _RMzL = _TOlb("followers") .. ":" .. _9Vqr
                _0CEU(_Fupd, _RMzL, "leader")
            end
        end
    end
    if _yKVR then
        local _JlZ1 = _yKVR.domestication
        _JlZ1 = _eUt1(_JlZ1) and _JlZ1 or nil
        local _a0Ki = _yKVR.obedience
        _a0Ki = _eUt1(_a0Ki) and _a0Ki or nil
        local _VgZs = _yKVR.tendencies
        _VgZs = _WJWr(_VgZs) and _VgZs or nil
        local _HBmb = _yKVR.minobedience
        _HBmb = _Msfj(_HBmb) and _HBmb or nil
        local _CrY1 = _yKVR.maxobedience
        _CrY1 = _Msfj(_CrY1) and _CrY1 or nil
        local _u0xo = _JlZ1 and _TOlb("domestication") .. _Ju5z(_JlZ1 * 0x64) .. "%" or ""
        local _JNew = _a0Ki and _TOlb("obedience") .. _Ju5z(_a0Ki * 0x64) .. "%" or ""
        if _JNew and _HBmb and _CrY1 and (_HBmb ~= 0x0 or _CrY1 ~= 0x1) then _JNew = _JNew .. "(" .. _Ju5z(_HBmb * 0x64) .. "%-" .. _Ju5z(_CrY1 * 0x64) .. "%)" end
        local _SQbw = ""
        if _VgZs then
            local _wORz = _VgZs.DEFAULT
            local _ip05 = _VgZs.ORNERY
            local _3g3Z = _VgZs.RIDER
            local _kP6G = _VgZs.PUDGY
            _SQbw = _eUt1(_wORz) and ((_JJx1(_SQbw) and _SQbw or "") .. _TOlb("tendencies_default") .. string.format("%0.3f", _wORz)) or _SQbw
            _SQbw = _eUt1(_ip05) and ((_JJx1(_SQbw) and _SQbw .. " " or "") .. _TOlb("tendencies_ornery") .. string.format("%0.3f", _ip05)) or _SQbw
            _SQbw = _eUt1(_3g3Z) and ((_JJx1(_SQbw) and _SQbw .. " " or "") .. _TOlb("tendencies_rider") .. string.format("%0.3f", _3g3Z)) or _SQbw
            _SQbw = _eUt1(_kP6G) and ((_JJx1(_SQbw) and _SQbw .. " " or "") .. _TOlb("tendencies_pudgy") .. string.format("%0.3f", _kP6G)) or _SQbw
        end
        if _JJx1(_u0xo) or _JJx1(_JNew) then
            local _X86A = _u0xo .. (_JJx1(_u0xo) and " " or "") .. _JNew
            _0CEU(_Fupd, _X86A, "domesticatable")
        end
        if _JJx1(_SQbw) then
            local _YHrT = _SQbw
            _0CEU(_Fupd, _YHrT, "domesticatable")
        end
    end
    if _7AxK then
        local _YKrx, rangeStr = nil, nil
        local _Vnzf, damage_1, damage_2 = nil, nil, nil
        if _G7JA(_7AxK.GetDamage) then _Vnzf, damage_1, damage_2 = _7AxK:GetDamage() end
        _Vnzf = _Vnzf or _7AxK.damage
        local _fD62 = _7AxK.attackrange
        if _eUt1(_Vnzf) then
            if _imtt and _G7JA(_imtt.GetCharge) then
                local _UX2m = _7AxK.damage
                local _B37n, maxcharge = _imtt:GetCharge()
                if _eUt1(_UX2m) and _0ldE(_B37n) and _eUt1(maxcharge) then
                    local _6He3 = _UX2m * _egct(_B37n / maxcharge, 0x0, 0x1)
                    _Vnzf = _Vnzf + _6He3
                    damage_1 = _eUt1(damage_1) and damage_1 + _6He3
                end
            end
            if _eUt1(damage_1) and _EqJc(damage_2) then
                damage_1 = _e3Gk(damage_1)
                damage_2 = (damage_2 >= 0x0 and "+" or "") .. _e3Gk(damage_2)
                _YKrx = damage_1 .. damage_2
            else
                _YKrx = _e3Gk(_Vnzf)
            end
        end
        if _eUt1(_fD62) then rangeStr = _e3Gk(_fD62) end
        if _YKrx or rangeStr then
            local _RIIT = _TOlb("weapon") .. ":"
            _RIIT = _RIIT .. (_YKrx ~= nil and (_TOlb("damage") .. _YKrx) or "") .. (_YKrx ~= nil and " " or "") .. (rangeStr ~= nil and (_TOlb("range") .. rangeStr) or "")
            _0CEU(_Fupd, _RIIT, "weapon")
        end
    end
    if _P4D4 then
        local _UKIY = _P4D4.explosiverange
        _UKIY = _0ldE(_UKIY) and _UKIY or 0x0
        local _x8LI = _P4D4.explosivedamage
        _x8LI = _0ldE(_x8LI) and _x8LI or 0x0
        local _8CjQ = _P4D4.buildingdamage
        _8CjQ = _0ldE(_8CjQ) and _8CjQ or 0x0
        if _x8LI > 0x0 or _UKIY > 0x0 then
            local _QYUR = _TOlb("explosive") .. ":"
            _QYUR = _QYUR .. _f6os(" ", _x8LI > 0x0 and _TOlb("damage") .. _e3Gk(_x8LI), _8CjQ > 0x0 and _TOlb("buildingdamage") .. _e3Gk(_8CjQ), _UKIY > 0x0 and _TOlb("range") .. _e3Gk(_UKIY))
            _0CEU(_Fupd, _QYUR, "explosive")
        end
    end
    if _h435 then
        local _TdWa, max = _h435.condition, _G7JA(_h435.GetMax) and _h435:GetMax() or _h435.maxcondition
        local _gT95 = _h435.absorb_percent
        if _0ldE(_TdWa) and _eUt1(max) then
            local _JdWq = _TOlb("armor") .. (_eUt1(_gT95) and ("(" .. _TOlb("absorbpercent") .. _Ju5z(_gT95 * 0x64) .. "%)") or "") .. ":"
            _JdWq = _JdWq .. _e3Gk(_TdWa) .. "/" .. _e3Gk(max)
            _0CEU(_Fupd, _JdWq, "armor")
        end
    end
    if _1mqm then
        local _FxQn, maxwork = _1mqm.workleft, _1mqm.maxwork
        local _OQuE = _1mqm.action
        if _eUt1(_FxQn) then
            local _4iFV = _WJWr(_OQuE) and _JJx1(_OQuE.str) and _OQuE.str or nil
            local _luo8 = _UDNX(_4iFV)
            _luo8 = _JJx1(_luo8) and _luo8 or (_WJWr(_luo8) and _JJx1(_luo8.GENERIC) and _luo8.GENERIC) or _TOlb("other")
            local _TrGi = _TOlb("workable") .. (_4iFV and "(" .. _luo8 .. ")" or "") .. ":" .. _Ju5z(_FxQn) .. (_eUt1(maxwork) and "/" .. _Ju5z(maxwork) or "")
            _0CEU(_Fupd, _TrGi, "workable")
        end
    end
    if _PMVf then
        local _XxkN = _PMVf.product
        _XxkN = _jEEY(_XxkN)
        local _VINb = _G7JA(_PMVf.CanBePicked) and _PMVf:CanBePicked()
        local _LMou = _PMVf.numtoharvest
        local _mucL = _PMVf.targettime
        local _W5ba = _eUt1(_mucL) and _mucL - GetTime()
        local _EqWK = _PMVf.regentime
        local _HaYV = ""
        if _JJx1(_XxkN) then _HaYV = _TOlb("pickproduct") .. ":" .. _XxkN .. (_eUt1(_LMou) and _LMou > 0x1 and "x" .. _LMou or "") elseif _VINb then _HaYV = _TOlb("pickable") end
        if _eUt1(_W5ba) then
            _HaYV = _HaYV .. (_JJx1(_HaYV) and " " or "") .. _TOlb("regen") .. ":" .. _Ju5z(_W5ba) .. "(" .. _Rns1(_W5ba, nil, true) .. ")" ..
                (_eUt1(_EqWK) and "/" .. _Ju5z(_EqWK) or "")
        end
        if _JJx1(_HaYV) then _0CEU(_Fupd, _HaYV, "pickable") end
    end
    if _geTj then
        local _Falr = _geTj.product
        local _GODi = _geTj.hacksleft
        local _mcBg = _geTj.targettime
        local _ct2r = _eUt1(_mcBg) and _mcBg - GetTime()
        local _3lJ1 = _UDNX("hack")
        _Falr = _jEEY(_Falr)
        local _rMmY = ""
        if _JJx1(_Falr) then _rMmY = _TOlb("hackproduct") .. ":" .. _Falr end
        if _eUt1(_GODi) and _JJx1(_3lJ1) then _rMmY = _rMmY .. (_JJx1(_rMmY) and " " or "") .. _3lJ1 .. _GODi end
        if _eUt1(_ct2r) then _rMmY = _rMmY .. (_JJx1(_rMmY) and " " or "") .. _TOlb("regen") .. ":" .. _Ju5z(_ct2r) .. "(" .. _Rns1(_ct2r, nil, true) .. ")" end
        if _JJx1(_rMmY) then _0CEU(_Fupd, _rMmY, "hackable") end
    end
    if _Gl9Q then
        local _qGNG = _Gl9Q.product
        local _KKgV = _Gl9Q.product_amt
        _qGNG = _jEEY(_qGNG)
        if _JJx1(_qGNG) then
            local _T1FL = _TOlb("shearproduct") .. ":" .. _qGNG .. (_eUt1(_KKgV) and _KKgV > 0x1 and "x" .. _KKgV or "")
            _0CEU(_Fupd, _T1FL, "shearable")
        end
    end
    if _Ji5m then
        local _B7YI = 0x0
        local _04zT = {}
        local _D48k = _Ji5m.actions or _Ji5m.action
        if _WJWr(_D48k) then
            for _xERw, _B7E2 in pairs(_D48k) do
                if _WJWr(_xERw) and _JJx1(_xERw.str) and _eUt1(_B7E2) then
                    _04zT[_xERw.str] = _B7E2
                    _B7YI = _B7YI + 0x1
                end
            end
        end
        local _Ywba = _TOlb("tool") .. ":"
        if _B7YI <= 0x4 and _B7YI > 0x0 then
            local _a6HM = 0x0
            for _6Qxk, _Xr06 in pairs(_04zT) do
                if _a6HM > 0x0 then _Ywba = _Ywba .. " " end
                local _xbax = _UDNX(_6Qxk)
                _xbax = _JJx1(_xbax) and _xbax or (_WJWr(_xbax) and _JJx1(_xbax.GENERIC) and _xbax.GENERIC) or _TOlb("other")
                _Ywba = _Ywba .. _xbax .. _Ju5z(_Xr06)
                _a6HM = _a6HM + 0x1
            end
        elseif _B7YI > 0x0 then
            _Ywba = _Ywba .. _B7YI .. _TOlb("tool_actions")
        end
        _0CEU(_Fupd, _Ywba, "tool")
    end
    if _UaG7 then
        local _nDvv = _UaG7.product
        _nDvv = _jEEY(_nDvv)
        local _HDjg = _G7JA(_UaG7.GetTimeToCook) and _UaG7:GetTimeToCook()
        if _JJx1(_nDvv) then
            local _2TuW = _TOlb("stewproduct") .. ":" .. _nDvv .. (_eUt1(_HDjg) and " " .. _Rns1(_HDjg) or "")
            _0CEU(_Fupd, _2TuW, "stewer")
        end
    end
    if _ELvE then
        local _xNWe = _ELvE.product
        _xNWe = _jEEY(_xNWe)
        local _5XH4 = _G7JA(_ELvE.GetTimeToDry) and _ELvE:GetTimeToDry()
        if _JJx1(_xNWe) then
            local _wXWW = _TOlb("dryproduct") .. ":" .. _xNWe .. (_eUt1(_5XH4) and "(" .. _Rns1(_5XH4) .. ")" or "")
            _0CEU(_Fupd, _wXWW, "dryer")
        end
    end
    if _DSsr then
        local _HXwf = _DSsr.foodtype
        local _OV9z = _WJWr(_o42o) and _WJWr(_o42o.components) and _WJWr(_o42o.components.inventoryitem) and _o42o.components.inventoryitem.owner or nil
        local _6hOv = _DSsr.GetHealth and _DSsr:GetHealth(_OV9z or _o42o) or _DSsr.healthvalue
        local _bPCG = _DSsr.GetHunger and _DSsr:GetHunger(_OV9z or _o42o) or _DSsr.hungervalue
        local _XBTm = _DSsr.GetSanity and _DSsr:GetSanity(_OV9z or _o42o) or _DSsr.sanityvalue
        local _wKXk = _DSsr.caffeinedelta
        local _EVaJ = _DSsr.caffeineduration
        local _DgaA, healthStr, hungerStr, sanityStr, coffeeStr = nil, nil, nil, nil, nil
        local _QIYT = _q2fp and {} or nil
        if _QIYT then _Beub(_QIYT, _TOlb("edible")) end
        if _JJx1(_HXwf) then
            _DgaA = "(" .. _TOlb("foodtype_" .. string.lower(_HXwf), _HXwf) .. ")"
            if _QIYT then _Beub(_QIYT, _DgaA) end
        end
        if _EqJc(_6hOv) then
            healthStr = (not _QIYT and _TOlb("health") or "") .. _e3Gk(_6hOv)
            if _QIYT then
                _ClXC(_QIYT, "dyc_status_health")
                _Beub(_QIYT, healthStr)
            end
        end
        if _EqJc(_bPCG) then
            hungerStr = (not _QIYT and _TOlb("hunger") or "") .. _e3Gk(_bPCG)
            if _QIYT then
                _ClXC(_QIYT, "dyc_status_hunger")
                _Beub(_QIYT, hungerStr)
            end
        end
        if _EqJc(_XBTm) then
            sanityStr = (not _QIYT and _TOlb("sanity") or "") .. _e3Gk(_XBTm)
            if _QIYT then
                _ClXC(_QIYT, "dyc_status_sanity")
                _Beub(_QIYT, sanityStr)
            end
        end
        if _eUt1(_wKXk) and _eUt1(_EVaJ) then
            coffeeStr = _TOlb("speed") .. _e3Gk(_wKXk) .. "(" .. _Rns1(_EVaJ, true) .. ")"
            if _QIYT then _Beub(_QIYT, coffeeStr) end
        end
        if _DgaA or healthStr or hungerStr or sanityStr then
            if _QIYT then
                if _QIYT[0x1] and _QIYT[0x1].text then _QIYT[0x1].text = _QIYT[0x1].text .. ":" end
                _lOjc(_Fupd, _QIYT, "edible")
            else
                local _gdBh = _f6os(" ", healthStr, hungerStr, sanityStr, coffeeStr)
                _gdBh = _TOlb("edible") .. (_DgaA or "") .. (#_gdBh > 0x0 and ":" or "") .. _gdBh
                _0CEU(_Fupd, _gdBh, "edible")
            end
        end
        if _JJx1(_8w7X) then
            local _U4Zq = _hPVf.ingredients[_8w7X]
            if _WJWr(_U4Zq) and _WJWr(_U4Zq.tags) then
                local _8Bcq = {}
                for _vag4, _dKA6 in pairs(_U4Zq.tags) do if _JJx1(_vag4) and _eUt1(_dKA6) then table.insert(_8Bcq, _TOlb("foodtag_" .. string.lower(_vag4), _vag4) .. _dKA6) end end
                local _amL2 = _TOlb("foodtags") .. ":" .. _f6os(",", _8Bcq)
                _0CEU(_Fupd, _amL2, "edible")
            end
        end
    end
    if _TXwa then
        local _UA60 = _TXwa.product
        _UA60 = _jEEY(_UA60)
        local _goPD = _TXwa.drytime
        if _JJx1(_UA60) then
            local _1TAT = _TOlb("dryproduct") .. ":" .. _UA60 .. (_eUt1(_goPD) and "(" .. _Rns1(_goPD, true) .. ")" or "")
            _0CEU(_Fupd, _1TAT, "dryable")
        end
    end
    if _gLHU then
        local _aLCB = _gLHU.product
        _aLCB = _G7JA(_aLCB) and _aLCB(_cDVz) or _aLCB
        _aLCB = _jEEY(_aLCB)
        if _JJx1(_aLCB) then
            local _VHlc = _TOlb("cookproduct") .. ":" .. _aLCB
            _0CEU(_Fupd, _VHlc, "cookable")
        end
    end
    if _6xXG then
        local _TToC = _6xXG.targettime
        local _9gwf = _6xXG.stage
        local _h1S4 = _6xXG.stages
        if _eUt1(_TToC) then
            local _CJxu = _TToC - GetTime()
            local _89jU = _Msfj(_9gwf) and _WJWr(_h1S4) and "(" .. _Ju5z(_9gwf) .. "/" .. #_h1S4 .. ")" or ""
            local _WJzM = _TOlb("growable") .. ":" .. _Rns1(_CJxu) .. _89jU
            _0CEU(_Fupd, _WJzM, "growable")
        end
    end
    if _5Np7 then
        local _Kw4C = _5Np7.product_prefab
        _Kw4C = _jEEY(_Kw4C)
        local _h8lD = _5Np7.growthpercent
        local _aIja = _5Np7.rate
        if _JJx1(_Kw4C) then
            local _lD0a = _Msfj(_h8lD) and _h8lD <= 0x1 and " " .. _Ju5z(_h8lD * 0x64) .. "%" .. (_eUt1(_aIja) and "(" .. _Rns1((0x1 - _h8lD) / _aIja) .. ")" or "") or ""
            local _1Jv9 = _TOlb("crop") .. ":" .. _Kw4C .. _lD0a
            _0CEU(_Fupd, _1Jv9, "crop")
        end
    end
    if _qMdj then
        local _aGrA = _qMdj.product
        _aGrA = _jEEY(_aGrA)
        local _oiDV = _qMdj.produce
        local _xBqk = _qMdj.maxproduce
        local _uL1N = _qMdj.growtime
        if _JJx1(_aGrA) then
            local _l48i = _0ldE(_oiDV) and (_Ju5z(_oiDV) .. (_0ldE(_xBqk) and "/" .. _Ju5z(_xBqk) or "")) or ""
            local _Pp34 = _TOlb("harvest") .. ":" .. _aGrA .. _l48i .. (_eUt1(_uL1N) and "(" .. _Rns1(_uL1N, true) .. ")" or "")
            _0CEU(_Fupd, _Pp34, "harvestable")
        end
    end
    if _vbBt then
        local _AwiE = _vbBt.progress
        local _jj2n = _vbBt.cracktime
        local _nzLe = _vbBt.hatchtime
        local _fDo9 = _vbBt.state
        local _FzgI = _4FoG(_fDo9) and _fDo9 == "unhatched" and _jj2n or _nzLe
        if _Msfj(_AwiE) then
            local _r9QJ = _TOlb("hatchable") .. ":" .. _Ju5z(_AwiE) .. (_eUt1(_FzgI) and "/" .. _Ju5z(_FzgI) or "")
            _0CEU(_Fupd, _r9QJ, "hatchable")
        end
    end
    if _cACp then
        local _MmY7, max = _cACp.current, _G7JA(_cACp.GetMax) and _cACp:GetMax() or _cACp.total
        if _0ldE(_MmY7) and _eUt1(max) then
            local _LntV = _TOlb("uses") .. ":" .. (_Ju5z(_MmY7 * 0xa) / 0xa) .. "/" .. _Ju5z(max)
            _0CEU(_Fupd, _LntV, "finiteuses")
        end
    end
    if _QSik then
        local _Mxa1 = _QSik.repair_value
        if _eUt1(_Mxa1) then
            local _99Mo = _TOlb("sewing") .. _Ju5z(_Mxa1)
            _0CEU(_Fupd, _99Mo, "sewing")
        end
    end
    if _TLLb then
        local _Jc64, max = _TLLb.currentfuel, _G7JA(_TLLb.GetMax) and _TLLb:GetMax() or _TLLb.maxfuel
        local _aXHR = _TLLb.fueltype
        if _0ldE(_Jc64) and _eUt1(max) then
            _Jc64 = _e3Gk(_Jc64)
            max = _e3Gk(max)
            local _P8Np = _JJx1(_aXHR) and "(" .. _TOlb("fuel_" .. _aXHR, _aXHR) .. ")" or ""
            local _iuMA = _TOlb("fuel") .. _P8Np .. ":" .. _Jc64 .. "(" .. _Rns1(_Jc64, nil, true) .. ")/" .. max
            _0CEU(_Fupd, _iuMA, "fueled")
        end
    end
    if _1oBm then
        local _QI16 = _1oBm.fuelvalue
        local _u5Ma = _1oBm.fueltype
        if _eUt1(_QI16) then
            local _g0CS = _JJx1(_u5Ma) and "(" .. _TOlb("fuel_" .. _u5Ma, _u5Ma) .. ")" or ""
            local _Dw9F = _TOlb("fuel") .. _g0CS .. _Ju5z(_QI16)
            _0CEU(_Fupd, _Dw9F, "fuel")
        end
    end
    if _tIcu then
        local _X19p, max = _tIcu.perishremainingtime, _G7JA(_tIcu.GetMax) and _tIcu:GetMax() or _tIcu.perishtime
        local _cVJZ = _G7JA(_tIcu.IsSpoiled) and _tIcu:IsSpoiled()
        local _OgrM = _G7JA(_tIcu.IsStale) and _tIcu:IsStale()
        if _0ldE(_X19p) and _eUt1(max) then
            _X19p = _e3Gk(_X19p)
            max = _e3Gk(max)
            local _JdMr = _cVJZ and _TOlb("spoiled") or (_OgrM and _TOlb("stale")) or _TOlb("fresh")
            local _UJkB = _o42o and
                ((_o42o:HasTag("fridge") and (_cDVz:HasTag("frozen") and not _o42o:HasTag("nocool") and not _o42o:HasTag("lowcool") and TUNING.PERISH_COLD_FROZEN_MULT or TUNING.PERISH_FRIDGE_MULT)) or (_o42o:HasTag("spoiler") and _o42o:HasTag("poison") and TUNING.PERISH_POISON_MULT) or (_o42o:HasTag("spoiler") and TUNING.PERISH_GROUND_MULT)) or
                0x1
            _UJkB = _Msfj(_UJkB) and _UJkB or 0x1
            local _hP3N = _JdMr .. ":" .. _X19p .. (_UJkB > 0x0 and "(" .. _Rns1(_X19p / _UJkB, nil, true) .. ")" or "") .. "/" .. max
            _0CEU(_Fupd, _hP3N, "perishable")
        end
    end
    if _OrDe then
        local _A6Yk = _G7JA(_OrDe.NeedsRepairs) and _OrDe:NeedsRepairs()
        local _vZos = _OrDe.repairmaterial
        if _A6Yk then
            local _8iCq = _JJx1(_vZos) and "(" .. _TOlb("repairmaterial_" .. string.lower(_vZos), _vZos) .. ")" or ""
            local _vxy5 = _TOlb("repairable") .. _8iCq
            _0CEU(_Fupd, _vxy5, "repairable")
        end
    end
    if _CkXE then
        local _8cso = _CkXE.workrepairvalue
        local _N9Ac = _CkXE.healthrepairvalue
        local _nk73 = _CkXE.perishrepairvalue
        local _mIxi = _CkXE.userepairvalue
        _8cso = _eUt1(_8cso) and _TOlb("work") .. _e3Gk(_8cso)
        _N9Ac = _eUt1(_N9Ac) and _TOlb("health") .. _e3Gk(_N9Ac)
        _nk73 = _eUt1(_nk73) and _TOlb("freshness") .. _e3Gk(_nk73)
        _mIxi = _eUt1(_mIxi) and _TOlb("uses") .. _e3Gk(_mIxi)
        local _8vYf = _CkXE.repairmaterial
        if _8cso or _N9Ac or _nk73 or _mIxi then
            local _6zEZ = _JJx1(_8vYf) and "(" .. _TOlb("repairmaterial_" .. string.lower(_8vYf), _8vYf) .. ")" or ""
            local _18OA = _TOlb("repairer") .. _6zEZ .. ":" .. _f6os(" ", _8cso, _N9Ac, _nk73, _mIxi)
            _0CEU(_Fupd, _18OA, "repairer")
        end
    end
    if _4Wv8 then
        local _Lv6x = _4Wv8.charged
        local _lpCf = _4Wv8.cooldown_deadline
        local _xPaA = _4Wv8.cooldown_duration
        local _GW6k = _eUt1(_lpCf) and _lpCf - GetTime() or -0x1
        if _Lv6x or _GW6k >= 0x0 then
            local _1vgz = _GW6k >= 0x0 and _e3Gk(_GW6k) .. "(" .. _Rns1(_GW6k, nil, true) .. ")" or ""
            local _Vts9 = _eUt1(_xPaA) and "/" .. _e3Gk(_xPaA) or ""
            local _Is8J = _TOlb("cooldown") .. ":" .. (_Lv6x and _TOlb("done") or _1vgz .. _Vts9)
            _0CEU(_Fupd, _Is8J, "cooldown")
        end
    end
    if _8R3A then
        local _ICwO = _8R3A.health
        if _eUt1(_ICwO) then
            local _v9A2 = _TOlb("heal") .. ":" .. _e3Gk(_ICwO) .. _TOlb("health")
            _0CEU(_Fupd, _v9A2, "healer")
        end
    end
    if _cfZd then
        local _nKS6 = _cfZd.recipe
        local _fsVt = _jEEY(_nKS6)
        if _JJx1(_fsVt) then
            local _vyJk = _TOlb("unlock") .. ":" .. _fsVt
            _0CEU(_Fupd, _vyJk, "teacher")
        end
    end
    if _59LU then
        local _Dt7G = _G7JA(_59LU.GetEffectiveness) and _59LU:GetEffectiveness()
        if _eUt1(_Dt7G) then
            local _2oPs = _TOlb("waterproofer") .. ":" .. _Ju5z(_Dt7G * 0x64) .. "%"
            _0CEU(_Fupd, _2oPs, "waterproofer")
        end
    end
    if _1FUh then
        local _d7Y2 = _w7d4(_1FUh.type)
        local _q3G4 = _1FUh.insulation
        if _0ldE(_q3G4) then
            local _svfG = _TOlb("insulator") .. (_JJx1(_d7Y2) and "(" .. _d7Y2 .. ")" or "") .. ":" .. (_Ju5z(_q3G4 * 0xa) / 0xa)
            _0CEU(_Fupd, _svfG, "insulator")
        end
    end
    if _zu1x then
        local _ve6r = _G7JA(_zu1x.GetHeat) and _zu1x:GetHeat(_vrag())
        if _EqJc(_ve6r) then
            local _NkuD = _TOlb("heat") .. ":" .. (_Ju5z(_ve6r * 0xa) / 0xa)
            _0CEU(_Fupd, _NkuD, "heater")
        end
    end
    if _jjDw then
        local _H9Nk, max, min = _jjDw.current, _jjDw.maxtemp, _jjDw.mintemp
        if _0ldE(_H9Nk) then
            local _TYfp = _TOlb("temperature") .. ":" .. (_Ju5z(_H9Nk * 0xa) / 0xa) .. (_0ldE(max) and _0ldE(min) and "(" .. _Ju5z(min) .. "~" .. _Ju5z(max) .. ")" or "")
            _0CEU(_Fupd, _TYfp, "temperature")
        end
    end
    if _m9b0 then
        local _F0Wg = _G7JA(_m9b0.GetDapperness) and _m9b0:GetDapperness(_m9b0.owner or _vrag())
        if _0ldE(_F0Wg) and _F0Wg ~= 0x0 then
            local _tiYq = _TOlb("dapperness") .. ":" .. (_Ju5z(_F0Wg * 0x3e8) / 0x3e8)
            _0CEU(_Fupd, _tiYq, "dapperness")
        end
    end
    if _vyo0 then
        local _W0Qm = _vyo0.equipslot or _vyo0.boatequipslot
        local _V1a9 = _G7JA(_vyo0.GetWalkSpeedMult) and _vyo0:GetWalkSpeedMult() or _vyo0.walkspeedmult
        local _sdZz = _G7JA(_vyo0.GetDapperness) and _vyo0:GetDapperness(_vyo0.owner or _vrag())
        local _xQ3S = {}
        if _JJx1(_W0Qm) then table.insert(_xQ3S, _TOlb("equipslot") .. ":" .. _TOlb("equipslot_" .. _W0Qm, _W0Qm)) end
        if _eUt1(_V1a9) and _V1a9 ~= 0x1 then table.insert(_xQ3S, _TOlb("speed") .. _Ju5z(_V1a9 * 0x64) .. "%") end
        if _0ldE(_sdZz) and _sdZz ~= 0x0 then table.insert(_xQ3S, _TOlb("dapperness") .. (_Ju5z(_sdZz * 0x3e8) / 0x3e8)) end
        if #_xQ3S > 0x0 then
            local _4mUe = ""
            for _uNiC = 0x1, #_xQ3S do _4mUe = _4mUe .. (_uNiC > 0x1 and " " or "") .. _xQ3S[_uNiC] end
            _0CEU(_Fupd, _4mUe, "equippable")
        end
    end
    if _Oi6S then
        local _XryC = _TOlb("burnable") .. (_vd8b and " " .. _TOlb("propagator") or "")
        _0CEU(_Fupd, _XryC, "burnable")
    end
    if _VEY7 then
        local _I8mm = _VEY7.appeasementvalue
        if _0ldE(_I8mm) and _I8mm ~= 0x0 then
            local _pQEW = _TOlb("appeasement") .. ":" .. _I8mm
            _0CEU(_Fupd, _pQEW, "appeasement")
        end
    end
    if _JJx1(_8w7X) then
        local _DhRQ = _AyvO(_cDVz)
        if _eUt1(_DhRQ) then
            local _8N2Q = _TOlb("naughtyvalue") .. ":" .. _e3Gk(_DhRQ)
            _0CEU(_Fupd, _8N2Q, "naughtyvalue")
        end
    end
    if _WdOz then
        local _9Q2Z = _WdOz.goldvalue
        local _7emh = _TOlb("tradable") .. (_eUt1(_9Q2Z) and ":" .. _TOlb("goldvalue") .. _9Q2Z or "")
        _0CEU(_Fupd, _7emh, "tradable")
    end
    if _3hH6 then
        local _yU6i, max = _G7JA(_3hH6.NumItems) and _3hH6:NumItems(), _3hH6.maxslots
        local _RoyE = _3hH6.equipslots
        local _CHBt = _WJWr(_RoyE) and _lVV7(_RoyE) or 0x0
        local _0NjQ, str2, str3 = "", "", ""
        if _Msfj(_yU6i) and _eUt1(max) then
            _0NjQ = _Ju5z(_yU6i) .. "/" .. _Ju5z(max)
            if _yU6i + _CHBt <= 0x5 and _WJWr(_3hH6.itemslots) then
                local _lgoW = {}
                for _FdfQ, _VCCh in pairs(_3hH6.itemslots) do if _WJWr(_VCCh) and _JJx1(_VCCh.prefab) then table.insert(_lgoW, _jEEY(_VCCh.prefab) or "") end end
                str3 = _f6os(",", _lgoW)
                str3 = _JJx1(str3) and "(" .. str3 .. ")" or ""
            end
        end
        if _WJWr(_RoyE) then
            if _CHBt <= 0x5 then
                local _zJFE = {}
                for _WfXE, _Twfp in pairs(_RoyE) do if _WJWr(_Twfp) and _JJx1(_Twfp.prefab) then table.insert(_zJFE, _jEEY(_Twfp.prefab) or "") end end
                str2 = _f6os(",", _zJFE)
                str2 = _JJx1(str2) and "[" .. str2 .. "]" or ""
            else
                str2 = "[" .. _CHBt .. "]"
            end
        end
        if _JJx1(_0NjQ) or _JJx1(str2) then
            local _TnoB = _TOlb("inventory") .. ":" .. _0NjQ .. str3 .. str2
            _0CEU(_Fupd, _TnoB, "inventory")
        end
    end
    if _VPal then
        local _mIZw = _G7JA(_VPal.NumItems) and _VPal:NumItems()
        local _GlO0 = _G7JA(_VPal.GetNumSlots) and _VPal:GetNumSlots() or _VPal.numslots
        local _0AMu = _VPal.boatequipslots
        local _Ppwo = _WJWr(_0AMu) and _lVV7(_0AMu) or 0x0
        local _Vre3, str2 = "", ""
        if _Msfj(_mIZw) and _eUt1(_GlO0) then
            _Vre3 = _Ju5z(_mIZw) .. "/" .. _Ju5z(_GlO0)
            if _WJWr(_VPal.slots) then
                local _c6HV = {}
                local _ZP7Y = _mIZw + _Ppwo > 0x5
                for _a8dr, _ZNEn in pairs(_VPal.slots) do
                    if _WJWr(_ZNEn) and _JJx1(_ZNEn.prefab) then table.insert(_c6HV, _jEEY(_ZNEn.prefab) or "") end
                    if _ZP7Y and #_c6HV > 0x0 then break end
                end
                local _NgKo = _f6os(",", _c6HV)
                _NgKo = _JJx1(_NgKo) and "(" .. _NgKo .. (_ZP7Y and "..." or "") .. ")" or ""
                _Vre3 = _Vre3 .. _NgKo
            end
        end
        if _WJWr(_0AMu) then
            if _Ppwo <= 0x5 then
                local _4ONw = {}
                for _DDYD, _91EB in pairs(_0AMu) do if _WJWr(_91EB) and _JJx1(_91EB.prefab) then table.insert(_4ONw, _jEEY(_91EB.prefab) or "") end end
                str2 = _f6os(",", _4ONw)
                str2 = _JJx1(str2) and "[" .. str2 .. "]" or ""
            else
                str2 = "[" .. _Ppwo .. "]"
            end
        end
        local _juzp = _Vre3 .. str2
        if _JJx1(_juzp) then
            _juzp = _TOlb("container") .. ":" .. _juzp
            _0CEU(_Fupd, _juzp, "container")
        end
    end
    if _Hfgd then
        local _adH1 = _Hfgd.itemdata
        local _nZ02 = _WJWr(_adH1) and #_adH1
        if _eUt1(_nZ02) then
            local _wuFb = _TOlb("contains") .. ":"
            if _nZ02 <= 0x5 then
                local _ViKO = 0x1
                for _Q08x = 0x1, _nZ02 do
                    local _slsv = _WJWr(_adH1[_Q08x]) and _adH1[_Q08x].prefab
                    local _0DZi = _WJWr(_adH1[_Q08x]) and _adH1[_Q08x].data
                    local _DLiE = _WJWr(_0DZi) and _0DZi.stackable
                    local _oonJ = _WJWr(_DLiE) and _DLiE.stack
                    _oonJ = _eUt1(_oonJ) and _oonJ > 0x1 and _e3Gk(_oonJ)
                    local _JTaf = _jEEY(_slsv)
                    if _JJx1(_JTaf) then
                        _wuFb = _wuFb .. (_ViKO > 0x1 and ", " or "") .. _JTaf .. (_oonJ and " x" .. _oonJ or "")
                        _ViKO = _ViKO + 0x1
                    end
                end
            else
                _wuFb = _wuFb .. _Ju5z(_nZ02) .. _TOlb("items")
            end
            _0CEU(_Fupd, _wuFb, "unwrappable")
        end
    end
    if _d8RH then
        local _XV9i = _d8RH.childname
        _XV9i = _jEEY(_XV9i)
        local _8WS1 = _d8RH.rarechild
        _8WS1 = _jEEY(_8WS1)
        local _r0Vs = _d8RH.childreninside
        local _wb7Y = _d8RH.numchildrenoutside
        local _VlaU = _d8RH.maxchildren
        if _JJx1(_XV9i) then
            local _aRyV = _d8RH.regening
            local _maWH = ""
            if _aRyV and _Msfj(_r0Vs) and _Msfj(_wb7Y) and _eUt1(_VlaU) and _wb7Y + _r0Vs < _VlaU then
                local _5ae7 = _d8RH.regenperiod
                local _Z2JH = _d8RH.timetonextregen
                if _eUt1(_5ae7) and _Msfj(_Z2JH) then _maWH = " " .. _TOlb("regen") .. ":" .. _Ju5z(_Z2JH) .. "(" .. _Rns1(_Z2JH, nil, true) .. ")/" .. _Ju5z(_5ae7) end
            end
            local _mjxd = _TOlb("spawner") .. "(" .. _XV9i .. (_JJx1(_8WS1) and "," .. _8WS1 or "") .. ")"
            local _U81M = _Msfj(_r0Vs) and _Msfj(_wb7Y) and _eUt1(_VlaU) and ":[" .. _r0Vs .. "+" .. _wb7Y .. "]/" .. _VlaU
            _mjxd = _mjxd .. (_JJx1(_U81M) and _U81M or "") .. (_JJx1(_maWH) and _maWH or "")
            _0CEU(_Fupd, _mjxd, "childspawner")
        end
    end
    if _VUfT then
        local _0Zin = _WJWr(_VUfT.child) and _VUfT.child or nil
        local _ryYy = _G7JA(_VUfT.GetChildName) and _VUfT:GetChildName() or _VUfT.childname
        _ryYy = _jEEY(_ryYy)
        local _Tpff = _VUfT.nextspawntime
        _Tpff = _0ldE(_Tpff) and _Tpff or 0x0
        local _wn57 = _VUfT.delay
        _wn57 = _0ldE(_wn57) and _wn57 or 0x0
        local _ak5q = _Tpff - GetTime()
        if _JJx1(_ryYy) then
            local _WXCD = _G7JA(_VUfT.IsOccupied) and _VUfT:IsOccupied()
            local _CzLL = _WXCD and _TOlb("occupied") or _TOlb("empty")
            local _X69c = (not _0Zin or _WXCD) and _VUfT.task ~= nil and _ak5q > 0x0 and _wn57 > 0x0 and
                " " .. (_WXCD and _TOlb("release") or _TOlb("regen")) .. ":" .. _Ju5z(_ak5q) .. "(" .. _Rns1(_ak5q, nil, true) .. ")/" .. _Ju5z(_wn57) or ""
            local _0V5w = _TOlb("spawner") .. "(" .. _ryYy .. "):" .. _CzLL .. _X69c
            _0CEU(_Fupd, _0V5w, "spawner")
        end
    end
    if _zxqP then
        local _2JqG = _G7JA(_zxqP.GetEnchanter) and _zxqP:GetEnchanter()
        local _mQoJ = _WJWr(_2JqG) and _G7JA(_2JqG.GetDisplayString) and _2JqG:GetDisplayString()
        if _JJx1(_mQoJ) then
            local _XDk9 = _TOlb("enchantments") .. ":" .. _mQoJ
            _0CEU(_Fupd, _XDk9, "inventoryitem")
        end
    end
    if _IbWw then
        local _nAdK = _IbWw.numcycles
        local _cL0c = _G7JA(_IbWw.GetNormTime) and _IbWw:GetNormTime()
        if _Msfj(_nAdK) and _Msfj(_cL0c) then
            local _wOV1 = _HvQ6(_nAdK, _cL0c)
            local _XmKX = _TOlb("moonphase") .. ":" .. _AYSj(_nAdK) .. "/4" .. (_wOV1 > 0x0 and ", " .. string.format(_TOlb("fullmoontimer"), _Rns1(_wOV1)) or ", " .. _TOlb("fullmoontimer2"))
            _0CEU(_Fupd, _XmKX, "clock")
        end
    end
    if _wZLO then
        local _qdpL = _G7JA(_wZLO.GetSeason) and _wZLO:GetSeason() or _wZLO.current_season
        local _rJfA = _G7JA(_wZLO.GetPercentSeason) and _wZLO:GetPercentSeason() or _wZLO.percent_season
        local _4zdf = _G7JA(_wZLO.GetSeasonLength) and _wZLO:GetSeasonLength()
        local _J2Q8 = _0ldE(_rJfA) and _0ldE(_4zdf) and _rJfA * _4zdf
        local _pMxx = _w7d4(_qdpL)
        if _JJx1(_pMxx) then
            _pMxx = _TOlb("season") .. ":" .. _pMxx
            local _2z9o = _pMxx .. (_Msfj(_J2Q8) and _Msfj(_4zdf) and ", " .. _Ju5z(_J2Q8 + 0x1) .. _TOlb("timer_day") .. "/" .. _Ju5z(_4zdf) .. _TOlb("timer_day") or "")
            _0CEU(_Fupd, _2z9o, "seasonmanager")
        end
    end
    if _ev1b then
        local _43an = _ev1b.phase
        local _YyTa = _G7JA(_ev1b.GetTimeLeftInEra) and _ev1b:GetTimeLeftInEra()
        if _JJx1(_43an) and _Msfj(_YyTa) then
            local _fBtT = _TOlb("nightmareclock") .. "(" .. _TOlb("nightmareclock_" .. _43an, _43an) .. "):" .. string.format(_TOlb("nightmareclocktimer"), _Rns1(_YyTa))
            _0CEU(_Fupd, _fBtT, "nightmareclock")
        end
    end
    if _uFJj then
        local _oJRO = _uFJj.houndstorelease
        _oJRO = _0ldE(_oJRO) and _oJRO or 0x0
        local _uNPN = _uFJj.timetoattack
        _uNPN = _0ldE(_uNPN) and _uNPN or 0x0
        local _IVDD = _uFJj.timetonexthound
        _IVDD = _0ldE(_IVDD) and _IVDD or 0x0
        local _8WLk = ""
        if _uNPN > 0x0 and _oJRO > 0x0 then
            _8WLk = string.format(_TOlb("houndtimer"), _Ju5z(_oJRO * 0xa) / 0xa, _Rns1(_uNPN))
        elseif _IVDD > 0x0 and _oJRO > 0x0 then
            _8WLk = string.format(
                _TOlb("houndtimer2"), _Ju5z(_oJRO * 0xa) / 0xa, _Rns1(_IVDD))
        end
        if _JJx1(_8WLk) then _0CEU(_Fupd, _8WLk, "hounded") end
    end
    if _uL7o then
        local _Ym40 = _uL7o.timetoattack
        local _daQy = _l7zs(_uL7o)
        _daQy = _0ldE(_daQy) and _daQy or 0x0
        _Ym40 = _0ldE(_Ym40) and _Ym40 or 0x0
        if _Ym40 > 0x0 then
            local _J2LG = string.format(_TOlb("battimer"), _Ju5z(_daQy), _Rns1(_Ym40))
            _0CEU(_Fupd, _J2LG, "batted")
        end
    end
    if _1rf9 then
        local _Pcai = _1rf9.nextquake
        if _eUt1(_Pcai) then
            local _J6UQ = string.format(_TOlb("quaketimer"), _Rns1(_Pcai))
            _0CEU(_Fupd, _J6UQ, "quaker")
        end
    end
    if _iVlp then
        local _5Tdo = _G7JA(_iVlp.GetNumSegmentsUntilEruption) and _iVlp:GetNumSegmentsUntilEruption()
        local _UwQj = _Msfj(TUNING.SEG_TIME) and TUNING.SEG_TIME
        local _zGob = _Msfj(TUNING.TOTAL_DAY_TIME) and TUNING.TOTAL_DAY_TIME
        if _Msfj(_5Tdo) and _UwQj and _zGob then
            local _WJm2 = math.floor(_zGob * GetClock():GetNormTime() / _UwQj) * _UwQj
            _WJm2 = _zGob * GetClock():GetNormTime() - _WJm2
            local _GDQn = _5Tdo * _UwQj - _WJm2
            local _2sfC = string.format(_TOlb("volcanotimer"), _Rns1(_GDQn))
            _0CEU(_Fupd, _2sfC, "volcanomanager")
        end
    end
    if _648X then
        local _bj7F = _648X.hasslers
        if _WJWr(_bj7F) and next(_bj7F) then
            for _Uv4b, _c5pe in pairs(_bj7F) do
                local _jQfR = _c5pe.timer
                local _uG8c = _c5pe.chance
                local _NJTg = _jEEY(_c5pe.prefab) or ""
                local _0hLf = _G7JA(_648X.GetHasslerState) and _648X:GetHasslerState(_Uv4b)
                local _qHXM = _JJx1(_0hLf) and (_0hLf == "WAITING" or _0hLf == "WARNING") and "(" .. _TOlb("timer_" .. _0hLf) .. (_eUt1(_uG8c) and _0hLf ~= "WARNING" and "," .. _sKSk(_uG8c) or "") ..
                    ")" or ""
                if _JJx1(_NJTg) and _JJx1(_qHXM) and _eUt1(_uG8c) then
                    local _NKmL = _NJTg .. _qHXM .. (_0ldE(_jQfR) and ":" .. _Rns1(_jQfR) or "")
                    _0CEU(_Fupd, _NKmL, "basehassler")
                end
            end
        end
    end
    if _F7TB then
        local _zlze = _F7TB.threats
        if _WJWr(_zlze) and next(_zlze) then
            for _Lm91, _uhSZ in pairs(_zlze) do
                local _x92w = _jEEY(_Lm91)
                local _tcYB = _G7JA(_F7TB.GetCurrentState) and _F7TB:GetCurrentState(_Lm91)
                local _A0PM = _JJx1(_tcYB) and "(" .. _TOlb("periodicthreat_" .. _tcYB, _tcYB) .. ")" or ""
                if _JJx1(_x92w) and _WJWr(_uhSZ) and _eUt1(_uhSZ.timer) then
                    local _TZVF = _x92w .. _A0PM .. ":" .. _Rns1(_uhSZ.timer)
                    _0CEU(_Fupd, _TZVF, "periodicthreat")
                end
            end
        end
    end
    if _Xrmb then
        local _iMBI = _G7JA(_Xrmb.TimeUntilRespawn) and _Xrmb:TimeUntilRespawn()
        _iMBI = _eUt1(_iMBI) and _iMBI or 0x0
        local _DErj = _G7JA(_Xrmb.TimeUntilCanAppear) and _Xrmb:TimeUntilCanAppear()
        _DErj = _eUt1(_DErj) and _DErj or 0x0
        local _h4BA = math.max(_iMBI, _DErj)
        local _K1WS = _G7JA(_Xrmb.CanSpawn) and _Xrmb:CanSpawn()
        local _yWRr = _jEEY("tigershark") or ""
        if _JJx1(_yWRr) and (_K1WS or _h4BA > 0x0) then
            local _OBtL = _yWRr .. (_K1WS and ":" .. _TOlb("timer_ready") or ":" .. _Rns1(_h4BA))
            _0CEU(_Fupd, _OBtL, "tigersharker")
        end
    end
    if _8512 then
        local _VUlI = _G7JA(_8512.TimeUntilCanSpawn) and _8512:TimeUntilCanSpawn()
        _VUlI = _eUt1(_VUlI) and _VUlI or 0x0
        local _FWvW = _G7JA(_8512.CanSpawn) and _8512:CanSpawn()
        local _BETR = _jEEY("kraken") or ""
        if _JJx1(_BETR) and (_FWvW or _VUlI > 0x0) then
            local _Qjw3 = _BETR .. (_FWvW and ":" .. _TOlb("timer_ready") or ":" .. _Rns1(_VUlI))
            _0CEU(_Fupd, _Qjw3, "krakener")
        end
    end
    if _ukJ5 then
        local _RToz = _ukJ5.dycSpawnTime
        local _Lx1I = _0ldE(_RToz) and _RToz - GetTime() or 0x0
        local _e6o7 = _ukJ5.disabled
        local _hD0R = STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.ROC or ""
        if _JJx1(_hD0R) and not _e6o7 and _Lx1I > 0x0 then
            local _s0WS = _hD0R .. ":" .. _Rns1(_Lx1I)
            _0CEU(_Fupd, _s0WS, "rocmanager")
        end
    end
    if _cDVz.GetPanelDescriptions then
        local _tTNv = _cDVz:GetPanelDescriptions()
        if #_tTNv > 0x0 then
            for _IO9g = 0x1, #_tTNv do
                if _tTNv[_IO9g] then
                    local _ieco = _tTNv[_IO9g].text
                    _0CEU(_Fupd, _ieco, "custom")
                end
            end
        end
    end
    return _Fupd
end
return _yAhs
