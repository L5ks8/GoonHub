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
    local EspTab = window:CreateTab("Esp", false)

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
        Title = "Kill Murder After Bag Full",
        Min = 5,
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






    return window
end

return UILayout


    