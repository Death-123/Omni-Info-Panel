local DYCInfoPanel = DYCInfoPanel
local DYCModRequire = DYCInfoPanel.DYCModRequire
local getInfo = DYCModRequire("dyc_descutil")
local RGBAColor = DYCInfoPanel.RGBAColor
local StrSpl = DYCInfoPanel.lib.StrSpl
local StringStartWith = DYCInfoPanel.lib.StringStartWith
local componentList = {
    prefab = true,
    tags = true,
    recipe = true,
    boathealth = true,
    health = true,
    combat = true,
    weapon = true,
    armor = true,
    tool = true,
    finiteuses = true,
    fueled = true,
    perishable = true,
    edible = true,
    inventoryitem = true,
    custom = true,
}
local function isDST() return TheSim:GetGameID() == "DST" end
local function hasLocalization(key) return DYCInfoPanel.localization:HasString(key) end
local function getLocalization(lang, key) return DYCInfoPanel.localization:GetString(lang, key) end
local function getActionDes(entity)
    if not entity or not entity.GetDescriptionString then return end
    local LMBAction, RMBAction = nil, nil
    local desStr = entity:GetDescriptionString()
    if desStr and type(desStr) == "string" and #desStr > 0 then
        local desLines = StrSpl(desStr, "\n")
        if desLines then
            for _, desLine in pairs(desLines) do
                if desLine and type(desLine) == "string" and #desLine > 0 then
                    if StringStartWith(desLine, STRINGS.LMB) then LMBAction = desLine end
                    if StringStartWith(desLine, STRINGS.RMB) then RMBAction = desLine end
                end
            end
        end
    end
    if LMBAction and type(LMBAction) == "string" and #LMBAction > 0 then
        local i = 1
        for j = 1, #LMBAction do
            local char = string.sub(LMBAction, j, j)
            if char == ":" or char == " " then i = j + 1 end
        end
        if i <= #LMBAction then LMBAction = string.sub(LMBAction, i) else LMBAction = nil end
    end
    print("getActionDes", LMBAction, " ", RMBAction)
    return LMBAction, RMBAction
end
local function isEntityInstValid(entity) return entity and entity.inst and entity.inst:IsValid() end
local function FollowObject(mouse, entity)
    local objectDetailWindow = DYCInfoPanel.objectDetailWindow
    if objectDetailWindow then
        local infoWindowPos = isEntityInstValid(entity) and entity:GetWorldPosition() or TheInput:ControllerAttached() and mouse and Vector3(TheSim:GetScreenPos(mouse.Transform:GetWorldPosition())) or
            TheInput:GetScreenPosition()
        local screenW, screenH = TheSim:GetScreenSize()
        local infoWindowW, infoWindowH = objectDetailWindow:GetSize()
        local entityW, entityH = 0, 0
        if isEntityInstValid(entity) and entity.bg then
            entityW, entityH = entity.bg:GetSize()
        elseif isEntityInstValid(entity) then
            entityW, entityH = 100, 100
        end
        local infopanelpos = DYCInfoPanel.cfgs.infopanelpos
        if infopanelpos and infopanelpos == "auto" then
            infopanelpos = TheInput:ControllerAttached() and "bl" or "follow"
        end
        if infopanelpos and infopanelpos == "tl" then
            infoWindowPos = Vector3(0, screenH, 0)
            entityW, entityH = 0, 0
        elseif infopanelpos and infopanelpos == "bl" then
            infoWindowPos = Vector3(0, 0, 0)
            entityW, entityH = 0, 0
        elseif infopanelpos and infopanelpos == "tr" then
            infoWindowPos = Vector3(screenW, screenH, 0)
            entityW, entityH = 0, 0
        elseif infopanelpos and infopanelpos == "br" then
            infoWindowPos = Vector3(screenW, 0, 0)
            entityW, entityH = 0, 0
        end
        local screenScale = objectDetailWindow.screenScale
        local finalW, finalH = (infoWindowW / 2 + entityW / 2 + 30) * screenScale, (infoWindowH / 2 + entityH / 2 + 20) * screenScale
        local offsetX = (screenH - infoWindowPos.y < finalH * 2 and infoWindowPos.y < finalH * 2 and (screenW - infoWindowPos.x < finalW * 2 and -finalW or finalW)) or
            (screenW - infoWindowPos.x < finalW and -finalW) or (infoWindowPos.x < finalW and finalW) or
            0
        local offsetY = (screenH - infoWindowPos.y < finalH * 2 and infoWindowPos.y < finalH * 2 and 0) or (screenH - infoWindowPos.y < finalH * 2 and -finalH) or (infoWindowPos.y < finalH and finalH) or
            (offsetX ~= 0 and 0) or finalH
        objectDetailWindow:SetOffset(infoWindowPos + Vector3(offsetX, offsetY, 0))
    end
