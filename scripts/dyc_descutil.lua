local DYCInfoPanel = DYCInfoPanel
local cooking = require("cooking")
local RGBAColor = DYCInfoPanel.RGBAColor

--#region toolfunctions
local function isDST() return TheSim:GetGameID() == "DST" end
local function getPlayer() if isDST() then return ThePlayer else return GetPlayer() end end
local function getWorld() if isDST() then return TheWorld else return GetWorld() end end
local function allRecipes() if isDST() then return _G.AllRecipes else return _G.GetAllRecipes() end end
local entityMap = {
    pigman = {
        GetValue = function(entity)
            if entity and entity.components and (not entity.components.werebeast or not entity.components.werebeast:IsInWereState()) then
                return 3
            end
        end,
    },
    ballphin = {
        GetValue = function(entity)
            if entity and entity.components and entity.components.follower and entity.components.follower.previousleader == getPlayer() then
                return 3
            end
        end,
    },
    babybeefalo = { value = 6 },
    teenbird = { value = 2 },
    smallbird = { value = 6 },
    beefalo = { value = 4 },
    crow = { value = 1 },
    robin = { value = 2 },
    robin_winter = { value = 2 },
    butterfly = { value = 1 },
    rabbit = { value = 1 },
    mole = { value = 1 },
    tallbird = { value = 2 },
    bunnyman = { value = 3 },
    penguin = { value = 2 },
    glommer = { value = 50 },
    catcoon = { value = 5 },
    toucan = { value = 1 },
    parrot = { value = 2 },
    parrot_pirate = { value = 6 },
    seagull = { value = 1 },
    crab = { value = 1 },
    solofish = { value = 2 },
    swordfish = { value = 4 },
    whale_white = { value = 6 },
    whale_blue = { value = 7 },
    jellyfish_planted = { value = 1 },
    rainbowjellyfish_planted = { value = 1 },
    ox = { value = 4 },
    lobster = { value = 2 },
    primeape = { value = 2 },
    doydoy = {
        GetValue = function(_)
            local world = getWorld()
            if world and world.components and world.components.doydoyspawner then
                return world.components.doydoyspawner:GetInnocenceValue()
            end
        end,
    },
    twister_seal = { value = 50 },
    glowfly = { value = 1 },
    pog = { value = 2 },
    pangolden = { value = 4 },
    kingfisher = { value = 2 },
    pigeon = { value = 1 },
    dungbeetle = { value = 3 },
    shopkeep = { value = 6 },
    piko = { value = 1 },
    piko_orange = { value = 2 },
    hippopotamoose = { value = 4 },
    mandrakeman = { value = 3 },
    peagawk = { value = 3 },
}
local tagList = {
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
    "irreplaceable" }
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
local function HasLocalization(key) return DYCInfoPanel.localization:HasString(key) end
local function getLocalization(lang, key) return DYCInfoPanel.localization:GetString(lang, key) end
local function getTimeStr(secs, short, showDay)
    if showDay then
        local days = secs / TUNING.TOTAL_DAY_TIME
        days = math.floor(days * 10 + 0.5) / 10
        return days .. getLocalization("timer_day")
    end
    local mins = math.max(math.floor(secs / 60), 0)
    local hours = math.max(math.floor(mins / 60), 0)
    secs = secs - mins * 60
    mins = mins - hours * 60
    secs = math.floor(secs)
    if short then
        return (hours > 0 and hours .. getLocalization("timer_hour") or "") ..
            (mins > 0 and mins .. getLocalization("timer_minute") or "") .. (secs > 0 and secs .. getLocalization("timer_second") or "")
    else
        return (hours > 0 and hours .. getLocalization("timer_hour") or "") ..
            ((mins > 0 or hours > 0) and mins .. getLocalization("timer_minute") or "") .. secs .. getLocalization("timer_second")
    end
end
local function round(num) return "" .. (math.abs(num) >= 20 and roundUp(num) or roundUp(num * 10) / 10) end
local function roundPercent(num) return (math.abs(num) >= 0.2 and roundUp(num * 100) or roundUp(num * 1000) / 10) .. "%" end
local function getCfgName(key)
    local name = isStrNotEmpty(key) and STRINGS.UI and STRINGS.UI.SANDBOXMENU and STRINGS.UI.SANDBOXMENU[string.upper(key)]
    return name
end
local function getName(key)
    local name = isStrNotEmpty(key) and STRINGS.NAMES[string.upper(key)]
    for i = 1, 9 do
        if name then break end
        name = name or (isStrNotEmpty(key) and STRINGS.NAMES[string.upper(key) .. i])
    end
    return name
end
local function getActionName(key) return isStrNotEmpty(key) and STRINGS.ACTIONS[string.upper(key)] end
local function getComponent(entity, component)
    local component = entity and (entity.components and entity.components[component] or entity.dycComponents and entity.dycComponents[component])
    return component
end
local function getRecipeIngredients(key)
    local allRecipes = allRecipes()
    if isTable(allRecipes) and isTable(allRecipes[key]) then return allRecipes[key].ingredients end
end
local productsTable = {}
local function getProducts(prefab)
    local products = productsTable[prefab] and productsTable[prefab].products
    if products then
        if #products > 0 then return products end
        return
    end
    local allRecipes = allRecipes()
    products = {}
    for product, ingredients in pairs(allRecipes) do
        if isTable(ingredients.ingredients) then
            for _, ingredient in pairs(ingredients.ingredients) do
                if isTable(ingredient) and ingredient.type == prefab then
                    table.insert(products, product)
                end
            end
        end
    end
    productsTable[prefab] = productsTable[prefab] or {}
    productsTable[prefab].products = products
    if #products > 0 then return products end
end
local function getDamage(entity, itemHold)
    local damagemultiplier = 1
    damagemultiplier = damagemultiplier * (entity.GetDamageModifier and entity:GetDamageModifier() or entity.damagemultiplier or 1)
    local defaultdamage = type(entity.defaultdamage) == "number" and entity.defaultdamage or 0
    local damagebonus = entity.damagebonus or 0
    if itemHold and itemHold.components.weapon then
        local damage = 0
        if itemHold.components.weapon.variedmodefn then
            local variedmode = itemHold.components.weapon.variedmodefn(itemHold)
            damage = variedmode.damage
        else
            damage = itemHold.components.weapon.GetDamage and itemHold.components.weapon:GetDamage() or itemHold.components.weapon.damage
        end
        if not damage then damage = 0 end
        return damage * damagemultiplier + damagebonus
    else
        if entity.inst.components.rider and entity.inst.components.rider:IsRiding() then
            local mount = entity.inst.components.rider:GetMount()
            if mount and mount.components.combat then
                defaultdamage = mount.components.combat.defaultdamage
                damagebonus = mount.components.combat.damagebonus or 0
            end
            local saddle = entity.inst.components.rider:GetSaddle()
            if saddle ~= nil and saddle.components.saddler ~= nil then defaultdamage = defaultdamage + saddle.components.saddler:GetBonusDamage() end
        end
    end
    return defaultdamage * damagemultiplier + damagebonus
end
local function getBatCount(batCave)
    local count = 0
    for _, interiorName in ipairs(batCave.batcaves) do
        local interiorspawner = GetWorld().components.interiorspawner
        local interior = interiorspawner and interiorspawner:GetInteriorByName(interiorName)
        if interior and interior.prefabs and #interior.prefabs > 0 then
            for i = #interior.prefabs, 1, -1 do
                local entity = interior.prefabs[i]
                if entity.name == "vampirebat" then count = count + 1 end
            end
        end
        if interior and interior.object_list and #interior.object_list > 0 then
            for i = #interior.object_list, 1, -1 do
                local entity = interior.object_list[i]
                if entity.prefab == "vampirebat" then count = count + 1 end
            end
        end
    end
    return count
end
local function getHeater(item)
    local components = item and item.components
    local heater = components and components.heater
    local burnable = components and components.burnable
    if not heater and burnable and item.children then
        for itemChildren, _ in pairs(item.children) do
            if itemChildren and itemChildren.components.heater then
                heater = itemChildren.components.heater
                break
            end
        end
    end
    return heater
end
local function getMoonphase(index)
    local moonphase = math.floor(index / 2) % (8)
    if moonphase >= 4 then moonphase = 8 - moonphase end
    return moonphase
end
local function getFullMoonTime(numcycles, normTime)
    local moonphase = math.floor(numcycles / 2) % (8)
    if moonphase == 4 then return 0 end
    local dayLeft = 8
    while dayLeft - numcycles - normTime <= 0 do dayLeft = dayLeft + 16 end
    return (dayLeft - numcycles - normTime) * TUNING.TOTAL_DAY_TIME
end
local function getEntityValue(entity)
    if entity and entity.prefab then
        if entityMap[entity.prefab] and entityMap[entity.prefab].GetValue then
            return entityMap[entity.prefab].GetValue(entity) or 0
        end
        return entityMap[entity.prefab] and entityMap[entity.prefab].value or 0
    end
    return 0
end
--#endregion

