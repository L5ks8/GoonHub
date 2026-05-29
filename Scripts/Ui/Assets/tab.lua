local CollectionService = game:GetService("CollectionService")

local Tab = {}

local DEFAULT_FONT = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)

local function addTag(instance, tag)
	if tag then
		CollectionService:AddTag(instance, tag)
	end
end

function Tab.Create(parent, config)
	config = config or {}

	local tab = Instance.new("ImageButton")
	tab.Name = config.Name or "tab"
	tab.AutoButtonColor = false
	tab.ImageTransparency = 1
	tab.BackgroundColor3 = config.BackgroundColor3 or Color3.fromRGB(41, 41, 41)
	tab.BackgroundTransparency = config.BackgroundTransparency or 1
	tab.BorderSizePixel = 0
	tab.Size = config.Size or UDim2.new(1, 0, 0, 30)
	tab.LayoutOrder = config.LayoutOrder or 0
	tab:SetAttribute("Selected", config.Selected == true)
	tab.Parent = parent

	addTag(tab, config.Tag or "OrbitNavigationButton")

	local layout = Instance.new("UIListLayout")
	layout.Name = "list"
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = tab

	local padding = Instance.new("UIPadding")
	padding.Name = "padding"
	padding.PaddingLeft = UDim.new(0, 12)
	padding.PaddingRight = UDim.new(0, 12)
	padding.Parent = tab

	local corner = Instance.new("UICorner")
	corner.Name = "corner"
	corner.CornerRadius = config.CornerRadius or UDim.new(0, 12)
	corner.Parent = tab

	local holder = Instance.new("ImageLabel")
	holder.Name = "holder"
	holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	holder.BackgroundTransparency = 0.8
	holder.BorderSizePixel = 0
	holder.ImageTransparency = 1
	holder.Size = UDim2.new(0, 20, 0, 20)
	holder.LayoutOrder = 1
	holder.Parent = tab

	local holderCorner = Instance.new("UICorner")
	holderCorner.Name = "Corner"
	holderCorner.CornerRadius = UDim.new(0, 6)
	holderCorner.Parent = holder

	local icon = Instance.new("ImageLabel")
	icon.Name = "icon"
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Image = config.Icon or "rbxassetid://11293977610"
	icon.ImageTransparency = config.IconTransparency or 0.5
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	icon.Size = UDim2.new(0, 14, 0, 14)
	icon.Parent = holder

	local label = Instance.new("TextLabel")
	label.Name = "label"
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.FontFace = config.FontFace or DEFAULT_FONT
	label.Text = config.Text or "Tab"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = config.TextSize or 14
	label.TextTransparency = config.TextTransparency or 0.5
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(0, 0, 0, 22)
	label.LayoutOrder = 2
	label.Parent = tab

	local flex = Instance.new("UIFlexItem")
	flex.Name = "Flex"
	flex.FlexMode = Enum.UIFlexMode.Fill
	flex.Parent = label

	if config.Screen then
		local screen = Instance.new("ObjectValue")
		screen.Name = "Screen"
		screen.Value = config.Screen
		screen.Parent = tab
	end

	if config.TranslationKey then
		label:SetAttribute("Key", config.TranslationKey)
		addTag(label, "OrbitTranslation")
	end

	if config.OnClick then
		tab.MouseButton1Click:Connect(function()
			config.OnClick(tab)
		end)
	end

	return tab
end

return Tab
