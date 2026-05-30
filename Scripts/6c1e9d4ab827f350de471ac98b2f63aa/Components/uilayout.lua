local UI = require(game:GetService("ReplicatedStorage").GoonHub.Assets.ui)
local Widgets = require(game:GetService("ReplicatedStorage").GoonHub.Assets.Components.widgets)
local UIFunctions = require(game:GetService("ReplicatedStorage").GoonHub.Assets.Components.uifunctions)

local UILayout = {}

function UILayout.Create()
    -- Toggle-States initialisieren, falls nicht vorhanden
    getgenv().NyroxToggleStates = getgenv().NyroxToggleStates or {}

    -- Basis UI erstellen
    local G2L = UI.CreateBase("GoonHub", "1.0.0")
    local window = {TabCount = 0, Stats = {FPS = {}, Ping = {}, Memory = {}}}

    -- Widgets initialisieren (fügt window:CreateTab hinzu)
    Widgets.Init(window, G2L)
    -- Interaktionen (Drag, Close, Zeit) laden
    UIFunctions.Init(G2L, window)

    -- Tabs definieren und mit Inhalten füllen
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