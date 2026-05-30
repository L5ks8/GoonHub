local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")

local UILayout = {}

function UILayout.Create()

    getgenv().NyroxToggleStates = getgenv().NyroxToggleStates or {}


    local G2L = UI.CreateBase("GoonHub", "1.0.0")
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
    local ShopTab = window:CreateTab("Shop", false)
    local EspTab = window:CreateTab("Esp", false)
    
    -- Main Tab
    local main = mainTab:CreateSection("Coins", "Left")
    main:CreateToggle({
        Title = "Coin farm",
        Column = "Left",
        Callback = function()
        end
    })
    main:CreateToggle({
        Title = "Kill All After Bag Full",
        SubTitle = "Kills all if murder",
        Column = "Left",
        Callback = function()
        end
    })
    main:CreateToggle({
        Title = "Kill Murder After Bag Full",
        SubTitle = "Sherriff ONLY",
        Column = "Left",
        Callback = function()
        end
    })
    main:CreateToggle({
        Title = "Reset Bag Full",
        SubTitle = nil,
        Column = "Left",
        Callback = function()
        end
    })
    main:CreateSlider({
        Title = "Distance",
        Min = 1,
        Max = 5,
        Default = 5,
        Column = "Left",
        Callback = function()
        end
    })
    main:CreateDropdown({
        Title = "Teleport Methods",
        Options = {
            "Instant Teleport",
            "Tween",
            "Walk"
            },
        Column = "Left",
        Callback = function()
        end
    })
    -- Farm Tab

    -- Misc Tab

    local misc = MiscTab:CreateSection("Misc", "Left")
    misc:CreateToggle({
        Title = "Noclip",
        Column = "Left",
        Callback = function()
        end
    })
    -- Shop Tab
    local shop = ShopTab:CreateSection("Shop", "Left")
    shop:CreateToggle({
        Title = "Auto Open Boxes",
        Column = "Left",
        Callback = function()
        end
    })
    shop:CreateSlider({
        Title = "Delay",
        Min = 1,
        Max = 5,
        Default = 1,
        Column = "Left",
        Callback = function()
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
        Callback = function()
        end
    })

    -- Esp Tab





    return window
end

return UILayout


    