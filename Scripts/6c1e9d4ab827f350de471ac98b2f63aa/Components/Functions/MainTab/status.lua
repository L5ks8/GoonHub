local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local LocalPlayer = Players.LocalPlayer

local Status = {}

local cachedMurderer = "Loading..."
local cachedSheriff = "Loading..."
local lastFadeTime = 0

-- Remote Event Listener für sofortige Rollen-Erkennung
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
local Gameplay = Remotes and Remotes:WaitForChild("Gameplay", 5)
local Fade = Gameplay and Gameplay:WaitForChild("Fade", 5)

if Fade then
    Fade.OnClientEvent:Connect(function(data)
        if type(data) ~= "table" then return end
        
        local playerData = (data.Function and data.Function.Arguments) or data
        if type(playerData) ~= "table" then return end

        lastFadeTime = tick()
        cachedMurderer = "Loading..."
        cachedSheriff = "Loading..."

        for playerName, info in pairs(playerData) do
            if type(info) == "table" and info.Role then
                local plr = Players:FindFirstChild(playerName)
                if info.Role == "Murderer" then
                    cachedMurderer = plr and plr.DisplayName or playerName
                elseif info.Role == "Sheriff" then
                    cachedSheriff = plr and plr.DisplayName or playerName
                end
            end
        end
    end)
end

-- Zentralisierte Rollen-Aktualisierung im Hintergrund, um Flickern zu vermeiden
task.spawn(function()
    while true do
        local timeSinceFade = tick() - lastFadeTime
        local weaponsExist = false
        
        for _, plr in pairs(Players:GetPlayers()) do
            local char = plr.Character
            local bp = plr:FindFirstChild("Backpack")
            
            local hasKnife = (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife"))
            local hasGun = (char and char:FindFirstChild("Gun")) or (bp and bp:FindFirstChild("Gun"))

            if hasKnife then
                cachedMurderer = plr.DisplayName
                weaponsExist = true
            end
            if hasGun then
                weaponsExist = true
                -- Nur als Sheriff setzen, wenn noch keiner durch das Remote-Event erkannt wurde
                if cachedSheriff == "Loading..." or cachedSheriff == "None" then
                    cachedSheriff = plr.DisplayName
                end
            end
        end

        if not weaponsExist and (workspace:FindFirstChild("Gun") or workspace:FindFirstChild("Knife")) then
            weaponsExist = true
        end

        -- Reset nur, wenn keine Waffen existieren und die Runde sicher vorbei ist
        if not weaponsExist and timeSinceFade > 10 then
            cachedMurderer = "Loading..."
            cachedSheriff = "Loading..."
        end
        
        task.wait(1)
    end
end)

function Status.getMurderer() return cachedMurderer end
function Status.getSheriff() return cachedSheriff end

function Status.getHero()
    if cachedSheriff == "Loading..." then return "None" end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and (plr.Character:FindFirstChild("Gun") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Gun"))) then
            if plr.DisplayName ~= cachedSheriff then return plr.DisplayName end
        end
    end
    return "None"
end

return Status