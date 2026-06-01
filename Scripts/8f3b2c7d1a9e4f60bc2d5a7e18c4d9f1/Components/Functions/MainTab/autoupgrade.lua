local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local AutoUpgrade = {}
local upgradeLoop = nil

local function getRemote(serviceName)
    local success, result = pcall(function()
        return RS:WaitForChild("Packages")
            :WaitForChild("_Index")
            :WaitForChild("leifstout_networker@0.3.1")
            :WaitForChild("networker")
            :WaitForChild("_remotes")
            :WaitForChild(serviceName)
            :WaitForChild("RemoteFunction")
    end)
    return success and result or nil
end

local UpgradeRemote = getRemote("UpgradeService")

local USC, UpgradeTree
pcall(function()
    USC = require(RS:WaitForChild("Source"):WaitForChild("Features"):WaitForChild("Upgrades"):WaitForChild("UpgradeServiceClient"))
    UpgradeTree = require(RS:WaitForChild("Source"):WaitForChild("Features"):WaitForChild("Upgrades"):WaitForChild("UpgradeTree"))
end)

local KNOWN_TREES = {"main", "lootTree", "playerTree"}

local function doUnlock(id)
    local ok, result = pcall(function()
        return UpgradeRemote:InvokeServer("requestUnlock", id)
    end)
    return ok and result == true
end

local function getTreeUpgrades(treeName)
    local tree = UpgradeTree and UpgradeTree[treeName]
    if type(tree) ~= "table" then return {} end
    local available = {}
    for id, data in pairs(tree) do
        if type(data) == "table" and data.id then
            local owns = false
            pcall(function() owns = USC.ownsUpgrade(player, id) end)
            if not owns then
                local depOk = true
                if data.dependency then
                    local depOwns = false
                    pcall(function() depOwns = USC.ownsUpgrade(player, data.dependency) end)
                    depOk = depOwns
                end
                if depOk then
                    local numCost = 0
                    if type(data.cost) == "number" then
                        numCost = data.cost
                    elseif type(data.cost) == "table" then
                        numCost = data.cost.amount or 0
                        if numCost == 0 then
                            for _, v in pairs(data.cost) do
                                if type(v) == "number" then numCost = v break end
                            end
                        end
                    end
                    table.insert(available, {id = id, cost = numCost})
                end
            end
        end
    end
    return available
end

local function getUpgradesToBuy()
    local all = {}
    for _, treeName in pairs(KNOWN_TREES) do
        for _, entry in pairs(getTreeUpgrades(treeName)) do
            table.insert(all, entry)
        end
    end
    table.sort(all, function(a, b) return a.cost < b.cost end)
    return all
end

function AutoUpgrade.Toggle(state)
    if upgradeLoop then
        task.cancel(upgradeLoop)
        upgradeLoop = nil
    end

    if state then
        upgradeLoop = task.spawn(function()
            while true do
                if UpgradeRemote and UpgradeTree and USC then
                    for _ = 1, 10 do
                        local available = getUpgradesToBuy()
                        if #available == 0 then break end
                        local bought = 0
                        for _, entry in pairs(available) do
                            if doUnlock(entry.id) then
                                bought = bought + 1
                                task.wait(0.15)
                            else
                                task.wait(0.05)
                            end
                        end
                        if bought == 0 then break end
                    end
                end
                task.wait(5) 
            end
        end)
    end
end

return AutoUpgrade