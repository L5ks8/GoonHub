local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local module = {}

local LP = Players.LocalPlayer
if not LP then
	repeat task.wait() LP = Players.LocalPlayer until LP
end

local GH_Sys = getgenv().GH_Sys
local Runtime = getgenv().Runtime

local FlingState = false
local selectedPlayerName = ""
local selectedPlayer = nil

local function Detect(p)
    if Runtime and Runtime.Roles then
        if p.Name == Runtime.Roles.Murd then return "Murderer" end
        if p.Name == Runtime.Roles.Sher then return "Sheriff" end
    end
    
    if not p.Character then return "Innocent" end
    if p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife")) then return "Murderer" end
    if p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

local function RunFling(targetPlayer)
    if FlingState then FlingState = false; return end
    if not targetPlayer or not targetPlayer.Character then return end
    
    FlingState = true
    
    local TChar = targetPlayer.Character
    local TRoot = TChar:FindFirstChild("HumanoidRootPart")
    local MyChar = LP.Character
    local MyRoot = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
    local OldFPDH = workspace.FallenPartsDestroyHeight
    local OldPos = MyRoot.CFrame

    if not TRoot or not MyRoot then FlingState = false; return end

    workspace.FallenPartsDestroyHeight = 0/0
    workspace.CurrentCamera.CameraSubject = TChar
    MyChar.Humanoid.PlatformStand = true
    
    local BAV = Instance.new("BodyAngularVelocity", MyRoot)
    BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    BAV.AngularVelocity = Vector3.new(0, 100000, 0)

    local BT = Instance.new("BodyThrust", MyRoot)
    BT.Force = Vector3.new(20000, 20000, 20000)
    
    task.spawn(function()
        local tStart = tick()
        while FlingState and targetPlayer.Parent and TChar.Parent and MyRoot.Parent do
            if TRoot.Position.Y < -50 or TChar.Humanoid.Health <= 0 then break end
            if (tick() - tStart) > 15 then break end
            if TRoot.Velocity.Magnitude > 100 or TRoot.Velocity.Y > 50 then break end
            local Pred = TRoot.CFrame + (TRoot.Velocity * 0.15)
            local Jitter = Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1))
            
            MyRoot.CFrame = Pred + Jitter
            MyRoot.Velocity = Vector3.new(9e9, 9e9, 9e9)
            MyRoot.RotVelocity = Vector3.new(9e9, 9e9, 9e9)
            
            RunService.Heartbeat:Wait()
        end
        
        if BAV then BAV:Destroy() end
        if BT then BT:Destroy() end
        if MyRoot then MyRoot.Velocity = Vector3.zero; MyRoot.RotVelocity = Vector3.zero; MyRoot.CFrame = OldPos end
        if MyChar and MyChar:FindFirstChild("Humanoid") then MyChar.Humanoid.PlatformStand = false end
        workspace.CurrentCamera.CameraSubject = LP.Character.Humanoid
        workspace.FallenPartsDestroyHeight = OldFPDH
        FlingState = false
    end)
end

function module.GetPlayerNames()
    local names = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    table.sort(names)
    return names
end

function module.SetSelectedPlayer(name)
    selectedPlayerName = name
    selectedPlayer = Players:FindFirstChild(name)
end

function module.ToggleSpectate(state)
    if state and selectedPlayer and selectedPlayer.Character then
        workspace.CurrentCamera.CameraSubject = selectedPlayer.Character.Humanoid
    else
        workspace.CurrentCamera.CameraSubject = LP.Character.Humanoid
    end
end

function module.ToggleFling(state)
    if state then
        if selectedPlayer then
            RunFling(selectedPlayer)
        else
            warn("No player selected for flinging.")
        end
    else
        FlingState = false 
    end
end

function module.FlingRandom()
    local candidates = {}
    for _, p in pairs(Players:GetPlayers()) do if p ~= LP and p.Character then table.insert(candidates, p) end end
    if #candidates > 0 then RunFling(candidates[math.random(1, #candidates)]) end
end

function module.FlingMurderer()
    local m = Players:FindFirstChild(Runtime.Roles.Murd)
    if not m then 
        for _, p in pairs(Players:GetPlayers()) do if Detect(p) == "Murderer" then m = p break end end
    end
    if m then RunFling(m) end
end

function module.FlingSheriff()
    local s = Players:FindFirstChild(Runtime.Roles.Sher)
    if not s then 
        for _, p in pairs(Players:GetPlayers()) do if Detect(p) == "Sheriff" then s = p break end end
    end
    if s then RunFling(s) end
end

function module.ToggleLoopFling(state)
    GH_Sys.State.LoopFling = state
    if state then
        task.spawn(function()
            while GH_Sys.State.LoopFling do
                for _, p in pairs(Players:GetPlayers()) do
                    if not GH_Sys.State.LoopFling then break end
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        RunFling(p)
                        local s = tick()
                        repeat task.wait(0.1) until not FlingState or (tick() - s) > 8
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    else
        FlingState = false
    end
end

function module.StopFling()
    FlingState = false
end

return module