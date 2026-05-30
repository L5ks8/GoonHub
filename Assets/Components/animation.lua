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

    -- Sound Effekt
    local loadSound = Instance.new("Sound")
    loadSound.SoundId = "rbxassetid://134221055367800"
    loadSound.Volume = 1
    loadSound.Parent = game:GetService("SoundService")

    -- Dunkler Hintergrund für den Blur-Effekt
    local darkOverlay = Instance.new("Frame")
    darkOverlay.Name = "DarkOverlay"
    darkOverlay.Size = UDim2.new(1, 0, 1, 0)
    darkOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
    darkOverlay.BackgroundTransparency = 1
    darkOverlay.ZIndex = 9990
    darkOverlay.Parent = screenGui

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
    TweenService:Create(blurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = 16}):Play()
    TweenService:Create(darkOverlay, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.45}):Play()
    TweenService:Create(loader, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
    
    local LoaderHandler = {}

    function LoaderHandler:Update(percent)
        TweenService:Create(loadingBarFill, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(math.clamp(percent/100, 0, 1), 0, 1, 0)
        }):Play()
    end

    function LoaderHandler:Finish()
        -- Balken auf 100% zwingen
        self:Update(100)
        task.wait(0.2)

        -- Logo ausfaden
        local fadeOut = TweenService:Create(loader, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {GroupTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        
        loader:Destroy()

        -- Hauptmenü einblenden
        TweenService:Create(blurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = 0}):Play()
        TweenService:Create(darkOverlay, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        
        loadSound:Play()
        
        local mainTween = TweenService:Create(mainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            GroupTransparency = 0,
            Size = originalSize
        })
        mainTween:Play()

        mainTween.Completed:Connect(function()
            if mainStroke then mainStroke.Transparency = 0.75 end
            blurEffect:Destroy()
            darkOverlay:Destroy()
            loadSound:Destroy()
        end)
    end

    return LoaderHandler
end

return Animation