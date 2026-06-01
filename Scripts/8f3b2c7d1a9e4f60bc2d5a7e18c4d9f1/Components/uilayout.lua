local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")
local AutoRoll = GoonHub.Import("Scripts/8f3b2c7d1a9e4f60bc2d5a7e18c4d9f1/Components/Functions/MainTab/autoroll")
local AutoIndexClaim = GoonHub.Import("Scripts/8f3b2c7d1a9e4f60bc2d5a7e18c4d9f1/Components/Functions/MainTab/autoindexclaim")
local AutoUpgrade = GoonHub.Import("Scripts/8f3b2c7d1a9e4f60bc2d5a7e18c4d9f1/Components/Functions/MainTab/autoupgrade")

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
    local MiscTab = window:CreateTab("Misc", false)
    local ConfigTab = window:CreateTab("Config", true)

    -- Main Tab
    local farmSection = MainTab:CreateSection("Farm", "Left")
    farmSection:CreateToggle({
        Title = "Auto Roll",
        Column = "Left",
        Default = false,
        Callback = function(state)
            AutoRoll.Toggle(state)
        end
    })

    -- Misc Tab
    local miscSection = MiscTab:CreateSection("Automation", "Left")
    miscSection:CreateToggle({
        Title = "Auto Claim Index",
        Column = "Left",
        Default = false,
        Callback = function(state)
            AutoIndexClaim.Toggle(state)
        end
    })
    miscSection:CreateToggle({
        Title = "Auto Upgrade",
        Column = "Left",
        Default = false,
        Callback = function(state)
            AutoUpgrade.Toggle(state)
        end
    }) 
    -- Farm Tab

    -- Config Tab
    local config = ConfigTab:CreateSection("Management", "Left")
    config:CreateButton("Save Current Config", function() end)
    config:CreateButton("Load Config", function() end)
    
    return window
end

return UILayout
