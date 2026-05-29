-- Murder Mystery 2
local StartTime = tick()

local Modules = {
    Colors =  {
        ["Green"] = "0,255,0", -- color in rgb
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

Modules.LoadUi = function()
	local folder = script.Parent
	local uiModule = folder:FindFirstChild("ui") or folder:FindFirstChild("ui.lua")

	if not uiModule then
		warn("[MM2]: [UI] - ui.lua was not found next to the game script.")
		return
	end

	local success, ui = pcall(require, uiModule)

	if not success then
		warn("[MM2]: [UI] - Could not require ui.lua:", ui)
		return
	end

	if type(ui) ~= "table" or type(ui.Load) ~= "function" then
		warn("[MM2]: [UI] - ui.lua must return a table with a Load function.")
		return
	end

	local loaded, loadError = pcall(ui.Load)

	if not loaded then
		warn("[MM2]: [UI] - Load failed:", loadError)
		return
	end

	Modules.print("Green", "[MM2]: [UI] - Loaded.")
end

local LoadTime = string.format("%.2f", tick() - StartTime)
Modules.ChangeColor()
Modules.print("Green", "[MM2]: [SUCCESS] - Authenticated in (" .. LoadTime .. "s)")
Modules.LoadUi()