local function addText(panelDescriptions, text, component) table.insert(panelDescriptions, { text = text, component = component }) end
local function addRichtext(panelDescriptions, richtext, component) table.insert(panelDescriptions, { richtext = richtext, component = component }) end
local function addRichtextStr(richtext, text, color)
    if isStrNotEmpty(text) then
        local lastText = #richtext > 0 and richtext[#richtext]
        if lastText and lastText.text and not lastText.color and not color then
            lastText.text = lastText.text .. text
        else
            table.insert(richtext, { text = text, color = color, })
        end
    end
end
local function addRichtextIcon(richtext, icon, color) table.insert(richtext, { icon = { atlas = "images/icons/" .. icon .. ".xml", image = icon .. ".tex" }, color = color, }) end
local function getInfo(entity, cfgPrefab, showTags, showRecipe, isRichtext)
    local panelDescriptions = {}
    if not entity or not entity.IsValid then return panelDescriptions end
    local prefab = entity.prefab
    local isSail = entity:HasTag("sail")
    local components = entity and entity.components
    local inventoryitem = components.inventoryitem or getComponent(entity, "inventoryitem")
    local owner = inventoryitem and inventoryitem.owner or nil
    local boathealth = components.boathealth
    local health = components.health or getComponent(entity, "health")
    local sanity = components.sanity or getComponent(entity, "sanity")
    local hunger = components.hunger or getComponent(entity, "hunger")
    local combat = components.combat or getComponent(entity, "combat")
    local aura = components.aura
    local locomotor = components.locomotor
    local drivable = components.drivable
    local eater = components.eater
    local follower = components.follower or getComponent(entity, "follower")
    local leader = components.leader
    local domesticatable = components.domesticatable
    local weapon = components.weapon
    local obsidiantool = components.obsidiantool
    local explosive = components.explosive
    local armor = components.armor
    local workable = components.workable
    local pickable = components.pickable
    local hackable = components.hackable
    local shearable = components.shearable
    local tool = components.tool
    local finiteuses = components.finiteuses
    local sewing = components.sewing
    local fueled = components.fueled
    local fuel = components.fuel
    local perishable = components.perishable
    local repairable = components.repairable
    local repairer = components.repairer
    local cooldown = components.cooldown
    local healer = components.healer
    local stewer = components.stewer
    local dryer = components.dryer
    local edible = components.edible
    local dryable = components.dryable
    local cookable = components.cookable
    local growable = components.growable
    local crop = components.crop
    local harvestable = components.harvestable
    local hatchable = components.hatchable
    local teacher = components.teacher
    local waterproofer = components.waterproofer
    local insulator = components.insulator
    local heater = getHeater(entity)
    local temperature = components.temperature
    local dapperness = components.dapperness
    local equippable = components.equippable or getComponent(entity, "equippable")
    local burnable = components.burnable
    local propagator = components.propagator
    local appeasement = components.appeasement
    local tradable = components.tradable
    local inventory = components.inventory
    local container = components.container or getComponent(entity, "container")
    local unwrappable = components.unwrappable
    local childspawner = components.childspawner
    local spawner = components.spawner
    local clock = components.clock
    local seasonmanager = components.seasonmanager
    local hounded = components.hounded
    local batted = components.batted
    local quaker = components.quaker
    local volcanomanager = components.volcanomanager
    local basehassler = components.basehassler
    local tigersharker = components.tigersharker
    local krakener = components.clock and getPlayer() and getPlayer().components.krakener
    local rocmanager = components.rocmanager
    local nightmareclock = components.nightmareclock
    local periodicthreat = components.periodicthreat
    if cfgPrefab and isStrNotEmpty(prefab) then
        local nameText = getLocalization("prefab") .. ":" .. prefab
        addText(panelDescriptions, nameText, "prefab")
    end
    if showTags and isFun(entity.HasTag) then
        local tags = {}
        for _, tag in pairs(tagList) do
            if entity:HasTag(tag) then
                table.insert(tags, getLocalization("tags_" .. tag, tag))
            end
        end
        if #tags > 0 then
            local tagsText = getLocalization("tags") .. ":" .. toStr(",", tags)
            addText(panelDescriptions, tagsText, "tags")
        end
    end
    if showRecipe and isStrNotEmpty(prefab) then
        local ingredients = getRecipeIngredients(prefab)
        if isTable(ingredients) and #ingredients > 0 then
            local ingredientsList = {}
            for _, ingredient in pairs(ingredients) do
                if isTable(ingredient) and isStrNotEmpty(ingredient.type) and isPositive(ingredient.amount) then
                    table.insert(ingredientsList, (getName(ingredient.type) or ingredient.type) .. " x" .. round(ingredient.amount))
                end
            end
            if #ingredientsList > 0 and #ingredientsList <= 5 then
                local ingredientsText = getLocalization("ingredients") .. ":" .. toStr(", ", ingredientsList)
                addText(panelDescriptions, ingredientsText, "recipe")
            elseif #ingredientsList > 5 then
                local ingredientsText = getLocalization("ingredients") .. ":" .. #ingredientsList .. getLocalization("ingredients2")
                addText(panelDescriptions, ingredientsText, "recipe")
            end
        end
        local products = getProducts(prefab)
        if isTable(products) and #products > 0 then
            local productsList = {}
            for _, product in pairs(products) do
                local productsName = getName(product) or product
                if isStrNotEmpty(productsName) then table.insert(productsList, productsName) end
            end
            if #productsList > 0 and #productsList <= 7 then
                local productsText = getLocalization("ingredientof") .. ":" .. toStr(", ", productsList)
                addText(panelDescriptions, productsText, "recipe")
            elseif #productsList > 7 then
                local productsText = getLocalization("ingredientof") .. ":" .. #productsList .. getLocalization("products")
                addText(panelDescriptions, productsText, "recipe")
            end
        end
    end
    if boathealth then
        local current, max = boathealth.currenthealth, boathealth.maxhealth
        local isLeaking = isFun(boathealth.IsLeaking) and boathealth:IsLeaking()
        if isNumber(current) and isPositive(max) then
            local boatHealthText = getLocalization("health") .. ":" .. roundUp(current) .. "/" .. roundUp(max) .. (isLeaking and " " .. getLocalization("leaking") or "")
            addText(panelDescriptions, boatHealthText, "boathealth")
        end
    end
    if health then
        local current, max = health.currenthealth, isFun(health.GetMax) and health:GetMax() or health.maxhealth
        if isNumber(current) and isPositive(max) then
            local healthText = getLocalization("health") .. ":" .. roundUp(current) .. "/" .. roundUp(max)
            addText(panelDescriptions, healthText, "health")
        end
    end
    if sanity then
        local current, max = sanity.current, sanity.max
        if isNumber(current) and isPositive(max) then
            local sanityText = getLocalization("sanity") .. ":" .. roundUp(current) .. "/" .. roundUp(max)
            addText(panelDescriptions, sanityText, "sanity")
        end
    end
    if hunger then
        local current, max = hunger.current, hunger.max
        if isNumber(current) and isPositive(max) then
            local hungetText = getLocalization("hunger") .. ":" .. roundUp(current) .. "/" .. roundUp(max)
            addText(panelDescriptions, hungetText, "hunger")
        end
    end
    if combat then
        local damage_0, damage_1, damage_2 = 0, 0, 0
        local weapon = isFun(combat.GetWeapon) and combat:GetWeapon()
        if isFun(combat.CalcEstimatedDamage) then
            damage_0, damage_1, damage_2 = combat:CalcEstimatedDamage(weapon)
            damage_0 = isNumber(damage_0) and damage_0 or 0
            damage_1 = isNumber(damage_1) and damage_1 or 0
            damage_2 = isNumber(damage_2) and damage_2 or 0
        end
        if damage_0 <= 0 then damage_0 = getDamage(combat, weapon) end
        if damage_0 <= 0 then
            local weaponComponent = weapon and weapon.components.weapon
            local defaultDamage = isPositive(combat.defaultdamage) and combat.defaultdamage or 0
            damage_0 = weaponComponent and isFun(weaponComponent.GetDamage) and weaponComponent:GetDamage() or (weaponComponent and weaponComponent.damage) or 0
            damage_0 = isPositive(damage_0) and damage_0 or 0
            damage_0 = damage_0 > 0 and damage_0 or defaultDamage
        end
        local attackRange = isFun(combat.GetAttackRange) and combat:GetAttackRange()
        attackRange = isPositive(attackRange) and attackRange or 0
        local damageStr, rangeStr = nil, nil
        if damage_0 ~= 0 then damageStr = damage_2 ~= 0 and round(damage_1) .. (damage_2 > 0 and "+" or "") .. round(damage_2) or round(damage_0) end
        if attackRange > 0 then rangeStr = round(attackRange) end
        if damageStr then
            local damageRangeText = ""
            damageRangeText = damageRangeText ..
                (damageStr ~= nil and (getLocalization("attackdamage") .. ":" .. damageStr) or "") .. (rangeStr ~= nil and (" " .. getLocalization("range") .. ":" .. rangeStr) or "")
            addText(panelDescriptions, damageRangeText, "combat")
        end
        if entity.GetCharacterBonus then
            local texts = {}
            local isAttackSpeedApplied = aura or isTable(entity.sg) and isTable(entity.sg.sg) and entity.sg.sg.isAttackSpeedApplied
            local attackspeed_percent = entity:GetCharacterBonus("attackspeed_percent")
            if isAttackSpeedApplied and isNumber(attackspeed_percent) then
                local attackSpeedText = getLocalization("attackspeed") .. ":" .. roundPercent(attackspeed_percent + 1)
                table.insert(texts, attackSpeedText)
            end
            if combat.GetEncReduction then
                local number, percent = combat:GetEncReduction()
                number = isPositive(number) and number or 0
                percent = entity:GetCharacterBonus("invincible") > 0 and 1 or percent
                percent = isPositive(percent) and percent or 0
                local damageReductionText = getLocalization("damagereduction") .. ":" .. round(number) .. "+" .. roundPercent(percent)
                table.insert(texts, damageReductionText)
            end
            local combatText = toStr(" ", texts)
            if isStrNotEmpty(combatText) then addText(panelDescriptions, combatText, "combat") end
        end
    end
    if locomotor then
        local walkspeed_0, walkspeed_1, walkspeed_2 = nil, nil, nil
        if isFun(locomotor.DYCGetWalkSpeed) then walkspeed_0, walkspeed_1, walkspeed_2 = locomotor:DYCGetWalkSpeed() elseif isFun(locomotor.GetWalkSpeed) then walkspeed_0 = locomotor:GetWalkSpeed() end
        walkspeed_0 = isPositive(walkspeed_0) and round(walkspeed_0)
        walkspeed_1 = isPositive(walkspeed_1) and round(walkspeed_1)
        walkspeed_2 = notEqZero(walkspeed_2) and round(walkspeed_2)
        local runspeed_0, runspeed_1, runspeed_2 = nil, nil, nil
        if isFun(locomotor.DYCGetRunSpeed) then runspeed_0, runspeed_1, runspeed_2 = locomotor:DYCGetRunSpeed() elseif isFun(locomotor.GetRunSpeed) then runspeed_0 = locomotor:GetRunSpeed() end
        runspeed_0 = isPositive(runspeed_0) and round(runspeed_0)
        runspeed_1 = isPositive(runspeed_1) and round(runspeed_1)
        runspeed_2 = notEqZero(runspeed_2) and round(runspeed_2)
        if walkspeed_0 or runspeed_0 then
            local walkspeedText = walkspeed_0 and
                getLocalization("walkspeed") .. ":" .. (walkspeed_1 and walkspeed_2 and walkspeed_1 .. (not string.find(walkspeed_2, "-") and "+" or "") .. walkspeed_2 or walkspeed_0) or
                ""
            local runspeedText = runspeed_0 and
                getLocalization("runspeed") .. ":" .. (runspeed_1 and runspeed_2 and runspeed_1 .. (not string.find(runspeed_2, "-") and "+" or "") .. runspeed_2 or runspeed_0) or ""
            local speedText = toStr(" ", walkspeedText, runspeedText)
            addText(panelDescriptions, speedText, "locomotor")
        end
        local speed_modifiers_add = locomotor.speed_modifiers_add
        local speed_modifiers_add_timer = locomotor.speed_modifiers_add_timer
        local speed_modifiers_mult = locomotor.speed_modifiers_mult
        local speed_modifiers_mult_timer = locomotor.speed_modifiers_mult_timer
        local negativeList, positiveList = {}, {}
        if isTable(speed_modifiers_add) and isTable(speed_modifiers_add_timer) then
            for modifierAddName, value in pairs(speed_modifiers_add) do
                local speedAdd = isNumber(value) and value or 0
                local modifierAddTimer = isPositive(speed_modifiers_add_timer[modifierAddName]) and speed_modifiers_add_timer[modifierAddName] or 0
                if isStrNotEmpty(modifierAddName) and speedAdd ~= 0 then
                    local modifierAddNameLower = string.lower(modifierAddName)
                    modifierAddName = HasLocalization(modifierAddNameLower) and getLocalization(modifierAddNameLower) or modifierAddName
                    modifierAddName = HasLocalization("speedboost_" .. modifierAddNameLower) and getLocalization("speedboost_" .. modifierAddNameLower) or modifierAddName
                    local speedAddText = modifierAddName .. (speedAdd > 0 and "+" or "") .. round(speedAdd) .. (modifierAddTimer > 0 and "(" .. getTimeStr(modifierAddTimer) .. ")" or "")
                    if modifierAddTimer > 0 then table.insert(positiveList, speedAddText) else table.insert(negativeList, speedAddText) end
                end
            end
        end
        if isTable(speed_modifiers_mult) and isTable(speed_modifiers_mult_timer) then
            for modifiersMultName, value in pairs(speed_modifiers_mult) do
                local speedMult = isNumber(value) and value or 0
                local modifiersMultTimer = isPositive(speed_modifiers_mult_timer[modifiersMultName]) and speed_modifiers_mult_timer[modifiersMultName] or 0
                modifiersMultTimer = isStrNotEmpty(modifiersMultName) and modifiersMultName == "WX_CHARGE" and isNumber(entity.charge_time) and entity.charge_time or modifiersMultTimer
                if isStrNotEmpty(modifiersMultName) and speedMult ~= 0 then
                    local modifiersMultNameLower = string.lower(modifiersMultName)
                    modifiersMultName = HasLocalization(modifiersMultNameLower) and getLocalization(modifiersMultNameLower) or modifiersMultName
                    modifiersMultName = HasLocalization("speedboost_" .. modifiersMultNameLower) and getLocalization("speedboost_" .. modifiersMultNameLower) or modifiersMultName
                    local speedMultText = modifiersMultName ..
                        (speedMult > 0 and "+" or "") .. roundPercent(speedMult) .. (modifiersMultTimer > 0 and "(" .. getTimeStr(modifiersMultTimer) .. ")" or "")
                    if modifiersMultTimer > 0 then table.insert(positiveList, speedMultText) else table.insert(negativeList, speedMultText) end
                end
            end
        end
        if #negativeList > 0 then
            local speedBoostText = getLocalization("speed") .. ":" .. toStr(" ", negativeList)
            addText(panelDescriptions, speedBoostText, "locomotor")
        end
        if #positiveList > 0 then
            local speedBoostText = getLocalization("speed") .. ":" .. toStr(" ", positiveList)
            addText(panelDescriptions, speedBoostText, "locomotor")
        end
    end
    if drivable then
        local driveSpeed = drivable.runspeed
        if notEqZero(driveSpeed) then
            local driveSpeedText = getLocalization("speed") .. ":" .. (driveSpeed > 0 and "+" or "") .. driveSpeed
            addText(panelDescriptions, driveSpeedText, "drivable")
        end
    end
    if isSail then
        local sailSpeedMult = entity.sail_speed_mult
        sailSpeedMult = isPositive(sailSpeedMult) and sailSpeedMult
        local sailAccelMult = entity.sail_accel_mult
        sailAccelMult = isPositive(sailAccelMult) and sailAccelMult
        if sailSpeedMult or sailAccelMult then
            local sailText = getLocalization("sail") ..
                ":" ..
                (sailSpeedMult and getLocalization("speed") .. roundUp(sailSpeedMult * 100) .. "%" or "") ..
                (sailSpeedMult and sailAccelMult and " " or "") .. (sailAccelMult and getLocalization("acceleration") .. roundUp(sailAccelMult * 100) .. "%" or "")
            addText(panelDescriptions, sailText)
        end
    end
    if eater then
        local foodprefs = eater.foodprefs
        if isTable(foodprefs) and #foodprefs > 0 then
            local eaterText = getLocalization("eater")
            local foodprefsSize = #foodprefs
            if foodprefsSize <= 6 then
                eaterText = eaterText .. "("
                for i = 1, foodprefsSize do
                    local foodpref = foodprefs[i]
                    if isStrNotEmpty(foodpref) then
                        eaterText = eaterText .. getLocalization("foodtype_" .. string.lower(foodpref), foodpref)
                        if i < foodprefsSize then eaterText = eaterText .. "," end
                    end
                end
                eaterText = eaterText .. ")"
            else
                eaterText = eaterText .. "(" .. foodprefsSize .. getLocalization("foodtypes") .. ")"
            end
            addText(panelDescriptions, eaterText, "eater")
        end
    end
    if follower then
        local followerLeader = isTable(follower.leader) and follower.leader.components and follower.leader or nil
        local followerLeaderName = followerLeader and isFun(followerLeader.GetDisplayName) and followerLeader:GetDisplayName() or nil
        followerLeaderName = isStrNotEmpty(followerLeaderName) and string.gsub(followerLeaderName, "\n", "") or nil
        if followerLeader and followerLeaderName then
            local targettime = follower.targettime
            local maxfollowtime = follower.maxfollowtime
            local targetTimeLeft = isNumber(targettime) and math.max(0, targettime - GetTime()) or -1
            local targetTimeLeftStr = targetTimeLeft > 0 and "(" .. getTimeStr(targetTimeLeft, nil, true) .. ")" or ""
            local followerStr = isPositive(maxfollowtime) and targetTimeLeft >= 0 and getLocalization("loyalty") .. ":" .. round(targetTimeLeft) .. targetTimeLeftStr .. "/" .. round(maxfollowtime) or
                nil
            local follwerText = getLocalization("leader") .. ":" .. followerLeaderName .. (followerStr ~= nil and " " .. followerStr or "")
            addText(panelDescriptions, follwerText, "follower")
        end
    end
    if leader then
        local leaderFollowers = leader.followers
        if isTable(leaderFollowers) then
            local count = getLength(leaderFollowers)
            if count > 0 then
                local leaderStr = ""
                if count <= 3 then
                    local i = 1
                    for leaderFollower, _ in pairs(leaderFollowers) do
                        local leaderFollowerName = isTable(leaderFollower) and isFun(leaderFollower.GetDisplayName) and leaderFollower:GetDisplayName() or nil
                        if isStrNotEmpty(leaderFollowerName) then
                            leaderFollowerName = string.gsub(leaderFollowerName, "\n", "")
                            leaderStr = leaderStr .. leaderFollowerName .. (i < count and "," or "")
                        end
                        i = i + 1
                    end
                else
                    leaderStr = count
                end
                local leaderText = getLocalization("followers") .. ":" .. leaderStr
                addText(panelDescriptions, leaderText, "leader")
            end
        end
    end
    if domesticatable then
        local domestication = domesticatable.domestication
        domestication = isPositive(domestication) and domestication or nil
        local obedience = domesticatable.obedience
        obedience = isPositive(obedience) and obedience or nil
        local tendencies = domesticatable.tendencies
        tendencies = isTable(tendencies) and tendencies or nil
        local minobedience = domesticatable.minobedience
        minobedience = isPosOrZero(minobedience) and minobedience or nil
        local maxobedience = domesticatable.maxobedience
        maxobedience = isPosOrZero(maxobedience) and maxobedience or nil
        local domesticationStr = domestication and getLocalization("domestication") .. roundUp(domestication * 100) .. "%" or ""
        local obedienceStr = obedience and getLocalization("obedience") .. roundUp(obedience * 100) .. "%" or ""
        if obedienceStr and minobedience and maxobedience and (minobedience ~= 0 or maxobedience ~= 1) then
            obedienceStr = obedienceStr ..
                "(" .. roundUp(minobedience * 100) .. "%-" .. roundUp(maxobedience * 100) .. "%)"
        end
        local tendenciesStr = ""
        if tendencies then
            local DEFAULT = tendencies.DEFAULT
            local ORNERY = tendencies.ORNERY
            local RIDER = tendencies.RIDER
            local PUDGY = tendencies.PUDGY
            tendenciesStr = isPositive(DEFAULT) and ((isStrNotEmpty(tendenciesStr) and tendenciesStr or "") .. getLocalization("tendencies_default") .. string.format("%0.3f", DEFAULT)) or tendenciesStr
            tendenciesStr = isPositive(ORNERY) and ((isStrNotEmpty(tendenciesStr) and tendenciesStr .. " " or "") .. getLocalization("tendencies_ornery") .. string.format("%0.3f", ORNERY)) or
                tendenciesStr
            tendenciesStr = isPositive(RIDER) and ((isStrNotEmpty(tendenciesStr) and tendenciesStr .. " " or "") .. getLocalization("tendencies_rider") .. string.format("%0.3f", RIDER)) or
                tendenciesStr
            tendenciesStr = isPositive(PUDGY) and ((isStrNotEmpty(tendenciesStr) and tendenciesStr .. " " or "") .. getLocalization("tendencies_pudgy") .. string.format("%0.3f", PUDGY)) or
                tendenciesStr
        end
        if isStrNotEmpty(domesticationStr) or isStrNotEmpty(obedienceStr) then
            local domesticatableText1 = domesticationStr .. (isStrNotEmpty(domesticationStr) and " " or "") .. obedienceStr
            addText(panelDescriptions, domesticatableText1, "domesticatable")
        end
        if isStrNotEmpty(tendenciesStr) then
            local domesticatableText2 = tendenciesStr
            addText(panelDescriptions, domesticatableText2, "domesticatable")
        end
    end
    if weapon then
        local damageStr, rangeStr = nil, nil
        local damage_0, damage_1, damage_2 = nil, nil, nil
        if isFun(weapon.GetDamage) then damage_0, damage_1, damage_2 = weapon:GetDamage() end
        damage_0 = damage_0 or weapon.damage
        local attackrange = weapon.attackrange
        if isPositive(damage_0) then
            if obsidiantool and isFun(obsidiantool.GetCharge) then
                local damage = weapon.damage
                local charge, maxcharge = obsidiantool:GetCharge()
                if isPositive(damage) and isNumber(charge) and isPositive(maxcharge) then
                    local chargeDamage = damage * clamp(charge / maxcharge, 0, 1)
                    damage_0 = damage_0 + chargeDamage
                    damage_1 = isPositive(damage_1) and damage_1 + chargeDamage
                end
            end
            if isPositive(damage_1) and notEqZero(damage_2) then
                damage_1 = round(damage_1)
                damage_2 = (damage_2 >= 0 and "+" or "") .. round(damage_2)
                damageStr = damage_1 .. damage_2
            else
                damageStr = round(damage_0)
            end
        end
        if isPositive(attackrange) then rangeStr = round(attackrange) end
        if damageStr or rangeStr then
            local weaponText = getLocalization("weapon") .. ":"
            weaponText = weaponText ..
                (damageStr ~= nil and (getLocalization("damage") .. damageStr) or "") .. (damageStr ~= nil and " " or "") .. (rangeStr ~= nil and (getLocalization("range") .. rangeStr) or "")
            addText(panelDescriptions, weaponText, "weapon")
        end
    end
    if explosive then
        local explosiverange = explosive.explosiverange
        explosiverange = isNumber(explosiverange) and explosiverange or 0
        local explosivedamage = explosive.explosivedamage
        explosivedamage = isNumber(explosivedamage) and explosivedamage or 0
        local buildingdamage = explosive.buildingdamage
        buildingdamage = isNumber(buildingdamage) and buildingdamage or 0
        if explosivedamage > 0 or explosiverange > 0 then
            local explosiveText = getLocalization("explosive") .. ":"
            explosiveText = explosiveText ..
                toStr(" ", explosivedamage > 0 and getLocalization("damage") .. round(explosivedamage), buildingdamage > 0 and getLocalization("buildingdamage") .. round(buildingdamage),
                    explosiverange > 0 and getLocalization("range") .. round(explosiverange))
            addText(panelDescriptions, explosiveText, "explosive")
        end
    end
    if armor then
        local condition, max = armor.condition, isFun(armor.GetMax) and armor:GetMax() or armor.maxcondition
        local absorb_percent = armor.absorb_percent
        if isNumber(condition) and isPositive(max) then
            local armorText = getLocalization("armor") .. (isPositive(absorb_percent) and ("(" .. getLocalization("absorbpercent") .. roundUp(absorb_percent * 100) .. "%)") or "") .. ":"
            armorText = armorText .. round(condition) .. "/" .. round(max)
            addText(panelDescriptions, armorText, "armor")
        end
    end
    if workable then
        local workleft, maxwork = workable.workleft, workable.maxwork
        local action = workable.action
        if isPositive(workleft) then
            local actionStr = isTable(action) and isStrNotEmpty(action.str) and action.str or nil
            local actionName = getActionName(actionStr)
            actionName = isStrNotEmpty(actionName) and actionName or (isTable(actionName) and isStrNotEmpty(actionName.GENERIC) and actionName.GENERIC) or getLocalization("other")
            local worableText = getLocalization("workable") .. (actionStr and "(" .. actionName .. ")" or "") .. ":" .. roundUp(workleft) .. (isPositive(maxwork) and "/" .. roundUp(maxwork) or "")
            addText(panelDescriptions, worableText, "workable")
        end
    end
    if pickable then
        local product = pickable.product
        product = getName(product)
        local canBePicked = isFun(pickable.CanBePicked) and pickable:CanBePicked()
        local numtoharvest = pickable.numtoharvest
        local targettime = pickable.targettime
        local targetTimeLeft = isPositive(targettime) and targettime - GetTime()
        local regentime = pickable.regentime
        local pickableText = ""
        if isStrNotEmpty(product) then
            pickableText = getLocalization("pickproduct") .. ":" .. product .. (isPositive(numtoharvest) and numtoharvest > 1 and "x" .. numtoharvest or "")
        elseif canBePicked then
            pickableText = getLocalization("pickable")
        end
        if isPositive(targetTimeLeft) then
            pickableText = pickableText ..
                (isStrNotEmpty(pickableText) and " " or "") .. getLocalization("regen") .. ":" .. roundUp(targetTimeLeft) .. "(" .. getTimeStr(targetTimeLeft, nil, true) .. ")" ..
                (isPositive(regentime) and "/" .. roundUp(regentime) or "")
        end
        if isStrNotEmpty(pickableText) then addText(panelDescriptions, pickableText, "pickable") end
    end
    if hackable then
        local product = hackable.product
        local hacksleft = hackable.hacksleft
        local targettime = hackable.targettime
        local targetTimeLeft = isPositive(targettime) and targettime - GetTime()
        local actionName = getActionName("hack")
        product = getName(product)
        local hackableText = ""
        if isStrNotEmpty(product) then hackableText = getLocalization("hackproduct") .. ":" .. product end
        if isPositive(hacksleft) and isStrNotEmpty(actionName) then hackableText = hackableText .. (isStrNotEmpty(hackableText) and " " or "") .. actionName .. hacksleft end
        if isPositive(targetTimeLeft) then
            hackableText = hackableText ..
                (isStrNotEmpty(hackableText) and " " or "") .. getLocalization("regen") .. ":" .. roundUp(targetTimeLeft) .. "(" .. getTimeStr(targetTimeLeft, nil, true) .. ")"
        end
        if isStrNotEmpty(hackableText) then addText(panelDescriptions, hackableText, "hackable") end
    end
    if shearable then
        local product = shearable.product
        local amount = shearable.product_amt
        product = getName(product)
        if isStrNotEmpty(product) then
            local shearableText = getLocalization("shearproduct") .. ":" .. product .. (isPositive(amount) and amount > 1 and "x" .. amount or "")
            addText(panelDescriptions, shearableText, "shearable")
        end
    end
    if tool then
        local count = 0
        local actionMap = {}
        local actions = tool.actions or tool.action
        if isTable(actions) then
            for action, efficiency in pairs(actions) do
                if isTable(action) and isStrNotEmpty(action.str) and isPositive(efficiency) then
                    actionMap[action.str] = efficiency
                    count = count + 1
                end
            end
        end
        local toolText = getLocalization("tool") .. ":"
        if count <= 4 and count > 0 then
            local i = 0
            for action, efficiency in pairs(actionMap) do
                if i > 0 then toolText = toolText .. " " end
                local actionName = getActionName(action)
                actionName = isStrNotEmpty(actionName) and actionName or (isTable(actionName) and isStrNotEmpty(actionName.GENERIC) and actionName.GENERIC) or getLocalization("other")
                toolText = toolText .. actionName .. roundUp(efficiency)
                i = i + 1
            end
        elseif count > 0 then
            toolText = toolText .. count .. getLocalization("tool_actions")
        end
        addText(panelDescriptions, toolText, "tool")
    end
    if stewer then
        local product = stewer.product
        product = getName(product)
        local timeToCook = isFun(stewer.GetTimeToCook) and stewer:GetTimeToCook()
        if isStrNotEmpty(product) then
            local stewerText = getLocalization("stewproduct") .. ":" .. product .. (isPositive(timeToCook) and " " .. getTimeStr(timeToCook) or "")
            addText(panelDescriptions, stewerText, "stewer")
        end
    end
    if dryer then
        local product = dryer.product
        product = getName(product)
        local timeToDry = isFun(dryer.GetTimeToDry) and dryer:GetTimeToDry()
        if isStrNotEmpty(product) then
            local dryerText = getLocalization("dryproduct") .. ":" .. product .. (isPositive(timeToDry) and "(" .. getTimeStr(timeToDry) .. ")" or "")
            addText(panelDescriptions, dryerText, "dryer")
        end
    end
    if edible then
        local foodtype = edible.foodtype
        local foodOwner = isTable(owner) and isTable(owner.components) and isTable(owner.components.inventoryitem) and owner.components.inventoryitem.owner or nil
        local healthvalue = edible.GetHealth and edible:GetHealth(foodOwner or owner) or edible.healthvalue
        local hungervalue = edible.GetHunger and edible:GetHunger(foodOwner or owner) or edible.hungervalue
        local sanityvalue = edible.GetSanity and edible:GetSanity(foodOwner or owner) or edible.sanityvalue
        local caffeinedelta = edible.caffeinedelta
        local caffeineduration = edible.caffeineduration
        local foodtypeStr, healthStr, hungerStr, sanityStr, coffeeStr = nil, nil, nil, nil, nil
        local richtext = isRichtext and {} or nil
        if richtext then addRichtextStr(richtext, getLocalization("edible")) end
        if isStrNotEmpty(foodtype) then
            foodtypeStr = "(" .. getLocalization("foodtype_" .. string.lower(foodtype), foodtype) .. ")"
            if richtext then addRichtextStr(richtext, foodtypeStr) end
        end
        if notEqZero(healthvalue) then
            healthStr = (not richtext and getLocalization("health") or "") .. round(healthvalue)
            if richtext then
                addRichtextIcon(richtext, "dyc_status_health")
                addRichtextStr(richtext, healthStr)
            end
        end
        if notEqZero(hungervalue) then
            hungerStr = (not richtext and getLocalization("hunger") or "") .. round(hungervalue)
            if richtext then
                addRichtextIcon(richtext, "dyc_status_hunger")
                addRichtextStr(richtext, hungerStr)
            end
        end
        if notEqZero(sanityvalue) then
            sanityStr = (not richtext and getLocalization("sanity") or "") .. round(sanityvalue)
            if richtext then
                addRichtextIcon(richtext, "dyc_status_sanity")
                addRichtextStr(richtext, sanityStr)
            end
        end
        if isPositive(caffeinedelta) and isPositive(caffeineduration) then
            coffeeStr = getLocalization("speed") .. round(caffeinedelta) .. "(" .. getTimeStr(caffeineduration, true) .. ")"
            if richtext then addRichtextStr(richtext, coffeeStr) end
        end
        if foodtypeStr or healthStr or hungerStr or sanityStr then
            if richtext then
                if richtext[1] and richtext[1].text then richtext[1].text = richtext[1].text .. ":" end
                addRichtext(panelDescriptions, richtext, "edible")
            else
                local edibleText = toStr(" ", healthStr, hungerStr, sanityStr, coffeeStr)
                edibleText = getLocalization("edible") .. (foodtypeStr or "") .. (#edibleText > 0 and ":" or "") .. edibleText
                addText(panelDescriptions, edibleText, "edible")
            end
        end
        if isStrNotEmpty(prefab) then
            local ingredients = cooking.ingredients[prefab]
            if isTable(ingredients) and isTable(ingredients.tags) then
                local tags = {}
                for tag, value in pairs(ingredients.tags) do
                    if isStrNotEmpty(tag) and isPositive(value) then
                        table.insert(tags, getLocalization("foodtag_" .. string.lower(tag), tag) .. value)
                    end
                end
                local foodtagsText = getLocalization("foodtags") .. ":" .. toStr(",", tags)
                addText(panelDescriptions, foodtagsText, "edible")
            end
        end
    end
    if dryable then
        local product = dryable.product
        product = getName(product)
        local drytime = dryable.drytime
        if isStrNotEmpty(product) then
            local dryableText = getLocalization("dryproduct") .. ":" .. product .. (isPositive(drytime) and "(" .. getTimeStr(drytime, true) .. ")" or "")
            addText(panelDescriptions, dryableText, "dryable")
        end
    end
    if cookable then
        local product = cookable.product
        product = isFun(product) and product(entity) or product
        product = getName(product)
        if isStrNotEmpty(product) then
            local cookableText = getLocalization("cookproduct") .. ":" .. product
            addText(panelDescriptions, cookableText, "cookable")
        end
    end
    if growable then
        local targettime = growable.targettime
        local stage = growable.stage
        local stages = growable.stages
        if isPositive(targettime) then
            local timeLeft = targettime - GetTime()
            local stageStr = isPosOrZero(stage) and isTable(stages) and "(" .. roundUp(stage) .. "/" .. #stages .. ")" or ""
            local growableText = getLocalization("growable") .. ":" .. getTimeStr(timeLeft) .. stageStr
            addText(panelDescriptions, growableText, "growable")
        end
    end
    if crop then
        local product = crop.product_prefab
        product = getName(product)
        local growthpercent = crop.growthpercent
        local rate = crop.rate
        if isStrNotEmpty(product) then
            local growStr = isPosOrZero(growthpercent) and growthpercent <= 1 and
                " " .. roundUp(growthpercent * 100) .. "%" .. (isPositive(rate) and "(" .. getTimeStr((1 - growthpercent) / rate) .. ")" or "") or ""
            local cropText = getLocalization("crop") .. ":" .. product .. growStr
            addText(panelDescriptions, cropText, "crop")
        end
    end
    if harvestable then
        local product = harvestable.product
        product = getName(product)
        local produce = harvestable.produce
        local maxproduce = harvestable.maxproduce
        local growtime = harvestable.growtime
        if isStrNotEmpty(product) then
            local produceStr = isNumber(produce) and (roundUp(produce) .. (isNumber(maxproduce) and "/" .. roundUp(maxproduce) or "")) or ""
            local harvestableText = getLocalization("harvest") .. ":" .. product .. produceStr .. (isPositive(growtime) and "(" .. getTimeStr(growtime, true) .. ")" or "")
            addText(panelDescriptions, harvestableText, "harvestable")
        end
    end
    if hatchable then
        local progress = hatchable.progress
        local cracktime = hatchable.cracktime
        local hatchtime = hatchable.hatchtime
        local state = hatchable.state
        local timeMax = isStr(state) and state == "unhatched" and cracktime or hatchtime
        if isPosOrZero(progress) then
            local hatchableText = getLocalization("hatchable") .. ":" .. roundUp(progress) .. (isPositive(timeMax) and "/" .. roundUp(timeMax) or "")
            addText(panelDescriptions, hatchableText, "hatchable")
        end
    end
    if finiteuses then
        local current, max = finiteuses.current, isFun(finiteuses.GetMax) and finiteuses:GetMax() or finiteuses.total
        if isNumber(current) and isPositive(max) then
            local finiteusesText = getLocalization("uses") .. ":" .. (roundUp(current * 10) / 10) .. "/" .. roundUp(max)
            addText(panelDescriptions, finiteusesText, "finiteuses")
        end
    end
    if sewing then
        local repair_value = sewing.repair_value
        if isPositive(repair_value) then
            local sewingText = getLocalization("sewing") .. roundUp(repair_value)
            addText(panelDescriptions, sewingText, "sewing")
        end
    end
    if fueled then
        local currentfuel, max = fueled.currentfuel, isFun(fueled.GetMax) and fueled:GetMax() or fueled.maxfuel
        local fueltype = fueled.fueltype
        if isNumber(currentfuel) and isPositive(max) then
            currentfuel = round(currentfuel)
            max = round(max)
            local fuelStr = isStrNotEmpty(fueltype) and "(" .. getLocalization("fuel_" .. fueltype, fueltype) .. ")" or ""
            local fueledText = getLocalization("fuel") .. fuelStr .. ":" .. currentfuel .. "(" .. getTimeStr(currentfuel, nil, true) .. ")/" .. max
            addText(panelDescriptions, fueledText, "fueled")
        end
    end
    if fuel then
        local fuelvalue = fuel.fuelvalue
        local fueltype = fuel.fueltype
        if isPositive(fuelvalue) then
            local fueltypeStr = isStrNotEmpty(fueltype) and "(" .. getLocalization("fuel_" .. fueltype, fueltype) .. ")" or ""
            local fuelText = getLocalization("fuel") .. fueltypeStr .. roundUp(fuelvalue)
            addText(panelDescriptions, fuelText, "fuel")
        end
    end
    if perishable then
        local perishremainingtime, max = perishable.perishremainingtime, isFun(perishable.GetMax) and perishable:GetMax() or perishable.perishtime
        local isSpoiled = isFun(perishable.IsSpoiled) and perishable:IsSpoiled()
        local isStale = isFun(perishable.IsStale) and perishable:IsStale()
        if isNumber(perishremainingtime) and isPositive(max) then
            perishremainingtime = round(perishremainingtime)
            max = round(max)
            local freshStr = isSpoiled and getLocalization("spoiled") or (isStale and getLocalization("stale")) or getLocalization("fresh")
            local perishMult = owner and
                ((owner:HasTag("fridge") and (entity:HasTag("frozen") and not owner:HasTag("nocool") and not owner:HasTag("lowcool") and TUNING.PERISH_COLD_FROZEN_MULT or TUNING.PERISH_FRIDGE_MULT)) or (owner:HasTag("spoiler") and owner:HasTag("poison") and TUNING.PERISH_POISON_MULT) or (owner:HasTag("spoiler") and TUNING.PERISH_GROUND_MULT)) or
                1
            perishMult = isPosOrZero(perishMult) and perishMult or 1
            local perishableText = freshStr .. ":" .. perishremainingtime .. (perishMult > 0 and "(" .. getTimeStr(perishremainingtime / perishMult, nil, true) .. ")" or "") .. "/" .. max
            addText(panelDescriptions, perishableText, "perishable")
        end
    end
    if repairable then
        local needsRepairs = isFun(repairable.NeedsRepairs) and repairable:NeedsRepairs()
        local repairmaterial = repairable.repairmaterial
        if needsRepairs then
            local repairableStr = isStrNotEmpty(repairmaterial) and "(" .. getLocalization("repairmaterial_" .. string.lower(repairmaterial), repairmaterial) .. ")" or ""
            local repairableText = getLocalization("repairable") .. repairableStr
            addText(panelDescriptions, repairableText, "repairable")
        end
    end
    if repairer then
        local workrepairvalue = repairer.workrepairvalue
        local healthrepairvalue = repairer.healthrepairvalue
        local perishrepairvalue = repairer.perishrepairvalue
        local userepairvalue = repairer.userepairvalue
        workrepairvalue = isPositive(workrepairvalue) and getLocalization("work") .. round(workrepairvalue)
        healthrepairvalue = isPositive(healthrepairvalue) and getLocalization("health") .. round(healthrepairvalue)
        perishrepairvalue = isPositive(perishrepairvalue) and getLocalization("freshness") .. round(perishrepairvalue)
        userepairvalue = isPositive(userepairvalue) and getLocalization("uses") .. round(userepairvalue)
        local repairmaterial = repairer.repairmaterial
        if workrepairvalue or healthrepairvalue or perishrepairvalue or userepairvalue then
            local repairerStr = isStrNotEmpty(repairmaterial) and "(" .. getLocalization("repairmaterial_" .. string.lower(repairmaterial), repairmaterial) .. ")" or ""
            local repairerText = getLocalization("repairer") .. repairerStr .. ":" .. toStr(" ", workrepairvalue, healthrepairvalue, perishrepairvalue, userepairvalue)
            addText(panelDescriptions, repairerText, "repairer")
        end
    end
    if cooldown then
        local charged = cooldown.charged
        local cooldown_deadline = cooldown.cooldown_deadline
        local cooldown_duration = cooldown.cooldown_duration
        local cooldownTimeLeft = isPositive(cooldown_deadline) and cooldown_deadline - GetTime() or -1
        if charged or cooldownTimeLeft >= 0 then
            local cooldownTimeLeftStr = cooldownTimeLeft >= 0 and round(cooldownTimeLeft) .. "(" .. getTimeStr(cooldownTimeLeft, nil, true) .. ")" or ""
            local cooldownDurationStr = isPositive(cooldown_duration) and "/" .. round(cooldown_duration) or ""
            local cooldownText = getLocalization("cooldown") .. ":" .. (charged and getLocalization("done") or cooldownTimeLeftStr .. cooldownDurationStr)
            addText(panelDescriptions, cooldownText, "cooldown")
        end
    end
    if healer then
        local health = healer.health
        if isPositive(health) then
            local healerText = getLocalization("heal") .. ":" .. round(health) .. getLocalization("health")
            addText(panelDescriptions, healerText, "healer")
        end
    end
    if teacher then
        local recipe = teacher.recipe
        local recipeName = getName(recipe)
        if isStrNotEmpty(recipeName) then
            local teacherText = getLocalization("unlock") .. ":" .. recipeName
            addText(panelDescriptions, teacherText, "teacher")
        end
    end
    if waterproofer then
        local effectiveness = isFun(waterproofer.GetEffectiveness) and waterproofer:GetEffectiveness()
        if isPositive(effectiveness) then
            local waterprooferText = getLocalization("waterproofer") .. ":" .. roundUp(effectiveness * 100) .. "%"
            addText(panelDescriptions, waterprooferText, "waterproofer")
        end
    end
    if insulator then
        local insulatorType = getCfgName(insulator.type)
        local insulation = insulator.insulation
        if isNumber(insulation) then
            local insulatorText = getLocalization("insulator") .. (isStrNotEmpty(insulatorType) and "(" .. insulatorType .. ")" or "") .. ":" .. (roundUp(insulation * 10) / 10)
            addText(panelDescriptions, insulatorText, "insulator")
        end
    end
    if heater then
        local heat = isFun(heater.GetHeat) and heater:GetHeat(getPlayer())
        if notEqZero(heat) then
            local heaterText = getLocalization("heat") .. ":" .. (roundUp(heat * 10) / 10)
            addText(panelDescriptions, heaterText, "heater")
        end
    end
    if temperature then
        local current, max, min = temperature.current, temperature.maxtemp, temperature.mintemp
        if isNumber(current) then
            local temperatureText = getLocalization("temperature") ..
                ":" .. (roundUp(current * 10) / 10) .. (isNumber(max) and isNumber(min) and "(" .. roundUp(min) .. "~" .. roundUp(max) .. ")" or "")
            addText(panelDescriptions, temperatureText, "temperature")
        end
    end
    if dapperness then
        local dapperness_ = isFun(dapperness.GetDapperness) and dapperness:GetDapperness(dapperness.owner or getPlayer())
        if isNumber(dapperness_) and dapperness_ ~= 0 then
            local dappernessText = getLocalization("dapperness") .. ":" .. (roundUp(dapperness_ * 1000) / 1000)
            addText(panelDescriptions, dappernessText, "dapperness")
        end
    end
    if equippable then
        local equipslot = equippable.equipslot or equippable.boatequipslot
        local walkspeedmult = isFun(equippable.GetWalkSpeedMult) and equippable:GetWalkSpeedMult() or equippable.walkspeedmult
        local dapperness_ = isFun(equippable.GetDapperness) and equippable:GetDapperness(equippable.owner or getPlayer())
        local equippableEffectList = {}
        if isStrNotEmpty(equipslot) then table.insert(equippableEffectList, getLocalization("equipslot") .. ":" .. getLocalization("equipslot_" .. equipslot, equipslot)) end
        if isPositive(walkspeedmult) and walkspeedmult ~= 1 then table.insert(equippableEffectList, getLocalization("speed") .. roundUp(walkspeedmult * 100) .. "%") end
        if isNumber(dapperness_) and dapperness_ ~= 0 then table.insert(equippableEffectList, getLocalization("dapperness") .. (roundUp(dapperness_ * 1000) / 1000)) end
        if #equippableEffectList > 0 then
            local equippableText = ""
            for i = 1, #equippableEffectList do equippableText = equippableText .. (i > 1 and " " or "") .. equippableEffectList[i] end
            addText(panelDescriptions, equippableText, "equippable")
        end
    end
    if burnable then
        local burnableText = getLocalization("burnable") .. (propagator and " " .. getLocalization("propagator") or "")
        addText(panelDescriptions, burnableText, "burnable")
    end
    if appeasement then
        local appeasementvalue = appeasement.appeasementvalue
        if isNumber(appeasementvalue) and appeasementvalue ~= 0 then
            local appeasementText = getLocalization("appeasement") .. ":" .. appeasementvalue
            addText(panelDescriptions, appeasementText, "appeasement")
        end
    end
    if isStrNotEmpty(prefab) then
        local value = getEntityValue(entity)
        if isPositive(value) then
            local naughtyvalueText = getLocalization("naughtyvalue") .. ":" .. round(value)
            addText(panelDescriptions, naughtyvalueText, "naughtyvalue")
        end
    end
    if tradable then
        local goldvalue = tradable.goldvalue
        local tradableText = getLocalization("tradable") .. (isPositive(goldvalue) and ":" .. getLocalization("goldvalue") .. goldvalue or "")
        addText(panelDescriptions, tradableText, "tradable")
    end
    if inventory then
        local numItems, max = isFun(inventory.NumItems) and inventory:NumItems(), inventory.maxslots
        local equipslots = inventory.equipslots
        local equipslotsSize = isTable(equipslots) and getLength(equipslots) or 0
        local inventoryUsedStr, equipslotsNameListStr, itemNameListStr = "", "", ""
        if isPosOrZero(numItems) and isPositive(max) then
            inventoryUsedStr = roundUp(numItems) .. "/" .. roundUp(max)
            if numItems + equipslotsSize <= 5 and isTable(inventory.itemslots) then
                local itemNameList = {}
                for _, item in pairs(inventory.itemslots) do
                    if isTable(item) and isStrNotEmpty(item.prefab) then
                        table.insert(itemNameList, getName(item.prefab) or "")
                    end
                end
                itemNameListStr = toStr(",", itemNameList)
                itemNameListStr = isStrNotEmpty(itemNameListStr) and "(" .. itemNameListStr .. ")" or ""
            end
        end
        if isTable(equipslots) then
            if equipslotsSize <= 5 then
                local equipslotsNameList = {}
                for _, equipslot in pairs(equipslots) do
                    if isTable(equipslot) and isStrNotEmpty(equipslot.prefab) then
                        table.insert(equipslotsNameList, getName(equipslot.prefab) or "")
                    end
                end
                equipslotsNameListStr = toStr(",", equipslotsNameList)
                equipslotsNameListStr = isStrNotEmpty(equipslotsNameListStr) and "[" .. equipslotsNameListStr .. "]" or ""
            else
                equipslotsNameListStr = "[" .. equipslotsSize .. "]"
            end
        end
        if isStrNotEmpty(inventoryUsedStr) or isStrNotEmpty(equipslotsNameListStr) then
            local inventoryText = getLocalization("inventory") .. ":" .. inventoryUsedStr .. itemNameListStr .. equipslotsNameListStr
            addText(panelDescriptions, inventoryText, "inventory")
        end
    end
    if container then
        local numItems = isFun(container.NumItems) and container:NumItems()
        local numslots = isFun(container.GetNumSlots) and container:GetNumSlots() or container.numslots
        local boatequipslots = container.boatequipslots
        local boatequipslotsSize = isTable(boatequipslots) and getLength(boatequipslots) or 0
        local containerUsedStr, boatequipslotsStr = "", ""
        if isPosOrZero(numItems) and isPositive(numslots) then
            containerUsedStr = roundUp(numItems) .. "/" .. roundUp(numslots)
            if isTable(container.slots) then
                local nameList = {}
                local ifLarge = numItems + boatequipslotsSize > 5
                for _, slot in pairs(container.slots) do
                    if isTable(slot) and isStrNotEmpty(slot.prefab) then table.insert(nameList, getName(slot.prefab) or "") end
                    if ifLarge and #nameList > 0 then break end
                end
                local nameListStr = toStr(",", nameList)
                nameListStr = isStrNotEmpty(nameListStr) and "(" .. nameListStr .. (ifLarge and "..." or "") .. ")" or ""
                containerUsedStr = containerUsedStr .. nameListStr
            end
        end
        if isTable(boatequipslots) then
            if boatequipslotsSize <= 5 then
                local nameList = {}
                for _, slot in pairs(boatequipslots) do if isTable(slot) and isStrNotEmpty(slot.prefab) then table.insert(nameList, getName(slot.prefab) or "") end end
                boatequipslotsStr = toStr(",", nameList)
                boatequipslotsStr = isStrNotEmpty(boatequipslotsStr) and "[" .. boatequipslotsStr .. "]" or ""
            else
                boatequipslotsStr = "[" .. boatequipslotsSize .. "]"
            end
        end
        local containerText = containerUsedStr .. boatequipslotsStr
        if isStrNotEmpty(containerText) then
            containerText = getLocalization("container") .. ":" .. containerText
            addText(panelDescriptions, containerText, "container")
        end
    end
    if unwrappable then
        local itemdata = unwrappable.itemdata
        local size = isTable(itemdata) and #itemdata
        if isPositive(size) then
            local unwrappableText = getLocalization("contains") .. ":"
            if size <= 5 then
                local count = 1
                for i = 1, size do
                    local prefab_ = isTable(itemdata[i]) and itemdata[i].prefab
                    local data = isTable(itemdata[i]) and itemdata[i].data
                    local stackable = isTable(data) and data.stackable
                    local stack = isTable(stackable) and stackable.stack
                    stack = isPositive(stack) and stack > 1 and round(stack)
                    local name = getName(prefab_)
                    if isStrNotEmpty(name) then
                        unwrappableText = unwrappableText .. (count > 1 and ", " or "") .. name .. (stack and " x" .. stack or "")
                        count = count + 1
                    end
                end
            else
                unwrappableText = unwrappableText .. roundUp(size) .. getLocalization("items")
            end
            addText(panelDescriptions, unwrappableText, "unwrappable")
        end
    end
    if childspawner then
        local childname = childspawner.childname
        childname = getName(childname)
        local rarechild = childspawner.rarechild
        rarechild = getName(rarechild)
        local childreninside = childspawner.childreninside
        local numchildrenoutside = childspawner.numchildrenoutside
        local maxchildren = childspawner.maxchildren
        if isStrNotEmpty(childname) then
            local regening = childspawner.regening
            local regeningStr = ""
            if regening and isPosOrZero(childreninside) and isPosOrZero(numchildrenoutside) and isPositive(maxchildren) and numchildrenoutside + childreninside < maxchildren then
                local regenperiod = childspawner.regenperiod
                local timetonextregen = childspawner.timetonextregen
                if isPositive(regenperiod) and isPosOrZero(timetonextregen) then
                    regeningStr = " " .. getLocalization("regen") .. ":" .. roundUp(timetonextregen) .. "(" .. getTimeStr(timetonextregen, nil, true) .. ")/" .. roundUp(regenperiod)
                end
            end
            local childspawnerText = getLocalization("spawner") .. "(" .. childname .. (isStrNotEmpty(rarechild) and "," .. rarechild or "") .. ")"
            local childNumStr = isPosOrZero(childreninside) and isPosOrZero(numchildrenoutside) and isPositive(maxchildren) and
            ":[" .. childreninside .. "+" .. numchildrenoutside .. "]/" .. maxchildren
            childspawnerText = childspawnerText .. (isStrNotEmpty(childNumStr) and childNumStr or "") .. (isStrNotEmpty(regeningStr) and regeningStr or "")
            addText(panelDescriptions, childspawnerText, "childspawner")
        end
    end
    if spawner then
        local child = isTable(spawner.child) and spawner.child or nil
        local childname = isFun(spawner.GetChildName) and spawner:GetChildName() or spawner.childname
        childname = getName(childname)
        local nextspawntime = spawner.nextspawntime
        nextspawntime = isNumber(nextspawntime) and nextspawntime or 0
        local delay = spawner.delay
        delay = isNumber(delay) and delay or 0
        local timeLeft = nextspawntime - GetTime()
        if isStrNotEmpty(childname) then
            local isOccupied = isFun(spawner.IsOccupied) and spawner:IsOccupied()
            local isOccupiedStr = isOccupied and getLocalization("occupied") or getLocalization("empty")
            local spawnStr = (not child or isOccupied) and spawner.task ~= nil and timeLeft > 0 and delay > 0 and
                " " .. (isOccupied and getLocalization("release") or getLocalization("regen")) .. ":" .. roundUp(timeLeft) .. "(" .. getTimeStr(timeLeft, nil, true) .. ")/" .. roundUp(delay) or ""
            local spawnerText = getLocalization("spawner") .. "(" .. childname .. "):" .. isOccupiedStr .. spawnStr
            addText(panelDescriptions, spawnerText, "spawner")
        end
    end
    if inventoryitem then
        local enchanter = isFun(inventoryitem.GetEnchanter) and inventoryitem:GetEnchanter()
        local displayString = isTable(enchanter) and isFun(enchanter.GetDisplayString) and enchanter:GetDisplayString()
        if isStrNotEmpty(displayString) then
            local inventoryitemText = getLocalization("enchantments") .. ":" .. displayString
            addText(panelDescriptions, inventoryitemText, "inventoryitem")
        end
    end
    if clock then
        local numcycles = clock.numcycles
        local normTime = isFun(clock.GetNormTime) and clock:GetNormTime()
        if isPosOrZero(numcycles) and isPosOrZero(normTime) then
            local fullMoonTime = getFullMoonTime(numcycles, normTime)
            local clockText = getLocalization("moonphase") ..
                ":" ..
                getMoonphase(numcycles) .. "/4" .. (fullMoonTime > 0 and ", " .. string.format(getLocalization("fullmoontimer"), getTimeStr(fullMoonTime)) or ", " .. getLocalization("fullmoontimer2"))
            addText(panelDescriptions, clockText, "clock")
        end
    end
    if seasonmanager then
        local current_season = isFun(seasonmanager.GetSeason) and seasonmanager:GetSeason() or seasonmanager.current_season
        local percent_season = isFun(seasonmanager.GetPercentSeason) and seasonmanager:GetPercentSeason() or seasonmanager.percent_season
        local seasonLength = isFun(seasonmanager.GetSeasonLength) and seasonmanager:GetSeasonLength()
        local dayNum = isNumber(percent_season) and isNumber(seasonLength) and percent_season * seasonLength
        local seasonName = getCfgName(current_season)
        if isStrNotEmpty(seasonName) then
            seasonName = getLocalization("season") .. ":" .. seasonName
            local seasonmanagerText = seasonName ..
                (isPosOrZero(dayNum) and isPosOrZero(seasonLength) and ", " .. roundUp(dayNum + 1) .. getLocalization("timer_day") .. "/" .. roundUp(seasonLength) .. getLocalization("timer_day") or "")
            addText(panelDescriptions, seasonmanagerText, "seasonmanager")
        end
    end
    if nightmareclock then
        local phase = nightmareclock.phase
        local timeLeftInEra = isFun(nightmareclock.GetTimeLeftInEra) and nightmareclock:GetTimeLeftInEra()
        if isStrNotEmpty(phase) and isPosOrZero(timeLeftInEra) then
            local nightmareclockText = getLocalization("nightmareclock") ..
                "(" .. getLocalization("nightmareclock_" .. phase, phase) .. "):" .. string.format(getLocalization("nightmareclocktimer"), getTimeStr(timeLeftInEra))
            addText(panelDescriptions, nightmareclockText, "nightmareclock")
        end
    end
    if hounded then
        local houndstorelease = hounded.houndstorelease
        houndstorelease = isNumber(houndstorelease) and houndstorelease or 0
        local timetoattack = hounded.timetoattack
        timetoattack = isNumber(timetoattack) and timetoattack or 0
        local timetonexthound = hounded.timetonexthound
        timetonexthound = isNumber(timetonexthound) and timetonexthound or 0
        local houndedText = ""
        if timetoattack > 0 and houndstorelease > 0 then
            houndedText = string.format(getLocalization("houndtimer"), roundUp(houndstorelease * 10) / 10, getTimeStr(timetoattack))
        elseif timetonexthound > 0 and houndstorelease > 0 then
            houndedText = string.format(getLocalization("houndtimer2"), roundUp(houndstorelease * 10) / 10, getTimeStr(timetonexthound))
        end
        if isStrNotEmpty(houndedText) then addText(panelDescriptions, houndedText, "hounded") end
    end
    if batted then
        local timetoattack = batted.timetoattack
        local batCount = getBatCount(batted)
        batCount = isNumber(batCount) and batCount or 0
        timetoattack = isNumber(timetoattack) and timetoattack or 0
        if timetoattack > 0 then
            local battedText = string.format(getLocalization("battimer"), roundUp(batCount), getTimeStr(timetoattack))
            addText(panelDescriptions, battedText, "batted")
        end
    end
    if quaker then
        local nextquake = quaker.nextquake
        if isPositive(nextquake) then
            local quakerText = string.format(getLocalization("quaketimer"), getTimeStr(nextquake))
            addText(panelDescriptions, quakerText, "quaker")
        end
    end
    if volcanomanager then
        local numSegmentsUntilEruption = isFun(volcanomanager.GetNumSegmentsUntilEruption) and volcanomanager:GetNumSegmentsUntilEruption()
        local segTime = isPosOrZero(TUNING.SEG_TIME) and TUNING.SEG_TIME
        local totalDayTime = isPosOrZero(TUNING.TOTAL_DAY_TIME) and TUNING.TOTAL_DAY_TIME
        if isPosOrZero(numSegmentsUntilEruption) and segTime and totalDayTime then
            local currentSegTime = math.floor(totalDayTime * GetClock():GetNormTime() / segTime) * segTime
            currentSegTime = totalDayTime * GetClock():GetNormTime() - currentSegTime
            local segTimeLeft = numSegmentsUntilEruption * segTime - currentSegTime
            local volcanomanagerText = string.format(getLocalization("volcanotimer"), getTimeStr(segTimeLeft))
            addText(panelDescriptions, volcanomanagerText, "volcanomanager")
        end
    end
    if basehassler then
        local hasslers = basehassler.hasslers
        if isTable(hasslers) and next(hasslers) then
            for key, hassler in pairs(hasslers) do
                local timer = hassler.timer
                local chance = hassler.chance
                local name = getName(hassler.prefab) or ""
                local state = isFun(basehassler.GetHasslerState) and basehassler:GetHasslerState(key)
                local hasslerStr = isStrNotEmpty(state) and (state == "WAITING" or state == "WARNING") and
                    "(" .. getLocalization("timer_" .. state) .. (isPositive(chance) and state ~= "WARNING" and "," .. roundPercent(chance) or "") ..
                    ")" or ""
                if isStrNotEmpty(name) and isStrNotEmpty(hasslerStr) and isPositive(chance) then
                    local basehasslerText = name .. hasslerStr .. (isNumber(timer) and ":" .. getTimeStr(timer) or "")
                    addText(panelDescriptions, basehasslerText, "basehassler")
                end
            end
        end
    end
    if periodicthreat then
        local threats = periodicthreat.threats
        if isTable(threats) and next(threats) then
            for key, threat in pairs(threats) do
                local name = getName(key)
                local state = isFun(periodicthreat.GetCurrentState) and periodicthreat:GetCurrentState(key)
                local periodicthreatStr = isStrNotEmpty(state) and "(" .. getLocalization("periodicthreat_" .. state, state) .. ")" or ""
                if isStrNotEmpty(name) and isTable(threat) and isPositive(threat.timer) then
                    local periodicthreatText = name .. periodicthreatStr .. ":" .. getTimeStr(threat.timer)
                    addText(panelDescriptions, periodicthreatText, "periodicthreat")
                end
            end
        end
    end
    if tigersharker then
        local tigersharkerSpawnTime = isFun(tigersharker.TimeUntilRespawn) and tigersharker:TimeUntilRespawn()
        tigersharkerSpawnTime = isPositive(tigersharkerSpawnTime) and tigersharkerSpawnTime or 0
        local timeUntilCanAppear = isFun(tigersharker.TimeUntilCanAppear) and tigersharker:TimeUntilCanAppear()
        timeUntilCanAppear = isPositive(timeUntilCanAppear) and timeUntilCanAppear or 0
        local timeLeft = math.max(tigersharkerSpawnTime, timeUntilCanAppear)
        local canSpawn = isFun(tigersharker.CanSpawn) and tigersharker:CanSpawn()
        local name = getName("tigershark") or ""
        if isStrNotEmpty(name) and (canSpawn or timeLeft > 0) then
            local tigersharkerText = name .. (canSpawn and ":" .. getLocalization("timer_ready") or ":" .. getTimeStr(timeLeft))
            addText(panelDescriptions, tigersharkerText, "tigersharker")
        end
    end
    if krakener then
        local krakenerSpawnTime = isFun(krakener.TimeUntilCanSpawn) and krakener:TimeUntilCanSpawn()
        krakenerSpawnTime = isPositive(krakenerSpawnTime) and krakenerSpawnTime or 0
        local canSpawn = isFun(krakener.CanSpawn) and krakener:CanSpawn()
        local name = getName("kraken") or ""
        if isStrNotEmpty(name) and (canSpawn or krakenerSpawnTime > 0) then
            local krakenerText = name .. (canSpawn and ":" .. getLocalization("timer_ready") or ":" .. getTimeStr(krakenerSpawnTime))
            addText(panelDescriptions, krakenerText, "krakener")
        end
    end
    if rocmanager then
        local dycSpawnTime = rocmanager.dycSpawnTime
        local timeLeft = isNumber(dycSpawnTime) and dycSpawnTime - GetTime() or 0
        local isDisabled = rocmanager.disabled
        local name = STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.ROC or ""
        if isStrNotEmpty(name) and not isDisabled and timeLeft > 0 then
            local rocmanagerText = name .. ":" .. getTimeStr(timeLeft)
            addText(panelDescriptions, rocmanagerText, "rocmanager")
        end
    end
    if entity.GetPanelDescriptions then
        local desTable = entity:GetPanelDescriptions()
        if #desTable > 0 then
            for i = 1, #desTable do
                if desTable[i] then
                    local text = desTable[i].text
                    addText(panelDescriptions, text, "custom")
                end
            end
        end
    end
    return panelDescriptions
end
return getInfo
