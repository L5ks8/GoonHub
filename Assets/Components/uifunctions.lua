local UIFunctions = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local GuiService = game:GetService("GuiService")

function UIFunctions.Init(G2L, window)
    local isMinimized = false
    local originalSize = G2L["2"].Size
    local sidebarOpen = true
    local miniButtons = nil
    local miniLogo = nil
    local resizing, resizeStartPos, resizeStartSize, resizeConn

    -- Dragging Logic
    local drag, dragStart, startPos, windowDragged, windowTargetPos
    local btnDrag, btnDragStart, btnStartPos
    local btnTargetPos = UDim2.new(0, 20, 0.5, -25)
    local dragThreshold = 5
    local movedDuringDrag = false

    local isToggling = false
    local function animateToggle()
        if isToggling then return end
        isToggling = true
        
        if G2L["2"].Visible then
            -- Smooth Scale Down
            local closeTween = TweenService:Create(
                G2L["2"], 
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
                { Size = UDim2.new(0, 0, 0, 0) }
            )
            closeTween:Play()
            closeTween.Completed:Connect(function()
                G2L["2"].Visible = false
                isToggling = false
            end)
        else
            -- Smooth Scale Up
            local targetSize = isMinimized and UDim2.new(0, 260, 0, 35) or originalSize
            G2L["2"].Size = UDim2.new(0, 0, 0, 0)
            G2L["2"].Visible = true
            
            local openTween = TweenService:Create(
                G2L["2"], 
                TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
                { Size = targetSize }
            )
            openTween:Play()
            openTween.Completed:Connect(function()
                isToggling = false
            end)
        end
    end

    -- Floating Toggle Button
    local toggleBtn = Instance.new("ImageButton")
    toggleBtn.Name = "GoonToggle"
    toggleBtn.Parent = G2L["1"]
    toggleBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
    toggleBtn.Image = "rbxassetid://135630585467568"
    toggleBtn.ZIndex = 10000
    toggleBtn.AutoButtonColor = false

    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)
    
    -- Spinning Border
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Name = "SelectionStroke"
    btnStroke.Color = Color3.new(1, 1, 1)
    btnStroke.Thickness = 1.5
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Transparency = 0.5
    btnStroke.Parent = toggleBtn

    local btnGradient = Instance.new("UIGradient")
    btnGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.45, 0),
        NumberSequenceKeypoint.new(0.55, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    btnGradient.Parent = btnStroke

    task.spawn(function()
        while task.wait() and toggleBtn.Parent do
            btnGradient.Rotation = (btnGradient.Rotation + 0.5) % 360
        end
    end)

    toggleBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            btnDrag, btnDragStart, btnStartPos = true, i.Position, toggleBtn.Position
            movedDuringDrag = false
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            if drag and not resizing then
                local d = i.Position - dragStart
                if not windowDragged and d.Magnitude > dragThreshold then
                    windowDragged = true
                end

                if windowDragged then
                    windowTargetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
                end
            elseif btnDrag then
                local d = i.Position - btnDragStart
                if d.Magnitude > dragThreshold then
                    movedDuringDrag = true
                end
                btnTargetPos = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + d.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + d.Y)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            if btnDrag and not movedDuringDrag then
                animateToggle()
            end
            drag, windowDragged = false, false
            btnDrag = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if drag and windowTargetPos then
            G2L["2"].Position = G2L["2"].Position:Lerp(windowTargetPos, 0.08)
        end
        toggleBtn.Position = toggleBtn.Position:Lerp(btnTargetPos, 0.08)
    end)

    -- Keybind Toggle (RightControl)
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
            animateToggle()
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseButton1 and G2L["2"].Visible then
            if resizing then return end

            local pos = input.Position
            local onInteractive = false
            local objects = G2L["1"]:GetGuiObjectsAtPosition(pos.X, pos.Y)
            for _, obj in pairs(objects) do
                if obj:IsA("TextButton") or obj:IsA("ImageButton") or obj:IsA("TextBox") then
                    onInteractive = true
                    break
                end
            end

            if onInteractive or gpe then return end

            local absPos = G2L["2"].AbsolutePosition
            local absSize = G2L["2"].AbsoluteSize

            if pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y then
                drag, dragStart, startPos, windowDragged, windowTargetPos = true, pos, G2L["2"].Position, false, G2L["2"].Position
            end
        end
    end)

    -- Sidebar Toggle (Gelber Button)
    if G2L["80"] then
        G2L["80"].MouseButton1Click:Connect(function()
            sidebarOpen = not sidebarOpen
            TweenService:Create(G2L["16"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(0, 220, 1, 0) or UDim2.new(0, 0, 1, 0)}):Play()
            TweenService:Create(G2L["11"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(1, -235, 1, 0) or UDim2.new(1, 0, 1, 0)}):Play()
        end)
    end

    local function closeUI()
        local Notifications = GoonHub.Import("Assets/Components/notifications")
        if Notifications then
            Notifications:Notify({
                Title = "Success",
                Description = "Script successfully closed",
                Icon = "rbxassetid://135630585467568"
            })
        end

        local closeTween = TweenService:Create(
            G2L["2"], 
            TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
            { Size = UDim2.new(0, 0, 0, 0) }
        )
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

        local tween = TweenService:Create(
            G2L["2"], 
            TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
            { Size = targetSize })
        tween:Play()
        
        if isMinimized then
            -- Verstecke Original-Inhalte
            G2L["10"].Visible = false
            G2L["65"].Visible = false
            G2L["a1"].Visible = false
            G2L["b"].Visible = false
            
            -- Erstelle Kopie der Buttons auf der rechten Seite
            miniButtons = G2L["70"]:Clone()
            miniButtons.Name = "MiniButtons"
            miniButtons.Parent = G2L["5"]
            miniButtons.Size = UDim2.new(0, 85, 0, 27)
            miniButtons.AnchorPoint = Vector2.new(1, 0.5) 
            miniButtons.Position = UDim2.new(1, -15, 0, 17.5)
            miniButtons.ZIndex = 2000
            miniButtons.Visible = true
            
            -- Icons und Kreise erzwingen (Sichtbarkeit & ZIndex Fix)
            for _, child in pairs(miniButtons:GetDescendants()) do
                if child:IsA("GuiObject") then
                    child.ZIndex = miniButtons.ZIndex + 5
                    if child:IsA("ImageLabel") then
                        child.ImageTransparency = 0
                    elseif child:IsA("Frame") and child.Name ~= "MiniButtons" then
                        child.BackgroundTransparency = child.BackgroundTransparency -- behalte original
                    end
                    child.Visible = true
                end
            end

            -- Erstelle Kopie des Logos auf der linken Seite
            miniLogo = G2L["6c"]:Clone()
            miniLogo.Name = "MiniLogo"
            miniLogo.Parent = G2L["5"]
            miniLogo.AnchorPoint = Vector2.new(0, 0.5)
            miniLogo.Position = UDim2.new(0, 15, 0, 17.5)
            miniLogo.ZIndex = 2000
            miniLogo.Visible = true

            local clonedLogoText = miniLogo:FindFirstChild("logo_text")
            if clonedLogoText then
                clonedLogoText.RichText = true
                clonedLogoText.TextTransparency = 0
                clonedLogoText.Text = '<font color="rgb(248, 191, 212)">Goon</font>Hub'
                clonedLogoText.Visible = true
            end

            -- Kopie-Buttons funktionsfähig machen (mit Tweens für Konsistenz)
            if miniButtons:FindFirstChild("close") then miniButtons.close.MouseButton1Click:Connect(closeUI) end
            if miniButtons:FindFirstChild("maximize") then miniButtons.maximize.MouseButton1Click:Connect(toggleMinimize) end
            if miniButtons:FindFirstChild("sidebar_toggle") then
                miniButtons.sidebar_toggle.MouseButton1Click:Connect(function()
                    sidebarOpen = not sidebarOpen
                    TweenService:Create(G2L["16"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(0, 220, 1, 0) or UDim2.new(0, 0, 1, 0)}):Play()
                    TweenService:Create(G2L["11"], TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = sidebarOpen and UDim2.new(1, -235, 1, 0) or UDim2.new(1, 0, 1, 0)}):Play()
                end)
            end
        else
            -- Lösche Kopie und zeige Originale
            if miniButtons then miniButtons:Destroy() miniButtons = nil end
            if miniLogo then miniLogo:Destroy() miniLogo = nil end
            G2L["10"].Visible = true
            G2L["65"].Visible = true
            G2L["a1"].Visible = true
            G2L["b"].Visible = true
        end
    end

    if G2L["94"] then G2L["94"].MouseButton1Click:Connect(toggleMinimize) end

    -- Resizing
    if G2L["b"] then

        G2L["b"].Size = UDim2.new(0, 30, 0, 30)
        G2L["b"].InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                drag = false
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
            pcall(function()
                local fps = math.floor(1/RunService.RenderStepped:Wait())
                
                -- Sicherstellen, dass window und Stats existieren, bevor wir darauf zugreifen
                if window and window.Stats then
                    if window.Stats.FPS and window.Stats.FPS:IsA("TextLabel") then 
                        window.Stats.FPS.Text = "FPS: " .. fps .. "/s" 
                    end
                    if window.Stats.Ping then 
                        window.Stats.Ping.Text = math.floor(Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats.Ping:GetValue() or 0) .. " ms" 
                    end
                    if window.Stats.Memory then 
                        window.Stats.Memory.Text = string.format("%.1f MB", Stats:GetTotalMemoryUsageMb()) 
                    end
                end
                
                if G2L["time_text"] then
                    G2L["time_text"].Text = os.date("%I:%M %p")
                end
            end)
        end
    end)
end

return UIFunctions
