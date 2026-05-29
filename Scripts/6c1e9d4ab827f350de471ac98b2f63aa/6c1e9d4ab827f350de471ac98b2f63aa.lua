-- Murder Mystery 2
local StartTime = tick()
local ScriptRoot = "Scripts/6c1e9d4ab827f350de471ac98b2f63aa/"
local AssetsRoot = "Assets/"
local DefaultBaseUrl = "https://raw.githubusercontent.com/L5ks8/GoonHub/main"

local Modules = {
    Colors =  {
        ["Green"] = "0,255,0", 
        ["Cyan"] = "33, 161, 163"
    }
}

Modules.ChangeColor = function() 
    game:GetService("RunService").Heartbeat:Connect(function()
    	if game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster") then 
	        for _, v in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do 
	            if v:IsA("TextLabel") then 
	                v.RichText = true 
	            end 
	        end 
	    end
    end)
end

Modules.print = function(color, text, size)
	if not Modules.Colors[color] then 
		warn("Color was not found!")
		return 
	end 
	
    local Text = '<font color="rgb(' .. Modules.Colors[color] .. ')"'
    if size then
        Text = Text .. ' size="' .. tostring(size) .. '"'
    end
    Text = Text .. '>' .. tostring(text) .. '</font>'
    print(Text)
end

Modules.LoadFile = function(path)
	local source

	if typeof(readfile) == "function" and (typeof(isfile) ~= "function" or isfile(path)) then
		local success, content = pcall(readfile, path)

		if success then
			source = content
		end
	end

	if not source then
		local env = getgenv and getgenv() or _G
		local baseUrl = rawget(env, "GOONHUB_BASE_URL") or DefaultBaseUrl

		baseUrl = tostring(baseUrl):gsub("/$", "")
		source = game:HttpGet(baseUrl .. "/" .. path:gsub("\\", "/"))
	end

	assert(source, "[MM2]: Could not load " .. path)

	local chunk, compileError = loadstring(source, path)
	assert(chunk, compileError)

	return chunk()
end

Modules.LoadScript = function(relativePath)
	return Modules.LoadFile(ScriptRoot .. relativePath)
end

Modules.LoadAsset = function(relativePath)
	return Modules.LoadFile(AssetsRoot .. relativePath)
end

Modules.LoadUI = function()
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end

	local UILayout = Modules.LoadScript("Components/uilayout.lua")
	local UI = Modules.LoadAsset("ui.lua")
	local MainFunctions = Modules.LoadAsset("mainfunction.lua")
	local Window = UILayout.new(UI, MainFunctions)

	local Home = Window:CreateTab("Home", "rbxassetid://11433532654")
	Window:CreateSection(Home, "Main")

	rawset(getgenv and getgenv() or _G, "GoonHubMM2", Window)

	return Window
end

local LoadTime = string.format("%.2f", tick() - StartTime)
Modules.ChangeColor()
Modules.print("Green", "[MM2]: [   SUCCESS   ] - Authenticated in (" .. LoadTime .. "s)")
Modules.LoadUI()
