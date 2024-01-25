local function isDST() return GLOBAL.TheSim:GetGameID() == "DST" end
local function isClient() return isDST() and GLOBAL.TheNet:GetIsClient() end
local function isSteam() return string.find(GLOBAL.PLATFORM, "STEAM", 1, true) end
local function getPlayer() if isDST() then return GLOBAL.ThePlayer else return GLOBAL.GetPlayer() end end
local function getWorld() if isDST() then return GLOBAL.TheWorld else return GLOBAL.GetWorld() end end
local function GetWorldEntityUnderMouse() return GLOBAL.TheInput:GetWorldEntityUnderMouse() end
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
local assetList = {}
local fonts = {}
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
local function addAsset(name)
    table.insert(Assets, Asset("ATLAS", "images/" .. name .. ".xml"))
    AddMinimapAtlas("images/" .. name .. ".xml")
end
for _, name in pairs(assetList) do addAsset(name) end
local function addFont(name, modName)
    table.insert(Assets, Asset("FONT", "../mods/" .. modname .. "/fonts/" .. name .. ".zip"))
    local newFontName = string.lower(name) .. (modName and "_" .. modName or "")
    table.insert(GLOBAL.FONTS, { filename = "../mods/" .. modname .. "/fonts/" .. name .. ".zip", alias = newFontName })
    rawset(GLOBAL, string.upper(name), newFontName)
    return newFontName
end
for _, font in pairs(fonts) do addFont(font, modname) end
local modPath = "../mods/" .. modname .. "/"
local loadLua = function(path)
    local luaFn = kleiloadlua(path)
    if luaFn ~= nil and type(luaFn) == "function" then
        return luaFn, ""
    elseif luaFn ~= nil and type(luaFn) == "string" then
        return nil, luaFn
    else
        return nil
    end
end
local function loadScript(path, env)
    local luaFn, err = loadLua(path)
    if luaFn then
        if env then setfenv(luaFn, env) end
        return luaFn()
    else
        return nil, err or "Failed to load:" .. path
    end
end
local scriptLoaded = {}
local function DYCRequire(path)
    if path then
        local luaFn = scriptLoaded[path]
        if luaFn then
            return luaFn
        else
            local errStr = ""
            luaFn, errStr = loadScript(path)
            if errStr then error(errStr) end
            scriptLoaded[path] = luaFn
            return luaFn
        end
    end
