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

    local mainTab = window:CreateTab("Main", false)
    
    local combat = mainTab:CreateSection("Combat", "Left")
    
    combat:CreateToggle({
        Title = "Kill All", 
        Column = "Left",
        Default = false, 
        Callback = function(state)
            print("Kill All ist:", state)
        end
    })

    combat:CreateButton({
        Title = "Instant Win",
        Column = "Left",
        Callback = function()
            print("Button gedrückt!")
        end
    })

    local movement = mainTab:CreateSection("Movement", "Right")

    movement:CreateSlider({
        Title = "WalkSpeed",
        Column = "Right",
        Min = 16,
        Max = 250,
        Default = 16,
        Callback = function(value)
            print("Geschwindigkeit:", value)
        end
    })

    local espTab = window:CreateTab("ESP", false)
    local visuals = espTab:CreateSection("Visuals", "Left")

    visuals:CreateToggle({
        Title = "Player ESP",
        Column = "Left",
        Default = false,
        Callback = function(state)
            print("ESP Status:", state)
        end
    })

    local settingsTab = window:CreateTab("Settings", true)
    local uiSettings = settingsTab:CreateSection("UI Settings")
    
    uiSettings:CreateButton("Destroy UI", function()
        game:GetService("CoreGui").GoonHub:Destroy()
    end)

    local aboutTab = window:CreateTab("About", true)
    local infoSection = aboutTab:CreateSection("Information")
    
    infoSection:CreateParagraph("GoonHub Version 1.0.0")
    infoSection:CreateParagraph("Developed by L5ks8")

    return window
end

return UILayout