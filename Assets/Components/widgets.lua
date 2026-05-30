local Widgets = {}
local UI = GoonHub.Import("Assets/ui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Widgets.Init(window, G2L)
    local New, fonts = UI.New, UI.GetFonts()

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
            local secFrame = New("Frame", {Size = UDim2.new(1, -10, 0, 32), BackgroundColor3 = Color3.fromRGB(30, 30, 30), ClipsDescendants = true, LayoutOrder = self.SectionCount}, self[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, secFrame)
            New("TextLabel", {Size = UDim2.new(1, 0, 0, 32), Text = "  "..title, TextColor3 = Color3.fromRGB(248, 191, 212), FontFace = fonts.bold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1}, secFrame)
            local container = New("Frame", {Name = "container", Position = UDim2.new(0, 10, 0, 35), Size = UDim2.new(1, -20, 0, 0), BackgroundTransparency = 1}, secFrame)
            local layout = New("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, container)
            layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                secFrame.Size = UDim2.new(1, -10, 0, layout.AbsoluteContentSize.Y + 45)
            end)
            local secObj = {WidgetCount = 0}
            function secObj:CreateToggle(...) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateToggle(..., col, container, self.WidgetCount) end
            function secObj:CreateSlider(...) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateSlider(..., col, container, self.WidgetCount) end
            function secObj:CreateButton(...) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateButton(..., col, container, self.WidgetCount) end
            function secObj:CreateKeybind(...) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateKeybind(..., col, container, self.WidgetCount) end
            function secObj:CreateParagraph(...) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateParagraph(..., col, container, self.WidgetCount) end
            function secObj:CreateDropdown(...) self.WidgetCount = self.WidgetCount + 1 return tObj:CreateDropdown(..., col, container, self.WidgetCount) end
            return secObj
        end

        function tObj:CreateToggle(title, default, callback, column, overrideParent, layoutOrder)
            local cfg = type(title) == "table" and title or {Title = title, Default = default, Callback = callback, Column = column}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            local state = getgenv().NyroxToggleStates[cfg.Title] or cfg.Default
            local f = New("Frame", {Size = UDim2.new(1, -10, 0, 35), BackgroundColor3 = Color3.fromRGB(30, 30, 30), LayoutOrder = lOrder}, overrideParent or self.currentParent[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, f)
            New("TextLabel", {Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 10, 0, 0), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.med, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd}, f)
            local btnTog = New("TextButton", {Size = UDim2.new(0, 34, 0, 18), Position = UDim2.new(1, -12, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = state and Color3.fromRGB(248, 191, 212) or Color3.fromRGB(60, 60, 60), Text = ""}, f)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, btnTog)
            local circle = New("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.new(1, 1, 1)}, btnTog)
            New("UICorner", {CornerRadius = UDim.new(1, 0)}, circle)
            btnTog.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(btnTog, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(248, 191, 212) or Color3.fromRGB(60, 60, 60)}):Play()
                TweenService:Create(circle, TweenInfo.new(0.3), {Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}):Play()
                getgenv().NyroxToggleStates[cfg.Title] = state cfg.Callback(state)
            end)
            task.spawn(function() cfg.Callback(state) end)
        end

        function tObj:CreateButton(title, callback, column, overrideParent, layoutOrder)
            local cfg = type(title) == "table" and title or {Title = title, Callback = callback, Column = column}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            local bWidget = New("TextButton", {Size = UDim2.new(1, -10, 0, 32), BackgroundColor3 = Color3.fromRGB(41, 41, 41), Text = cfg.Title, TextColor3 = Color3.new(1,1,1), FontFace = fonts.bold, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = lOrder}, overrideParent or self.currentParent[col])
            New("UICorner", {CornerRadius = UDim.new(0, 6)}, bWidget)
            bWidget.MouseButton1Click:Connect(cfg.Callback)
        end

        function tObj:CreateParagraph(text, column, overrideParent, layoutOrder)
            local cfg = type(text) == "table" and text or {Text = text, Column = column}
            local col = cfg.Column or self.lastColumn
            local lOrder = layoutOrder or cfg.LayoutOrder
            return New("TextLabel", {Size = UDim2.new(1, -10, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = cfg.Text, TextColor3 = Color3.fromRGB(180, 180, 180), FontFace = fonts.reg, TextSize = 13, BackgroundTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = lOrder}, overrideParent or self.currentParent[col])
        end

        return tObj
    end

    -- Sidebar Layout Fix: Sicherstellen, dass die unteren Bereiche Platz haben
    if G2L["18"] and not G2L["18"]:FindFirstChildOfClass("UIFlexItem") then
        New("UIFlexItem", {FlexMode = Enum.UIFlexMode.None}, G2L["18"])
    end

    -- System-Tabs (Settings, About) automatisch am Ende der Initialisierung hinzufügen
    -- task.defer stellt sicher, dass sie NACH den Spiel-Tabs (Main, ESP) erscheinen
    task.defer(function()
        local settingsTab = window:CreateTab("Settings", true)
        local uiSettings = settingsTab:CreateSection("UI Settings", "Left")
        
        uiSettings:CreateButton({
            Title = "Destroy UI",
            Column = "Left",
            Callback = function() 
                if G2L["1"] then G2L["1"]:Destroy() end
            end
        })

        local aboutTab = window:CreateTab("About", true)
        local info = aboutTab:CreateSection("Information", "Left")
        
        info:CreateParagraph({
            Text = "GoonHub Version 1.0.0\nDeveloped by L5ks8",
            Column = "Left"
        })
    end)
end

return Widgets