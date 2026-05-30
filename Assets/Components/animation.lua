local Animation = {}
local TweenService = game:GetService("TweenService")

function Animation.PlayLoading(G2L)
    local mainFrame = G2L["2"]
    local screenGui = G2L["1"]

    -- Vorbereitung: Hauptmenü unsichtbar und etwas kleiner machen für den Effekt
    mainFrame.GroupTransparency = 1
    local originalSize = mainFrame.Size
    mainFrame.Size = UDim2.new(0, originalSize.X.Offset - 80, 0, originalSize.Y.Offset - 80)

    -- Loader Container erstellen
    local loader = Instance.new("CanvasGroup")
    loader.Name = "LoaderOverlay"
    loader.Size = UDim2.new(0, 400, 0, 150)
    loader.Position = UDim2.new(0.5, 0, 0.5, 0)
    loader.AnchorPoint = Vector2.new(0.5, 0.5)
    loader.BackgroundTransparency = 1
    loader.GroupTransparency = 1
    loader.Parent = screenGui
    loader.ZIndex = 9999

    -- Logo im Loader
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(1, 0, 1, 0)
    logo.BackgroundTransparency = 1
    logo.RichText = true
    logo.Text = '<font color="rgb(248, 191, 212)">Goon</font>Hub'
    logo.TextColor3 = Color3.new(1, 1, 1)
    logo.TextSize = 50
    logo.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
    logo.Parent = loader

    -- Animations-Sequenz
    task.spawn(function()
        -- 1. Logo einfaden
        TweenService:Create(loader, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
        task.wait(1.5)

        -- 2. Logo ausfaden
        local fadeOut = TweenService:Create(loader, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {GroupTransparency = 1})
        fadeOut:Play()
        
        fadeOut.Completed:Connect(function()
            loader:Destroy()
            -- 3. Hauptmenü mit "Back"-Effekt einblenden
            TweenService:Create(mainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                GroupTransparency = 0,
                Size = originalSize
            }):Play()
        end)
    end)
end

return Animation