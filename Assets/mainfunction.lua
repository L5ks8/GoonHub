local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local MainFunctions = {}
MainFunctions.__index = MainFunctions

local function connect(button, callback)
	if not button or not callback then
		return
	end

	button.MouseButton1Click:Connect(function()
		local ok, result = pcall(callback)
		if not ok then
			warn("[GoonHub MainFunctions]: " .. tostring(result))
		end
	end)
end

function MainFunctions.new(ui)
	local self = setmetatable({
		UI = ui,
		Connections = {},
		IsFullscreen = false,
		IsMinimized = false,
		IsSidebarOpen = true,
		NormalSize = ui.Main.Size,
		NormalPosition = ui.Main.Position,
		MinimizeSize = ui.Main.Size,
	}, MainFunctions)

	self:BindButtons()
	self:MakeDraggable()
	self:MakeResizable()
	self:BindDebug()

	return self
end

function MainFunctions:BindButtons()
	connect(self.UI.CloseButton, function()
		self:Close()
	end)

	connect(self.UI.ReturnButton, function()
		self:Minimize()
	end)

	connect(self.UI.NavButton, function()
		self:ToggleSidebar()
	end)

	connect(self.UI.FullscreenButton, function()
		self:ToggleFullscreen()
	end)
end

function MainFunctions:BindDebug()
	local last = os.clock()
	local frames = 0

	table.insert(self.Connections, RunService.RenderStepped:Connect(function()
		frames += 1
		local now = os.clock()

		if now - last >= 1 then
			if self.UI.FpsLabel then
				self.UI.FpsLabel.Text = "FPS: " .. tostring(frames) .. "/s"
			end

			frames = 0
			last = now
		end
	end))
end

function MainFunctions:MakeDraggable()
	local main = self.UI.Main
	local handle = self.UI.DragHandle
	local dragging = false
	local dragStart
	local startPosition

	if not main or not handle then
		return
	end

	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end)

	table.insert(self.Connections, UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
	end))
end

function MainFunctions:MakeResizable()
	local main = self.UI.Main
	local handle = self.UI.ResizeHandle
	local resizing = false
	local resizeStart
	local startSize

	if not main or not handle then
		return
	end

	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		resizing = true
		resizeStart = input.Position
		startSize = main.Size

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end
		end)
	end)

	table.insert(self.Connections, UserInputService.InputChanged:Connect(function(input)
		if not resizing then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local delta = input.Position - resizeStart
		main.Size = UDim2.new(0, math.clamp(startSize.X.Offset + delta.X, 520, 1100), 0, math.clamp(startSize.Y.Offset + delta.Y, 360, 760))
	end))
end

function MainFunctions:ToggleSidebar()
	self.IsSidebarOpen = not self.IsSidebarOpen

	if self.UI.Sidebar then
		self.UI.Sidebar.Visible = self.IsSidebarOpen
	end

	if self.UI.Screen then
		self.UI.Screen.Size = self.IsSidebarOpen and UDim2.new(1, -235, 1, 0) or UDim2.new(1, -28, 1, 0)
	end
end

function MainFunctions:ToggleFullscreen()
	self.IsFullscreen = not self.IsFullscreen

	if self.IsFullscreen then
		self.NormalSize = self.UI.Main.Size
		self.NormalPosition = self.UI.Main.Position
		self.UI.Main.Size = UDim2.new(1, -24, 1, -24)
		self.UI.Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	else
		self.UI.Main.Size = self.NormalSize
		self.UI.Main.Position = self.NormalPosition
	end
end

function MainFunctions:Minimize()
	if not self.UI.Main then
		return
	end

	self.IsMinimized = not self.IsMinimized

	if self.IsMinimized then
		self.MinimizeSize = self.UI.Main.Size
		self.UI.Main.Size = UDim2.new(self.UI.Main.Size.X.Scale, self.UI.Main.Size.X.Offset, 0, 35)

		if self.UI.Content then
			self.UI.Content.Visible = false
		end
	else
		self.UI.Main.Size = self.MinimizeSize

		if self.UI.Content then
			self.UI.Content.Visible = true
		end
	end
end

function MainFunctions:Close()
	if self.OnClose then
		self.OnClose()
		return
	end

	self:Destroy()
end

function MainFunctions:Destroy()
	for _, connection in ipairs(self.Connections) do
		connection:Disconnect()
	end

	table.clear(self.Connections)

	if self.UI.Root then
		self.UI.Root:Destroy()
	end
end

return MainFunctions
