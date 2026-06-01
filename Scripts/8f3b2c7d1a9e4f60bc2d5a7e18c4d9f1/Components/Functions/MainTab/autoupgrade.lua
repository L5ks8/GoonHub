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
local USC = require(RS.Source.Features.Upgrades.UpgradeServiceClient)
local UpgradeTree = require(RS.Source.Features.Upgrades.UpgradeTree)

local KNOWN_TREES = {"main", "lootTree", "playerTree"}

local function getTreeUpgrades(treeName)
    local tree = UpgradeTree[treeName]
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
                    end
                    table.insert(available, {id = id, cost = numCost})
                end
            end
        end
    end
    return available
end

function AutoUpgrade.Toggle(state)
    if upgradeLoop then
        task.cancel(upgradeLoop)
        upgradeLoop = nil
    end

    if state then
        upgradeLoop = task.spawn(function()
            while true do
                for _, treeName in ipairs(KNOWN_TREES) do
                    local available = getTreeUpgrades(treeName)
                    table.sort(available, function(a, b) return a.cost < b.cost end)
                    for _, entry in ipairs(available) do
                        pcall(function() UpgradeRemote:InvokeServer("requestUnlock", entry.id) end)
                    end
                end
                task.wait(5) 
            end
        end)
    end
end

return AutoUpgrade