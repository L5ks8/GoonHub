-- Murder Mystery 2 
local StartTime = tick()

-- UI Pfad und Layout laden
local Scripts = game:GetService("ReplicatedStorage"):WaitForChild("GoonHub"):WaitForChild("Scripts")
local UILayout = require(Scripts["6c1e9d4ab827f350de471ac98b2f63aa"].Components.uilayout)

-- UI Instanziieren (Tabs und Buttons werden nun intern in uilayout.lua erstellt)
local window = UILayout.Create()

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

local LoadTime = string.format("%.2f", tick() - StartTime)
Modules.ChangeColor()
Modules.print("Green", "[MM2]: [   SUCCESS   ] - Authenticated in (" .. LoadTime .. "s)")
