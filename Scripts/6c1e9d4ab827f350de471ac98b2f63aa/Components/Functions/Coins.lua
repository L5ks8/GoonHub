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
    EventTokenKey = ""
}

local SETTINGS = {
    BAG_TEXT_REGEX = "(%d+)%s*/%s*(%d+)",
    EVENT_TOKEN_GUESS_NAMES = { "Candy","Snow","SnowToken","Token","Present","Heart","CoinEvent","Ball","Orb" },
    COIN_CONTAINER_NAMES = { "CoinContainer","Coins","Coin","Drops","Tokens","CandyContainer" }
}

-- Prüfen ob Teil wie eine Münze aussieht (Heuristik aus Snippet)
local function looksLikeCoin(part)
    if not part or not part:IsA("BasePart") then return false end
    if not part:FindFirstChildOfClass("TouchTransmitter") and not part:FindFirstChild("TouchInterest") then
        return false
    end
    local n = string.lower(part.Name or "")
    for _, guess in ipairs(SETTINGS.EVENT_TOKEN_GUESS_NAMES) do
        if string.find(n, string.lower(guess)) then return true end
    end
    if part:GetAttribute("CoinID") ~= nil then return true end
    local p = part.Parent
    if p then
        local pn = string.lower(p.Name)
        for _, k in ipairs(SETTINGS.COIN_CONTAINER_NAMES) do
            if string.find(pn, string.lower(k)) then return true end
        end
    end
    return false
end

-- Beutelfortschritt aus der GUI auslesen
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

-- Sanfte Bewegung oder TP
local function moveTo(targetCFrame)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    if dist > State.TeleportDist then
        hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
    else
        local duration = math.max(0.05, dist / math.clamp(State.Speed, 15, 25))
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame + Vector3.new(0, 3, 0)})
        tween:Play()
        return tween
    end
end

-- Münzen finden
local function getNearestCoin()
    local nearest, minDist = nil, math.huge
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if looksLikeCoin(obj) then
            local d = (hrp.Position - obj.Position).Magnitude
            if d < minDist then
                nearest, minDist = obj, d
            end
        end
    end
    return nearest, minDist
end

local function mainLoop()
    while State.Enabled do
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                local have, cap = getBagProgress()
                if have >= cap then
                    if State.AutoReset then
                        LocalPlayer.Character:BreakJoints()
                        LocalPlayer.CharacterAdded:Wait()
                        task.wait(1)
                    end
                else
                    local coin, dist = getNearestCoin()
                    if coin then
                        local tween = moveTo(coin.CFrame)
                        local t0 = os.clock()
                        while State.Enabled and coin.Parent and os.clock() - t0 < 3 do
                            if not coin:FindFirstChild("TouchInterest") and not coin:FindFirstChildOfClass("TouchTransmitter") then break end
                            task.wait(0.05)
                        end
                        if tween then tween:Cancel() end
                    end
                end
            end
        end)
        task.wait(0.05)
    end
end

function Coins.Toggle(state)
    State.Enabled = state
    if state then task.spawn(mainLoop) end
end

function Coins.SetSpeed(val)
    State.Speed = val
end

function Coins.SetAutoReset(state)
    State.AutoReset = state
end

return Coins