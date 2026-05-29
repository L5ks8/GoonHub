local Players = game:GetService("Players")

local SharedUi = require(script.Parent.Parent.Ui.ui)

local GameUi = {}

local function createPanel(parent)
	local panel = Instance.new("Frame")
	panel.Name = "MM2Panel"
	panel.AnchorPoint = Vector2.new(0, 0.5)
	panel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	panel.BorderSizePixel = 0
	panel.Position = UDim2.new(0, 24, 0.5, 0)
	panel.Size = UDim2.new(0, 360, 0, 430)
	panel.Parent = parent

	local corner = Instance.new("UICorner")
	corner.Name = "Corner"
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = panel

	local padding = Instance.new("UIPadding")
	padding.Name = "Padding"
	padding.PaddingTop = UDim.new(0, 18)
	padding.PaddingRight = UDim.new(0, 18)
	padding.PaddingBottom = UDim.new(0, 18)
	padding.PaddingLeft = UDim.new(0, 18)
	padding.Parent = panel

	local layout = Instance.new("UIListLayout")
	layout.Name = "List"
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 12)
	layout.Parent = panel

	return panel
end

local function createHeader(parent)
	local header = Instance.new("TextLabel")
	header.Name = "Header"
	header.BackgroundTransparency = 1
	header.BorderSizePixel = 0
	header.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	header.Text = "Murder Mystery 2"
	header.TextColor3 = Color3.fromRGB(255, 255, 255)
	header.TextSize = 20
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.Size = UDim2.new(1, 0, 0, 28)
	header.LayoutOrder = 1
	header.Parent = parent

	local description = Instance.new("TextLabel")
	description.Name = "Description"
	description.BackgroundTransparency = 1
	description.BorderSizePixel = 0
	description.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	description.Text = "Test UI"
	description.TextColor3 = Color3.fromRGB(255, 255, 255)
	description.TextTransparency = 0.55
	description.TextSize = 13
	description.TextXAlignment = Enum.TextXAlignment.Left
	description.Size = UDim2.new(1, 0, 0, 18)
	description.LayoutOrder = 2
	description.Parent = parent
end

local function createNavigation(parent)
	local navigation = Instance.new("Frame")
	navigation.Name = "Navigation"
	navigation.BackgroundTransparency = 1
	navigation.BorderSizePixel = 0
	navigation.Size = UDim2.new(1, 0, 0, 74)
	navigation.LayoutOrder = 3
	navigation.Parent = parent

	local layout = Instance.new("UIListLayout")
	layout.Name = "List"
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 8)
	layout.Parent = navigation

	SharedUi.Tab.Create(navigation, {
		Name = "Main",
		Text = "Main",
		Icon = "rbxassetid://11293977610",
		LayoutOrder = 1,
	})

	SharedUi.Tab.Create(navigation, {
		Name = "Settings",
		Text = "Settings",
		Icon = "rbxassetid://11293977610",
		LayoutOrder = 2,
	})
end

local function createContent(parent)
	local content = Instance.new("Frame")
	content.Name = "Content"
	content.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
	content.BorderSizePixel = 0
	content.Size = UDim2.new(1, 0, 0, 250)
	content.LayoutOrder = 4
	content.Parent = parent

	local corner = Instance.new("UICorner")
	corner.Name = "Corner"
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = content

	local padding = Instance.new("UIPadding")
	padding.Name = "Padding"
	padding.PaddingTop = UDim.new(0, 14)
	padding.PaddingRight = UDim.new(0, 14)
	padding.PaddingBottom = UDim.new(0, 14)
	padding.PaddingLeft = UDim.new(0, 14)
	padding.Parent = content

	local layout = Instance.new("UIListLayout")
	layout.Name = "List"
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = content

	SharedUi.Toggle.Create(content, {
		Name = "TestToggle",
		Text = "Test Toggle",
		Description = "Asset preview",
		LayoutOrder = 1,
	})

	SharedUi.SliderWithBox.Create(content, {
		Name = "TestSlider",
		Text = "Test Slider",
		Min = 0,
		Max = 100,
		Default = 50,
		LayoutOrder = 2,
	})

	SharedUi.Button.Create(content, {
		Name = "TestButton",
		Text = "Test Button",
		LayoutOrder = 3,
	})

	SharedUi.Dropdown.Create(content, {
		Name = "TestDropdown",
		Visible = true,
		Open = true,
		LayoutOrder = 4,
		Options = {
			{
				Text = "Test Option",
				Description = "No function yet",
				Icon = "rbxassetid://11293977610",
			},
		},
	})
end

function GameUi.Load()
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local existing = playerGui:FindFirstChild("GoonHub_MM2")

	if existing then
		existing:Destroy()
	end

	local screenGui = SharedUi.CreateWindow(playerGui, {
		Name = "GoonHub_MM2",
	})

	local panel = createPanel(screenGui)
	createHeader(panel)
	createNavigation(panel)
	createContent(panel)

	return screenGui
end

return GameUi
