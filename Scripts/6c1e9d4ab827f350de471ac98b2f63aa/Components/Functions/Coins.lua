local Coins = {}

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

local safePosition = CFrame.new(14.384642, 516.698608, -25.254295)

local autoFarmEnabled = false
local noclipConnection
local coinsCollected = 0

function Coins.Toggle(state)
    autoFarmEnabled = state
    coinsCollected = 0

    if autoFarmEnabled then
        -- Noclip aktivieren
        if not noclipConnection then
            noclipConnection = runService.Stepped:Connect(function()
                if autoFarmEnabled and player.Character then
                    for _, part in pairs(player.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end

        -- Farm Loop starten
        task.spawn(function()
            while autoFarmEnabled do
                local coinContainer = game:GetService("Workspace"):FindFirstChild("CoinContainer", true)
                
                if coinContainer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    
                    for _, v in pairs(coinContainer:GetChildren()) do
                        if not autoFarmEnabled then break end
                        
                        local targetPart = v:IsA("BasePart") and v or (v:FindFirstChild("Hitbox") or v:FindFirstChildOfClass("Part") or v:FindFirstChildOfClass("MeshPart"))
                        
                        if targetPart and targetPart.Parent then
                            hrp.CFrame = targetPart.CFrame
                            task.wait(0.5)
                            coinsCollected = coinsCollected + 1

                            hrp.CFrame = safePosition
                            task.wait(2)

                            if coinsCollected >= 40 then
                                autoFarmEnabled = false
                                break
                            end
                        end
                    end
                end
                task.wait(1)
            end

            -- Cleanup wenn deaktiviert
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
        end)
    end
end

return Coins
