-- Auto Kill All (only when local is Murderer)
local module = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
if not LP then repeat task.wait() LP = Players.LocalPlayer until LP end

local GH_Sys = getgenv().GH_Sys or { State = { Rage = false } }
getgenv().GH_Sys = GH_Sys
local Runtime = getgenv().Runtime or { Roles = { Murd = "None", Sher = "None", Me = "Innocent" } }
getgenv().Runtime = Runtime

local running = false
local worker

local function attackTarget(p)
    if not p or not p.Character then return end
    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local myChar = LP.Character
    if not myChar then return end
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local start = tick()
    while running and p.Parent and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 do
        local equippedKnife = LP.Character and LP.Character:FindFirstChild("Knife")
        if not equippedKnife then
            local bk = LP.Backpack and LP.Backpack:FindFirstChild("Knife")
            if bk then pcall(function() LP.Character.Humanoid:EquipTool(bk) end) end
            RunService.Heartbeat:Wait()
            RunService.Heartbeat:Wait()
            if not (LP.Character and LP.Character:FindFirstChild("Knife")) then
                break
            end
        end
        if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then break end
        
        local k = LP.Character:FindFirstChild("Knife")
        pcall(function()
            LP.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
            if k then k:Activate() end
        end)
        
        RunService.Heartbeat:Wait()
        if (tick() - start) > 4 then break end
        
        if Runtime and Runtime.Match and not Runtime.Match.Active then
            running = false
            break
        end
    end
    
    pcall(function()
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.PlatformStand = false
        end
    end)
end

local function workerFunc()
    while running do
        if Runtime.Roles and Runtime.Roles.Me == "Murderer" then
            local waited = 0
            while running and not (LP.Character and LP.Character:FindFirstChild("Knife")) and waited < 20 do
                -- try to equip if present in backpack
                local bk = LP.Backpack and LP.Backpack:FindFirstChild("Knife")
                if bk and LP.Character and LP.Character:FindFirstChild("Humanoid") then
                    pcall(function() LP.Character.Humanoid:EquipTool(bk) end)
                end
                task.wait(0.5); waited = waited + 0.5
            end
            if not (LP.Character and LP.Character:FindFirstChild("Knife")) then
                task.wait(1)
                continue
            end
            if Runtime and Runtime.Match and not Runtime.Match.Active then
                running = false
                break
            end
            local othersAlive = 0
            for _, pp in pairs(Players:GetPlayers()) do
                if pp ~= LP and pp.Character and pp.Character:FindFirstChild("Humanoid") and pp.Character.Humanoid.Health > 0 then
                    othersAlive = othersAlive + 1
                end
            end
            if othersAlive == 0 then
                running = false
                break
            end

            for _, p in pairs(Players:GetPlayers()) do
                if not running then break end
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    attackTarget(p)
                    task.wait(0.2)
                end
            end
        end
        task.wait(0.5)
    end
end

function module.Toggle(state)
    if type(state) ~= "boolean" then state = not running end
    if state == running then return end
    running = state
    if running then
        worker = task.spawn(workerFunc)
    else
        worker = nil
    end
end

function module.IsRunning()
    return running
end

getgenv().AutoKillAll = module

return module
