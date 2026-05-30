local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local Workspace = cloneref(game:GetService("Workspace"))
local LocalPlayer = Players.LocalPlayer

local Coins = {}
local farmEnabled = false

-- Configurable settings based on the provided H4-Hub snippet
local Settings = {
    TPDelay = 0.05,
    PreFarmTP = Vector3.new(0, 9999, 0),
    PostFarmTP = Vector3.new(0, 9999, 0)
}

-- Helper function to handle teleportation safely
local function tp(pos)
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Added the +3 Y offset from your snippet for better landing on coins
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end
end

-- Core coin collection logic
local function collectCoins()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if not farmEnabled then break end
        if obj:IsA("Part") and obj.Name == "Coin" then
            tp(obj.Position)
            task.wait(Settings.TPDelay)
        end
    end
end

-- Main execution loop
local function mainLoop()
    while farmEnabled do
        pcall(function()
            tp(Settings.PreFarmTP)
            task.wait(0.2)
            collectCoins()
            tp(Settings.PostFarmTP)
        end)
        task.wait(0.1)
    end
end

function Coins.Toggle(state)
    farmEnabled = state
    if farmEnabled then
        task.spawn(mainLoop)
    end
end

return Coins