end
local function getBuffName(buffInfo) return buffInfo.buff:GetDisplayName(buffInfo) end
local function getSuffix(buffInfo) return buffInfo.buff:GetSuffix(buffInfo) .. "      " end
local function getSourceString(buffInfo) return buffInfo.buff:GetSourceString(buffInfo) end
local function getBuffColor(buffInfo)
    return buffInfo.buff.type == "positive" and DYCInfoPanel.RGBAColor(0, 1, 0, 1) or
        buffInfo.buff.type == "negative" and DYCInfoPanel.RGBAColor(1, 0, 0, 1) or
        DYCInfoPanel.RGBAColor(1, 1, 1, 1)
end
local function getBuffDes(buffInfo) return buffInfo.buff:GetDescription(buffInfo) end
local ShowObjectDetail = nil
ShowObjectDetail = function(entity, hoveredWidget, LAction, RAction)
    local objectDetailWindow = DYCInfoPanel.objectDetailWindow
    if objectDetailWindow then
        objectDetailWindow.focusedObject = entity
        if not entity then
            if not hoveredWidget or hoveredWidget == objectDetailWindow.hoveredWidget then
                if objectDetailWindow.shown then objectDetailWindow:Toggle(false) end
                objectDetailWindow.hoveredWidget = nil
            end
            return
        end
        if objectDetailWindow.hoveredWidget ~= hoveredWidget and hoveredWidget and entity then
            local DYCDataSyncer = rawget(_G, "DYCDataSyncer")
            if DYCDataSyncer and DYCDataSyncer.SendSyncDataRPC then
                DYCDataSyncer.SendSyncDataRPC(entity)
                entity.dycOnSyncFinish = function()
                    if objectDetailWindow.hoveredWidget == hoveredWidget and not entity.dycTask_SyncFinish then
                        entity.dycTask_SyncFinish = entity:DoTaskInTime(0,
                            function()
                                ShowObjectDetail(entity, hoveredWidget, LAction, RAction)
                                entity.dycTask_SyncFinish = nil
                            end)
                    end
                end
            end
        end
        objectDetailWindow.hoveredWidget = hoveredWidget
        local stackable = entity.components.stackable
        local inventoryitem = isDST() and entity.replica.inventoryitem or entity.components.inventoryitem
        local equippable = entity.components.equippable
        local unwrappable = entity.components.unwrappable
        local enchanter = inventoryitem and inventoryitem.GetEnchanter and inventoryitem:GetEnchanter()
        local showRarity = DYCInfoPanel.cfgs.rarity and (equippable ~= nil or unwrappable ~= nil)
        local icon = nil
        if enchanter and enchanter.GetIcon then
            local atlas, image = enchanter:GetIcon()
            if atlas and image then icon = { atlas = atlas, image = image } end
        end
        if not icon and inventoryitem and inventoryitem.GetAtlas and inventoryitem.GetImage then
            local atlas, image = inventoryitem:GetAtlas(), inventoryitem:GetImage()
            icon = { atlas = atlas, image = image }
        end
        local adjective = entity:GetAdjective()
        adjective = adjective and type(adjective) == "string" and string.gsub(adjective, "\n", "")
        local displayName = entity:GetDisplayName()
        displayName = displayName and type(displayName) == "string" and string.gsub(displayName, "\n", "")
        if entity.prefab and displayName and string.find(string.lower(displayName), "missing name") then displayName = getLocalization("world_" .. entity.prefab, displayName) end
        local stacksizeStr = stackable and stackable.stacksize > 1 and "x" .. tostring(stackable.stacksize) or nil
        local LActionStr, RActionStr = getActionDes(hoveredWidget)
        LActionStr = LActionStr or LAction
        RActionStr = RActionStr or RAction
        LActionStr = LActionStr and type(LActionStr) == "string" and string.gsub(LActionStr, "\n", "")
        RActionStr = RActionStr and type(RActionStr) == "string" and string.gsub(RActionStr, "\n", "")
        print("getActionDes", LAction, " ", RAction)
        local rarityNum = entity.GetRarity and entity:GetRarity() or 0
        local rarityStr = rarityNum > 0 and entity.GetRarityString and entity:GetRarityString() or nil
        local rarityColor = entity.GetRarityColor and entity:GetRarityColor()
        local qualityString = rarityStr and entity.GetQualityString and entity:GetQualityString()
        if not showRarity then
            rarityStr = nil
            rarityColor = nil
            qualityString = nil
        end
        local recipeDesc = entity.prefab and STRINGS.RECIPE_DESC[string.upper(entity.prefab)] or nil
        recipeDesc = recipeDesc and type(recipeDesc) == "string" and string.gsub(recipeDesc, "\n", "")
        local longDes = entity.GetPanelLongDescription and entity:GetPanelLongDescription() or nil
        recipeDesc = (recipeDesc or "") .. (recipeDesc and longDes and " " or "") .. (longDes or "")
        longDes = entity.GetEnchantmentLongDescription and entity:GetEnchantmentLongDescription() or nil
        recipeDesc = (recipeDesc or "") .. (recipeDesc and longDes and " " or "") .. (longDes or "")
        recipeDesc = #recipeDesc > 0 and recipeDesc or nil
        recipeDesc = recipeDesc and type(recipeDesc) == "string" and getLocalization("longdesnospace") == "true" and string.gsub(recipeDesc, " ", "") or recipeDesc
        local desTable = getInfo(entity, DYCInfoPanel.cfgs.prefab, DYCInfoPanel.cfgs.tags, DYCInfoPanel.cfgs.recipe, DYCInfoPanel.cfgs.richtext)
        local entity2, inst2Type = nil, ""
        if entity and entity.components.rider and entity.components.rider.mount then
            entity2 = entity.components.rider.mount
            inst2Type = getLocalization("mount")
        elseif entity and entity.components.driver and entity.components.driver.vehicle then
            entity2 = entity.components.driver.vehicle
            inst2Type = getLocalization("vehicle")
        end
        if entity2 then
            local entity2DesTable = getInfo(entity2, DYCInfoPanel.cfgs.prefab, DYCInfoPanel.cfgs.tags, DYCInfoPanel.cfgs.recipe, DYCInfoPanel.cfgs.richtext)
            if #entity2DesTable > 0 then
                local inst2Str = inst2Type .. ": " .. (entity2:GetDisplayName() or "")
                inst2Str = inst2Str and type(inst2Str) == "string" and string.gsub(inst2Str, "\n", "")
                table.insert(desTable, { text = inst2Str, color = RGBAColor() })
                for _, entity2DesLine in pairs(entity2DesTable) do table.insert(desTable, entity2DesLine) end
            end
        end
        if not entity:HasTag("ground") and DYCInfoPanel.cfgs.content and DYCInfoPanel.cfgs.content == "concise" then
            local temDesTable = {}
            for _, desLine in pairs(desTable) do
                if desLine and desLine.component and componentList[desLine.component] then
                    table.insert(temDesTable, desLine)
                end
            end
            desTable = temDesTable
            recipeDesc = nil
        end
        objectDetailWindow:SetObjectDetail({
            action = LActionStr,
            action2 = RActionStr,
            icon = hoveredWidget and hoveredWidget.buffInfo and { atlas = hoveredWidget.buffInfo.buff.atlas, image = hoveredWidget.buffInfo.buff.image } or icon,
            prefix = adjective,
            name = hoveredWidget and hoveredWidget.buffInfo and getBuffName(hoveredWidget.buffInfo) or displayName,
            nameColor = hoveredWidget and hoveredWidget.buffInfo and getBuffColor(hoveredWidget.buffInfo) or rarityColor,
            suffix = hoveredWidget and hoveredWidget.buffInfo and getSuffix(hoveredWidget.buffInfo) or stacksizeStr,
            des = hoveredWidget and hoveredWidget.buffInfo and getBuffDes(hoveredWidget.buffInfo) or recipeDesc,
            desColor = hoveredWidget and hoveredWidget.buffInfo and DYCInfoPanel.RGBAColor(),
            rarity = rarityStr and (getLocalization("rarity") .. ":" .. rarityStr) or nil,
            quality = qualityString and (" " .. getLocalization("quality") .. ":" .. qualityString) or nil,
            lines = desTable,
            encLines = entity.GetEnchantmentLines and entity:GetEnchantmentLines(),
            buffInfos = entity.GetSortedBuffs and entity:GetSortedBuffs(),
            buffSource = hoveredWidget and hoveredWidget.buffInfo and getSourceString(hoveredWidget.buffInfo),
        })
        FollowObject(entity, hoveredWidget)
        if not objectDetailWindow.shown then objectDetailWindow:Toggle(true) end
    end
