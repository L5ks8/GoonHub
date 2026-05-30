local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")
local Animation = GoonHub.Import("Assets/Components/animation")

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

    Animation.PlayLoading(G2L)

    UIFunctions.Init(G2L, window)

    -- Game Tabs
    local mainTab = window:CreateTab("Main", false)
    local FarmTab = window:CreateTab("Farm", false)
    local MiscTab = window:CreateTab("Misc", false)

    local combat = mainTab:CreateSection("Combat", "Left")
    local movement = mainTab:CreateSection("Movement", "Right")
    
    combat:CreateToggle({
        Title = "Kill All", 
        Column = "Left",
        Default = false, 
        Callback = function(state) print("Kill All:", state) end
    })

    combat:CreateButton({
        Title = "Instant Win",
        Column = "Left",
        Callback = function() print("Instant Win triggered") end
    })

    movement:CreateSlider({
        Title = "WalkSpeed",
        Column = "Right",
        Min = 16,
        Max = 250,
        Default = 16,
        Callback = function(v) pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end) end
    })

    local espTab = window:CreateTab("ESP", false)
    local visuals = espTab:CreateSection("Visuals", "Left")
    local filters = espTab:CreateSection("Filters", "Right")

    visuals:CreateToggle({
        Title = "Player ESP",
        Column = "Left",
        Default = false,
        Callback = function(state) print("ESP:", state) end
    })

    filters:CreateToggle({
        Title = "Show Team",
        Column = "Right",
        Default = true,
        Callback = function(state) print("Show Team:", state) end
    })
    return window
end

return UILayout