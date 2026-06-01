local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer

local Status = {}

local cachedMurderer = "Wait..."
local cachedSheriff = "Wait..."

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

return Status