end
local moveHandlerAdded = false
local function addMoveHandler()
    moveHandlerAdded = true
    TheInput:AddMoveHandler(function(_, _)
        local objectDetailWindow = DYCInfoPanel.objectDetailWindow
        if objectDetailWindow and objectDetailWindow.hoveredWorldInst then FollowObject() end
    end)
end
local entityCache = nil
local displayNameCache = nil
local LActionStrCache = nil
local RActionStrCache = nil
local currenthealthCache = nil
local dycSyncTimeCache = nil
local function ShowMouseObjectDetail(entity, LAction, RAction)
    local objectDetailWindow = DYCInfoPanel.objectDetailWindow
    if not objectDetailWindow then return end
    if not moveHandlerAdded then addMoveHandler() end
    if objectDetailWindow.hoveredWidget then
        objectDetailWindow.hoveredWorldInst = nil
        return
    end
    entity = entity ~= nil and not entity:HasTag("Fx") and entity
    if objectDetailWindow.hoveredWorldInst ~= entity and entity then
        local DYCDataSyncer = rawget(_G, "DYCDataSyncer")
        if DYCDataSyncer and DYCDataSyncer.SendSyncDataRPC then DYCDataSyncer.SendSyncDataRPC(entity) end
    end
    objectDetailWindow.hoveredWorldInst = entity
    if not entity then
        if objectDetailWindow.shown then objectDetailWindow:Toggle(false) end
        entityCache = nil
        return
    end
    if not objectDetailWindow.shown then objectDetailWindow:Toggle(true) end
    local stackable = entity.components.stackable
    local displayName = entity:GetDisplayName()
    local LActionStr = LAction and LAction:GetActionString()
    local RActionStr = RAction and RAction:GetActionString()
    RActionStr = RActionStr and STRINGS.RMB .. ":" .. RActionStr
    local health = entity.components.health
    local currenthealth = health and health.currenthealth
    currenthealth = currenthealth ~= nil and type(currenthealth) == "number" and currenthealth
    local dycSyncTime = entity.dycSyncTime
    entity.dycMouseHoverTimer = entity.dycMouseHoverTimer and entity.dycMouseHoverTimer + FRAMES or 0
    if dycSyncTimeCache == dycSyncTime and
        displayNameCache == displayName and
        entityCache == entity and
        LActionStrCache == LActionStr and
        RActionStrCache == RActionStr and
        currenthealthCache == currenthealth and
        entity.dycMouseHoverTimer < 0.5 then
        return
    else
        dycSyncTimeCache = dycSyncTime
        displayNameCache = displayName
        entityCache = entity
        LActionStrCache = LActionStr
        RActionStrCache = RActionStr
        currenthealthCache = currenthealth
    end
    entity.dycMouseHoverTimer = 0
    ShowObjectDetail(entity, nil, LActionStr, RActionStr)
end
local function ClearUpdateOdwTask(hoveredWidget)
    if hoveredWidget.inst.dycUpdateOdwTask then
        hoveredWidget.inst.dycUpdateOdwTask:Cancel()
        hoveredWidget.inst.dycUpdateOdwTask = nil
    end
end
local function CreateUpdateOdwTask(hoveredWidget, entity)
    hoveredWidget.inst.dycUpdateOdwTask = hoveredWidget.inst:DoPeriodicTask(0.5,
        function()
            local objectDetailWindow = DYCInfoPanel.objectDetailWindow
            if objectDetailWindow and objectDetailWindow.hoveredWidget == hoveredWidget and entity and entity:IsValid() then
                ShowObjectDetail(entity, hoveredWidget)
            else
                ClearUpdateOdwTask(hoveredWidget)
            end
        end)
end
local odwutil = {
    ShowObjectDetail = ShowObjectDetail,
    ShowMouseObjectDetail = ShowMouseObjectDetail,
    FollowObject = FollowObject,
    ClearUpdateOdwTask = ClearUpdateOdwTask,
    CreateUpdateOdwTask = CreateUpdateOdwTask,
}
return odwutil
