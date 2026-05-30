local UI = require(game:GetService("ReplicatedStorage").GoonHub.Assets.ui)
local Widgets = require(game:GetService("ReplicatedStorage").GoonHub.Assets.Components.widgets)

local UILayout = {}

function UILayout.Create()
    -- Basis UI erstellen
    local G2L = UI.CreateBase("GoonHub", "1.0.0")
    local window = {TabCount = 0}

    -- Widgets initialisieren (fügt window:CreateTab hinzu)
    Widgets.Init(window, G2L)

    -- Tab definieren
    local mainTab = window:CreateTab("Main", false)
    local settingsTab = window:CreateTab("Settings", true) -- Fixierter Tab unten

    return window, mainTab
end

return UILayout