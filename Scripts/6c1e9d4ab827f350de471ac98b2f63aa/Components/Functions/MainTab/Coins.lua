local Coins = {}
getgenv().coinFarm = false
getgenv().coinTeleportMethod = "Tween"
getgenv().coinFarmSpeed = 20

local isTweening = false
local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')

local lastPositions = {}
local MAX_HISTORY = 5

	local function isInSpawn(vec)
		local reference = Vector3.new(300, 500, 0)
		local inspawn = false
		if (vec - reference).Magnitude < 500 then
			inspawn = true
		else
			inspawn = false
		end
		return inspawn
	end

	local function isRoundLive()
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Name == "Coin_Server" then
				return true
			end
		end
		return false
	end

	local function isRecentlyVisited(pos)
		for _, oldPos in ipairs(lastPositions) do
			if (oldPos - pos).Magnitude < 5 then -- tolerance
				return true
			end
		end
		return false
	end

	local function addPosition(pos)
		table.insert(lastPositions, pos)
		if #lastPositions > MAX_HISTORY then
			table.remove(lastPositions, 1) -- remove oldest
		end
	end

	local function setupCharacter()
		local char = Players.LocalPlayer.Character
		if not char then
			return
		end
		local root = char:FindFirstChild("HumanoidRootPart")
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not root or not humanoid then
			return
		end
		humanoid.AutoRotate = false
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		if not root:FindFirstChild("AntiGravityForce") then
			local attachment = Instance.new("Attachment")
			attachment.Name = "AntiGravityAttachment"
			attachment.Parent = root
			local force = Instance.new("VectorForce")
			force.Name = "AntiGravityForce"
			force.Attachment0 = attachment
			force.Force = Vector3.new(0, root.AssemblyMass * workspace.Gravity, 0)

			force.RelativeTo = Enum.ActuatorRelativeTo.World
			force.ApplyAtCenterOfMass = true
			force.Parent = root
		end
	end

	local function startFarmLoop()
		while getgenv().coinFarm do
			task.wait()
			local char = Players.LocalPlayer.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local humanoid = char and char:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.AutoRotate = false
			end
			if not root or not isRoundLive() or isInSpawn(root.Position) then
				task.wait(1)
				continue
			end
			local closestCoin = nil
			local shortestDistance = math.huge
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and v.Name == "Coin_Server" and v.Parent then
					local dist = (v.Position - root.Position).Magnitude

					-- skip recently visited positions
					if not isRecentlyVisited(v.Position) then
						if dist >= 3 and dist <= 50 then
							if dist < shortestDistance then
								shortestDistance = dist
								closestCoin = v
							end
						end
					end
				end
			end
			if closestCoin then
				local targetPos = closestCoin.Position - Vector3.new(0, 8, 0)
				local targetCFrame = CFrame.lookAt(targetPos, targetPos + Vector3.new(0, 0.1, 1)) * CFrame.Angles(math.rad(90), 0, 0)
				
				if getgenv().coinTeleportMethod == "Tween" then
					isTweening = true
					local distance = (root.Position - targetPos).Magnitude
					local duration = distance / getgenv().coinFarmSpeed
					local tween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
					tween:Play()
					tween.Completed:Wait()
					isTweening = false
				else
					root.CFrame = targetCFrame
					task.wait(0.1)
				end

				addPosition(closestCoin.Position)
				task.wait(2.2)
			else
				task.wait(0.2)
			end
		end
	end

	Players.LocalPlayer.CharacterAdded:Connect(function()
		if getgenv().coinFarm then
			task.wait(1)
			pcall(setupCharacter)
		end
	end)

	function Coins.Toggle(state)
		getgenv().coinFarm = state
		if state then
			setupCharacter()
			task.spawn(pcall, startFarmLoop)
			-- Orientation Loop
			task.spawn(function()
				while getgenv().coinFarm do
					local char = Players.LocalPlayer.Character
					local root = char and not isTweening and char:FindFirstChild("HumanoidRootPart")
					if root then
						local pos = root.Position
						root.CFrame = CFrame.lookAt(pos, pos + Vector3.new(0, 0, 1)) * CFrame.Angles(math.rad(90), 0, 0)
					end
					task.wait()
				end
			end)
		end
	end

	function Coins.SetTeleportMethod(method)
		getgenv().coinTeleportMethod = method
	end

	function Coins.SetFarmSpeed(speed)
		getgenv().coinFarmSpeed = speed
	end

return Coins