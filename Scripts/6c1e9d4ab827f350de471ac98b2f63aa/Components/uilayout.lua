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
    main:CreateButton({
        Title = "Coin farm",
        Column = "Left",
        Callback = function()
            print("Coin Farm gestartet")
        end
    })
    main:CreateButton({
        Title = "Kill All After Bag Full",
        SubTitle = "Kills all if murder",
        Column = "Left",
        Callback = function()
            print("Kill All gestartet")
        end
    })
    main:CreateButton({
        Title = "Kill Murder After Bag Full",
        SubTitle = "Sherriff ONLY",
        Column = "Left",
        Callback = function()
            print("Kill Murder gestartet")
        end
    })

    return window
end

return UILayout


    