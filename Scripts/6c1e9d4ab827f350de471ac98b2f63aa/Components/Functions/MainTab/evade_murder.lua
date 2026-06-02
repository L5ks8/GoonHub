local module = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
if not LP then repeat task.wait() LP = Players.LocalPlayer until LP end

local GH_Sys = getgenv().GH_Sys or { State = { Evade = true }, Cfg = { EvadeDist = 22, Walk = 35 } }
getgenv().GH_Sys = GH_Sys
local Runtime = getgenv().Runtime or { Roles = { Murd = "None", Sher = "None", Me = "Innocent" } }
getgenv().Runtime = Runtime

local att = Instance.new("Attachment") att.Name = "GH_Evade_Att"
local rot = Instance.new("AlignOrientation") rot.Mode = Enum.OrientationAlignmentMode.OneAttachment rot.RigidityEnabled = true rot.Attachment0 = att
local mov = Instance.new("LinearVelocity") mov.Attachment0 = att mov.MaxForce = math.huge mov.VectorVelocity = Vector3.zero mov.RelativeTo = Enum.ActuatorRelativeTo.World

local conn
local running = false

local function GetMurdererPos()
    if not Runtime.Roles or not Runtime.Roles.Murd then return nil end
    local p = Players:FindFirstChild(Runtime.Roles.Murd)
    if not p or not p.Character then return nil end
    return p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart.Position or nil
end

local function startLoop()
    if conn then return end
    conn = RunService.Heartbeat:Connect(function()
        if not running then return end
        if not LP.Character then return end
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        local hum = LP.Character:FindFirstChild("Humanoid")
        if not hrp or not hum then return end

        local mpos = GetMurdererPos()
        if GH_Sys.State.Evade and mpos then
            local dist = (hrp.Position - mpos).Magnitude
            if dist < (GH_Sys.Cfg.EvadeDist or 22) then
                att.Parent = hrp; rot.Parent = hrp; mov.Parent = hrp
                hum.PlatformStand = true
                local esc = (hrp.Position - mpos).Unit
                mov.VectorVelocity = esc * ((GH_Sys.Cfg and GH_Sys.Cfg.Walk or 35) * 1.5)
                rot.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + esc)
                return
            end
        end
        att.Parent = nil; rot.Parent = nil; mov.Parent = nil
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.PlatformStand = false end
    end)
end

function module.Toggle(state)
    if type(state) ~= "boolean" then state = not GH_Sys.State.Evade end
    GH_Sys.State.Evade = state
    running = state
    if running then startLoop() end
end

function module.SetDistance(v)
    local n = tonumber(v) or GH_Sys.Cfg.EvadeDist or 22
    GH_Sys.Cfg.EvadeDist = n
end

getgenv().EvadeMurderModule = module

return module
