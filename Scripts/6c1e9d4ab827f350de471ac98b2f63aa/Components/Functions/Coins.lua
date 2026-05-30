local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local Workspace = cloneref(game:GetService("Workspace"))
local TweenService = cloneref(game:GetService("TweenService"))
local LocalPlayer = Players.LocalPlayer

local Coins = {}
local State = {
    Enabled = false,
    Speed = 20,
    AutoReset = true,
    BagLimit = 40,
    TeleportDist = 150,
    EventTokenKey = "",
    Method = "Tween",
    SafePosition = CFrame.new(26.183889, 504.818054, -21.357656)
}

local CharacterCollisionConnection
local SETTINGS = {
    BAG_TEXT_REGEX = "(%d+)%s*/%s*(%d+)",
    EVENT_TOKEN_GUESS_NAMES = { "Candy","Snow","SnowToken","Token","Present","Heart","CoinEvent","Ball","Orb" },
    COIN_CONTAINER_NAMES = { "CoinContainer","Coins","Coin","Drops","Tokens","CandyContainer" }
}
local function looksLikeCoin(obj)
    local target = obj:IsA("BasePart") and obj or (obj:FindFirstChild("Hitbox") or obj:FindFirstChildOfClass("BasePart"))
    if not target then return false end
    
    if not target:FindFirstChildOfClass("TouchTransmitter") and not target:FindFirstChild("TouchInterest") then
        return false
    end
    local n = string.lower(obj.Name or "")
    for _, guess in ipairs(SETTINGS.EVENT_TOKEN_GUESS_NAMES) do
        if string.find(n, string.lower(guess)) then return true end
    end
    if obj:GetAttribute("CoinID") ~= nil then return true end
    local p = obj.Parent
    if p then
        local pn = string.lower(p.Name)
        for _, k in ipairs(SETTINGS.COIN_CONTAINER_NAMES) do
            if string.find(pn, string.lower(k)) then return true end
        end
    end
    return false
end

local function getBagProgress()
    local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if gui then
        for _, d in ipairs(gui:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                local a, b = string.match(tostring(d.Text or ""), SETTINGS.BAG_TEXT_REGEX)
                if a and b then
                    return tonumber(a) or 0, tonumber(b) or State.BagLimit
                end
            end
        end
    end
    return 0, State.BagLimit
end

local function moveTo(targetCFrame)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    if dist > State.TeleportDist then
        hrp.CFrame = targetCFrame * CFrame.new(0, 2, 0)
    else
        local duration = math.max(0.01, dist / math.clamp(State.Speed, 15, 25))
        
        hrp.Velocity = Vector3.zero
        hrp.RotVelocity = Vector3.zero
        
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame * CFrame.new(0, -3.5, 0)})
        tween:Play()
        return tween
    end
end

local function getNearestCoin()
    local nearest, minDist = nil, math.huge
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local container = Workspace:FindFirstChild("CoinContainer", true)
    if container then
        for _, obj in ipairs(container:GetChildren()) do
            if looksLikeCoin(obj) then
                local targetPart = obj:IsA("BasePart") and obj or (obj:FindFirstChild("Hitbox") or obj:FindFirstChildOfClass("BasePart"))
                if targetPart then
                    local d = (hrp.Position - targetPart.Position).Magnitude
                    if d < minDist then
                        nearest, minDist = obj, d
                    end
                end
            end
        end
    end
    return nearest, minDist
end

local function mainLoop()
    while State.Enabled do
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                -- Disable collisions to prevent lag/stuck
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then 
                        part.CanCollide = false 
                    end
                end

                local have, cap = getBagProgress()
                if have >= cap then
                    if State.AutoReset then
                        LocalPlayer.Character:BreakJoints()
                        LocalPlayer.CharacterAdded:Wait()
                        task.wait(1)
                    end
                else
                    if State.Method == "Instant Teleport" then
                        local coin = getNearestCoin()
                        if coin and LocalPlayer.Character then
                            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.Anchored = true
                                hrp.CFrame = coin.CFrame * CFrame.new(0, -3.5, 0)
                                task.wait(0.3)
                                hrp.CFrame = State.SafePosition
                                hrp.Anchored = false
                                task.wait(0.1) 
                            end
                        end
                    else
                        local coin, dist = getNearestCoin()
                        if coin then
                            local targetPart = coin:IsA("BasePart") and coin or (coin:FindFirstChild("Hitbox") or coin:FindFirstChildOfClass("BasePart"))
                            if targetPart then
                                local tween = moveTo(targetPart.CFrame)
                                if tween then
                                    local hrp = LocalPlayer.Character.HumanoidRootPart
                                    hrp.Anchored = true
                                    
                                    local t0 = os.clock()
                                    while State.Enabled and coin.Parent and os.clock() - t0 < 3 do
                                        if not targetPart:FindFirstChild("TouchInterest") and not targetPart:FindFirstChildOfClass("TouchTransmitter") then break end
                                        task.wait()
                                    end
                                    
                                    tween:Cancel()
                                    hrp.Anchored = false
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.05)
    end
end

function Coins.Toggle(state)
    State.Enabled = state
    
    if CharacterCollisionConnection then CharacterCollisionConnection:Disconnect() end
    if state then
        -- Keep collisions disabled during farm to prevent physics lag
        CharacterCollisionConnection = game:GetService("RunService").Stepped:Connect(function()
            if State.Enabled and LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    end

    if state then task.spawn(mainLoop) end
end

function Coins.SetSpeed(val)
    State.Speed = val
end

function Coins.SetAutoReset(state)
    State.AutoReset = state
end

function Coins.SetMethod(val)
    State.Method = val
end

return Coins