local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local Lighting = cloneref(game:GetService("Lighting"))
local Workspace = cloneref(game:GetService("Workspace"))
local LocalPlayer = Players.LocalPlayer

local Misc = {}
local noclipConnection
local antiFlingConnection
local autoFlingConnection

-- Noclip Logik
function Misc.ToggleNoclip(state)
    if noclipConnection then noclipConnection:Disconnect() end
    getgenv().GoonHub.Config.Data["Noclip"] = state
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
    getgenv().GoonHub.Config.Save()
end

-- Anti-Fling Logik (aus Snippet)
function Misc.ToggleAntiFling(state)
    if antiFlingConnection then antiFlingConnection:Disconnect() end
    getgenv().GoonHub.Config.Data["Anti-Fling"] = state
    if state then
        antiFlingConnection = RunService.Stepped:Connect(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end
        end)
    end
    getgenv().GoonHub.Config.Save()
end

-- Murderer finden
local function getMurderer()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if plr.Character:FindFirstChild("Knife") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Knife")) then
                return plr.Character:FindFirstChild("HumanoidRootPart")
            end
        end
    end
    return nil
end

-- Fling Funktion (aus Snippet)
function Misc.Fling(target)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not target then return end
    
    local oldCFrame = hrp.CFrame
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(9999, 9999, 9999)
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.P = 1250
    bv.Parent = hrp
    
    hrp.CFrame = target.CFrame
    task.wait(0.1)
    bv:Destroy()
    hrp.CFrame = oldCFrame
end

-- Auto Fling Toggle
function Misc.ToggleAutoFling(state)
    if autoFlingConnection then task.cancel(autoFlingConnection) end
    getgenv().GoonHub.Config.Data["Auto Fling Murderer"] = state
    if state then
        autoFlingConnection = task.spawn(function()
            while state do
                local murd = getMurderer()
                if murd then
                    Misc.Fling(murd)
                end
                task.wait(0.5)
            end
        end)
    end
    getgenv().GoonHub.Config.Save()
end

-- Performance Mode (aus Snippet)
function Misc.EnablePerformanceMode()
    getgenv().GoonHub.Config.Data["Enable Performance Mode"] = true
    Lighting.FogEnd = 1000000
    Lighting.Brightness = 0
    Lighting.GlobalShadows = false
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Decal") then
            v:Destroy()
        end
    end
    getgenv().GoonHub.Config.Save()
end

return Misc