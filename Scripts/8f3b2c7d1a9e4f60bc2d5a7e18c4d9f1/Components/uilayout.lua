local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")
local AutoRoll = GoonHub.Import("Scripts/8f3b2c7d1a9e4f60bc2d5a7e18c4d9f1/Components/Functions/MainTab/autoroll")
local AutoIndexClaim = GoonHub.Import("Scripts/8f3b2c7d1a9e4f60bc2d5a7e18c4d9f1/Components/Functions/MainTab/autoindexclaim")

local UILayout = {}

function UILayout.Create()

    getgenv().GoonHubToggleStates = getgenv().GoonHubToggleStates or {}

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
    local MainTab = window:CreateTab("Main", false)
    local FarmTab = window:CreateTab("Farm", false)
    local MiscTab = window:CreateTab("Misc", false)
    local EspTab = window:CreateTab("Esp", false)
    local ConfigTab = window:CreateTab("Config", false)

    -- Main Tab
    local Section = MainTab:CreateSection("Farm", "Left")
    Section:CreateToggle({
        Title = "Auto Roll",
        Column = "Left",
        Default = false,
        Callback = function(state)
            AutoRoll.Toggle(state)
        end
    })
    -- Farm Tab
    local Section = FarmTab:CreateSection("Others", "Left")
    Section:CreateToggle({
        Title = "Auto Claim Index",
        Column = "Left",
        Default = false,
        Callback = function(state)
            AutoIndexClaim.Toggle(state)
        end
    })

    -- Config Tab
    local config = ConfigTab:CreateSection("Management", "Left")
    config:CreateButton("Save Current Config", function() end)
    config:CreateButton("Load Config", function() end)
    
    return window
end

return UILayout
