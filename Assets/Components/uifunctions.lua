local UIFunctions = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

function UIFunctions.Init(G2L, window)
    local isMinimized = false
    local isMaximized = false
    local lastSize = G2L["2"].Size
    local originalSize = G2L["2"].Size
    local sidebarOpen = true

    -- Originale Button-Positionen speichern
    local origRedPos = G2L["72"] and G2L["72"].Position
    local origYellowPos = G2L["80"] and G2L["80"].Position
    local origGreenPos = G2L["94"] and G2L["94"].Position

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

    -- Sidebar Toggle (Gelber Button)
    if G2L["80"] then
        G2L["80"].MouseButton1Click:Connect(function()
            if isMinimized then return end
            sidebarOpen = not sidebarOpen
            TweenService:Create(G2L["16"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(0, 220, 1, 0) or UDim2.new(0, 0, 1, 0)}):Play()
            TweenService:Create(G2L["11"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(1, -235, 1, 0) or UDim2.new(1, 0, 1, 0)}):Play()
        end)
    end

    -- Close & Fullscreen
    if G2L["72"] then G2L["72"].MouseButton1Click:Connect(function() G2L["1"]:Destroy() end) end
    
    -- Minimize Toggle (Grüner Button)
    if G2L["94"] then 
        G2L["94"].MouseButton1Click:Connect(function()
            if not isMinimized then
                isMinimized = true
                -- Nur speichern, wenn das Fenster tatsächlich groß ist
                if G2L["2"].Size.Y.Offset > 40 then
                    lastSize = G2L["2"].Size
                end
                TweenService:Create(G2L["2"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 220, 0, 40)}):Play()
                
                -- Buttons nach links schieben beim Minimieren
                if G2L["72"] then TweenService:Create(G2L["72"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 15, 0.5, 0)}):Play() end
                if G2L["80"] then TweenService:Create(G2L["80"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 40, 0.5, 0)}):Play() end
                if G2L["94"] then TweenService:Create(G2L["94"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 65, 0.5, 0)}):Play() end

                G2L["11"].Visible = false
                G2L["16"].Visible = false
                G2L["a1"].Visible = false
                if G2L["b"] then G2L["b"].Visible = false end
                if G2L["time_text"] then G2L["time_text"].Visible = false end
            else
                isMinimized = false
                TweenService:Create(G2L["2"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = lastSize or originalSize}):Play()
                
                -- Buttons zurück an ihre originale Position schieben
                if G2L["72"] then TweenService:Create(G2L["72"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = origRedPos}):Play() end
                if G2L["80"] then TweenService:Create(G2L["80"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = origYellowPos}):Play() end
                if G2L["94"] then TweenService:Create(G2L["94"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = origGreenPos}):Play() end

                G2L["11"].Visible = true
                G2L["16"].Visible = true
                G2L["a1"].Visible = true
                if G2L["b"] then G2L["b"].Visible = true end
                if G2L["time_text"] then G2L["time_text"].Visible = true end
            end
        end) 
    end

    -- Resizing
    local resizing, resizeStartPos, resizeStartSize, resizeConn
    if G2L["b"] then
        G2L["b"].InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing, resizeStartPos, resizeStartSize = true, input.Position, G2L["2"].AbsoluteSize
                resizeConn = UserInputService.InputChanged:Connect(function(move)
                    if move.UserInputType == Enum.UserInputType.MouseMovement then
                        local delta = move.Position - resizeStartPos
                        G2L["2"].Size = UDim2.new(0, math.clamp(resizeStartSize.X + delta.X, 500, 1200), 0, math.clamp(resizeStartSize.Y + delta.Y, 350, 800))
                        if not isMaximized then originalSize = G2L["2"].Size end
                    end
                end)
            end
        end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 and resizing then resizing = false if resizeConn then resizeConn:Disconnect() end end end)
    end

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