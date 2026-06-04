-- Instances: 18 | Scripts: 0 | Modules: 0 | Tags: 1
local module = {}
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UI = GoonHub.Import("Assets/ui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GoonNotifications"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = (gethui and gethui()) or LP:WaitForChild("PlayerGui")

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 300, 1, -40)
Container.Position = UDim2.new(1, -310, 0, 20)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

function module:Notify(data)
	local title = data.Title or "Notification"
	local desc = data.Description or ""
	local icon = data.Icon or "rbxassetid://135630585467568"
	local duration = data.Duration or 5

	local Banner = Instance.new("CanvasGroup")
	Banner.Name = "Banner"
	Banner.BackgroundColor3 = UI.CurrentMain or Color3.fromRGB(37, 37, 37)
	Banner.BorderSizePixel = 0
	Banner.AutomaticSize = Enum.AutomaticSize.XY
	Banner.GroupTransparency = 1
	Banner.LayoutOrder = -os.clock() * 1000
	Banner.Parent = Container

	Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 15)

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 2
	Stroke.Color = UI.CurrentAccent
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	Stroke.Transparency = 0.6
	Stroke.Parent = Banner

	local Padding = Instance.new("UIPadding")
	Padding.PaddingTop = UDim.new(0, 15)
	Padding.PaddingBottom = UDim.new(0, 15)
	Padding.PaddingLeft = UDim.new(0, 20)
	Padding.PaddingRight = UDim.new(0, 20)
	Padding.Parent = Banner

	local List = Instance.new("UIListLayout")
	List.FillDirection = Enum.FillDirection.Horizontal
	List.Padding = UDim.new(0, 14)
	List.VerticalAlignment = Enum.VerticalAlignment.Center
	List.Parent = Banner

	local holder = Instance.new("ImageLabel")
	holder.Name = "holder"
	holder.Size = UDim2.new(0, 32, 0, 32)
	holder.BackgroundTransparency = 0.8
	holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	holder.ImageTransparency = 1
	holder.Parent = Banner

	Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)

	local iconLabel = Instance.new("ImageLabel")
	iconLabel.Name = "icon"
	iconLabel.Size = UDim2.new(0, 20, 0, 20)
	iconLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	iconLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Image = icon
	iconLabel.Parent = holder

	local information = Instance.new("Frame")
	information.Name = "information"
	information.BackgroundTransparency = 1
	information.AutomaticSize = Enum.AutomaticSize.XY
	information.Parent = Banner

	local infolist = Instance.new("UIListLayout")
	infolist.Padding = UDim.new(0, 2)
	infolist.SortOrder = Enum.SortOrder.LayoutOrder
	infolist.Parent = information

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "title"
	titleLabel.Text = title
	titleLabel.TextColor3 = UI.CurrentAccent
	titleLabel.TextSize = 15
	titleLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium)
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.BackgroundTransparency = 1
	titleLabel.AutomaticSize = Enum.AutomaticSize.XY
	titleLabel.Parent = information

	local descLabel = Instance.new("TextLabel")
	descLabel.Name = "description"
	descLabel.Text = desc
	descLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	descLabel.TextTransparency = 0.5
	descLabel.TextSize = 12
	descLabel.FontFace = Font.new("rbxassetid://12187365364")
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.BackgroundTransparency = 1
	descLabel.AutomaticSize = Enum.AutomaticSize.XY
	descLabel.Parent = information

	-- Slide-in Animation
	Banner.Position = UDim2.new(1, 100, 0, 0)
	
	TweenService:Create(Banner, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0),
		GroupTransparency = 0
	}):Play()

	task.delay(duration, function()
		local fade = TweenService:Create(Banner, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 100, 0, 0),
			GroupTransparency = 1
		})
		fade:Play()
		fade.Completed:Wait()
		Banner:Destroy()
	end)
end

return module