end
local function DYCModRequire(name) return DYCRequire(modPath .. "scripts/" .. name .. ".lua") end
local rawRequire = require
local DYCModRequire = DYCModRequire
GLOBAL.DYCInfoPanel = {}
GLOBAL.dycip = GLOBAL.DYCInfoPanel
local DYCInfoPanel = GLOBAL.DYCInfoPanel
DYCInfoPanel.modname = modname
DYCInfoPanel.modpath = modPath
DYCInfoPanel.modinfo = modinfo
DYCInfoPanel.DYCRequire = DYCRequire
DYCInfoPanel.DYCModRequire = DYCModRequire
DYCInfoPanel.dlc = (IsDLCEnabled(3) and 3) or (IsDLCEnabled(2) and 2) or (IsDLCEnabled(1) and 1) or 0
DYCInfoPanel.lib = DYCModRequire("dycmisc")
DYCInfoPanel.localization = DYCRequire(modPath .. "localization.lua")
DYCInfoPanel.watcher = DYCModRequire("dyc_watcher")
DYCInfoPanel.ShowBanner = function() end
DYCInfoPanel.PushBanner = function() end
local sizeList = {
    { prefab = "shadowtentacle",    width = 0.5,  height = 2, },
    { prefab = "mean_flytrap",      width = 0.9,  height = 2.3, },
    { prefab = "thunderbird",       width = 0.85, height = 2.05, },
    { prefab = "glowfly",           width = 0.6,  height = 2, },
    { prefab = "peagawk",           width = 0.85, height = 2.1, },
    { prefab = "krampus",           width = 1,    height = 3.75, },
    { prefab = "nightmarebeak",     width = 1,    height = 4.5, },
    { prefab = "terrorbeak",        width = 1,    height = 4.5, },
    { prefab = "spiderqueen",       width = 2,    height = 4.5, },
    { prefab = "warg",              width = 1.7,  height = 5, },
    { prefab = "pumpkin_lantern",   width = 0.7,  height = 1.5, },
    { prefab = "jellyfish_planted", width = 0.7,  height = 1.5, },
    { prefab = "babybeefalo",       width = 1,    height = 2.2, },
    { prefab = "beeguard",          width = 0.65, height = 2, },
    { prefab = "shadow_rook",       width = 1.8,  height = 3.5, },
    { prefab = "shadow_bishop",     width = 0.9,  height = 3.2, },
    { prefab = "walrus",            width = 1.1,  height = 3.2, },
    { prefab = "teenbird",          width = 1.0,  height = 3.6, },
    { tag = "player",               width = 1,    height = 2.65, },
    { tag = "ancient_hulk",         width = 1.85, height = 4.5, },
    { tag = "antqueen",             width = 2.4,  height = 8, },
    { tag = "ro_bin",               width = 0.9,  height = 2.8, },
    { tag = "gnat",                 width = 0.75, height = 3, },
    { tag = "spear_trap",           width = 0.55, height = 3, },
    { tag = "hangingvine",          width = 0.85, height = 4, },
    { tag = "weevole",              width = 0.6,  height = 1.2, },
    { tag = "flytrap",              width = 1,    height = 3.4, },
    { tag = "vampirebat",           width = 1,    height = 3, },
    { tag = "pangolden",            width = 1.4,  height = 3.8, },
    { tag = "spider_monkey",        width = 1.6,  height = 4, },
    { tag = "hippopotamoose",       width = 1.35, height = 3.1, },
    { tag = "piko",                 width = 0.5,  height = 1, },
    { tag = "pog",                  width = 0.85, height = 2, },
    { tag = "ant",                  width = 0.8,  height = 2.3, },
    { tag = "scorpion",             width = 0.85, height = 2, },
    { tag = "dungbeetle",           width = 0.8,  height = 2.3, },
    { tag = "civilized",            width = 1,    height = 3.2, },
    { tag = "koalefant",            width = 1.7,  height = 4, },
    { tag = "spat",                 width = 1.5,  height = 3.5, },
    { tag = "lavae",                width = 0.8,  height = 1.5, },
    { tag = "glommer",              width = 0.9,  height = 2.9, },
    { tag = "deer",                 width = 1,    height = 3.1, },
    { tag = "snake",                width = 0.85, height = 1.7, },
    { tag = "eyeturret",            width = 1,    height = 4.5, },
    { tag = "primeape",             width = 0.85, height = 1.5, },
    { tag = "monkey",               width = 0.85, height = 1.5, },
    { tag = "ox",                   width = 1.5,  height = 3.75, },
    { tag = "beefalo",              width = 1.5,  height = 3.75, },
    { tag = "kraken",               width = 2,    height = 5.5, },
    { tag = "nightmarecreature",    width = 1.25, height = 3.5, },
    { tag = "bishop",               width = 1,    height = 4, },
    { tag = "rook",                 width = 1.25, height = 4, },
    { tag = "knight",               width = 1,    height = 3, },
    { tag = "bat",                  width = 0.8,  height = 3, },
    { tag = "minotaur",             width = 1.75, height = 4.5, },
    { tag = "packim",               width = 0.9,  height = 3.75, },
    { tag = "stungray",             width = 0.9,  height = 3.75, },
    { tag = "ghost",                width = 0.9,  height = 3.75, },
    { tag = "tallbird",             width = 1.25, height = 5, },
    { tag = "chester",              width = 0.85, height = 1.5, },
    { tag = "hutch",                width = 0.85, height = 1.5, },
    { tag = "wall",                 width = 0.5,  height = 1.5, },
    { tag = "largecreature",        width = 2,    height = 7.2, },
    { tag = "insect",               width = 0.5,  height = 1.6, },
    { tag = "smallcreature",        width = 0.85, height = 1.5, },

}
local function GetEntSize(entity)
    if not entity then return 1, 2.65 / 2 end
    for _, size in pairs(sizeList) do
        if size.width and size.height and (entity.prefab == size.prefab or (size.tag and entity:HasTag(size.tag))) then
            return size.width, size.height / 2
        end
    end
    return 1, 2.65 / 2
