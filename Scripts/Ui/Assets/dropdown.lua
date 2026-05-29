local CollectionService = game:GetService("CollectionService")

local Dropdown = {}

local DEFAULT_FONT = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)

local function addTag(instance, tag)
	if tag then
		CollectionService:AddTag(instance, tag)
	end
end

function Dropdown.Create(parent, config)
	config = config or {}

	local dropdown = Instance.new("Frame")
	dropdown.Name = config.Name or "Dropdown"
	dropdown.BackgroundTransparency = 1
	dropdown.BorderSizePixel = 0
	dropdown.AutomaticSize = Enum.AutomaticSize.Y
	dropdown.Size = config.Size or UDim2.new(1, 0, 0, 0)
	dropdown.LayoutOrder = config.LayoutOrder or 0
	dropdown.Visible = config.Visible == true
	dropdown.Parent = parent

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.BackgroundTransparency = 1
	main.BorderSizePixel = 0
	main.AutomaticSize = Enum.AutomaticSize.Y
	main.Size = UDim2.new(1, 0, 0, 0)
	main.Parent = dropdown

	local content = Instance.new("CanvasGroup")
	content.Name = "Content"
	content.BackgroundColor3 = config.BackgroundColor3 or Color3.fromRGB(23, 23, 23)
	content.BorderSizePixel = 0
	content.AutomaticSize = Enum.AutomaticSize.Y
	content.Size = UDim2.new(1, 0, 0, 0)
	content.GroupTransparency = config.Open and 0 or 1
	content.Parent = main

	local corner = Instance.new("UICorner")
	corner.Name = "Corner"
	corner.CornerRadius = config.CornerRadius or UDim.new(0, 10)
	corner.Parent = content

	local list = Instance.new("UIListLayout")
	list.Name = "List"
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, 4)
	list.Parent = content

	local padding = Instance.new("UIPadding")
	padding.Name = "Padding"
	padding.PaddingTop = UDim.new(0, 8)
	padding.PaddingBottom = UDim.new(0, 8)
	padding.PaddingLeft = UDim.new(0, 8)
	padding.PaddingRight = UDim.new(0, 8)
	padding.Parent = content

	addTag(dropdown, config.Tag or "OrbitDropdown")

	local function addOption(option)
		option = option or {}

		local result = Instance.new("ImageButton")
		result.Name = option.Name or "result"
		result.AutoButtonColor = false
		result.ImageTransparency = 1
		result.BackgroundTransparency = 1
		result.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		result.BorderSizePixel = 0
		result.Size = UDim2.new(1, 0, 0, 50)
		result.LayoutOrder = option.LayoutOrder or 0
		result.Parent = content

		local resultCorner = Instance.new("UICorner")
		resultCorner.Name = "Corner"
		resultCorner.CornerRadius = UDim.new(0, 8)
		resultCorner.Parent = result

		local resultPadding = Instance.new("UIPadding")
		resultPadding.Name = "Padding"
		resultPadding.PaddingLeft = UDim.new(0, 10)
		resultPadding.PaddingRight = UDim.new(0, 10)
		resultPadding.Parent = result

		local resultList = Instance.new("UIListLayout")
		resultList.Name = "List"
		resultList.FillDirection = Enum.FillDirection.Horizontal
		resultList.VerticalAlignment = Enum.VerticalAlignment.Center
		resultList.SortOrder = Enum.SortOrder.LayoutOrder
		resultList.Padding = UDim.new(0, 10)
		resultList.Parent = result

		if option.Icon then
			local thumbnail = Instance.new("ImageLabel")
			thumbnail.Name = "Thumbnail"
			thumbnail.BackgroundTransparency = 1
			thumbnail.BorderSizePixel = 0
			thumbnail.Image = option.Icon
			thumbnail.Size = UDim2.new(0, 34, 0, 34)
			thumbnail.LayoutOrder = 1
			thumbnail.Parent = result

			local thumbnailCorner = Instance.new("UICorner")
			thumbnailCorner.Name = "corner"
			thumbnailCorner.CornerRadius = UDim.new(1, 0)
			thumbnailCorner.Parent = thumbnail
		end

		local information = Instance.new("Frame")
		information.Name = "Information"
		information.BackgroundTransparency = 1
		information.BorderSizePixel = 0
		information.Size = UDim2.new(0, 0, 0, 34)
		information.LayoutOrder = 2
		information.Parent = result

		local flex = Instance.new("UIFlexItem")
		flex.Name = "flex"
		flex.FlexMode = Enum.UIFlexMode.Fill
		flex.Parent = information

		local title = Instance.new("TextLabel")
		title.Name = option.TitleName or "Display"
		title.BackgroundTransparency = 1
		title.BorderSizePixel = 0
		title.FontFace = option.FontFace or DEFAULT_FONT
		title.Text = option.Text or "Result"
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.TextSize = 14
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.Size = UDim2.new(1, 0, 0, 18)
		title.Parent = information

		local subtitle = Instance.new("TextLabel")
		subtitle.Name = option.SubtitleName or "Username"
		subtitle.BackgroundTransparency = 1
		subtitle.BorderSizePixel = 0
		subtitle.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		subtitle.Text = option.Description or ""
		subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		subtitle.TextTransparency = 0.6
		subtitle.TextSize = 12
		subtitle.TextXAlignment = Enum.TextXAlignment.Left
		subtitle.Position = UDim2.new(0, 0, 0, 18)
		subtitle.Size = UDim2.new(1, 0, 0, 16)
		subtitle.Parent = information

		if option.OnClick then
			result.MouseButton1Click:Connect(function()
				option.OnClick(result)
			end)
		end

		return result
	end

	for _, option in ipairs(config.Options or {}) do
		addOption(option)
	end

	return dropdown
end

return Dropdown
