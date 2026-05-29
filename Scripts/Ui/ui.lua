local Ui = {}

Ui.Button = require(script.Assets.button)
Ui.Dropdown = require(script.Assets.dropdown)
Ui.SliderWithBox = require(script.Assets.sliderwithbox)
Ui.Tab = require(script.Assets.tab)
Ui.Toggle = require(script.Assets.toggle)

function Ui.CreateWindow(parent, config)
	config = config or {}

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = config.Name or "GoonHubUi"
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = config.DisplayOrder or 9999998
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = parent

	return screenGui
end

return Ui
