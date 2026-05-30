local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")

local UILayout = {}

function UILayout.Create()
    local Window = UI:MakeWindow({
        Name = "GoonHub",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "GoonHub"
    })
    return Window
end

return UILayout
