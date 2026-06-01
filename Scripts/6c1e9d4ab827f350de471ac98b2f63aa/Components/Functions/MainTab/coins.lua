local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local Status = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/status")

local Coins = {}
local farmLoop = nil
local tpPos = Vector3.new(31.723007, 504.818054, -27.340113)
local currentMethod = "Instant Teleport"
local currentSpeed = 20

local function tp(cf)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = cf
	end
end

local function tween(targetCF)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        local distance = (root.Position - targetCF.Position).Magnitude
        local duration = distance / currentSpeed
        
        local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local t = TweenService:Create(root, info, {CFrame = targetCF})
        t:Play()
        t.Completed:Wait()
    end
end

function Coins.SetMethod(method)
    currentMethod = method
end

function Coins.SetSpeed(speed)
    currentSpeed = speed
end

function Coins.Toggle(state)
    if farmLoop then task.cancel(farmLoop) farmLoop = nil end
    if not state then return end
    
    farmLoop = task.spawn(function()
        while true do
            local murderer = Status and Status.getMurderer() or "Loading..."
            if murderer ~= "Loading..." and murderer ~= "None" then
                for _, coin in pairs(workspace:GetDescendants()) do
                    if coin.Name == "Coin_Server" and coin:IsA("BasePart") then
                        if currentMethod == "Instant Teleport" then
                            tp(coin.CFrame)
                            task.wait(0.1)
                            tp(CFrame.new(tpPos))
                        elseif currentMethod == "Tween" then
                            tween(coin.CFrame)
                            task.wait(0.1)
                            tween(CFrame.new(tpPos))
                        end
                        task.wait(0.1)
                    end
                    if not farmLoop then break end
                end
            end
            task.wait(1)
        end
    end)
end

return Coins