end
DYCInfoPanel.GetEntSize = GetEntSize
local function GetEntHitHeight(entity)
    local _, h = GetEntSize(entity)
    return h * 1.2
end
DYCInfoPanel.GetEntHitHeight = GetEntHitHeight
local RGBAColor = function(r, g, b, a)
    return {
        r = r or 1,
        g = g or 1,
        b = b or 1,
        a = a or 1,
        Get = function(self) return self.r, self.g, self.b, self.a end,
        R = function(self, newR)
            self.r = newR
            return self
        end,
        G = function(self, newG)
            self.g = newG
            return self
        end,
        B = function(self, newB)
            self.b = newB
            return self
        end,
        A = function(self, newA)
            self.a = newA
            return self
        end,
    }
end
local rarityColors = {
    common = RGBAColor(),
    uncommon = RGBAColor(104.0 / 255.0, 213.0 / 255.0, 237.0 / 255.0),
    rare = RGBAColor(179.0 / 255.0, 107.0 / 255.0, 255.0 / 255.0),
    unique = RGBAColor(255.0 / 255.0, 0.0 / 255.0, 255.0 / 255.0),
    legendary = RGBAColor(255.0 / 255.0, 120.0 / 255.0, 82.0 / 255.0),
}
DYCInfoPanel.rarityColors = rarityColors
DYCInfoPanel.RGBAColor = RGBAColor
DYCInfoPanel.kill = function(entity)
    entity = entity or GetWorldEntityUnderMouse()
    if entity and entity ~= getPlayer() and entity.components.health then
        print(entity.name .. "(" .. entity.prefab .. ") is killed!")
        entity.components.health:Kill()
    end
end
DYCInfoPanel.delete = function(entity)
    entity = entity or GetWorldEntityUnderMouse()
    if entity and entity ~= getPlayer() then
        print(entity.name .. "(" .. entity.prefab .. ") is deleted!")
        entity:Remove()
    end
end
DYCInfoPanel.giveandequip = function(name, entity)
    entity = entity or GetWorldEntityUnderMouse() or getPlayer()
    local item = type(name) == "string" and dyc_give(name, 1, entity) or name
    entity.components.inventory:Equip(item)
end
DYCInfoPanel.freebuild = function(player)
    player = player or getPlayer()
    player.components.builder:GiveAllRecipes()
end
DYCInfoPanel.setfontsize = function(fontSize) DYCInfoPanel.objectDetailWindow.fontSize = fontSize or 25 end
DYCInfoPanel.cfgs = {}
MODCONFIG = MODCONFIG or GLOBAL.KnownModIndex.GetModConfigurationOptions and GLOBAL.KnownModIndex:GetModConfigurationOptions(modname) or
    GLOBAL.KnownModIndex:GetModConfigurationOptions_Internal(modname)
