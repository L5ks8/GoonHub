local UserInputService = game:GetService("UserInputService")

local Layout = {}
Layout.__index = Layout

local COLORS = {
	Background = Color3.fromRGB(24, 24, 24),
	Panel = Color3.fromRGB(32, 32, 32),
	PanelHover = Color3.fromRGB(40, 40, 40),
	Stroke = Color3.fromRGB(70, 70, 70),
	Text = Color3.fromRGB(245, 245, 245),
	Muted = Color3.fromRGB(165, 165, 165),
	Accent = Color3.fromRGB(64, 190, 150),
	Off = Color3.fromRGB(72, 72, 72),
}

local function make(className, properties, children)
	local instance = Instance.new(className)

	for property, value in pairs(properties or {}) do
		instance[property] = value
	end

	for _, child in ipairs(children or {}) do
		child.Parent = instance
	end

	return instance
end

local function connect(button, callback)
	if not button or not callback then
		return
	end

	button.Active = true
	button.Selectable = true

	button.Activated:Connect(function()
		local ok, result = pcall(callback)
		if not ok then
			warn("[GoonHub UI]: " .. tostring(result))
		end
	end)
end

local function call(callback, ...)
	if not callback then
		return
	end

	local ok, result = pcall(callback, ...)
	if not ok then
		warn("[GoonHub UI]: " .. tostring(result))
	end
end

local function label(text, size, color)
	return make("TextLabel", {
		BackgroundTransparency = 1,
		FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
		Text = text,
		TextColor3 = color or COLORS.Text,
		TextSize = size or 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 20),
	})
end

local function corner(radius)
	return make("UICorner", {
		CornerRadius = UDim.new(0, radius or 8),
	})
end

local function stroke(transparency)
	return make("UIStroke", {
		Color = COLORS.Stroke,
		Transparency = transparency or 0.35,
		Thickness = 1,
	})
end

local function setButtonActive(button, active)
	button.BackgroundTransparency = active and 0.1 or 1
	local text = button:FindFirstChild("label")
	if text then
		text.TextColor3 = active and COLORS.Text or COLORS.Muted
	end
end

local function createPage(name, parent, order)
	local page = make("ScrollingFrame", {
		Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
		LayoutOrder = order,
		Name = name,
		ScrollBarImageTransparency = 0.65,
		ScrollBarThickness = 3,
		Size = UDim2.new(1, 0, 1, 0),
	})

	make("UIPadding", {
		PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		PaddingTop = UDim.new(0, 12),
		Parent = page,
	})

	make("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page,
	})

	page.Parent = parent
	return page
end

local function createNavButton(name, icon, parent, order)
	local button = make("ImageButton", {
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(41, 41, 41),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ImageTransparency = 1,
		LayoutOrder = order,
		Name = name,
		Size = UDim2.new(1, 0, 0, 31),
	})

	make("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = button,
	})

	make("UIPadding", {
		PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent = button,
	})

	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Parent = button,
	})

	local holder = make("Frame", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.8,
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Name = "holder",
		Size = UDim2.new(0, 20, 0, 20),
		Parent = button,
	})
	corner(6).Parent = holder

	make("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = icon or "rbxassetid://11433532654",
		Name = "icon",
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 14, 0, 14),
		Parent = holder,
	})

	local text = label(name, 14, COLORS.Muted)
	text.Name = "label"
	text.LayoutOrder = 2
	text.Size = UDim2.new(0, 0, 0, 22)
	text.Parent = button

	make("UIFlexItem", {
		FlexMode = Enum.UIFlexMode.Fill,
		Parent = text,
	})

	make("ObjectValue", {
		Name = "Screen",
		Parent = button,
	})

	button.Parent = parent
	return button
end

function Layout.new(ui, mainFunctions)
	local self = setmetatable({
		UI = ui,
		Tabs = {},
		TabCount = 0,
		Connections = {},
		MainFunctions = mainFunctions and mainFunctions.new(ui) or nil,
	}, Layout)

	if self.MainFunctions then
		self.MainFunctions.OnClose = function()
			self:Destroy()
		end
	end

	return self
end

function Layout:CreateTab(name, icon)
	self.TabCount += 1
	local order = self.TabCount
	local page = createPage(name, self.UI.Screen, order)
	local button

	if order == 1 and self.UI.HomeButton then
		button = self.UI.HomeButton
		button.Name = name

		local text = button:FindFirstChild("label")
		if text then
			text.Text = name
		end
	else
		button = createNavButton(name, icon, self.UI.Navigation, order)
	end

	local screenValue = button:FindFirstChild("Screen")
	if screenValue then
		screenValue.Value = page
	end

	connect(button, function()
		self:SelectTab(name)
	end)

	self.Tabs[name] = {
		Button = button,
		Page = page,
	}

	if order == 1 then
		self:SelectTab(name)
	end

	return self.Tabs[name]
end

function Layout:SelectTab(name)
	for tabName, tab in pairs(self.Tabs) do
		setButtonActive(tab.Button, tabName == name)
	end

	local tab = self.Tabs[name]
	if tab then
		self.UI.PageLayout:JumpTo(tab.Page)
	end
