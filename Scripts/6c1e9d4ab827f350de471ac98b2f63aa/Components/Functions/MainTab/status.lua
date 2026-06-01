local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local LocalPlayer = Players.LocalPlayer

local Status = {}

local cachedMurderer = "Loading..."
local cachedSheriff = "Loading..."

-- Remote Event Listener für sofortige Rollen-Erkennung
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
local Gameplay = Remotes and Remotes:WaitForChild("Gameplay", 5)
local PlayerDataChanged = Gameplay and Gameplay:WaitForChild("PlayerDataChanged", 5)

if PlayerDataChanged then
    PlayerDataChanged.OnClientEvent:Connect(function(data)
        if type(data) ~= "table" then return end
        
        for playerName, info in pairs(data) do
            if info.Role == "Murderer" then
                local plr = Players:FindFirstChild(playerName)
                cachedMurderer = plr and plr.DisplayName or playerName
            elseif info.Role == "Sheriff" then
                local plr = Players:FindFirstChild(playerName)
                cachedSheriff = plr and plr.DisplayName or playerName
            end
        end
    end)
end

local function checkRoundReset()
    local weaponsExist = false
    
    for _, plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        local bp = plr:FindFirstChild("Backpack")
        if (char and (char:FindFirstChild("Knife") or char:FindFirstChild("Gun"))) or 
           (bp and (bp:FindFirstChild("Knife") or bp:FindFirstChild("Gun"))) then
            weaponsExist = true
            break
        end
    end
    
    if not weaponsExist then
        if workspace:FindFirstChild("Gun") or workspace:FindFirstChild("Knife") then
            weaponsExist = true
        end
    end

    if not weaponsExist then
        cachedMurderer = "Loading..."
        cachedSheriff = "Loading..."
    end
end

-- Murder finder
function Status.getMurderer()
    checkRoundReset()
    if cachedMurderer == "Loading..." then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and (plr.Character:FindFirstChild("Knife") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Knife"))) then
                cachedMurderer = plr.DisplayName
                break
            end
        end
    end
    return cachedMurderer
end

-- Sherrif finder
function Status.getSheriff()
    checkRoundReset()
    if cachedSheriff == "Loading..." then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and (plr.Character:FindFirstChild("Gun") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Gun"))) then
                cachedSheriff = plr.DisplayName
                break
            end
        end
    end
    return cachedSheriff
end

-- Hero finder
function Status.getHero()
    checkRoundReset()
    
    if cachedSheriff == "Loading..." then return "None" end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and (plr.Character:FindFirstChild("Gun") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Gun"))) then
            if plr.DisplayName ~= cachedSheriff then
                return plr.DisplayName
            end
        end
    end
    return "None"
end

return Status