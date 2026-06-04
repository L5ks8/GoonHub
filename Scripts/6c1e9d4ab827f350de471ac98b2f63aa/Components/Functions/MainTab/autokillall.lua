local module = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
if not LP then repeat task.wait() LP = Players.LocalPlayer until LP end

local GH_Sys = getgenv().GH_Sys or { State = { AutoKillAllActive = false, Rage = false } }
getgenv().GH_Sys = GH_Sys
local Runtime = getgenv().Runtime or { Roles = { Murd = "None", Sher = "None", Me = "Innocent" }, Match = { Alive = true, Active = true } }
getgenv().Runtime = Runtime

local KillEvent = nil
pcall(function()
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
end)

local function KillLoop()
    if not LP.Character then return end

    while GH_Sys.State.AutoKillAllActive do
        if Runtime.Roles.Me ~= "Murderer" or not Runtime.Match.Active or not Runtime.Match.Alive then
            GH_Sys.State.AutoKillAllActive = false
            break
        end

        local killedSomeoneThisIteration = false
        for _, v in pairs(Players:GetPlayers()) do
            if not GH_Sys.State.AutoKillAllActive or Runtime.Roles.Me ~= "Murderer" or not Runtime.Match.Active then break end
            if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                killedSomeoneThisIteration = true
                local targetHRP = v.Character.HumanoidRootPart
                
                local knife = LP.Backpack:FindFirstChild("Knife")
                if knife then
                    knife.Parent = LP.Character
                    task.wait(0.1)
                end
                
                if LP.Character:FindFirstChild("Knife") then
                    LP.Character.HumanoidRootPart.CFrame = targetHRP.CFrame
                    VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,false,0)
                    task.wait()
                    VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,false,0)
                    local attackStart = tick()
                    while tick() - attackStart < 0.75 do
                        if not GH_Sys.State.AutoKillAllActive or Runtime.Roles.Me ~= "Murderer" or not Runtime.Match.Active or not v.Parent or not v.Character or not v.Character:FindFirstChild("HumanoidRootPart") or v.Character.Humanoid.Health <= 0 then
                            break
                        end
                        LP.Character.HumanoidRootPart.CFrame = targetHRP.CFrame
                        RunService.Heartbeat:Wait()
                    end
                end
                
            end
        end

        if not GH_Sys.State.AutoKillAllActive or Runtime.Roles.Me ~= "Murderer" or not Runtime.Match.Active then
            GH_Sys.State.AutoKillAllActive = false
            break
        end

        if not killedSomeoneThisIteration then
            task.wait(1)
        end
        task.wait(0.1) 
    end
    GH_Sys.State.AutoKillAllActive = false
end

function module.Toggle(state)
    if Runtime.Roles.Me ~= "Murderer" then return end
    if type(state) ~= "boolean" then state = not GH_Sys.State.AutoKillAllActive end
    GH_Sys.State.AutoKillAllActive = state
    if state then
        task.spawn(function()
            KillLoop()
        end)
    end
end

function module.IsRunning()
    return GH_Sys.State.AutoKillAllActive
end

getgenv().AutoKillAll = module

return module
