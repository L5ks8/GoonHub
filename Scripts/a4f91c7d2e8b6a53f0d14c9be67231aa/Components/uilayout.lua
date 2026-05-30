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

    local loader = Animation.PlayLoading(G2L)
    loader:Update(20)

    UIFunctions.Init(G2L, window)

    -- Game Tabs
    local mainTab = window:CreateTab("Main", false)
    local FarmTab = window:CreateTab("Farm", false)
    local MiscTab = window:CreateTab("Misc", false)
    local EspTab = window:CreateTab("Esp", false)
    local ConfigTab = window:CreateTab("Config", false)
    
    loader:Update(80)
    
    window.Loader = loader
    
    return window
end

return UILayout