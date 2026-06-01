local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")
local Coins = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/Coins")
local Misc = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MiscTab/misc")
local Status = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/status")
local Visuals = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/EspTab/visuals")

local UILayout = {}

function UILayout.Create()

    local MarketplaceService = game:GetService("MarketplaceService")
    local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    local gameName = success and info.Name or "Unknown Game"

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
    local EspTab = window:CreateTab("Esp", false)
    local MiscTab = window:CreateTab("Misc", false)
    local ShopTab = window:CreateTab("Shop", false)
    
    -- Main Tab
    local coinsSection = mainTab:CreateSection("Coins", "Left")
    coinsSection:CreateToggle({
        Title = "Coin farm",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Coins.Toggle(state)
        end
    })
    coinsSection:CreateSlider({
        Title = "Farm Speed",
        Min = 15,
        Max = 25,
        Default = 20,
        Column = "Left",
        Callback = function(value)
            Coins.SetSpeed(value)
        end
    })
    coinsSection:CreateToggle({
        Title = "Auto Reset (Full Bag)",
        SubTitle = "Resets if bag full",
        Column = "Left",
        Default = false
    })
    coinsSection:CreateDropdown({
        Title = "Teleport Methods",
        Default = "Tween",
        Options = {
            "Instant Teleport",
            "Tween",
        },
        Column = "Left",
        Callback = function(value)
            Coins.SetMethod(value)
        end
    })
    local statusSection = mainTab:CreateSection("Status", "Right")
    local murderLabel = statusSection:CreateLabel("Murderer:", "Wait...")
    local sheriffLabel = statusSection:CreateLabel("Sheriff:", "Wait...")
    local heroLabel = statusSection:CreateLabel("Hero:", "nil")

    -- Status Update Loop
    task.spawn(function()
        while task.wait(1) and Status do
            local murd = Status.getMurderer()
            local sher = Status.getSheriff()
            local hero = Status.getHero()
            
            murderLabel:Set(murd)
            sheriffLabel:Set(sher)
            heroLabel:Set(hero)
        end
    end)

    -- Esp Tab
    local esp = EspTab:CreateSection("Visuals", "Left")
    esp:CreateToggle({
        Title = "Esp",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Visuals.ToggleEsp(state)
        end
    })
    esp:CreateToggle({
        Title = "Self Esp",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Visuals.SetSelfEsp(state)
        end
    })
    -- Misc Tab

    local misc = MiscTab:CreateSection("Misc", "Left")
    misc:CreateToggle({
        Title = "Noclip",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Misc.ToggleNoclip(state)
        end
    })
    misc:CreateToggle({
        Title = "Anti-Fling",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Misc.ToggleAntiFling(state)
        end
    })
    misc:CreateToggle({
        Title = "Auto Fling Murderer",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Misc.ToggleAutoFling(state)
        end
    })
    misc:CreateButton({
        Title = "Enable Performance Mode",
        Column = "Left",
        Callback = function()
            Misc.EnablePerformanceMode()
        end
    })
    -- Shop Tab
    local shop = ShopTab:CreateSection("Shop", "Left")
    shop:CreateToggle({
        Title = "Auto Open Boxes",
        Column = "Left",
        Default = false,
        Callback = function(state)
        end
    })
    shop:CreateSlider({
        Title = "Delay",
        Min = 1,
        Max = 5,
        Default = 1,
        Column = "Left",
        Callback = function(value)
            -- Logic for delay
        end
    })
    shop:CreateDropdown({
        Title = "Boxes",
        Options = {
            "MysteryBox1",
            "MysteryBox2",
            "KniveBox1",
            "KniveBox2",
            "KniveBox3",
            "KniveBox4",
            "KniveBox5",
            "MLG Box",
            "Gun Box1",
            "Gun Box2",
            "Gun Box3"
        },
        Column = "Left",
        Default = "MysteryBox1",
        Callback = function(value)
            -- Logic for selection
        end
    })

    return window
end
return UILayout