local UI = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function UI.New(class, props, parent)
    local i = Instance.new(class)
    for k, v in pairs(props) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end

function UI.GetFonts()
    return {
        reg = Font.new("rbxassetid://12187365364"),
        bold = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold),
        med = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium),
        logo = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
    }
end

function UI.CreateBase(title, versionText)
    local New = UI.New
    local fonts = UI.GetFonts()
    local G2L = {}

    local targetParent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
    if targetParent:FindFirstChild("GoonHub") then targetParent.GoonHub:Destroy() end

    G2L["1"] = New("ScreenGui", {IgnoreGuiInset = true, Name = "GoonHub", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, targetParent)
    G2L["2"] = New("CanvasGroup", {BackgroundColor3 = Color3.fromRGB(36, 36, 36), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0, 700, 0, 465), Position = UDim2.new(0.5, 0, 0.5, 0), Name = "Main", ClipsDescendants = true}, G2L["1"])
    New("UICorner", {CornerRadius = UDim.new(0, 18)}, G2L["2"])
    New("UIStroke", {Transparency = 0.75, Thickness = 2}, G2L["2"])

    G2L["4"] = New("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Name = "panel"}, G2L["2"])
    G2L["5"] = New("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 999, Name = "controls"}, G2L["4"])
    G2L["6"] = New("ImageButton", {Size = UDim2.new(0, 70, 0, 35), Position = UDim2.new(0.5, 0, 0, 0), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Name = "drag"}, G2L["5"])
    local bar = New("Frame", {BackgroundColor3 = Color3.fromRGB(150, 150, 150), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(1, 0, 0, 5), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0.3}, G2L["6"])
    New("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)

    -- Resize Handle
    G2L["b"] = New("ImageButton", {Size = UDim2.new(0, 35, 0, 35), Position = UDim2.new(1, -8, 1, -8), AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, ZIndex = 1005, Name = "resize"}, G2L["5"])
    New("ImageLabel", {Size = UDim2.new(1,0,1,0), Image = "rbxassetid://88780680171023", ImageColor3 = Color3.fromRGB(91, 91, 91), BackgroundTransparency = 1}, G2L["b"])

    G2L["10"] = New("Frame", {Size = UDim2.new(1, 0, 1, -35), Position = UDim2.new(0.5, 0, 1, 0), AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, Name = "content"}, G2L["4"])
    New("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 35), PaddingRight = UDim.new(0, 15)}, G2L["10"])

    G2L["65"] = New("ImageButton", {Size = UDim2.new(1, 0, 0, 35), Position = UDim2.new(0, 0, 0, -35), BackgroundTransparency = 1, Name = "topbar", ZIndex = 1001}, G2L["10"])
    New("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)}, G2L["65"])
    New("UIPadding", {PaddingLeft = UDim.new(0, 15), PaddingRight = UDim.new(0, 15)}, G2L["65"])

    G2L["6e"] = New("Frame", {Size = UDim2.new(0, 85, 1, 0), BackgroundTransparency = 1, Name = "actions", LayoutOrder = 1}, G2L["65"])
    local space = New("Frame", {Name = "space", BackgroundTransparency = 1, LayoutOrder = 2}, G2L["65"])
    New("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill}, space)

    G2L["6c"] = New("Frame", {AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 1, Name = "logo", LayoutOrder = 3}, G2L["65"])
    G2L["logo_text"] = New("TextLabel", {AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Text = string.format("<font color=\"rgb(248, 191, 212)\">Goon</font>Hub <font color=\"rgb(150,150,150)\" size=\"12\">%s</font>", versionText), RichText = true, FontFace = fonts.logo, TextSize = 21, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center}, G2L["6c"])
    G2L["weather"] = New("ImageLabel", {Size = UDim2.new(0, 21, 0, 21), Image = "rbxassetid://13056160366", BackgroundTransparency = 1, Name = "weather", LayoutOrder = 4}, G2L["65"])

    G2L["70"] = New("Frame", {Size = UDim2.new(1, 0, 0, 27), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(25, 25, 25)}, G2L["6e"])
    New("UICorner", {CornerRadius = UDim.new(1, 0)}, G2L["70"])
    New("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 4)}, G2L["70"])
    New("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4)}, G2L["70"])
    local function CreateTopButton(name, color, iconId, lo)
        local b = New("ImageButton", {Name = name, Size = UDim2.new(0, 22, 0, 22), BackgroundTransparency = 1, LayoutOrder = lo}, G2L["70"])
        local f = New("Frame", {Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1}, b)
        local c = New("ImageLabel", {Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5), BackgroundColor3 = color, ImageTransparency = 1, BackgroundTransparency = 0}, f)
        New("UICorner", {CornerRadius = UDim.new(1,0)}, c)
        local i = New("ImageLabel", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5), ImageTransparency = 0, BackgroundTransparency = 1, ZIndex = 1002}, f)
        New("UIStroke", {Transparency = 0.9, Color = Color3.new(1,1,1)}, i) 
        New("UICorner", {CornerRadius = UDim.new(1,0)}, i)
        New("ImageLabel", {Size = UDim2.new(0, 8, 0, 8), Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5), Image = "rbxassetid://"..iconId, ImageColor3 = Color3.new(0,0,0), ImageTransparency = 0, ZIndex = 1003, BackgroundTransparency = 1}, f)
        return b
    end

    G2L["72"] = CreateTopButton("close", Color3.fromRGB(255, 51, 51), "109757326745560", 1)
    G2L["80"] = CreateTopButton("sidebar_toggle", Color3.fromRGB(226, 183, 26), "4773248567", 2)
    G2L["94"] = CreateTopButton("maximize", Color3.fromRGB(122, 214, 3), "11295291707", 3)

    G2L["11"] = New("Frame", {Size = UDim2.new(1, -235, 1, 0), Position = UDim2.new(1, 0, 1, 0), AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(21, 21, 21), BackgroundTransparency = 0.7, ClipsDescendants = true, Name = "screen"}, G2L["10"])
    New("UICorner", {CornerRadius = UDim.new(0, 12)}, G2L["11"])
    G2L["14"] = New("UIPageLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Animated = true}, G2L["11"])

    G2L["16"] = New("Frame", {Size = UDim2.new(0, 220, 1, 0), BackgroundTransparency = 1, Name = "bar", ClipsDescendants = true}, G2L["10"])
    New("UIListLayout", {Padding = UDim.new(0, 7), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, G2L["16"])

    G2L["4b"] = New("Frame", {Size = UDim2.new(1, -22, 0, 0), BackgroundColor3 = Color3.fromRGB(9, 9, 9), BackgroundTransparency = 0.7, LayoutOrder = 3}, G2L["16"])
    New("UICorner", {CornerRadius = UDim.new(0, 15)}, G2L["4b"]) New("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill}, G2L["4b"])
    G2L["4c"] = New("ScrollingFrame", {Size = UDim2.new(1, 0, 1, -16), Position = UDim2.new(0, 0, 0, 8), BackgroundTransparency = 1, ScrollBarThickness = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y, Name = "navigation"}, G2L["4b"])
    New("UIListLayout", {Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, G2L["4c"])
    New("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 2)}, G2L["4c"])

    G2L["18"] = New("Frame", {Size = UDim2.new(1, -22, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Name = "anchored_buttons", LayoutOrder = 5}, G2L["16"])
    G2L["19"] = New("Frame", {BackgroundColor3 = Color3.fromRGB(9, 9, 9), BackgroundTransparency = 0.7, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Name = "main"}, G2L["18"])
    New("UICorner", {CornerRadius = UDim.new(0, 12)}, G2L["19"])
    New("UIPadding", {PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)}, G2L["19"])
    New("UIListLayout", {Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, G2L["19"])

    G2L["38"] = New("ImageButton", {Size = UDim2.new(1, -22, 0, 48), BackgroundColor3 = Color3.fromRGB(9, 9, 9), BackgroundTransparency = 0.7, LayoutOrder = 10, Name = "user", AutoButtonColor = false}, G2L["16"])
    New("UICorner", {CornerRadius = UDim.new(0, 15)}, G2L["38"])
    New("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 10), Wraps = false}, G2L["38"])
    New("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 35)}, G2L["38"])

    local p = New("Frame", {Size = UDim2.new(0, 26, 0, 26), BackgroundTransparency = 1, Name = "profile"}, G2L["38"])
    G2L["avatar"] = New("ImageLabel", {Size = UDim2.new(0, 26, 0, 26), Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150", BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(36, 36, 36)}, p)
    New("UICorner", {CornerRadius = UDim.new(1, 0)}, G2L["avatar"])

    local info = New("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 1, Name = "info"}, G2L["38"])
    New("UIListLayout", {VerticalAlignment = Enum.VerticalAlignment.Center}, info) New("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill}, info)
    G2L["display_name"] = New("TextLabel", {Size = UDim2.new(1, 0, 0, 15), Text = LocalPlayer.DisplayName, FontFace = fonts.bold, TextSize = 13, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, info)
    G2L["user_name"] = New("TextLabel", {Size = UDim2.new(1, 0, 0, 10), Text = "@"..LocalPlayer.Name, FontFace = fonts.reg, TextSize = 11, TextColor3 = Color3.new(0.6,0.6,0.6), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, info)

    local tBox = New("ImageButton", {Size = UDim2.new(0, 40, 0, 20), BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.8, Name = "time", AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X}, G2L["38"])
    New("UICorner", {CornerRadius = UDim.new(0, 4)}, tBox) New("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, tBox)
    G2L["time_text"] = New("TextLabel", {Size = UDim2.new(1, 0, 1, 0), Text = "00:00 PM", FontFace = fonts.reg, TextSize = 12, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, TextTransparency = 0.2, AutomaticSize = Enum.AutomaticSize.X}, tBox)

    G2L["a1"] = New("Frame", {Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 1, 0), AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.9, Name = "debug"}, G2L["4"])
    New("UIStroke", {Color = Color3.fromRGB(46, 46, 46)}, G2L["a1"])
    New("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 15)}, G2L["a1"])
    New("UIPadding", {PaddingLeft = UDim.new(0, 18)}, G2L["a1"])

    local function CreateStat(txt, color)
        local f = New("Frame", {AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1}, G2L["a1"])
        New("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4)}, f)
        New("TextLabel", {Text = txt, TextColor3 = color or Color3.fromRGB(255, 255, 81), FontFace = fonts.med, TextSize = 12, BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X}, f)
        return New("TextLabel", {Text = "--", TextColor3 = Color3.new(1,1,1), FontFace = fonts.med, TextSize = 12, BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X}, f)
    end

    G2L["mem_label"] = CreateStat("Memory Usage:")
    G2L["ping_label"] = CreateStat("Avg. Ping:")
    G2L["fps_label"] = New("TextLabel", {Name = "fps", Text = "FPS: --", FontFace = fonts.med, TextSize = 12, TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.XY}, G2L["a1"])

    return G2L
end

return UI
