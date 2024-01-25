local function getDycSpawnTime(self) return self.dycSpawnTime end
local function setDycSpawnTime(self, time) self.dycSpawnTime = GetTime() + (time or 0) end
local function GetNextSpawnTime(self, ...)
    local time = self.dycOldGetNextSpawnTime and self.dycOldGetNextSpawnTime(self, ...)
    setDycSpawnTime(self, time)
    return time
end
local function OnLoad(self, arg, ...)
    local data = self.dycOldOnLoad and self.dycOldOnLoad(self, arg, ...)
    if self.nexttime then setDycSpawnTime(self, self.nexttime) end
    return data
end
local function LongUpdate(self, updateTime, ...)
    local data = self.dycOldLongUpdate and self.dycOldLongUpdate(self, updateTime, ...)
    local time = getDycSpawnTime(self)
    if time then setDycSpawnTime(self, time - GetTime() - updateTime) end
    return data
end
local function dycRocmanager(origin)
    origin.dycOldGetNextSpawnTime = origin.GetNextSpawnTime
    origin.GetNextSpawnTime = GetNextSpawnTime
    origin.dycOldOnLoad = origin.OnLoad
    origin.OnLoad = OnLoad
    origin.dycOldLongUpdate = origin.LongUpdate
    origin.LongUpdate = LongUpdate
end
return dycRocmanager
