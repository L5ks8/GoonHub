-- Coins auto-farm module moved from main script
local module = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = nil
pcall(function() Remotes = ReplicatedStorage:WaitForChild("Remotes") end)

-- wait for LocalPlayer in executors where it's not immediately available
local LP = Players.LocalPlayer
if not LP then
	repeat task.wait() LP = Players.LocalPlayer until LP
end

local GH_Sys = getgenv().GH_Sys or { State = { Farming = false, Evade = true, Rage = false, Reset = false, SurviveRound = true }, Cfg = { Walk = 35, FarmMode = "Tween" } }
getgenv().GH_Sys = GH_Sys
local Runtime = getgenv().Runtime or { Roles = { Murd = "None", Sher = "None", Me = "Innocent" }, Match = { Alive = true, Active = true }, Farm = { Node = nil, Tick = 0, Folder = nil, Cur = 0, Max = 50, Ignored = {} } }
getgenv().Runtime = Runtime
local BagLbl = getgenv().BagLbl
local teleportProcessing = false

local att = Instance.new("Attachment"); att.Name = "GH_Force"
local rot = Instance.new("AlignOrientation"); rot.Mode = Enum.OrientationAlignmentMode.OneAttachment; rot.RigidityEnabled = true; rot.Attachment0 = att
local mov = Instance.new("LinearVelocity"); mov.Attachment0 = att; mov.MaxForce = math.huge; mov.VectorVelocity = Vector3.zero; mov.RelativeTo = Enum.ActuatorRelativeTo.World

-- slow multiplier to make farm movement less twitchy (0.0 - 1.0)
local SPEED_MULT = 0.5

local function FindBag()
	if Runtime.Farm.Folder and Runtime.Farm.Folder.Parent then return Runtime.Farm.Folder end
	Runtime.Farm.Folder = workspace:FindFirstChild("CoinContainer", true)
	return Runtime.Farm.Folder
end

