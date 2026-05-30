local Animation = {}
local TweenService = game:GetService("TweenService")

function Animation.PlayLoading(G2L)
    local mainFrame = G2L["2"]
    local screenGui = G2L["1"]
    local mainStroke = G2L["main_stroke"] -- Referenz auf den Stroke des Hauptmenüs

    -- Vorbereitung: Hauptmenü unsichtbar und etwas kleiner machen für den Effekt
    mainFrame.GroupTransparency = 1
    local originalSize = mainFrame.Size
    mainFrame.Size = UDim2.new(0, originalSize.X.Offset - 80, 0, originalSize.Y.Offset - 80)

    -- Stroke des Hauptmenüs während des Ladens ausblenden
    if mainStroke then
        mainStroke.Transparency = 1
    end

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

    -- Blur Effekt hinzufügen
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Parent = game.Lighting -- BlurEffect gehört in Lighting oder Camera
    blurEffect.Size = 0 -- Start mit keiner Unschärfe

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

    -- Loading Bar
    local loadingBarBg = Instance.new("Frame")
    loadingBarBg.Name = "LoadingBarBackground"
    loadingBarBg.Size = UDim2.new(0.8, 0, 0, 10)
    loadingBarBg.Position = UDim2.new(0.5, 0, 0.8, 0) -- Unter dem Logo
    loadingBarBg.AnchorPoint = Vector2.new(0.5, 0.5)
    loadingBarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    loadingBarBg.Parent = loader
    local loadingBarBgCorner = Instance.new("UICorner")
    loadingBarBgCorner.CornerRadius = UDim.new(1, 0)
    loadingBarBgCorner.Parent = loadingBarBg

    local loadingBarFill = Instance.new("Frame")
    loadingBarFill.Name = "LoadingBarFill"
    loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
    loadingBarFill.BackgroundColor3 = Color3.fromRGB(248, 191, 212)
    loadingBarFill.Parent = loadingBarBg
    local loadingBarFillCorner = Instance.new("UICorner")
    loadingBarFillCorner.CornerRadius = UDim.new(1, 0)
    loadingBarFillCorner.Parent = loadingBarFill

    -- Animations-Sequenz
    task.spawn(function()
        -- Start Blur
        TweenService:Create(blurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = 10}):Play()

        -- 1. Logo einfaden
        TweenService:Create(loader, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
        -- Ladebalken füllen über die gesamte Dauer der Logo-Animation
        TweenService:Create(loadingBarFill, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()

        task.wait(1.5)

        -- 2. Logo ausfaden
        local fadeOut = TweenService:Create(loader, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {GroupTransparency = 1})
        fadeOut:Play()
        
        fadeOut.Completed:Connect(function()
            loader:Destroy() -- Loader entfernen
            -- 3. Hauptmenü mit "Back"-Effekt einblenden
            local mainTween = TweenService:Create(mainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                GroupTransparency = 0,
                Size = originalSize
            })
            mainTween:Play()

            -- Blur entfernen und Stroke des Hauptmenüs wieder sichtbar machen
            TweenService:Create(blurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = 0}):Play()
            mainTween.Completed:Connect(function()
                if mainStroke then
                    mainStroke.Transparency = 0.75
                end
                blurEffect:Destroy() -- Blur Effekt aufräumen
            end)
        end)
    end)
end

return Animation