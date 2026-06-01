local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local LocalPlayer = Players.LocalPlayer
local Status = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/status")

local Visuals = {}
local espConnection

local function getRoleColor(plr)
    local name = plr.DisplayName
    
    if name == Status.getMurderer() then
        return Color3.fromRGB(255, 0, 0) -- Rot
    elseif name == Status.getHero() then
        return Color3.fromRGB(255, 255, 0) -- Gelb
    elseif name == Status.getSheriff() then
        return Color3.fromRGB(0, 0, 255) -- Blau
    end
    
    return Color3.fromRGB(0, 255, 0) -- Grün (Innocent)
end

function Visuals.ToggleEsp(state)
    if espConnection then espConnection:Disconnect() end
    
    if state then
        espConnection = RunService.RenderStepped:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local char = player.Character
                    local head = char:FindFirstChild("Head")
                    local color = getRoleColor(player)

                    -- Highlight (Charms)
                    local highlight = char:FindFirstChild("GoonHub_Highlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "GoonHub_Highlight"
                        highlight.Parent = char
                    end
                    highlight.FillColor = color
                    highlight.OutlineColor = color
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                    -- Name ESP (BillboardGui)
                    local billboard = char:FindFirstChild("GoonHub_NameESP")
                    if not billboard and head then
                        billboard = Instance.new("BillboardGui")
                        billboard.Name = "GoonHub_NameESP"
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Adornee = head
                        billboard.Parent = char

                        local label = Instance.new("TextLabel")
                        label.Name = "NameLabel"
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.TextStrokeTransparency = 0
                        label.Font = Enum.Font.BuilderSansBold
                        label.TextSize = 14
                        label.Parent = billboard
                    end
                    
                    local label = billboard and billboard:FindFirstChild("NameLabel")
                    if label then
                        label.Text = player.DisplayName
                        label.TextColor3 = color
                    end
                end
            end
        end)
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("GoonHub_Highlight")
                if highlight then
                    highlight:Destroy()
                end
                local billboard = player.Character:FindFirstChild("GoonHub_NameESP")
                if billboard then
                    billboard:Destroy()
                end
            end
        end
    end
end

return Visuals