local DYCInfoPanel = DYCInfoPanel
local TableContains = DYCInfoPanel.lib.TableContains
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
local function isDST() return TheSim:GetGameID() == "DST" end
local function getPlayer() if isDST() then return ThePlayer else return GetPlayer() end end
local function getWorld() if isDST() then return TheWorld else return GetWorld() end end
local function getClock() if isDST() then return TheWorld.net.components.clock else return GetClock() end end
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
local function getFullMoonTime(numcycles, normTime)
    local moonphase = math.floor(numcycles / 2) % (8)
    if moonphase == 4 then return 0 end
    local dayLeft = 8
    while dayLeft - numcycles - normTime <= 0 do dayLeft = dayLeft + 16 end
    return (dayLeft - numcycles - normTime) * TUNING.TOTAL_DAY_TIME
end
local function dycWatcherRun(self)
    if not DYCInfoPanel.cfgs.notifications then return end
    local bannerSystem = DYCInfoPanel.bannerSystem
    local redColor = { 1, 0, 0 }
    local orangeColor = { 1, 0.5, 0 }
    local whiteColor = { 1, 1, 1 }
    local world = getWorld()
    local clock = getClock()
    local components = world and world.components
    local hounded = components and components.hounded
    local inOneMinuteHounded = false
    local oneMinuteHounded = 60
    local inTenMinuteHounded = false
    local tenMinuteHounded = 600
    local showedHounded = false
    local batted = components and components.batted
    local inOneMinuteBatted = false
    local oneMinuteBatted = 60
    local inTenMinuteBatted = false
    local tenMinuteBatted = 600
    local timeToBatted = 999999
    local battedCount = 0
    local volcanomanager = components and components.volcanomanager
    local inHalfMinute = false
    local halfMinute = 30
    local inTwoMinute = false
    local twoMinute = 120
    local inEightMinute = false
    local eightMinute = 480
    local timeToEruption = 999999
    local inEruption = false
    local basehassler = components and components.basehassler
    local inTimeHasslerList = {}
    local hasslerIsWarningList = {}
    local hasslerStateList = {}
    local hasslersTimeList = { 60, 480, 10800 }
    local periodicthreat = components and components.periodicthreat
    local inTimeThreatsList = {}
    local threatsStateList = {}
    local threatsTimeList = { 60, 480, 10800 }
    local rocmanager = components and components.rocmanager
    local rocInTimeList = { false, false, false }
    local rocTimeList = { 120, 480, 10800 }
    local rocTime = 999999
    local bloodmoon_active = clock.bloodmoon_active
    local dayCompleteFlag = false
    world:ListenForEvent("daycomplete",
        function(self, _)
            if dayCompleteFlag then return end
            dayCompleteFlag = true
            self:DoTaskInTime(FRAMES,
                function()
                    dayCompleteFlag = false
                    local numcycles = clock and clock.numcycles
                    local normTime = clock and clock:GetNormTime()
                    local fullMoonTime = getFullMoonTime(numcycles, normTime)
                    if fullMoonTime == 0 then DYCInfoPanel.PushBanner(getLocalization("fullmoontimer2"), 12, whiteColor) end
                end)
        end)
    local phaseChangeFlag = false
    local lastPhase = ""
    world:ListenForEvent("phasechange",
        function(self, _)
            if phaseChangeFlag then return end
            phaseChangeFlag = true
            self:DoTaskInTime(FRAMES,
                function()
                    phaseChangeFlag = false
                    local nightmareclock = isTable(self.components.nightmareclock) and self.components.nightmareclock
                    local phase = nightmareclock and nightmareclock.phase
                    local timeLeftInEra = nightmareclock and isFun(nightmareclock.GetTimeLeftInEra) and nightmareclock:GetTimeLeftInEra()
                    if isStrNotEmpty(phase) then
                        if lastPhase ~= "warn" and phase == "warn" and isPositive(timeLeftInEra) then
                            DYCInfoPanel.PushBanner(string.format(getLocalization("watcher_nightmareclock1"), getTimeStr(timeLeftInEra)), 12, orangeColor, true)
                        elseif lastPhase ~= "nightmare" and phase == "nightmare" then
                            DYCInfoPanel.PushBanner(getLocalization("watcher_nightmareclock2"), 12, redColor, true)
                        elseif lastPhase == "nightmare" and phase ~= "nightmare" then
                            DYCInfoPanel.PushBanner(
                                getLocalization("watcher_nightmareclock3"), 12, whiteColor)
                        end
                        lastPhase = phase
                    end
                end)
        end)
    local timerMax = 0.5
    local timer = 0
    world:DoPeriodicTask(FRAMES,
        function()
            timer = timer + FRAMES
            if timer >= timerMax then
                timer = 0
                if clock.bloodmoon_active ~= bloodmoon_active then
                    bloodmoon_active = clock.bloodmoon_active
                    if bloodmoon_active then DYCInfoPanel.PushBanner(getLocalization("watcher_bloodmoon1"), 12, redColor, true) else DYCInfoPanel.PushBanner(getLocalization("watcher_bloodmoon2"), 12,
                            whiteColor) end
                end
                if hounded then
                    local houndedtimerTag = "houndedtimer"
                    local timetoattack = hounded.timetoattack
                    timetoattack = isPosOrZero(timetoattack) and timetoattack or 0
                    local houndstorelease = hounded.houndstorelease
                    houndstorelease = isNumber(houndstorelease) and houndstorelease or 0
                    local showHounded = false
                    local inOneMin = false
                    if not inOneMinuteHounded and timetoattack <= oneMinuteHounded then
                        showHounded = true
                    elseif not inTenMinuteHounded and timetoattack <= tenMinuteHounded then
                        showHounded = true
                    end
                    if showHounded then
                        inOneMin = timetoattack <= 60
                        local getHoundedText = function()
                            timetoattack = hounded.timetoattack
                            timetoattack = isPosOrZero(timetoattack) and timetoattack or 0
                            houndstorelease = hounded.houndstorelease
                            houndstorelease = isNumber(houndstorelease) and houndstorelease or 0
                            return getLocalization("timer_warning") .. ": " .. string.format(getLocalization("houndtimer"), roundUp(houndstorelease), getTimeStr(timetoattack))
                        end
                        local houndedText = getHoundedText()
                        local updateFn = function(self, _) self:SetText(getHoundedText()) end
                        local startFn = function(self)
                            self:AddTag(houndedtimerTag)
                            self:SetUpdateFn(updateFn)
                        end
                        bannerSystem:FadeOutBanners(houndedtimerTag)
                        DYCInfoPanel.PushBanner(houndedText, inOneMin and timetoattack or 12, orangeColor, true, startFn)
                    end
                    if not showedHounded and timetoattack <= 0 then
                        bannerSystem:FadeOutBanners(houndedtimerTag)
                        DYCInfoPanel.PushBanner(getLocalization("watcher_houndattack"), 12, redColor, true)
                    end
                    if timetoattack > oneMinuteHounded then inOneMinuteHounded = false else inOneMinuteHounded = true end
                    if timetoattack > tenMinuteHounded then inTenMinuteHounded = false else inTenMinuteHounded = true end
                    if timetoattack > 0 then showedHounded = false else showedHounded = true end
                end
                if batted then
                    local battedtimerTag = "battedtimer"
                    local timetoattack = batted.timetoattack
                    timetoattack = isPosOrZero(timetoattack) and timetoattack or 0
                    local batCount = getBatCount(batted)
                    batCount = isNumber(batCount) and batCount or 0
                    local showBatted = false
                    local battedInOneMinute = false
                    if not inOneMinuteBatted and timetoattack <= oneMinuteBatted then showBatted = true elseif not inTenMinuteBatted and timetoattack <= tenMinuteBatted then showBatted = true end
                    if showBatted then
                        battedInOneMinute = timetoattack <= 60
                        local getBattedText = function()
                            timetoattack = batted.timetoattack
                            timetoattack = isPosOrZero(timetoattack) and timetoattack or 0
                            batCount = getBatCount(batted)
                            batCount = isNumber(batCount) and batCount or 0
                            return getLocalization("timer_warning") .. ": " .. string.format(getLocalization("battimer"), roundUp(batCount), getTimeStr(timetoattack))
                        end
                        local battedText = getBattedText()
                        local updateFn = function(self, _) self:SetText(getBattedText()) end
                        local startFn = function(self)
                            self:AddTag(battedtimerTag)
                            self:SetUpdateFn(updateFn)
                        end
                        bannerSystem:FadeOutBanners(battedtimerTag)
                        DYCInfoPanel.PushBanner(battedText, battedInOneMinute and timetoattack or 12, orangeColor, true, startFn)
                    end
                    if timeToBatted < timetoattack and battedCount > 0 then
                        bannerSystem:FadeOutBanners(battedtimerTag)
                        DYCInfoPanel.PushBanner(getLocalization("watcher_batattack"), 12, redColor, true)
                    end
                    if timetoattack > oneMinuteBatted then inOneMinuteBatted = false else inOneMinuteBatted = true end
                    if timetoattack > tenMinuteBatted then inTenMinuteBatted = false else inTenMinuteBatted = true end
                    timeToBatted = timetoattack
                    battedCount = batCount
                end
                if volcanomanager then
                    local volcanomanagertimerTag = "volcanomanagertimer"
                    local numSegmentsUntilEruption = isFun(volcanomanager.GetNumSegmentsUntilEruption) and volcanomanager:GetNumSegmentsUntilEruption()
                    local SEG_TIME = isPosOrZero(TUNING.SEG_TIME) and TUNING.SEG_TIME
                    local TOTAL_DAY_TIME = isPosOrZero(TUNING.TOTAL_DAY_TIME) and TUNING.TOTAL_DAY_TIME
                    if isPosOrZero(numSegmentsUntilEruption) and SEG_TIME and TOTAL_DAY_TIME then
                        local segPassedTime = math.floor(TOTAL_DAY_TIME * getClock():GetNormTime() / SEG_TIME) * SEG_TIME
                        segPassedTime = TOTAL_DAY_TIME * getClock():GetNormTime() - segPassedTime
                        local timeLeft = numSegmentsUntilEruption * SEG_TIME - segPassedTime
                        local showVolcano = false
                        local eruptionInTwoMinute = false
                        if inEruption then showVolcano = true elseif not inHalfMinute and timeLeft <= halfMinute then showVolcano = true elseif not inTwoMinute and timeLeft <= twoMinute then showVolcano = true elseif not inEightMinute and timeLeft <= eightMinute then showVolcano = true end
                        if showVolcano then
                            eruptionInTwoMinute = timeLeft <= 120
                            local getEruptionText = function()
                                numSegmentsUntilEruption = isFun(volcanomanager.GetNumSegmentsUntilEruption) and volcanomanager:GetNumSegmentsUntilEruption()
                                segPassedTime = math.floor(TOTAL_DAY_TIME * getClock():GetNormTime() / SEG_TIME) * SEG_TIME
                                segPassedTime = TOTAL_DAY_TIME * getClock():GetNormTime() - segPassedTime
                                timeLeft = isPosOrZero(numSegmentsUntilEruption) and numSegmentsUntilEruption * SEG_TIME - segPassedTime
                                return getLocalization("timer_warning") .. ": " .. string.format(getLocalization("volcanotimer"), isPosOrZero(timeLeft) and getTimeStr(timeLeft) or "?")
                            end
                            local eruptionText = getEruptionText()
                            local updateFn = function(self, _)
                                self:SetText(getEruptionText())
                                numSegmentsUntilEruption = isFun(volcanomanager.GetNumSegmentsUntilEruption) and volcanomanager:GetNumSegmentsUntilEruption()
                                if not isPosOrZero(numSegmentsUntilEruption) then self:FadeOut() end
                            end
                            local startFn = function(self)
                                self:AddTag(volcanomanagertimerTag)
                                self:SetUpdateFn(updateFn)
                            end
                            bannerSystem:FadeOutBanners(volcanomanagertimerTag)
                            DYCInfoPanel.PushBanner(eruptionText, eruptionInTwoMinute and timeLeft or 12, orangeColor, true, startFn)
                        end
                        if timeToEruption < timeLeft and timeToEruption <= 2 then
                            bannerSystem:FadeOutBanners(volcanomanagertimerTag)
                            DYCInfoPanel.PushBanner(getLocalization("watcher_volcano"), 12, redColor, true)
                        end
                        if timeLeft > halfMinute then inHalfMinute = false else inHalfMinute = true end
                        if timeLeft > twoMinute then inTwoMinute = false else inTwoMinute = true end
                        if timeLeft > eightMinute then inEightMinute = false else inEightMinute = true end
                        timeToEruption = timeLeft
                        inEruption = false
                    else
                        timeToEruption = 999999
                        inEruption = true
                    end
                end
                if basehassler then
                    local basehasslertimerTag = "basehasslertimer"
                    local hasslers = basehassler.hasslers
                    if isTable(hasslers) and next(hasslers) then
                        for id, hassler in pairs(hasslers) do
                            local chance = hassler.chance
                            local timer = isTable(hassler) and hassler.timer
                            local prefab = isTable(hassler) and hassler.prefab
                            local name = getName(prefab) or ""
                            local state = isFun(basehassler.GetHasslerState) and basehassler:GetHasslerState(id)
                            local hasslerStr = isStrNotEmpty(state) and (state == "WAITING" or state == "WARNING") and
                                "(" .. getLocalization("timer_" .. state) .. (isPositive(chance) and state ~= "WARNING" and "," .. roundPercent(chance) or "") .. ")" or ""
                            if not inTimeHasslerList[hassler] then
                                inTimeHasslerList[hassler] = {}
                                for _ = 1, #hasslersTimeList do table.insert(inTimeHasslerList[hassler], false) end
                            end
                            local inTimeHassler = inTimeHasslerList[hassler]
                            if isNumber(timer) and isPositive(chance) and isStrNotEmpty(name) and isStrNotEmpty(hasslerStr) then
                                local showHassler = false
                                local inWarning = false
                                for i = 1, #hasslersTimeList do
                                    if not inTimeHassler[i] and timer <= hasslersTimeList[i] and state ~= "WARNING" then showHassler = true end
                                    if timer > hasslersTimeList[i] then inTimeHassler[i] = false else inTimeHassler[i] = true end
                                end
                                if not hasslerIsWarningList[hassler] and hasslerStateList[hassler] ~= state and state == "WARNING" then
                                    hasslerIsWarningList[hassler] = true
                                    showHassler = true
                                    inWarning = true
                                elseif hasslerIsWarningList[hassler] and state ~= "WARNING" then
                                    hasslerIsWarningList[hassler] = false
                                end
                                if showHassler then
                                    local getHasslerText = function()
                                        timer = isTable(hassler) and hassler.timer
                                        return name .. hasslerStr .. ":" .. (isPosOrZero(timer) and getTimeStr(timer) or "?")
                                    end
                                    local hasslerText = getHasslerText()
                                    local updateFn = function(self, _) self:SetText(getHasslerText()) end
                                    local startFn = function(self)
                                        self:AddTag(basehasslertimerTag .. name)
                                        self:SetUpdateFn(updateFn)
                                    end
                                    bannerSystem:FadeOutBanners(basehasslertimerTag .. name)
                                    DYCInfoPanel.PushBanner(hasslerText, inWarning and timer or 12, orangeColor, true, startFn)
                                end
                            elseif isTable(hassler) and isStrNotEmpty(name) then
                                for i = 1, #inTimeHassler do if inTimeHassler[i] == true then inTimeHassler[i] = false end end
                            end
                            if isTable(hassler) and isStrNotEmpty(name) then
                                if hasslerStateList[hassler] == "WARNING" and state ~= "WARNING" then
                                    bannerSystem:FadeOutBanners(basehasslertimerTag .. name)
                                    DYCInfoPanel.PushBanner(string.format(getLocalization("watcher_hassler"), name), 12, redColor, true)
                                elseif hasslerStateList[hassler] == "WAITING" and state ~= "WAITING" and state ~= "WARNING" then
                                    bannerSystem:FadeOutBanners(basehasslertimerTag .. name)
                                    DYCInfoPanel.PushBanner(string.format(getLocalization("watcher_hasslerskipped"), name), 12, whiteColor, false)
                                end
                            end
                            hasslerStateList[hassler] = state
                        end
                    end
                end
                if periodicthreat then
                    local periodicthreattimerTag = "periodicthreattimer"
                    local threats = periodicthreat.threats
                    if isTable(threats) and next(threats) then
                        for id, threat in pairs(threats) do
                            local timer = isTable(threat) and threat.timer
                            local nameKey = id
                            local name = getName(nameKey) or ""
                            local state = isFun(periodicthreat.GetCurrentState) and periodicthreat:GetCurrentState(id)
                            local threatStr = isStrNotEmpty(state) and "(" .. getLocalization("periodicthreat_" .. state, state) .. ")" or ""
                            if not inTimeThreatsList[threat] then
                                inTimeThreatsList[threat] = {}
                                for _ = 1, #threatsTimeList do table.insert(inTimeThreatsList[threat], false) end
                            end
                            local threatInTimeList = inTimeThreatsList[threat]
                            if isPositive(timer) and isStrNotEmpty(name) and isStrNotEmpty(threatStr) then
                                local showThreats = false
                                local inOneMinute = false
                                for i = 1, #threatsTimeList do
                                    if not threatInTimeList[i] and timer <= threatsTimeList[i] then
                                        showThreats = true
                                        inOneMinute = timer <= 60
                                    end
                                    if timer > threatsTimeList[i] then threatInTimeList[i] = false else threatInTimeList[i] = true end
                                end
                                if showThreats then
                                    local getThreatsText = function()
                                        timer = isTable(threat) and threat.timer
                                        return name .. threatStr .. ":" .. (isPosOrZero(timer) and getTimeStr(timer) or "?")
                                    end
                                    local threatsText = getThreatsText()
                                    local updateFn = function(self, _) self:SetText(getThreatsText()) end
                                    local startFn = function(self)
                                        self:AddTag(periodicthreattimerTag .. name)
                                        self:SetUpdateFn(updateFn)
                                    end
                                    bannerSystem:FadeOutBanners(periodicthreattimerTag .. name)
                                    DYCInfoPanel.PushBanner(threatsText, inOneMinute and timer or 12, orangeColor, true, startFn)
                                end
                                if threatsStateList[threat] == "warn" and state == "event" then
                                    bannerSystem:FadeOutBanners(periodicthreattimerTag .. name)
                                    DYCInfoPanel.PushBanner(string.format(getLocalization("watcher_hassler"), name), 12, redColor, true)
                                elseif threatsStateList[threat] == "event" and state == "wait" then
                                    for i = 1, #threatInTimeList do threatInTimeList[i] = false end
                                end
                            end
                            threatsStateList[threat] = state
                        end
                    end
                end
                if rocmanager then
                    local rocmanagertimerTag = "rocmanagertimer"
                    local dycSpawnTime = rocmanager.dycSpawnTime
                    local time = isNumber(dycSpawnTime) and dycSpawnTime - GetTime() or 0
                    local disabled = rocmanager.disabled
                    local rocName = STRINGS.UI.CUSTOMIZATIONSCREEN.NAMES.ROC or ""
                    if isStrNotEmpty(rocName) and not disabled and time >= 0 then
                        local showRoc = false
                        for i = 1, #rocInTimeList do
                            if not rocInTimeList[i] and isNumber(rocTimeList[i]) and time <= rocTimeList[i] and time >= 1 then
                                showRoc = true
                                break
                            end
                        end
                        for i = 1, #rocInTimeList do if isNumber(rocTimeList[i]) and time > rocTimeList[i] then rocInTimeList[i] = false else rocInTimeList[i] = true end end
                        if showRoc then
                            local getRocText = function()
                                time = isNumber(dycSpawnTime) and dycSpawnTime - GetTime() or 0
                                return rocName .. ":" .. (isPosOrZero(time) and getTimeStr(time) or "?")
                            end
                            local rocText = getRocText()
                            local updateFn = function(self, _) self:SetText(getRocText()) end
                            local startFn = function(self)
                                self:AddTag(rocmanagertimerTag)
                                self:SetUpdateFn(updateFn)
                            end
                            bannerSystem:FadeOutBanners(rocmanagertimerTag)
                            DYCInfoPanel.PushBanner(rocText, 12, whiteColor, false, startFn)
                        end
                        if time < timerMax and time ~= rocTime and rocTime <= 2 then
                            bannerSystem:FadeOutBanners(rocmanagertimerTag)
                            DYCInfoPanel.PushBanner(string.format(getLocalization("watcher_hassler"), rocName), 12, whiteColor)
                        end
                        rocTime = time
                    else
                        rocTime = 999999
                    end
                end
            end
        end)
end
local dycWatcher = {}
function dycWatcher:Start() dycWatcherRun(self) end

return dycWatcher
