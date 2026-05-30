local UIFunctions = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

function UIFunctions.Init(G2L, window)
    local isMinimized = false
    local originalSize = G2L["2"].Size
    local sidebarOpen = true
    local miniButtons = nil

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
            sidebarOpen = not sidebarOpen
            TweenService:Create(G2L["16"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(0, 220, 1, 0) or UDim2.new(0, 0, 1, 0)}):Play()
            TweenService:Create(G2L["11"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(1, -235, 1, 0) or UDim2.new(1, 0, 1, 0)}):Play()
        end)
    end

    -- Hilfsfunktion für Schließen
    local function closeUI()
        local closeTween = TweenService:Create(G2L["2"], TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            GroupTransparency = 1,
            Size = UDim2.new(0, G2L["2"].Size.X.Offset - 100, 0, G2L["2"].Size.Y.Offset - 100),
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            G2L["1"]:Destroy() 
        end)
    end

    -- Close
    if G2L["72"] then 
        G2L["72"].MouseButton1Click:Connect(closeUI) 
    end

    -- Minimize
    local function toggleMinimize()
        isMinimized = not isMinimized
        local targetSize = isMinimized and UDim2.new(0, 260, 0, 35) or originalSize
        
        local tween = TweenService:Create(G2L["2"], TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize})
        tween:Play()
        
        if isMinimized then
            -- Verstecke Original-Inhalte
            G2L["10"].Visible = false
            G2L["a1"].Visible = false
            G2L["b"].Visible = false
            
            -- Erstelle Kopie der Buttons neben der Drag-Leiste
            miniButtons = G2L["70"]:Clone()
            miniButtons.Parent = G2L["5"]
            miniButtons.AnchorPoint = Vector2.new(0, 0.5)
            miniButtons.Position = UDim2.new(0.5, 45, 0, 17.5) -- Rechts neben der Drag-Leiste (Mitte von 35px)
            
            -- Kopie-Buttons funktionsfähig machen
            miniButtons:FindFirstChild("close").MouseButton1Click:Connect(closeUI)
            miniButtons:FindFirstChild("maximize").MouseButton1Click:Connect(toggleMinimize)
            miniButtons:FindFirstChild("sidebar_toggle").MouseButton1Click:Connect(function()
                sidebarOpen = not sidebarOpen
                G2L["16"].Size = sidebarOpen and UDim2.new(0, 220, 1, 0) or UDim2.new(0, 0, 1, 0)
                G2L["11"].Size = sidebarOpen and UDim2.new(1, -235, 1, 0) or UDim2.new(1, 0, 1, 0)
            end)
        else
            -- Lösche Kopie und zeige Originale
            if miniButtons then miniButtons:Destroy() miniButtons = nil end
            G2L["10"].Visible = true
            G2L["a1"].Visible = true
            G2L["b"].Visible = true
        end
    end

    if G2L["94"] then G2L["94"].MouseButton1Click:Connect(toggleMinimize) end

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
                        if not isMinimized then originalSize = G2L["2"].Size end
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