local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local Status = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/status")

local Coins = {}
local farmLoop = nil
local tpPos = Vector3.new(31.723007, 504.818054, -27.340113)
local currentMethod = "Tween"
local currentSpeed = 20
local isEnabled = false

local lastPositions = {}
local MAX_HISTORY = 5
local MIN_COIN_DIST = 3
local MAX_COIN_DIST = 50

local function isInSpawn(vec)
    local reference = Vector3.new(300, 500, 0)
    if (vec - reference).Magnitude < 500 then
        return true
    end
    return false
end

local function isRoundLive()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Coin_Server" then
            return true
        end
    end
    return false
end

local function isRecentlyVisited(pos)
    for _, oldPos in ipairs(lastPositions) do
        if (oldPos - pos).Magnitude < 5 then
            return true
        end
    end
    return false
end

local function addPosition(pos)
    table.insert(lastPositions, pos)
    if #lastPositions > MAX_HISTORY then
        table.remove(lastPositions, 1)
    end
end

local function findClosestCoin(root)
    if not root then return nil end
    local closestCoin = nil
    local shortestDistance = math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Coin_Server" and v.Parent then
            local dist = (v.Position - root.Position).Magnitude
            if not isRecentlyVisited(v.Position) and dist >= MIN_COIN_DIST and dist <= MAX_COIN_DIST then
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestCoin = v
                end
            end
        end
    end
    return closestCoin
end

local function setupCharacter()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end
    humanoid.AutoRotate = false
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    if not root:FindFirstChild("AntiGravityForce") then
        local attachment = Instance.new("Attachment")
        attachment.Name = "AntiGravityAttachment"
        attachment.Parent = root
        local force = Instance.new("VectorForce")
        force.Name = "AntiGravityForce"
        force.Attachment0 = attachment
        force.Force = Vector3.new(0, root.AssemblyMass * workspace.Gravity, 0)
        force.RelativeTo = Enum.ActuatorRelativeTo.World
        force.ApplyAtCenterOfMass = true
        force.Parent = root
    end
end

local function isPlayerInRound()
    local char = player.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
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

    local targetPos = targetCF.Position
    local distance = (root.Position - targetPos).Magnitude
    local duration = math.max(0.2, distance / currentSpeed)

    local lv = root.CFrame.LookVector
    local yaw = math.atan2(lv.X, lv.Z)
    local targetCFrame = CFrame.new(targetPos) * CFrame.Angles(0, yaw, 0)
    local noclipActive = root.CanCollide == false

    local prevCollides = nil
    if not noclipActive and char then
        prevCollides = {}
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                prevCollides[p] = p.CanCollide
                p.CanCollide = false
            end
        end
    end

    local info = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local ok, err = pcall(function()
        local t = TweenService:Create(root, info, {CFrame = targetCFrame})
        t:Play()
        t.Completed:Wait()
    end)

    if prevCollides then
        for p, prev in pairs(prevCollides) do
            if p and p.Parent then
                p.CanCollide = prev
            end
        end
    end

    if not ok then
        warn("Tween failed:", err)
    end
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
            local char = player.Character
            local humanoid = char and char:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then
                task.wait(0.5)
                continue
            end

            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root or not isRoundLive() or isInSpawn(root.Position) then
                task.wait(1)
                continue
            end

            local closestCoin = findClosestCoin(root)
            if not closestCoin then
                task.wait(0.2)
                continue
            end

            if currentMethod == "Instant Teleport" then
                tp(closestCoin.CFrame)
                task.wait(0.5)
                tp(CFrame.new(tpPos))
                task.wait(2)
            elseif currentMethod == "Tween" then
                if firstCoin then
                    tp(closestCoin.CFrame)
                    task.wait(0.3)
                    firstCoin = false
                else
                    tween(closestCoin.CFrame)
                    task.wait(0.1)
                end
            elseif currentMethod == "Teleport 2" then
                humanoid.AutoRotate = false
                local poshi = closestCoin.Position
                local pos = poshi - Vector3.new(0, 8, 0)
                root.CFrame = CFrame.lookAt(poshi, poshi + Vector3.new(0, 0, 1))
                root.AssemblyAngularVelocity = Vector3.new(0, 2, 0)
                root.AssemblyLinearVelocity = Vector3.new(0, 2, 0)
                task.wait(0.5)
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = CFrame.lookAt(pos, pos + Vector3.new(0, 0.1, 1)) * CFrame.Angles(math.rad(90), 0, 0)

                addPosition(closestCoin.Position)
                task.wait(2.2)
            else
                local poshi = closestCoin.Position
                local pos = poshi - Vector3.new(0, 8, 0)
                root.CFrame = CFrame.lookAt(poshi, poshi + Vector3.new(0, 0, 1))
                root.AssemblyAngularVelocity = Vector3.new(0, 2, 0)
                root.AssemblyLinearVelocity = Vector3.new(0, 2, 0)
                task.wait(0.5)
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = CFrame.lookAt(pos, pos + Vector3.new(0, 0.1, 1)) * CFrame.Angles(math.rad(90), 0, 0)

                addPosition(closestCoin.Position)
                task.wait(2.2)
            end
        end
    end)

    -- ensure character setup
    if state then
        setupCharacter()
        player.CharacterAdded:Connect(function()
            task.wait(1)
            setupCharacter()
        end)
    end
end

return Coins
