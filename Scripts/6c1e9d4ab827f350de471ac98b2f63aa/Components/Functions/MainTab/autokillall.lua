-- Auto Kill All from script.lua
local module = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
if not LP then repeat task.wait() LP = Players.LocalPlayer until LP end

local GH_Sys = getgenv().GH_Sys or { State = { Farming = false, Rage = false } }
getgenv().GH_Sys = GH_Sys
local Runtime = getgenv().Runtime or { Roles = { Murd = "None", Sher = "None", Me = "Innocent" }, Match = { Alive = true, Active = true } }
getgenv().Runtime = Runtime

local function KillLoop()
    if not LP.Character then return end
    local k = LP.Backpack:FindFirstChild("Knife")
    if k then LP.Character.Humanoid:EquipTool(k) end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local t = v.Character.HumanoidRootPart
            local s = tick()
            repeat
                if not GH_Sys.State.Farming then return end
                k = LP.Character:FindFirstChild("Knife") or LP.Backpack:FindFirstChild("Knife")
                if k and k.Parent ~= LP.Character then LP.Character.Humanoid:EquipTool(k) end
                LP.Character.HumanoidRootPart.CFrame = t.CFrame * CFrame.new(0, 0, 2)
                if k then k:Activate() end
                RunService.Heartbeat:Wait()
            until v.Character.Humanoid.Health <= 0 or (tick() - s) > 2 or not v.Parent
        end
    end
    GH_Sys.State.Farming = false
end

function module.Toggle(state)
    if type(state) ~= "boolean" then state = not GH_Sys.State.Farming end
    GH_Sys.State.Farming = state
    if state then
        task.spawn(function()
            KillLoop()
        end)
    end
end

function module.IsRunning()
    return GH_Sys.State.Farming
end

getgenv().AutoKillAll = module

return module
