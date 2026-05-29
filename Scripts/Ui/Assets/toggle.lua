local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local Toggle = {}

local DEFAULT_FONT = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
local TWEEN = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function addTag(instance, tag)
	if tag then
		CollectionService:AddTag(instance, tag)
	end
end

local function setState(switch, state, callback, skipCallback)
	switch:SetAttribute("State", state)

	local circle = switch:FindFirstChild("circle")
	if circle then
		TweenService:Create(circle, TWEEN, {
			Position = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 0, 0.5, 0),
			BackgroundTransparency = state and 0 or 0.95,
		}):Play()
	end

	TweenService:Create(switch, TWEEN, {
		BackgroundColor3 = state and Color3.fromRGB(61, 119, 255) or Color3.fromRGB(23, 23, 23),
	}):Play()

	if not skipCallback then
		if callback then
			callback(state, switch)
		end
	end
end

function Toggle.Create(parent, config)
	config = config or {}

	local item = Instance.new("Frame")
	item.Name = config.Name or "Toggle"
	item.BackgroundTransparency = 1
	item.BorderSizePixel = 0
	item.Size = config.Size or UDim2.new(1, 0, 0, 50)
	item.LayoutOrder = config.LayoutOrder or 0
	item.Parent = parent

	addTag(item, config.ItemTag or "SettingObject")

	local padding = Instance.new("UIPadding")
	padding.Name = "Padding"
	padding.PaddingLeft = UDim.new(0, 12)
	padding.PaddingRight = UDim.new(0, 12)
	padding.Parent = item

	local layout = Instance.new("UIListLayout")
	layout.Name = "List"
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = item

	local info = Instance.new("Frame")
	info.Name = "info"
	info.BackgroundTransparency = 1
	info.BorderSizePixel = 0
	info.Size = UDim2.new(0, 0, 0, 32)
	info.LayoutOrder = 1
	info.Parent = item

	local flex = Instance.new("UIFlexItem")
	flex.Name = "Flex"
	flex.FlexMode = Enum.UIFlexMode.Fill
	flex.Parent = info

	local header = Instance.new("TextLabel")
	header.Name = "Header"
	header.BackgroundTransparency = 1
	header.BorderSizePixel = 0
	header.FontFace = config.FontFace or DEFAULT_FONT
	header.Text = config.Text or "Toggle"
	header.TextColor3 = Color3.fromRGB(255, 255, 255)
	header.TextSize = config.TextSize or 14
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.Size = UDim2.new(1, 0, 0, 18)
	header.Parent = info

	local description = Instance.new("TextLabel")
	description.Name = "Description"
	description.BackgroundTransparency = 1
	description.BorderSizePixel = 0
	description.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	description.Text = config.Description or ""
	description.TextColor3 = Color3.fromRGB(255, 255, 255)
	description.TextTransparency = 0.7
	description.TextSize = config.DescriptionSize or 12
	description.TextXAlignment = Enum.TextXAlignment.Left
	description.Size = UDim2.new(1, 0, 0, 16)
	description.Position = UDim2.new(0, 0, 0, 18)
	description.Parent = info

	local switch = Instance.new("ImageButton")
	switch.Name = "switch"
	switch.AutoButtonColor = false
	switch.ImageTransparency = 1
	switch.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
	switch.BorderSizePixel = 0
	switch.AnchorPoint = Vector2.new(1, 0.5)
	switch.Position = UDim2.new(1, 0, 0.5, 0)
	switch.Size = config.SwitchSize or UDim2.new(0, 45, 0, 27)
	switch.LayoutOrder = 99
	switch:SetAttribute("Enabled", config.Enabled == nil and true or config.Enabled)
	switch:SetAttribute("State", false)
	switch.Parent = item

	addTag(switch, config.Tag or "OrbitBooleanSwitch")

	local corner = Instance.new("UICorner")
	corner.Name = "Corner"
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = switch

	local switchPadding = Instance.new("UIPadding")
	switchPadding.PaddingLeft = UDim.new(0, 5)
	switchPadding.PaddingRight = UDim.new(0, 5)
	switchPadding.Parent = switch

	local circle = Instance.new("Frame")
	circle.Name = "circle"
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.BackgroundTransparency = 0.95
	circle.BorderSizePixel = 0
	circle.AnchorPoint = Vector2.new(0, 0.5)
	circle.Position = UDim2.new(0, 0, 0.5, 0)
	circle.Size = UDim2.new(0, 19, 0, 19)
	circle.Parent = switch

	local circleCorner = Instance.new("UICorner")
	circleCorner.Name = "Corner"
	circleCorner.CornerRadius = UDim.new(1, 0)
	circleCorner.Parent = circle

	switch.MouseButton1Click:Connect(function()
		if switch:GetAttribute("Enabled") == false then
			return
		end

		setState(switch, not switch:GetAttribute("State"), config.OnChanged)
	end)

	setState(switch, config.Default == true, config.OnChanged, true)

	return item
end

return Toggle