local function GetEnemy()
	if not GH_Sys.State.Evade then return nil end
	local n = (Runtime.Roles and Runtime.Roles.Me == "Murderer") and (Runtime.Roles.Sher or "") or (Runtime.Roles and Runtime.Roles.Murd or "")
	local p = Players:FindFirstChild(n)
	return (p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")) and p.Character.HumanoidRootPart.Position or nil
end

local function ScanGrid()
	local c = FindBag()
	if not c then return nil end
	if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return nil end
	local hrp = LP.Character.HumanoidRootPart
	local pos = hrp.Position
	local bad = GetEnemy()
	local best, dist = nil, math.huge

	-- iterate descendants for robust detection (parts inside models, attachments)
	for _, obj in pairs(c:GetDescendants()) do
		if Runtime.Farm.Ignored[obj] then continue end
		local part = nil
		if obj:IsA("BasePart") then
			part = obj
		elseif obj:IsA("Model") and obj.PrimaryPart then
			part = obj.PrimaryPart
		end
		if part and (obj.Name == "Coin" or obj.Name == "SnowToken" or obj:FindFirstChild("TouchInterest") or part.Name == "Coin" or part.Name == "SnowToken") then
			if GH_Sys.State.Evade and bad and (part.Position - bad).Magnitude < 18 then
				-- too close to enemy, skip
			else
				local d = (pos - part.Position).Magnitude
				if d < dist then dist = d; best = part end
			end
		end
	end

	-- fallback: also check direct children (in case GetDescendants missed something)
	if not best then
		for _, v in pairs(c:GetChildren()) do
			if not Runtime.Farm.Ignored[v] then
				local p = v:IsA("BasePart") and v or (v:IsA("Model") and v.PrimaryPart)
				if p and (v.Name == "Coin" or v.Name == "SnowToken" or v:FindFirstChild("TouchInterest")) then
					if not (GH_Sys.State.Evade and bad and (p.Position - bad).Magnitude < 18) then
						local d = (pos - p.Position).Magnitude
						if d < dist then dist = d; best = p end
					end
				end
			end
		end
	end

	return best
end

local function KillLoop()
	if not LP.Character then return end
	local k = LP.Backpack:FindFirstChild("Knife")
	if k then LP.Character.Humanoid:EquipTool(k) end
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
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
	att.Parent = nil; rot.Parent = nil; mov.Parent = nil
	if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.PlatformStand = false end
end

-- Remote event handlers
if Remotes and Remotes:FindFirstChild("Gameplay") then
	Remotes:WaitForChild("Gameplay"):WaitForChild("PlayerDataChanged").OnClientEvent:Connect(function(d)
		if type(d) == "table" then
			local me = d[LP.Name]
			Runtime.Roles = Runtime.Roles or { Murd = "None", Sher = "None", Me = "Innocent" }
			Runtime.Roles.Murd = "None"; Runtime.Roles.Sher = "None"
			for n, data in pairs(d) do
				if data.Role == "Murderer" then Runtime.Roles.Murd = n
				elseif data.Role == "Sheriff" then Runtime.Roles.Sher = n end
			end
			if me then
				Runtime.Match = Runtime.Match or { Alive = true, Active = true }
				Runtime.Match.Active = true; Runtime.Roles.Me = me.Role or "Innocent"
				Runtime.Match.Alive = not (me.Dead or me.Killed)
				GH_Sys.State.Rage = false
				if me.Coins then Runtime.Farm.Cur = me.Coins end
			else
				Runtime.Match.Active = false; GH_Sys.State.Rage = false
			end
		end
	end)

	Remotes:WaitForChild("Gameplay"):WaitForChild("CoinCollected").OnClientEvent:Connect(function(t, a, m)
		if type(a) == "number" then Runtime.Farm.Cur = a end
		if type(m) == "number" then Runtime.Farm.Max = m end
		if Runtime.Farm.Node then Runtime.Farm.Ignored[Runtime.Farm.Node] = true; Runtime.Farm.Node = nil end
		if BagLbl and type(BagLbl.SetDesc) == "function" then BagLbl:SetDesc(Runtime.Farm.Cur .. " / " .. Runtime.Farm.Max) end
		if Runtime.Farm.Cur >= Runtime.Farm.Max then
			if Runtime.Roles and Runtime.Roles.Me == "Murderer" and GH_Sys.State.Rage then
				GH_Sys.State.Rage = true
			elseif GH_Sys.State.Reset then
				GH_Sys.State.Farming = false
				if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.Health = 0 end
				task.wait(4)
				Runtime.Farm.Cur = 0; Runtime.Farm.Ignored = {}; GH_Sys.State.Farming = true
			elseif GH_Sys.State.SurviveRound then
				-- Keep farming state active to move to safe spot
			else
				GH_Sys.State.Farming = false
			end
		end
	end)
end

local conn
conn = RunService.Heartbeat:Connect(function()
	local c = LP.Character
	if not c then return end
	local hrp, hum = c:FindFirstChild("HumanoidRootPart"), c:FindFirstChild("Humanoid")
	if not hrp or not hum then return end

	if GH_Sys.State.Farming and Runtime.Match and Runtime.Match.Alive and hum.Health > 0 then
		if GH_Sys.State.Rage then
			att.Parent = nil; rot.Parent = nil; mov.Parent = nil
			hum.PlatformStand = false
			KillLoop()
			return
		end

		if not FindBag() then
			att.Parent = nil; rot.Parent = nil; mov.Parent = nil
			hum.PlatformStand = false
			return
		end

		hum.PlatformStand = true
		for _, t in pairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
		for _, v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end

		if GH_Sys.State.Evade then
			local d = GetEnemy()
			if d and (hrp.Position - d).Magnitude < 22 then
				local esc = (hrp.Position - d).Unit
				att.Parent = hrp; rot.Parent = hrp; mov.Parent = hrp
				mov.VectorVelocity = esc * ((GH_Sys.Cfg and GH_Sys.Cfg.Walk or 35) * 1.5) * SPEED_MULT
				rot.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + esc)
				return
			end
		end

		-- Teleport Farm Mode Logic
		if GH_Sys.Cfg.FarmMode == "Teleport" then
			att.Parent = nil; rot.Parent = nil; mov.Parent = nil
			if teleportProcessing then return end

			-- Bag Full & Survive Round Logic (Instant TP to safe spot)
			if Runtime.Farm.Cur >= Runtime.Farm.Max and not GH_Sys.State.Reset and GH_Sys.State.SurviveRound then
				att.Parent = nil; rot.Parent = nil; mov.Parent = nil
				hrp.CFrame = CFrame.new(1.076589, 504.818115, -25.737610)
				hum.PlatformStand = true
				return 
			end

			local node = ScanGrid()
			if node then
				teleportProcessing = true
				task.spawn(function()
					att.Parent = nil; rot.Parent = nil; mov.Parent = nil
					hum.PlatformStand = true
					
					-- Teleport slightly above and then to the node to trigger touch
					hrp.CFrame = node.CFrame * CFrame.new(0, 0.5, 0)
					task.wait()
					hrp.CFrame = node.CFrame
					
					if firetouchinterest then firetouchinterest(hrp, node, 0) end
					task.wait(0.5)
					if firetouchinterest then firetouchinterest(hrp, node, 1) end
					
					hrp.CFrame = CFrame.new(1.076589, 504.818115, -25.737610)
					task.wait(2)
					teleportProcessing = false
				end)
			else
				hrp.CFrame = CFrame.new(1.076589, 504.818115, -25.737610)
			end
			return
		end

		-- Bag Full & Survive Round Logic
		if Runtime.Farm.Cur >= Runtime.Farm.Max and not GH_Sys.State.Reset and GH_Sys.State.SurviveRound then
			att.Parent = hrp; rot.Parent = hrp; mov.Parent = hrp
			local safePos = Vector3.new(1.076589, 504.818115, -25.737610)
			mov.VectorVelocity = (safePos - hrp.Position).Unit * ((GH_Sys.Cfg and GH_Sys.Cfg.Walk or 35) * SPEED_MULT)
			
			if (safePos - hrp.Position).Magnitude > 2 then 
				rot.CFrame = CFrame.lookAt(hrp.Position, safePos) * CFrame.Angles(math.rad(90), 0, 0)
			else
				mov.VectorVelocity = Vector3.zero
			end
			
			Runtime.Farm.Node = nil -- Disable coin detection
			return 
		end

		if Runtime.Farm.Node and not Runtime.Farm.Node.Parent then Runtime.Farm.Node = nil end
		if not Runtime.Farm.Node then Runtime.Farm.Node = ScanGrid(); Runtime.Farm.Tick = tick() end

		if Runtime.Farm.Node then
			att.Parent = hrp; rot.Parent = hrp; mov.Parent = hrp
			local tp = Runtime.Farm.Node.Position + Vector3.new(0, -1.5, 0)
			mov.VectorVelocity = (tp - hrp.Position).Unit * ((GH_Sys.Cfg and GH_Sys.Cfg.Walk or 35) * SPEED_MULT)
			if (tp - hrp.Position).Magnitude > 2 then rot.CFrame = CFrame.lookAt(hrp.Position, tp) * CFrame.Angles(math.rad(90), 0, 0) end
		else
			mov.VectorVelocity = Vector3.zero
		end
	else
		att.Parent = nil; rot.Parent = nil; mov.Parent = nil
		if hum.PlatformStand then hum.PlatformStand = false end
	end
end)

-- expose a stop function to clean up if needed
function module.Stop()
	if conn and type(conn.Disconnect) == "function" then
		conn:Disconnect()
		conn = nil
	end
	att:Destroy(); rot:Destroy(); mov:Destroy()
end

-- UI helpers expected by `uilayout.lua`
function module.Toggle(state)
	if type(state) ~= "boolean" then state = not (GH_Sys.State.Farming) end
	module.SetFarming(state)
end

function module.SetSpeed(value)
	local v = tonumber(value) or GH_Sys.Cfg.Walk or 35
	GH_Sys.Cfg.Walk = v
end

function module.SetMode(v)
	GH_Sys.Cfg.FarmMode = v
end

function module.SetReset(state)
	if type(state) ~= "boolean" then state = not (GH_Sys.State.Reset) end
	GH_Sys.State.Reset = state
end

function module.SetFarming(v)
	GH_Sys.State.Farming = v
end

getgenv().CoinsModule = module

return module
