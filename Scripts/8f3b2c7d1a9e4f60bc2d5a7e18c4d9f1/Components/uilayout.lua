local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")

local UILayout = {}

function UILayout.Create()

    getgenv().NyroxToggleStates = getgenv().NyroxToggleStates or {}

    local MarketplaceService = game:GetService("MarketplaceService")
    local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    local gameName = success and info and info.Name or "Unknown Game"

    local G2L = UI.CreateBase(gameName, "1.0.0")
    local window = {
        TabCount = 0, 
        Stats = {
            FPS = G2L["fps_label"],
            Ping = G2L["ping_label"],
            Memory = G2L["mem_label"]
        }
    }

    Widgets.Init(window, G2L)

    UIFunctions.Init(G2L, window)

    -- Game Tabs
    local mainTab = window:CreateTab("Main", false)
    local FarmTab = window:CreateTab("Farm", false)
    local MiscTab = window:CreateTab("Misc", false)
    local EspTab = window:CreateTab("Esp", false)
    local ConfigTab = window:CreateTab("Config", false)

    -- Main Tab
    local rolls = mainTab:CreateSection("Roll Settings", "Left")
    rolls:CreateToggle("Auto Roll", false, function(state)
        -- Auto Roll Logic
    end)
    rolls:CreateToggle("Fast Roll", false, function(state)
        -- Fast Roll Logic
    end)
    rolls:CreateSlider("Luck Boost", 1, 100, 1, function(val)
        -- Luck Logic
    end)

    local potions = mainTab:CreateSection("Potions", "Right")
    potions:CreateToggle("Auto Use Luck Potions", false, function(state) end)
    potions:CreateToggle("Auto Use Speed Potions", false, function(state) end)
    potions:CreateButton("Clear Active Effects", function() end)

    -- Farm Tab
    local farm = FarmTab:CreateSection("Automation", "Left")
    farm:CreateToggle("Auto Claim Quests", false, function(state) end)
    farm:CreateToggle("Auto Claim Achievements", false, function(state) end)
    farm:CreateToggle("Auto Collect Coins", false, function(state) end)

    local shop = FarmTab:CreateSection("Shop Automation", "Right")
    shop:CreateToggle("Auto Buy Luck Potions", false, function(state) end)
    shop:CreateToggle("Auto Buy Speed Potions", false, function(state) end)
    shop:CreateSlider("Min. Coins to Keep", 0, 10000, 100, function(v) end)

    -- Misc Tab
    local world = MiscTab:CreateSection("World", "Left")
    world:CreateSlider("WalkSpeed", 16, 250, 16, function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)
    world:CreateSlider("JumpPower", 50, 500, 50, function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end)

    local teleports = MiscTab:CreateSection("Teleports", "Left")
    teleports:CreateButton("Teleport to Spawn", function() 
        game.Players.LocalPlayer.Character:MoveTo(Vector3.new(0, 50, 0)) 
    end)
    teleports:CreateButton("Teleport to Shop", function() end)

    local visual = MiscTab:CreateSection("Visuals", "Right")
    visual:CreateToggle("Remove Fog", false, function(state)
        game.Lighting.FogEnd = state and 100000 or 1000
    end)
    visual:CreateButton("Fullbright", function()
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    end)
    
    return window
end

return UILayout