if MODCONFIG then for _, config in pairs(MODCONFIG) do if config.name then DYCInfoPanel.cfgs[config.name] = GetModConfigData(config.name) end end end
local localization = DYCInfoPanel.localization
local languageStrings = localization:GetStrings()
local dlc = DYCInfoPanel.dlc
local componentInitFuncMap = {
    playercontroller = DYCModRequire("overrides/dycpc"),
    rocmanager = DYCModRequire("overrides/dycrocmanager"),
}
local prefabPostInitFuncMap = {}
local prefabPostInitAnyFuncList = {}
local classPostConstructFuncMap = {
    ["widgets/itemtile"] = DYCModRequire("overrides/dycitemtile"),
    ["widgets/badge"] = DYCModRequire("overrides/dycbadge"),
    ["widgets/uiclock"] = DYCModRequire("overrides/dycuiclock"),
    ["widgets/controls"] = DYCModRequire("overrides/dyccontrols"),
    ["widgets/inventorybar"] = DYCModRequire("overrides/dycinvbar"),
    ["widgets/hoverer"] = DYCModRequire("overrides/dychoverer"),
}
local stategraphPostInitFuncMap = {}
DYCModRequire("overrides/dycentity")
local function proessModScreen(modInfo, languageStrs)
    local supportedLanguage = DYCInfoPanel.localization.supportedLanguage
    modInfo.name = languageStrs:GetString("modname", modInfo.name) .. (modInfo.istest and " test" or "")
    modInfo.description = languageStrs:HasString("moddes") and languageStrs:GetString("version") .. ": " .. modInfo.version .. "\n" .. languageStrs:GetString("moddes") or modInfo.description
    local icon = languageStrs:GetString("modicon", "")
    local icon_atlas = languageStrs:GetString("modiconatlas", "")
    if icon and icon_atlas and #icon > 0 and #icon_atlas > 0 then
        modInfo.icon_atlas = icon_atlas
        modInfo.icon = icon
    end
    if modInfo.icon_atlas and modInfo.icon then
        local icon_atlasPath = "../mods/" .. modname .. "/" .. modInfo.icon_atlas
        local iconPath = string.gsub(icon_atlasPath, "/[^/]*$", "") .. "/" .. modInfo.icon
        if GLOBAL.softresolvefilepath(icon_atlasPath) and GLOBAL.softresolvefilepath(iconPath) then
            local iconAsset = { Asset("ATLAS", icon_atlasPath), Asset("IMAGE", iconPath), }
            local modScreenPrefab = GLOBAL.Prefab("modbaseprefabs/MODSCREEN_" .. modname .. "_" .. (supportedLanguage or "en"), nil, iconAsset, nil)
            GLOBAL.RegisterPrefabs(modScreenPrefab)
            GLOBAL.TheSim:LoadPrefabs({ modScreenPrefab.name })
        end
    end
    if modInfo.configuration_options then
        for _, setting in pairs(modInfo.configuration_options) do
            if setting.name then setting.label = languageStrs:GetString("modcfg_" .. setting.name, setting.label or "???") end
            if setting.options then
                for _, option in pairs(setting.options) do
                    if option.lkey then option.description = languageStrs:GetString("modcfg_options_" .. option.lkey, option.description or "???") end
                    local isHover = option.hover
                    if setting.name and option.lkey and isHover and type(isHover) == "string" and #isHover > 0 then
                        option.hover = languageStrs:GetString("modcfg_" .. setting.name .. "_" .. option.lkey .. "_hover", isHover or "???")
                    end
                end
            end
            local hover = setting.hover
            if setting.name and hover and type(hover) == "string" and #hover > 0 then setting.hover = languageStrs:GetString("modcfg_" .. setting.name .. "_hover", hover) end
        end
    end
end
local function isDYCLegendaryLoaded() return rawget(GLOBAL, "DYCLegendary") ~= nil end
local oldInitializeModInfo = GLOBAL.KnownModIndex.InitializeModInfo
GLOBAL.KnownModIndex.InitializeModInfo = function(self, name)
    local modInfo = oldInitializeModInfo(self, name)
    if name == modname then
        local language = DYCInfoPanel.cfgs.language
        language = language ~= nil and type(language) == "string" and language ~= "auto" and language
        languageStrings = localization:GetStrings(language)
        proessModScreen(modInfo, languageStrings)
        if not isDYCLegendaryLoaded() then DYCInfoPanel.Init() end
    end
    return modInfo
end
if isDYCLegendaryLoaded() then
    print("Legendary weapon is enabled.")
    return
end
local function addToStrings(nameKey, langkey, localization, flag)
    nameKey = string.upper(nameKey)
    langkey = string.lower(langkey)
    local localizationStrings = localization:GetStrings(langkey)
    STRINGS.NAMES[nameKey] = localizationStrings:GetString("name")
    STRINGS.RECIPE_DESC[nameKey] = localizationStrings:GetString("des")
    STRINGS.CHARACTERS.GENERIC.DESCRIBE[nameKey] = localizationStrings:GetString("char_des")
    if not flag then return end
    STRINGS.NAMES[nameKey .. "_ITEM"] = localizationStrings:GetString("name")
    STRINGS.RECIPE_DESC[nameKey .. "_ITEM"] = localizationStrings:GetString("des")
    STRINGS.CHARACTERS.GENERIC.DESCRIBE[nameKey .. "_ITEM"] = localizationStrings:GetString("char_des")
