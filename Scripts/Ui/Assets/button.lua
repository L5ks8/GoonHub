local CollectionService = game:GetService("CollectionService")

local Button = {}

local DEFAULT_FONT = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)

local function addTag(instance, tag)
	if tag then
		CollectionService:AddTag(instance, tag)
	end
end

function Button.Create(parent, config)
	config = config or {}

	local button = Instance.new("ImageButton")
	button.Name = config.Name or "Button"
	button.AutoButtonColor = config.AutoButtonColor == nil and false or config.AutoButtonColor
	button.ImageTransparency = 1
	button.BackgroundColor3 = config.BackgroundColor3 or Color3.fromRGB(23, 23, 23)
	button.BackgroundTransparency = config.BackgroundTransparency or 0
	button.BorderSizePixel = 0
	button.Size = config.Size or UDim2.new(1, 0, 0, 40)
	button.LayoutOrder = config.LayoutOrder or 0
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.Name = "Corner"
	corner.CornerRadius = config.CornerRadius or UDim.new(0, 18)
	corner.Parent = button

	local padding = Instance.new("UIPadding")
	padding.Name = "Padding"
	padding.PaddingLeft = config.PaddingLeft or UDim.new(0, 18)
	padding.PaddingRight = config.PaddingRight or UDim.new(0, 18)
	padding.Parent = button

	local layout = Instance.new("UIListLayout")
	layout.Name = "List"
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = button

	if config.Icon then
		local holder = Instance.new("ImageLabel")
		holder.Name = "holder"
		holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		holder.BackgroundTransparency = 0.8
		holder.BorderSizePixel = 0
		holder.ImageTransparency = 1
		holder.Size = config.IconHolderSize or UDim2.new(0, 24, 0, 24)
		holder.LayoutOrder = 1
		holder.Parent = button

		local holderCorner = Instance.new("UICorner")
		holderCorner.Name = "Corner"
		holderCorner.CornerRadius = UDim.new(0, 6)
		holderCorner.Parent = holder

		local icon = Instance.new("ImageLabel")
		icon.Name = "icon"
		icon.BackgroundTransparency = 1
		icon.BorderSizePixel = 0
		icon.Image = config.Icon
		icon.ImageTransparency = config.IconTransparency or 0.5
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		icon.Size = config.IconSize or UDim2.new(0, 16, 0, 16)
		icon.Parent = holder
	end

	local label = Instance.new("TextLabel")
	label.Name = "label"
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.FontFace = config.FontFace or DEFAULT_FONT
	label.Text = config.Text or "Button"
	label.TextColor3 = config.TextColor3 or Color3.fromRGB(255, 255, 255)
	label.TextSize = config.TextSize or 15
	label.TextTransparency = config.TextTransparency or 0
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(0, 0, 1, 0)
	label.AutomaticSize = Enum.AutomaticSize.X
	label.LayoutOrder = 2
	label.Parent = button

	if config.TranslationKey then
		label:SetAttribute("Key", config.TranslationKey)
		addTag(label, "OrbitTranslation")
	end

	addTag(button, config.Tag or "OrbitButton")

	if config.OnClick then
		button.MouseButton1Click:Connect(config.OnClick)
	end

	return button
end

return Button
