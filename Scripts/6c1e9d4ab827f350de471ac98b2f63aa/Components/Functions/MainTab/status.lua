local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer

local Status = {}

-- Murder finder
function Status.getMurderer()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            if plr.Character:FindFirstChild("Knife") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Knife")) then
                return plr.DisplayName or plr.Name
            end
        end
    end
    return "Wait..."
end

-- Sherrif finder
function Status.getSheriff()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            if plr.Character:FindFirstChild("Gun") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Gun")) then
                return plr.DisplayName or plr.Name
            end
        end
    end
    return "Wait..."
end

return Status