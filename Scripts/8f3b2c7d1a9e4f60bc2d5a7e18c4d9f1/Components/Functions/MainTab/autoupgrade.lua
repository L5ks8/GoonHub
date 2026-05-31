local AutoUpgrade = {}
local upgradeConnection

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Source = ReplicatedStorage:WaitForChild("Source")
local Features = Source:WaitForChild("Features")
local UpgradeTree = require(Features:WaitForChild("Upgrades"):WaitForChild("UpgradeTree"))
local TutorialServiceClient = require(Features:WaitForChild("Tutorial"):WaitForChild("TutorialServiceClient"))
local DataServiceClient = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("DataService")).client

function AutoUpgrade.Toggle(state)
    local config = getgenv().SlimeConfig
    if config then
        config.AutoUpgrades = state
    end

    if upgradeConnection then 
        task.cancel(upgradeConnection)
        upgradeConnection = nil
    end

    if state then
        upgradeConnection = task.spawn(function()
            while task.wait(1) do
                local services = getgenv().SlimeServices
                if not services or not services.Upgrade then continue end

                local upgrades = DataServiceClient:get("upgrades") or {}
                local coins = DataServiceClient:get("coins") or 0
                local rollCurrency = DataServiceClient:get("rollCurrency") or 0

                for _, tree in pairs(UpgradeTree) do
                    for upgradeId, upgrade in pairs(tree) do
                        if not upgrades[upgradeId] then
                            local canUnlock = false
                            pcall(function()
                                canUnlock = TutorialServiceClient:canUnlockUpgrade(upgradeId)
                            end)
                            
                            if canUnlock == nil then canUnlock = true end
                            
                            if canUnlock then
                                local dependency = upgrade.dependency
                                local depMet = false
                                if not dependency or dependency == "origin" then
                                    depMet = true
                                elseif upgrades[dependency] then
                                    depMet = true
                                end
                                
                                if depMet then
                                    local cost = upgrade.cost
                                    local canAfford = true
                                    local currency, amount
                                    if cost then
                                        currency = cost.currency
                                        amount = cost.amount
                                        if currency == "coins" then
                                            canAfford = (coins >= amount)
                                        elseif currency == "rollCurrency" then
                                            canAfford = (rollCurrency >= amount)
                                        else
                                            canAfford = false
                                        end
                                    end
                                    
                                    if canAfford then
                                        if cost then
                                            if currency == "coins" then
                                                coins = coins - amount
                                            elseif currency == "rollCurrency" then
                                                rollCurrency = rollCurrency - amount
                                            end
                                        end
                                        
                                        pcall(function()
                                            services.Upgrade:InvokeServer("requestUnlock", upgradeId)
                                        end)
                                        task.wait(0.1)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end

return AutoUpgrade