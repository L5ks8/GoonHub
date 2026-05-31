-- Jailbreak
local StartTime = tick()

if not getgenv().GoonHub then
    getgenv().GoonHub = {
        Import = function(path)
            local baseUrl = "https://raw.githubusercontent.com/L5ks8/GoonHub/main/"
            local success, content = pcall(function() return game:HttpGet(baseUrl .. path .. ".lua") end)
            if success then
                local func, err = loadstring(content)
                if func then return func() else warn("Goon Hub: Loadstring error: " .. tostring(err)) end
            end
            warn("Goon Hub: Error fetching " .. path .. " - " .. tostring(content))
        end
    }
end

local Modules = {
    Colors =  {
        ["Green"] = "0,255,0", 
        ["Cyan"] = "33, 161, 163"
    }
}

Modules.ChangeColor = function() 
    local function fix(v)
        if v:IsA("TextLabel") then v.RichText = true end
    end
    local success, devConsole = pcall(function() return game:GetService("CoreGui"):WaitForChild("DevConsoleMaster", 5) end)
    if success and devConsole then
        for _, v in ipairs(devConsole:GetDescendants()) do fix(v) end
        devConsole.DescendantAdded:Connect(fix)
    end
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

Modules.ChangeColor()
local LoadTime = string.format("%.2f", tick() - StartTime)
task.delay(0.1, function()
    Modules.print("Green", "[Jailbreak]: [   SUCCESS   ] - Authenticated in (" .. LoadTime .. "s)")
end)

-- UI laden
local UILayout = GoonHub.Import("Scripts/4c1e7d9ab826f350de471ac98b2f63bc/Components/uilayout")
local window = UILayout and UILayout.Create()