local UserInputService = game:GetService("UserInputService")

local SliderWithBox = {}

local DEFAULT_FONT = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)

local function clampNumber(value, min, max)
	return math.clamp(tonumber(value) or min, min, max)
end

function SliderWithBox.Create(parent, config)
	config = config or {}

	local min = config.Min or 0
	local max = config.Max or 100
	local value = clampNumber(config.Default or min, min, max)

	local item = Instance.new("Frame")
	item.Name = config.Name or "SliderWithBox"
	item.BackgroundTransparency = 1
	item.BorderSizePixel = 0
	item.Size = config.Size or UDim2.new(1, 0, 0, 64)
	item.LayoutOrder = config.LayoutOrder or 0
	item.Parent = parent

	local title = Instance.new("TextLabel")
	title.Name = "title"
	title.BackgroundTransparency = 1
	title.BorderSizePixel = 0
	title.FontFace = config.FontFace or DEFAULT_FONT
	title.Text = config.Text or "Slider"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = config.TextSize or 14
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Size = UDim2.new(1, -92, 0, 20)
	title.Parent = item

	local box = Instance.new("TextBox")
	box.Name = "box"
	box.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
	box.BorderSizePixel = 0
	box.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	box.Text = tostring(value)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.TextSize = 14
	box.PlaceholderText = tostring(min)
	box.PlaceholderColor3 = Color3.fromRGB(57, 57, 57)
	box.AnchorPoint = Vector2.new(1, 0)
	box.Position = UDim2.new(1, 0, 0, 0)
	box.Size = UDim2.new(0, 82, 0, 28)
	box.Parent = item

	local boxCorner = Instance.new("UICorner")
	boxCorner.Name = "Corner"
	boxCorner.CornerRadius = UDim.new(0, 12)
	boxCorner.Parent = box

	local track = Instance.new("ImageButton")
	track.Name = "slider"
	track.AutoButtonColor = false
	track.ImageTransparency = 1
	track.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
	track.BorderSizePixel = 0
	track.Position = UDim2.new(0, 0, 0, 38)
	track.Size = UDim2.new(1, 0, 0, 12)
	track.Parent = item

	local trackCorner = Instance.new("UICorner")
	trackCorner.Name = "Corner"
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local fill = Instance.new("Frame")
	fill.Name = "fill"
	fill.BackgroundColor3 = config.FillColor3 or Color3.fromRGB(61, 119, 255)
	fill.BorderSizePixel = 0
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.Name = "Corner"
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local knob = Instance.new("Frame")
	knob.Name = "knob"
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.new(0, 0, 0.5, 0)
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Parent = track

	local knobCorner = Instance.new("UICorner")
	knobCorner.Name = "Corner"
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local function apply(newValue, fireCallback)
		value = clampNumber(newValue, min, max)
		local range = max - min
		local alpha = range == 0 and 0 or (value - min) / range

		fill.Size = UDim2.new(alpha, 0, 1, 0)
		knob.Position = UDim2.new(alpha, 0, 0.5, 0)
		box.Text = tostring(math.floor(value + 0.5))
		item:SetAttribute("Value", value)

		if fireCallback and config.OnChanged then
			config.OnChanged(value, item)
		end
	end

	local function valueFromX(x)
		local alpha = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		return min + ((max - min) * alpha)
	end

	local dragging = false

	track.MouseButton1Down:Connect(function(x)
		dragging = true
		apply(valueFromX(x), true)
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			apply(valueFromX(input.Position.X), true)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	box.FocusLost:Connect(function()
		apply(box.Text, true)
	end)

	apply(value, false)

	return item
end

return SliderWithBox
