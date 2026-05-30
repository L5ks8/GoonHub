local Coins = {}

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

local replicatedStorage = game:GetService("ReplicatedStorage")

local safePosition = CFrame.new(14.384642, 516.698608, -25.254295)

local autoFarmEnabled = false
local noclipConnection
local killMurdererAfterBagFull = false
local coinsInBag = 0
local currentRole = "Innocent" 

local gameplayRemotes = replicatedStorage:FindFirstChild("Remotes") and replicatedStorage.Remotes:FindFirstChild("Gameplay")
if gameplayRemotes then
    local roleSelect = gameplayRemotes:FindFirstChild("RoleSelect")
    if roleSelect then
        roleSelect.OnClientEvent:Connect(function(role)
            currentRole = role
            coinsInBag = 0
        end)
    end
    local roundStart = gameplayRemotes:FindFirstChild("RoundStart")
    if roundStart then
        roundStart.OnClientEvent:Connect(function()
            coinsInBag = 0 
            currentRole = "Innocent" 
        end)
    end
end

local function getMurderer()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife")) then
                return p
            end
        end
    end
    return nil
end

local function isSheriff()
    return currentRole == "Sheriff"
end

local function isInRound()
    local roleData = replicatedStorage:FindFirstChild("RoleData") local normal = game:GetService("Workspace"):FindFirstChild("Normal") return (roleData and #roleData:GetChildren() > 0) and normal ~= nil
end

function Coins.Toggle(state)
    autoFarmEnabled = state

    if autoFarmEnabled then
        if not noclipConnection then
            noclipConnection = runService.Stepped:Connect(function()
                if autoFarmEnabled and player.Character then
                    for _, part in pairs(player.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
        task.spawn(function()
            while autoFarmEnabled do
                local coinContainer = game:GetService("Workspace"):FindFirstChild("CoinContainer", true)
                
                if not isInRound() then
                    coinsInBag = 0
                end
                if isInRound() and coinContainer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local coins = coinContainer:GetChildren()

                    if coinsInBag >= 40 then
                        player.Character.HumanoidRootPart.CFrame = safePosition
                        if killMurdererAfterBagFull and isSheriff() then
                            local murderer = getMurderer()
                            if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
                                pcall(function()
                                    local weaponService = replicatedStorage:FindFirstChild("ClientServices"):FindFirstChild("WeaponService")
                                    if weaponService and weaponService:FindFirstChild("GunFired") then
                                        weaponService.GunFired:FireServer(murderer.Character.HumanoidRootPart.Position)
                                    end
                                end)
                            end
                        end
                        task.wait(0.5)
                    else 
                        for _, v in pairs(coins) do
                            if not autoFarmEnabled or coinsInBag >= 40 then break end
                            
                            local targetPart = v:IsA("BasePart") and v or (v:FindFirstChild("Hitbox") or v:FindFirstChildOfClass("Part") or v:FindFirstChildOfClass("MeshPart"))
                            
                            if targetPart and targetPart.Parent then
                                if not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then break end
                                
                                player.Character.HumanoidRootPart.CFrame = targetPart.CFrame
                                task.wait(0.5)
                                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then 
                                    player.Character.HumanoidRootPart.CFrame = safePosition 
                                    coinsInBag = coinsInBag + 1
                                end
                                task.wait(2)
                            end
                        end
                    end
                else
                    task.wait(1)
                end
            end

            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end

function Coins.SetKillMurdererAfterBagFull(state)
    killMurdererAfterBagFull = state
end

function Coins.ResetBag()
    coinsInBag = 0
end

return Coins