end

function Layout:CreateSection(tab, title)
	local section = make("Frame", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = COLORS.Background,
		BorderSizePixel = 0,
		Name = title,
		Size = UDim2.new(1, 0, 0, 0),
		Parent = tab.Page,
	}, {
		corner(10),
		stroke(0.55),
	})

	make("UIPadding", {
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 10),
		Parent = section,
	})

	make("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = section,
	})

	local titleLabel = label(title, 15, COLORS.Text)
	titleLabel.Name = "title"
	titleLabel.Parent = section

	return section
end

function Layout:CreateButton(parent, text, callback)
	local button = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.Panel,
		BorderSizePixel = 0,
		FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
		Name = text,
		Size = UDim2.new(1, 0, 0, 36),
		Text = text,
		TextColor3 = COLORS.Text,
		TextSize = 14,
		Parent = parent,
	}, {
		corner(8),
		stroke(0.7),
	})

	connect(button, callback)
	return button
end

function Layout:CreateToggle(parent, text, default, callback)
	local enabled = default == true
	local row = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.Panel,
		BorderSizePixel = 0,
		Name = text,
		Size = UDim2.new(1, 0, 0, 40),
		Text = "",
		Parent = parent,
	}, {
		corner(8),
		stroke(0.7),
	})

	make("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent = row,
	})

	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Parent = row,
	})

	local textLabel = label(text, 14, COLORS.Text)
	textLabel.LayoutOrder = 1
	textLabel.Size = UDim2.new(0, 0, 1, 0)
	textLabel.Parent = row

	make("UIFlexItem", {
		FlexMode = Enum.UIFlexMode.Fill,
		Parent = textLabel,
	})

	local switch = make("Frame", {
		BackgroundColor3 = enabled and COLORS.Accent or COLORS.Off,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Name = "switch",
		Size = UDim2.new(0, 42, 0, 22),
		Parent = row,
	}, {
		corner(12),
	})

	local knob = make("Frame", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Name = "knob",
		Position = enabled and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8),
		Size = UDim2.new(0, 16, 0, 16),
		Parent = switch,
	}, {
		corner(8),
	})

	local function set(value)
		enabled = value == true
		switch.BackgroundColor3 = enabled and COLORS.Accent or COLORS.Off
		knob.Position = enabled and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8)
		call(callback, enabled)
	end

	connect(row, function()
		set(not enabled)
	end)

	if default ~= nil then
		call(callback, enabled)
	end

	return {
		Instance = row,
		Set = set,
		Get = function()
			return enabled
		end,
	}
end

function Layout:CreateSlider(parent, text, min, max, default, callback)
	min = min or 0
	max = max or 100
	if max <= min then
		max = min + 1
	end

	local value = math.clamp(default or min, min, max)
	local dragging = false
	local range = max - min

	local row = make("Frame", {
		BackgroundColor3 = COLORS.Panel,
		BorderSizePixel = 0,
		Name = text,
		Size = UDim2.new(1, 0, 0, 56),
		Parent = parent,
	}, {
		corner(8),
		stroke(0.7),
	})

	make("UIPadding", {
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 8),
		Parent = row,
	})

	local title = label(text, 14, COLORS.Text)
	title.Size = UDim2.new(1, -56, 0, 18)
	title.Parent = row

	local valueLabel = label(tostring(value), 13, COLORS.Muted)
	valueLabel.AnchorPoint = Vector2.new(1, 0)
	valueLabel.Position = UDim2.new(1, 0, 0, 0)
	valueLabel.Size = UDim2.new(0, 52, 0, 18)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = row

	local track = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.Off,
		BorderSizePixel = 0,
		Name = "track",
		Position = UDim2.new(0, 0, 0, 30),
		Size = UDim2.new(1, 0, 0, 8),
		Text = "",
		Parent = row,
	}, {
		corner(4),
	})

	local fill = make("Frame", {
		BackgroundColor3 = COLORS.Accent,
		BorderSizePixel = 0,
		Name = "fill",
		Size = UDim2.new((value - min) / range, 0, 1, 0),
		Parent = track,
	}, {
		corner(4),
	})

	local function setFromX(x)
		local percent = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		value = math.floor((min + (range * percent)) * 100) / 100
		fill.Size = UDim2.new(percent, 0, 1, 0)
		valueLabel.Text = tostring(value)
		call(callback, value)
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		dragging = true
		setFromX(input.Position.X)
	end)

	table.insert(self.Connections, UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			setFromX(input.Position.X)
		end
	end))

	table.insert(self.Connections, UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end))

	call(callback, value)

	return {
		Instance = row,
		Set = function(nextValue)
			value = math.clamp(nextValue, min, max)
			local percent = (value - min) / range
			fill.Size = UDim2.new(percent, 0, 1, 0)
			valueLabel.Text = tostring(value)
			call(callback, value)
		end,
		Get = function()
			return value
		end,
	}
end

function Layout:Destroy()
	for _, connection in ipairs(self.Connections) do
		connection:Disconnect()
	end

	table.clear(self.Connections)

	if self.MainFunctions then
		self.MainFunctions:Destroy()
	end
end

return Layout
