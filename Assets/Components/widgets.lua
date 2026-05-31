local Widgets = {}
local UI = GoonHub.Import("Assets/ui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Widgets.Init(window, G2L)
    local New, fonts = UI.New, UI.GetFonts()
    getgenv().NyroxToggleStates = getgenv().NyroxToggleStates or {}

    window.Stats = {
        FPS = G2L["fps_label"] or nil,
        Ping = G2L["ping_label"] or nil,
        Memory = G2L["mem_label"] or nil
    }

    function window:CreateTab(name, isFixed)
        self.TabCount = self.TabCount + 1
        local tabIndex, iconId = self.TabCount, (name == "Home" and "11433532654") or (name == "Settings" and "11293977610") or (name == "About" and "11419720347") or "11433532654"
        
        -- Nav Button
        local parent = isFixed and G2L["19"] or G2L["4c"]
        local b = New("ImageButton", {Name = name, Size = UDim2.new(1, 0, 0, 31), BackgroundTransparency = 1, AutoButtonColor = false, LayoutOrder = tabIndex, ClipsDescendants = false}, parent)
        local item = New("Frame", {Name = "item", Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, ZIndex = 2}, b)
        local sel = New("Frame", {Name = "selector", AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.new(0.5,0,0.5,0), Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(41,41,41), BackgroundTransparency = 1, ZIndex = 0}, b)
        New("UICorner", {CornerRadius = UDim.new(0, 10)}, sel)
        local str = New("UIStroke", {Name = "SelectionStroke", Color = Color3.new(1,1,1), Thickness = 1.5, Transparency = 1, ApplyStrokeMode = "Border"}, sel)
        local gra = New("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.45, 0), NumberSequenceKeypoint.new(0.55, 0), NumberSequenceKeypoint.new(1, 1)})}, str)
        New("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 10)}, item)
        New("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}, item)
        local h = New("ImageLabel", {Name = "holder", Size = UDim2.new(0, 20, 0, 20), BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.8, ImageTransparency = 1, LayoutOrder = 1, ZIndex = 3}, item)
        New("UICorner", {CornerRadius = UDim.new(0,6)}, h)
        local ic = New("ImageLabel", {Name = "icon", Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5), Image = "rbxassetid://"..iconId, ImageTransparency = 0.5, ZIndex = 4, BackgroundTransparency = 1}, h)
        local lb = New("TextLabel", {Name = "label", Text = name, FontFace = fonts.med, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextTransparency = 0.5, BackgroundTransparency = 1, LayoutOrder = 2, ZIndex = 3, TextXAlignment = Enum.TextXAlignment.Left}, item)
        New("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill}, lb)

        task.spawn(function() while task.wait() do if not b or not b.Parent then break end gra.Rotation = (gra.Rotation + 0.1) % 360 end end)

        -- Page
        local page = New("Frame", {Name = name.."Tab", Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, LayoutOrder = tabIndex}, G2L["11"])
        local function makeCol(n, pos)
            local c = New("ScrollingFrame", {Name = n, Size = UDim2.new(0.5, -10, 1, -15), Position = pos, BackgroundTransparency = 1, ScrollBarThickness = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y}, page)
            New("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, c) return c
        end
        local leftCol, rightCol = makeCol("Left", UDim2.new(0, 10, 0, 10)), makeCol("Right", UDim2.new(0.5, 5, 0, 10))

        b.MouseButton1Click:Connect(function()
            G2L["14"]:JumpToIndex(tabIndex - 1)
            local function setBtn(bt, active)
                local s = bt:FindFirstChild("selector") 
                if s then 
                    TweenService:Create(s, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {BackgroundTransparency = active and 0 or 1, Size = active and UDim2.new(1,-12,1,-4) or UDim2.new(1,0,1,0)}):Play() 
                    local st = s:FindFirstChild("SelectionStroke") 
                    if st then TweenService:Create(st, TweenInfo.new(0.4), {Transparency = active and 0 or 1}):Play() end 
                end
                local l = bt:FindFirstChild("label", true) 
                if l then TweenService:Create(l, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {TextTransparency = active and 0 or 0.5}):Play() end
                local hld = bt:FindFirstChild("holder", true) 
                if hld then 
                    local icon = hld:FindFirstChild("icon", true) 
                    if icon then TweenService:Create(icon, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {ImageTransparency = active and 0 or 0.5}):Play() end 
                end
            end
            for _, v in pairs(G2L["4c"]:GetChildren()) do if v:IsA("ImageButton") then setBtn(v, v == b) end end
            for _, v in pairs(G2L["19"]:GetChildren()) do if v:IsA("ImageButton") then setBtn(v, v == b) end end
        end)

        if tabIndex == 1 then
            sel.BackgroundTransparency = 0
            sel.Size = UDim2.new(1, -12, 1, -4)
            str.Transparency = 0
            str.Color = Color3.new(1, 1, 1)
            lb.TextTransparency = 0
            ic.ImageTransparency = 0
        end

        local tObj = {Left = leftCol, Right = rightCol, lastColumn = "Left", currentParent = {Left = leftCol, Right = rightCol}, SectionCount = 0}

        function tObj:CreateSection(title, column)
            local col = column or self.lastColumn
            self.SectionCount = self.SectionCount + 1
            local secFrame = New("Frame", {Size = UDim2.new(1, -10, 0, 32), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(30, 30, 30), ClipsDescendants = false, LayoutOrder = self.SectionCount}, self[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, secFrame)
            New("TextLabel", {Size = UDim2.new(1, 0, 0, 32), Text = "  "..title, TextColor3 = UI.CurrentAccent, FontFace = fonts.bold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1}, secFrame)
            local container = New("Frame", {Name = "container", Position = UDim2.new(0, 10, 0, 35), Size = UDim2.new(1, -20, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1}, secFrame)
            local layout = New("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, container)
            New("UIPadding", {PaddingBottom = UDim.new(0, 10)}, container)

            local secObj = {WidgetCount = 0}
            function secObj:CreateToggle(title, default, callback) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateToggle(title, default, callback, col, container, self.WidgetCount) end
            function secObj:CreateSlider(title, min, max, default, callback) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateSlider(title, min, max, default, callback, col, container, self.WidgetCount) end
            function secObj:CreateButton(title, callback) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateButton(title, callback, col, container, self.WidgetCount) end
            function secObj:CreateKeybind(title, callback) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateKeybind(title, callback, col, container, self.WidgetCount) end
            function secObj:CreateParagraph(text) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateParagraph(text, col, container, self.WidgetCount) end
            function secObj:CreateDropdown(title, options, callback) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateDropdown(title, options, callback, col, container, self.WidgetCount) end
            return secObj
        end

        function tObj:CreateToggle(title, default, callback, column, overrideParent, layoutOrder)
            local cfg = type(title) == "table" and title or {Title = title, Default = default, Callback = callback, Column = column, SubTitle = nil}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            local state = getgenv().NyroxToggleStates[cfg.Title] or cfg.Default
            
            local hasSub = cfg.SubTitle ~= nil
            local f = New("Frame", {Size = UDim2.new(1, 0, 0, hasSub and 45 or 35), BackgroundColor3 = Color3.fromRGB(30, 30, 30), LayoutOrder = lOrder}, overrideParent or self.currentParent[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, f)
            
            if hasSub then
                New("TextLabel", {Size = UDim2.new(1, -50, 0, 16), Position = UDim2.new(0, 10, 0, 6), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.med, TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd}, f)
                New("TextLabel", {Size = UDim2.new(1, -50, 0, 14), Position = UDim2.new(0, 10, 0, 22), Text = cfg.SubTitle, TextColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.reg, TextSize = 10, TextTruncate = Enum.TextTruncate.AtEnd}, f)
            else
                New("TextLabel", {Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 10, 0, 0), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.med, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd}, f)
            end

            local btnTog = New("TextButton", {Size = UDim2.new(0, 34, 0, 18), Position = UDim2.new(1, -12, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = state and UI.CurrentAccent or Color3.fromRGB(45, 45, 45), Text = "", AutoButtonColor = false}, f)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, btnTog)
            local circle = New("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.new(1, 1, 1)}, btnTog)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, circle)

            -- Hover Animation (Spinning Stroke nur auf dem Knopf rechts)
            local sel = New("Frame", {Name = "selector", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 10}, btnTog)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, sel)
            local str = New("UIStroke", {Color = Color3.new(1, 1, 1), Thickness = 1.5, Transparency = 1, ApplyStrokeMode = "Border"}, sel)
            local gra = New("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.45, 0), NumberSequenceKeypoint.new(0.55, 0), NumberSequenceKeypoint.new(1, 1)})}, str)

            task.spawn(function()
                while task.wait() do
                    if not btnTog or not btnTog.Parent then break end
                    gra.Rotation = (gra.Rotation + 1) % 360
                end
            end)

            f.MouseEnter:Connect(function()
                TweenService:Create(str, TweenInfo.new(0.3), {Transparency = 0.5}):Play()
            end)
            f.MouseLeave:Connect(function()
                TweenService:Create(str, TweenInfo.new(0.3), {Transparency = 1}):Play()
            end)

            btnTog.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(btnTog, TweenInfo.new(0.3), {BackgroundColor3 = state and UI.CurrentAccent or Color3.fromRGB(45, 45, 45)}):Play()
                TweenService:Create(circle, TweenInfo.new(0.3), {Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}):Play()
                getgenv().NyroxToggleStates[cfg.Title] = state 
                if cfg.Callback then cfg.Callback(state) end
            end)
            
            if cfg.Callback then
                task.spawn(function() cfg.Callback(state) end)
            end
        end

        function tObj:CreateSlider(title, min, max, default, callback, column, overrideParent, layoutOrder)
            local cfg = type(title) == "table" and title or {Title = title, Min = min, Max = max, Default = default, Callback = callback, Column = column}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            
            local f = New("Frame", {Size = UDim2.new(1, 0, 0, 45), BackgroundColor3 = Color3.fromRGB(30, 30, 30), LayoutOrder = lOrder}, overrideParent or self.currentParent[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, f)
            
            local titleLabel = New("TextLabel", {Size = UDim2.new(1, -60, 0, 25), Position = UDim2.new(0, 10, 0, 0), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.med, TextSize = 13}, f)
            local valueLabel = New("TextBox", {Size = UDim2.new(0, 50, 0, 25), Position = UDim2.new(1, -10, 0, 0), AnchorPoint = Vector2.new(1, 0), Text = tostring(cfg.Default), TextColor3 = UI.CurrentAccent, BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right, FontFace = fonts.bold, TextSize = 13, ClearTextOnFocus = false, ZIndex = 10}, f)
            
            local sliderBg = New("Frame", {Size = UDim2.new(1, -20, 0, 4), Position = UDim2.new(0.5, 0, 0.5, 10), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, f)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, sliderBg)
            
            local sliderFill = New("Frame", {Size = UDim2.new(math.clamp((cfg.Default - cfg.Min) / (cfg.Max - cfg.Min), 0, 1), 0, 1, 0), BackgroundColor3 = UI.CurrentAccent}, sliderBg)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, sliderFill)

            local sliderTrigger = New("TextButton", {Size = UDim2.new(1, -20, 0, 20), Position = UDim2.new(0.5, 0, 0.5, 10), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Text = "", AutoButtonColor = false}, f)

            valueLabel.FocusLost:Connect(function()
                local val = tonumber(valueLabel.Text)
                if val then
                    val = math.clamp(val, cfg.Min, cfg.Max)
                    valueLabel.Text = tostring(val)
                    sliderFill.Size = UDim2.new(math.clamp((val - cfg.Min) / (cfg.Max - cfg.Min), 0, 1), 0, 1, 0)
                    cfg.Callback(val)
                else
                    valueLabel.Text = tostring(math.floor(cfg.Min + (sliderFill.Size.X.Scale * (cfg.Max - cfg.Min))))
                end
            end)
            
            local function update(input)
                local pos = math.clamp((input.Position.X - sliderTrigger.AbsolutePosition.X) / sliderTrigger.AbsoluteSize.X, 0, 1)
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                local value = math.floor(cfg.Min + (pos * (cfg.Max - cfg.Min)))
                valueLabel.Text = tostring(value)
                cfg.Callback(value)
            end
            
            local dragging = false
            sliderTrigger.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    update(input)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)

            task.spawn(function() cfg.Callback(cfg.Default) end)
        end

        function tObj:CreateButton(title, callback, column, overrideParent, layoutOrder)
            local cfg = type(title) == "table" and title or {Title = title, Callback = callback, Column = column, SubTitle = nil}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            
            local hasSub = cfg.SubTitle ~= nil
            local bWidget = New("TextButton", {Size = UDim2.new(1, 0, 0, hasSub and 45 or 32), BackgroundColor3 = Color3.fromRGB(41, 41, 41), Text = hasSub and "" or cfg.Title, TextColor3 = Color3.new(1,1,1), FontFace = fonts.bold, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = lOrder, AutoButtonColor = false}, overrideParent or self.currentParent[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, bWidget)
            
            if hasSub then
                New("TextLabel", {Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 0, 8), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Center, FontFace = fonts.bold, TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd}, bWidget)
                New("TextLabel", {Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 24), Text = cfg.SubTitle, TextColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Center, FontFace = fonts.reg, TextSize = 10, TextTruncate = Enum.TextTruncate.AtEnd}, bWidget)
            end
            
            bWidget.MouseButton1Click:Connect(cfg.Callback)
        end

        function tObj:CreateParagraph(text, column, overrideParent, layoutOrder)
            local cfg = type(text) == "table" and text or {Text = text, Column = column}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            return New("TextLabel", {Size = UDim2.new(1, -10, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = cfg.Text, TextColor3 = Color3.fromRGB(180, 180, 180), FontFace = fonts.reg, TextSize = 13, BackgroundTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = lOrder}, overrideParent or self.currentParent[col])
        end

        function tObj:CreateDropdown(title, options, callback, column, overrideParent, layoutOrder)
            local cfg = type(title) == "table" and title or {Title = title, Options = options, Callback = callback, Column = column}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            local dropped = false
            local selected = cfg.Default or cfg.Options[1] or "None"
            
            local f = New("Frame", {Size = UDim2.new(1, 0, 0, 45), BackgroundColor3 = Color3.fromRGB(30, 30, 30), LayoutOrder = lOrder, ClipsDescendants = true}, overrideParent or self.currentParent[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, f)
            New("TextLabel", {Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 10, 0, 1), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.med, TextSize = 13}, f)
            
            local btn = New("TextButton", {Size = UDim2.new(1, -20, 0, 22), Position = UDim2.new(0, 10, 0, 20), BackgroundColor3 = Color3.fromRGB(40, 40, 40), Text = "  " .. selected, TextColor3 = UI.CurrentAccent, FontFace = fonts.bold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, AutoButtonColor = false}, f)
            New("UICorner", {CornerRadius = UDim.new(0, 4)}, btn)
            local arrow = New("TextLabel", {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(1, -25, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), Text = "▼", BackgroundTransparency = 1, TextColor3 = UI.CurrentAccent, TextSize = 12}, btn)
            
            local list = New("ScrollingFrame", {Name = "list", Position = UDim2.new(0, 10, 0, 45), Size = UDim2.new(1, -20, 1, -50), BackgroundTransparency = 1, Visible = false, ScrollBarThickness = 2, ScrollBarImageColor3 = UI.CurrentAccent, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0,0,0,0)}, f)
            local listLayout = New("UIListLayout", {Padding = UDim.new(0, 5)}, list)
            
            for _, opt in pairs(cfg.Options) do
                local optBtn = New("TextButton", {Size = UDim2.new(1, 0, 0, 25), BackgroundColor3 = Color3.fromRGB(35, 35, 35), Text = opt, TextColor3 = Color3.new(0.8, 0.8, 0.8), FontFace = fonts.reg, TextSize = 12, AutoButtonColor = false}, list)
                New("UICorner", {CornerRadius = UDim.new(0, 4)}, optBtn)
                optBtn.MouseButton1Click:Connect(function()
                    selected = opt 
                    btn.Text = "  " .. opt 
                    dropped = false 
                    list.Visible = false
                    if self.currentParent[col] then self.currentParent[col].ScrollingEnabled = true end
                    
                    TweenService:Create(f, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 45)}):Play()
                    TweenService:Create(arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Rotation = 0}):Play()
                    if cfg.Callback then cfg.Callback(opt) end
                end)
            end
            
            btn.MouseButton1Click:Connect(function()
                dropped = not dropped
                list.Visible = dropped
                if self.currentParent[col] then self.currentParent[col].ScrollingEnabled = not dropped end
                
                local targetHeight = dropped and math.min(listLayout.AbsoluteContentSize.Y + 53, 200) or 45
                TweenService:Create(f, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
                TweenService:Create(arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Rotation = dropped and 180 or 0}):Play()
            end)
        end

        return tObj
    end


    if G2L["18"] and not G2L["18"]:FindFirstChildOfClass("UIFlexItem") then
        New("UIFlexItem", {FlexMode = Enum.UIFlexMode.None}, G2L["18"])
    end


    task.defer(function()
        local Theme = GoonHub.Import("Assets/Config/themes")
        local savedTheme = Theme and Theme.Load() or "Dark"
        
        local settingsTab = window:CreateTab("Settings", true)
        local themeSection = settingsTab:CreateSection("Themes", "Left")
        themeSection:CreateDropdown({
            Title = "Theme",
            Options = {"Dark", "Light", "Blue", "Halloween", "Red", "Purple", "Midnight", "Ocean", "Rose", "Emerald", "Amber", "Sakura", "Cyberpunk", "Forest"},
            Default = savedTheme,
            Callback = function(value)
                UI.SetTheme(G2L, value)
                if Theme then Theme.Save(value) end
            end
        })

        local aboutTab = window:CreateTab("About", true)
        local info = aboutTab:CreateSection("Information", "Left")
        
        info:CreateParagraph({
            Text = "GoonHub Version 1.0.0",
            Column = "Left"
        })
        info:CreateParagraph({
            Text = "Developed by L5ks8",
            Column = "Left"
        })

        UI.SetTheme(G2L, savedTheme)
    end)
end

return Widgets