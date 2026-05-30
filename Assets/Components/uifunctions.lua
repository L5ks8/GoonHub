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

    -- Originale Button-Daten speichern
    local origRedPos, origYellowPos, origGreenPos
    local origRedAnchor, origYellowAnchor, origGreenAnchor
    
    local function saveOriginals()
        if G2L["72"] and not origRedPos then origRedPos, origRedAnchor = G2L["72"].Position, G2L["72"].AnchorPoint end
        if G2L["80"] and not origYellowPos then origYellowPos, origYellowAnchor = G2L["80"].Position, G2L["80"].AnchorPoint end
        if G2L["94"] and not origGreenPos then origGreenPos, origGreenAnchor = G2L["94"].Position, G2L["94"].AnchorPoint end
    end
    saveOriginals()

    local topBarLayout = G2L["6"] and G2L["6"]:FindFirstChildOfClass("UIListLayout")

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
            saveOriginals()
            if not isMinimized then
                isMinimized = true
                if topBarLayout then topBarLayout.Enabled = false end
                
                if G2L["2"].Size.Y.Offset > 40 then
                    lastSize = G2L["2"].Size
                end
                
                -- Fenster verkleinern
                TweenService:Create(G2L["2"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 220, 0, 40)}):Play()
                
                -- Buttons sichtbar machen und nach links schieben
                local btnIds = {"72", "80", "94"}
                for i, id in ipairs(btnIds) do
                    if G2L[id] then
                        G2L[id].Visible = true
                        G2L[id].ZIndex = 100
                        G2L[id].AnchorPoint = Vector2.new(0, 0.5)
                        TweenService:Create(G2L[id], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 15 + (i-1)*25, 0.5, 0)}):Play()
                    end
                end

                local hideElements = {"11", "16", "a1", "b", "time_text"}
                for _, id in ipairs(hideElements) do
                    if G2L[id] then G2L[id].Visible = false end
                end
            else
                isMinimized = false
                if topBarLayout then topBarLayout.Enabled = true end
                
                TweenService:Create(G2L["2"], TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = lastSize or originalSize}):Play()
                
                if G2L["72"] then G2L["72"].AnchorPoint = origRedAnchor or Vector2.new(0, 0.5) TweenService:Create(G2L["72"], TweenInfo.new(0.4), {Position = origRedPos}):Play() end
                if G2L["80"] then G2L["80"].AnchorPoint = origYellowAnchor or Vector2.new(0, 0.5) TweenService:Create(G2L["80"], TweenInfo.new(0.4), {Position = origYellowPos}):Play() end
                if G2L["94"] then G2L["94"].AnchorPoint = origGreenAnchor or Vector2.new(0, 0.5) TweenService:Create(G2L["94"], TweenInfo.new(0.4), {Position = origGreenPos}):Play() end

                local showElements = {"11", "16", "a1", "b", "time_text"}
                for _, id in ipairs(showElements) do
                    if G2L[id] then G2L[id].Visible = true end
                end
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
            if window.Stats.FPS then window.Stats.FPS.Text = "FPS: " .. fps .. "/s" end
            if G2L["time_text"] then G2L["time_text"].Text = os.date("%I:%M %p") end
            pcall(function()
                if window.Stats.Ping then window.Stats.Ping.Text = math.floor(Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats.Ping:GetValue() or 0) .. " ms" end
                if window.Stats.Memory then window.Stats.Memory.Text = string.format("%.1f MB", Stats:GetTotalMemoryUsageMb()) end
            end)
        end
    end)
end

return UIFunctions