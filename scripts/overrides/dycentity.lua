local desTable = {}
local function getDes(entity)
    desTable[entity] = desTable[entity] or { des = {}, longDes = {} }
    return desTable[entity]
end
local function setDes(desName, desId, desText, isLong)
    desText = isLong and desText and tostring(desText) or desText and string.gsub(tostring(desText), "\n", "") or nil
    local oldDes = getDes(desName)
    local des = isLong and oldDes.longDes or oldDes.des
    if desId then
        desId = tostring(desId)
        local flag = false
        if #des > 0 then
            for i = 1, #des do
                if des[i].index == desId then
                    flag = true
                    if desText then
                        des[i].text = desText
                    else
                        table.remove(des, i)
                    end
                    break
                end
            end
            if not flag and desText then
                table.insert(des, { index = desId, text = desText })
            end
        else
            if desText then
                table.insert(des, { index = desId, text = desText })
            end
        end
    end
end
function EntityScript:SetPanelDescription(desId, desText)
    setDes(self, desId, desText, false)
end

function EntityScript:SetPanelLongDescription(desId, desText)
    setDes(self, desId, desText, true)
end

function EntityScript:GetPanelDescriptions()
    local des = getDes(self)
    return des.des
end

function EntityScript:GetPanelLongDescription()
    local des = getDes(self)
    local longDes = ""
    if #des.longDes > 0 then
        for i = 1, #des.longDes do
            longDes = longDes .. (#longDes > 0 and " " or "") .. des.longDes[i].text
        end
    end
    return longDes
end