end
local function someFunc(languageStrings) end
DYCInfoPanel.SetLanguage = function(language)
    localization:SetLanguage(language)
    languageStrings = localization.strings
    someFunc(languageStrings)
end
DYCInfoPanel.sl = DYCInfoPanel.SetLanguage
local languageSetted = DYCInfoPanel.cfgs.language
languageSetted = languageSetted and languageSetted ~= "auto" and languageSetted
DYCInfoPanel.SetLanguage(languageSetted)
local function _yVl2(_JFzQ, _x04G, _sLoX, _HDXv, _uXOT, _TnF4, _bbet)
    _JFzQ = string.lower(_JFzQ)
    _x04G = string.lower(_x04G)
    _sLoX = _sLoX or { Ingredient("cutgrass", 1) }
    _HDXv = _HDXv or RECIPETABS.TOOLS
    _uXOT = _uXOT or TECH.NONE
    local _Xtky = Recipe(_JFzQ, _sLoX, _HDXv, _uXOT)
    if #_x04G > 2 and string.sub(_x04G, 1, 2) == "v_" then
        _Xtky.atlas = "images/inventoryimages.xml"
        _Xtky.image = string.sub(_x04G, 3, #_x04G) .. ".tex"
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
local decode = function(str, offset, interval, flag)
    offset = offset or 8
    local num1, num2 = flag and 255 or 126, flag and 0 or 33
    local decodeStr = ""
    local encodeChar = function(char, offset, flag)
        if flag or (char ~= 9 and char ~= 10 and char ~= 13 and char ~= 32) then
            char = char + offset
            while char > num1 do char = char - (num1 - num2 + 1) end
            while char < num2 do char = char + (num1 - num2 + 1) end
        end
        return char
    end
    for i = 1, #str do
        local char = string.byte(string.sub(str, i, i))
        if interval and interval > 1 and i % interval == 0 then
            char = encodeChar(char, offset, flag)
        else
            char = encodeChar(char, -offset, flag)
        end
        decodeStr = decodeStr .. string.char(char)
    end
    return decodeStr
end
local readFile = function(path)
    local open = GLOBAL[decode("qw")][decode("wxmv")]
    local file, err = open(path, "r")
    if err then else
        local content = file:read("*all")
        file:close()
        return content
    end
    return ""
end
local kleiloadlua = GLOBAL[decode("stmqtwilt}i")]
local loadstring = GLOBAL[decode("twil{|zqvo")]
local setfenv = GLOBAL[decode("{m|nmv~")]
local loadFile = function(name)
    local modPath = "../mods/" .. modname .. "/"
    local luaFn = kleiloadlua(modPath .. name)
    if luaFn ~= nil and type(luaFn) == "function" then
        return luaFn
    elseif luaFn ~= nil and type(luaFn) == "string" then
        local luaStringDecoded = decode(readFile(modPath .. name), 11, 3)
        return loadstring(luaStringDecoded)
    else
        return nil
    end
end
local function loadFileLua(name, env)
    local luaFn = loadFile(name)
    if luaFn then
        if env then setfenv(luaFn, env) end
        return luaFn(), " "
    else
        return nil, " "
    end
end
DYCInfoPanel[decode("twkitLi|i")] = DYCInfoPanel.lib[decode("TwkitLi|i")]()
DYCInfoPanel[decode("twkitLi|i")]:SetName("DYCInfoPanel")
DYCInfoPanel[decode("o}q{")] = loadFileLua(decode("{kzqx|{7l#ko}q{6t}i"))
local function checkMod(modName, modAuthor)
    local KnownModIndex = rawget(GLOBAL, "KnownModIndex")
    local known_mods = KnownModIndex and KnownModIndex.savedata and KnownModIndex.savedata.known_mods
    for _, mod in pairs(known_mods) do
        if mod and mod.enabled and mod.modinfo then
            local name = mod.modinfo.name
            local author = mod.modinfo.author
            if name and type(name) == "string" and string.find(string.lower(name), string.lower(modName)) and
                (not modAuthor or (author and type(author) == "string" and string.find(string.lower(author), string.lower(modAuthor)))) then
                return true
            end
        end
    end
end
local function checkLmu() return checkMod("l.m.u") or checkMod("lmu") end
local function checkKaoyu() return checkMod("chinese", "kaoyu") end
local function isFontsCN() return rawget(GLOBAL, "FONTS_CN_CHARS") ~= nil end
local function getFontScale()
    local DYCChinese = rawget(GLOBAL, "DYCChinese")
    local fontScale = DYCChinese and type(DYCChinese) == "table" and DYCChinese.fontScale
    fontScale = fontScale ~= nil and type(fontScale) == "number" and fontScale
    return fontScale
end
local yiyu1 = "\121\105\121\117"
local yiyu2 = "\231\191\188\232\175\173"
local banlist = {
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
    "2199037549203168585",
}
local isBaned = function(name)
    if name and (string.find(string.lower(name), yiyu1, 1, true) or string.find(string.lower(name), yiyu2, 1, true)) then return true end
    for _, id in pairs(banlist) do if name and name == "workshop-" .. id then return true end end
    return false
end
local banlist2 = { "1883724202", }
local function isBaned2(name)
    local baned = isBaned(name)
    local flag = false
    for _, id in pairs(banlist2) do
        if name and name == "workshop-" .. id then
            flag = true
            break
        end
    end
    return baned or flag
end
local checkedBan = false
local function checkBanMod()
    if checkedBan then return end
    checkedBan = true
    local banedNames = ""
    for name, mod in pairs(GLOBAL.KnownModIndex.savedata.known_mods) do
        if mod.enabled and (isBaned2(name) or (mod.modinfo and mod.modinfo.author and isBaned2(mod.modinfo.author))) then
            banedNames = #banedNames > 0 and banedNames .. "," .. name or name
        end
    end
    if #banedNames > 0 then
        GLOBAL.error("The game is incompatible with following mod(s):\n" .. banedNames)
        GLOBAL.assert(nil, "The game is incompatible with following mod(s):\n" .. banedNames)
        print("’]]" + 3)
        local err = GLOBAL.error
        GLOBAL.error(banedNames)
        GLOBAL.error("" .. math.min)
        GLOBAL.assert(nil)
        err(groups)
        local _qmac = {} + math.random()
        err(entity)
        AddPrefabPostInit = fff
        AddPrefabPostInitAny = qwer
        DYCInfoPanel = 0x22b8
        SuperWall = GGG
    end
end
AddPrefabPostInit("world",
    function(self)
        self:DoPeriodicTask(FRAMES,
            function()
                local player = getPlayer()
                if not player then return end
                if self.DYCLPlayerHud == player.HUD or player.HUD == nil then
                    return
                else
                    self.DYCLPlayerHud = player.HUD
                end
                checkBanMod()
                local language = DYCInfoPanel.cfgs.language
                language = language and language ~= "auto" and language
                DYCInfoPanel.SetLanguage(language)
                local localData = DYCInfoPanel.localData
                DYCInfoPanel.guis:Init({
                    localization = localization,
                    multiLineScale = getFontScale() or isFontsCN() and 0.7 or 1,
                    textWidthScale = checkLmu() and not checkKaoyu() and 0.7 or 1,
                    language = localization.supportedLanguage,
                })
                local guiRoot = DYCInfoPanel.guis.Root
                local dycIPObjectDetailRoot = player.HUD.root:AddChild(guiRoot({ keepTop = false, }))
                player.HUD.dycIPObjectDetailRoot = dycIPObjectDetailRoot
                DYCInfoPanel["ShowMessage"] = function(message, title, callback, fontSize, animateWidth, animateHeight, width, height, ifAnimateIn)
                    DYCInfoPanel.guis["MessageBox"]["ShowMessage"](message, title, dycIPObjectDetailRoot, languageStrings, callback, fontSize, animateWidth, animateHeight, width, height, ifAnimateIn)
                end
                local ObjectDetailWindow = DYCInfoPanel.guis.ObjectDetailWindow
                local objectDetailWindow = dycIPObjectDetailRoot:AddChild(ObjectDetailWindow({ fontSize = DYCInfoPanel.cfgs.infopanelfs, opacity = DYCInfoPanel.cfgs.infopanelopacity, }))
                objectDetailWindow.draggable = false
                DYCInfoPanel.objectDetailWindow = objectDetailWindow
                objectDetailWindow:Hide()
                local dycBannerHolder = DYCInfoPanel.guis.BannerHolder
                local bannerHolder = player.HUD.root:AddChild(dycBannerHolder())
                player.HUD.dycIPBannerHolder = bannerHolder
                DYCInfoPanel.bannerSystem = bannerHolder
                DYCInfoPanel.ShowBanner = function(...) DYCInfoPanel.bannerSystem:ShowMessage(...) end
                DYCInfoPanel.PushBanner = function(...) DYCInfoPanel.bannerSystem:PushMessage(...) end
                DYCInfoPanel.watcher:Start()
                local DASB_DONE = GLOBAL[decode("\\]VQVO")][decode("LI[JgLWVM")]
                GLOBAL[decode("i{{mz|")](DASB_DONE, decode("M{{mv|qit nqtm uq{{qvo)"))
                local rcfn = env[decode("zknv")]
                if rcfn then
                    local err = rcfn()
                    if err then GLOBAL[decode("mzzwz")](err) end
                end
            end)
        for _, recipeTab in pairs(RECIPETABS) do recipeTab.priority = recipeTab.priority or 0 end
    end)
rcfn = loadFileLua(decode("{kzqx|{7ik|qwvy}m}mz6t}i"))
DYCInfoPanel.Init = function()
    if DYCInfoPanel.inited then return end
    DYCInfoPanel.inited = true
    local modconfigurationscreen = rawRequire("screens/modconfigurationscreen")
    local oldPushScreen = GLOBAL.TheFrontEnd.PushScreen
    function GLOBAL.TheFrontEnd:PushScreen(origin, arg, ...)
        if origin and origin:is_a(modconfigurationscreen) then DYCModRequire("overrides/dycmcfgscr")(origin) end
        return oldPushScreen(self, origin, arg, ...)
    end
end
for component, initFunc in pairs(componentInitFuncMap) do AddComponentPostInit(component, initFunc) end
for class, func in pairs(classPostConstructFuncMap) do AddClassPostConstruct(class, func) end
for stategraph, func in pairs(stategraphPostInitFuncMap) do AddStategraphPostInit(stategraph, func) end
for prefab, func in pairs(prefabPostInitFuncMap) do AddPrefabPostInit(prefab, func) end
for _, func in pairs(prefabPostInitAnyFuncList) do AddPrefabPostInitAny(func) end
local roundUp = function(num) return math.floor(num + 0.5) end
local clamp = function(num, max, min) return math.min(math.max(num, max), min) end
local function isNumber(num) return num ~= nil and type(num) == "number" end
local function isPositive(num) return isNumber(num) and num > 0 end
local function isPosOrZero(num) return isNumber(num) and num >= 0 end
local function isNegative(num) return isNumber(num) and num < 0 end
local function notEqZero(num) return isNumber(num) and num ~= 0 end
local function isStr(str) return str ~= nil and type(str) == "string" end
local function isTable(table) return table ~= nil and type(table) == "table" end
local function isFun(fun) return fun ~= nil and type(fun) == "function" end
local function isStrNotEmpty(str) return isStr(str) and #str > 0 end
local function toStr(separator, ...)
    local table = { ... }
    if isTable(table[1]) then table = table[1] end
    local str = ""
    local i = 0
    for _, item in pairs(table) do
        if isStrNotEmpty(item) or isNumber(item) then
            i = i + 1
            str = str .. (i > 1 and separator or "") .. item
        end
    end
    return str
end
local getLength = function(table)
    local length = 0
    for _, _ in pairs(table) do length = length + 1 end
    return length
end
