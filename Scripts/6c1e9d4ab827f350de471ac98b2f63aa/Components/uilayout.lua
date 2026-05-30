local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")

local UILayout = {}

function UILayout.Create()
    -- Toggle-States initialisieren, falls nicht vorhanden
    getgenv().NyroxToggleStates = getgenv().NyroxToggleStates or {}

    -- Basis UI erstellen
    local G2L = UI.CreateBase("GoonHub", "1.0.0")
    local window = {
        TabCount = 0, 
        Stats = {
            FPS = G2L["fps_label"],
            Ping = G2L["ping_label"],
            Memory = G2L["mem_label"]
        }
    }

    -- Widgets initialisieren (fügt window:CreateTab hinzu)
    Widgets.Init(window, G2L)
    -- Interaktionen (Drag, Close, Zeit) laden
    UIFunctions.Init(G2L, window)

    -- Game Tabs
    local mainTab = window:CreateTab("Main", false)
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

    -- System Tabs (Werden immer am Ende angehängt)
    local function AddSystemTabs()
        local settingsTab = window:CreateTab("Settings", true)
        local uiSettings = settingsTab:CreateSection("UI Settings", "Left")
        uiSettings:CreateButton({
            Title = "Destroy UI",
            Column = "Left",
            Callback = function() game:GetService("CoreGui").GoonHub:Destroy() end
        })

        local aboutTab = window:CreateTab("About", true)
        local info = aboutTab:CreateSection("Information", "Left")
        info:CreateParagraph({Text = "GoonHub Version 1.0.0", Column = "Left"})
        info:CreateParagraph({Text = "Developed by L5ks8", Column = "Left"})
    end

    AddSystemTabs()

    return window
end

return UILayout