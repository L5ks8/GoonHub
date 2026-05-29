local MainFunctions = {}
local UserInputService = game:GetService("UserInputService")

-- Drag Funktion
function MainFunctions.AddDrag(frame, dragHandle)
    local dragging, dragInput, dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Resize Funktion
function MainFunctions.AddResize(frame, resizeHandle)
    local dragging, dragInput, dragStart, startSize
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startSize = frame.Size
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Size = UDim2.new(startSize.X.Scale, math.max(startSize.X.Offset + delta.X, 300), startSize.Y.Scale, math.max(startSize.Y.Offset + delta.Y, 200))
        end
    end)
end

-- Spiel-Spezifisches Setup (Beispiel für "6c1e" / PlaceId)
function MainFunctions.CheckGame(G2L)
    local placeId = game.PlaceId
    -- Hier kannst du PlaceIDs oder Namen prüfen
    if placeId == 6830861118 or tostring(placeId):find("6c1e") then
        -- Beispiel: Ändere die Farbe oder füge ein Label hinzu, wenn das Spiel erkannt wurde
        if G2L["6d"] then 
            G2L["6d"].Text = "GoonHub - Game Detected!"
            G2L["6d"].TextColor3 = Color3.fromRGB(0, 255, 120)
        end
        -- Hier könnten später Funktionen zum Erstellen neuer Tabs aufgerufen werden
    end
end

function MainFunctions.Apply(G2L)
    -- Close Button (G2L["72"]): Zerstört die gesamte UI
    if G2L["72"] then
        G2L["72"].MouseButton1Click:Connect(function()
            G2L["1"]:Destroy()
        end)
    end

    -- Return Button (G2L["7c"]): Navigiert im PageLayout zurück zur ersten Seite (Home)
    if G2L["7c"] and G2L["14"] then
        G2L["7c"].MouseButton1Click:Connect(function()
            G2L["14"]:JumpTo(G2L["14"].Parent:GetChildren()[1])
        end)
    end

    -- Minimize Button (G2L["80"] - Nav Button): Schaltet die Sichtbarkeit des Main-Frames um
    if G2L["80"] and G2L["2"] then
        G2L["80"].MouseButton1Click:Connect(function()
            G2L["2"].Visible = not G2L["2"].Visible
        end)
    end

    -- Drag & Resize aktivieren
    if G2L["2"] and G2L["6"] then
        MainFunctions.AddDrag(G2L["2"], G2L["6"])
    end
    if G2L["2"] and G2L["b"] then
        MainFunctions.AddResize(G2L["2"], G2L["b"])
    end

    MainFunctions.CheckGame(G2L)
end

return MainFunctions