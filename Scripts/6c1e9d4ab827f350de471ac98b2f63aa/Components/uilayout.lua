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
            FPS = UI.New("TextLabel", {Text = "FPS: --", TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextSize = 12, AutomaticSize = Enum.AutomaticSize.XY}, G2L["a1"]),
            Ping = UI.New("TextLabel", {Text = "Ping: --", TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextSize = 12, AutomaticSize = Enum.AutomaticSize.XY}, G2L["a1"]),
            Memory = UI.New("TextLabel", {Text = "Mem: --", TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextSize = 12, AutomaticSize = Enum.AutomaticSize.XY}, G2L["a1"])
        }
    }

    -- Widgets initialisieren (fügt window:CreateTab hinzu)
    Widgets.Init(window, G2L)
    -- Interaktionen (Drag, Close, Zeit) laden
    UIFunctions.Init(G2L, window)


    local mainTab = window:CreateTab("Main", false)
    local combatSection = mainTab:CreateSection("Combat")
    combatSection:CreateToggle("Kill All", false, function(state)
        print("Kill All ist:", state)
    end)

    local settingsTab = window:CreateTab("Settings", true)
    local uiSettings = settingsTab:CreateSection("UI Settings")
    uiSettings:CreateButton("Destroy UI", function()
        game:GetService("CoreGui").GoonHub:Destroy()
    end)

    return window
end

return UILayout