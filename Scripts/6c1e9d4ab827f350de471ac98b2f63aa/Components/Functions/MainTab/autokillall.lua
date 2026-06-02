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
    
    for _, v in pairs(Players:GetPlayers()) do
        if not GH_Sys.State.Farming then return end
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local target = v.Character.HumanoidRootPart
            local startTime = tick()
            
            -- Equip knife
            local knife = LP.Backpack and LP.Backpack:FindFirstChild("Knife")
            if knife and LP.Character then
                pcall(function() LP.Character.Humanoid:EquipTool(knife) end)
                task.wait(0.2)
            end
            
            -- Attack loop
            while GH_Sys.State.Farming and v.Parent and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 do
                if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then break end
                if (tick() - startTime) > 5 then break end
                
                knife = LP.Character:FindFirstChild("Knife")
                if not knife then
                    knife = LP.Backpack and LP.Backpack:FindFirstChild("Knife")
                    if knife then pcall(function() LP.Character.Humanoid:EquipTool(knife) end) end
                end
                
                -- Move to target and attack
                if knife then
                    pcall(function()
                        LP.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, 2.5)
                        knife:Activate()
                    end)
                end
                
                RunService.Heartbeat:Wait()
            end
        end
    end
    
    GH_Sys.State.Farming = false
end

function module.Toggle(state)
    if Runtime.Roles.Me ~= "Murderer" then return end
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
