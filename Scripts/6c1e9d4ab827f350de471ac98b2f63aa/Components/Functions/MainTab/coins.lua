local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local Status = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/status")

local Coins = {}
local farmLoop = nil
local tpPos = Vector3.new(31.723007, 504.818054, -27.340113)
local currentMethod = "Instant Teleport"
local currentSpeed = 20
local isEnabled = false

local function isPlayerInRound()
	local murderer = Status.getMurderer()
	
	if murderer == "Loading..." or murderer == "None" then
		return false
	end
	
	if not player.Character then
		return false
	end
	
	local humanoid = player.Character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return false
	end
	
	return true
end

local function tp(cf)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = cf
	end
end

local function tween(targetCF)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local distance = (root.Position - targetCF.Position).Magnitude
    local duration = math.max(0.3, distance / currentSpeed)
    
    local info = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local t = TweenService:Create(root, info, {CFrame = targetCF})
    
    local connection
    connection = t.Completed:Connect(function()
        connection:Disconnect()
    end)
    
    t:Play()
    t.Completed:Wait()
end

function Coins.SetMethod(method)
    currentMethod = method
end

function Coins.SetSpeed(speed)
    currentSpeed = speed
end

function Coins.Toggle(state)
    if farmLoop then 
        task.cancel(farmLoop)
        farmLoop = nil
    end
    
    isEnabled = state
    
    if not state then
        task.wait(0.1)
        tp(CFrame.new(tpPos))
        return
    end
    
    farmLoop = task.spawn(function()
        local firstCoin = true
        
        while isEnabled do
            if not isPlayerInRound() then
                task.wait(0.5)
                continue
            end
            
            local murderer = Status.getMurderer()
            if murderer ~= "Loading..." and murderer ~= "None" then
                for _, coin in pairs(workspace:GetDescendants()) do
                    if not isPlayerInRound() or not isEnabled then break end
                    
                    if coin.Name == "Coin_Server" and coin:IsA("BasePart") then
                        if currentMethod == "Instant Teleport" then
                            tp(coin.CFrame)
                            task.wait(0.5)
                            tp(CFrame.new(tpPos))
                            task.wait(2)
                        elseif currentMethod == "Tween" then
                            if firstCoin then
                                tp(coin.CFrame)
                                task.wait(0.3)
                                firstCoin = false
                            else
                                tween(coin.CFrame)
                            end
                        end
                    end
                    if not farmLoop or not isEnabled then break end
                end
            end
            task.wait(1)
        end
    end)
end

return Coins
