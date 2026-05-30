local UIFunctions = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

function UIFunctions.Init(G2L, window)
    -- Dragging
    local drag, dragStart, startPos
    if G2L["6"] then G2L["6"].InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag, dragStart, startPos = true, i.Position, G2L["2"].Position end
    end) end
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            G2L["2"].Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)

    -- Sidebar Toggle
    local sidebarOpen = true
    if G2L["80"] then G2L["80"].MouseButton1Click:Connect(function()
        sidebarOpen = not sidebarOpen
        TweenService:Create(G2L["16"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(0, 220, 1, 0) or UDim2.new(0, 0, 1, 0)}):Play()
        TweenService:Create(G2L["11"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(1, -235, 1, -30) or UDim2.new(1, -30, 1, -30)}):Play()
    end) end

    -- Close & Fullscreen
    if G2L["72"] then G2L["72"].MouseButton1Click:Connect(function() G2L["1"]:Destroy() end) end
    
    local isMaximized = false
    local originalSize = G2L["2"].Size
    if G2L["94"] then G2L["94"].MouseButton1Click:Connect(function()
        isMaximized = not isMaximized
        TweenService:Create(G2L["2"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = isMaximized and UDim2.new(1, -40, 1, -40) or originalSize}):Play()
    end) end

    -- Stats Loop
    task.spawn(function()
        while task.wait(1) and G2L["1"].Parent do
            local fps = math.floor(1/RunService.RenderStepped:Wait())
            window.Stats.FPS.Text = "FPS: " .. fps .. "/s"
            G2L["time_text"].Text = os.date("%I:%M %p")
            pcall(function()
                window.Stats.Ping.Text = math.floor(Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats.Ping:GetValue() or 0) .. " ms"
                window.Stats.Memory.Text = string.format("%.1f MB", Stats:GetTotalMemoryUsageMb())
            end)
        end
    end)
end

return UIFunctions