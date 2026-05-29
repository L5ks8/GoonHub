local Ui = {}

local assets = script:WaitForChild("Assets")

local function requireAsset(name)
	local module = assets:FindFirstChild(name) or assets:FindFirstChild(name .. ".lua")

	if not module then
		error("Missing UI asset: " .. name)
	end

	return require(module)
end

Ui.Button = requireAsset("button")
Ui.Dropdown = requireAsset("dropdown")
Ui.SliderWithBox = requireAsset("sliderwithbox")
Ui.Tab = requireAsset("tab")
Ui.Toggle = requireAsset("toggle")

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
