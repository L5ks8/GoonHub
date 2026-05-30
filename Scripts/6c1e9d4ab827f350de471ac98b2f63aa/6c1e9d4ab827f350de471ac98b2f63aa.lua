-- Murder Mystery 2 
local StartTime = tick()

-- GoonHub Environment Setup (da loader.lua nicht angepasst werden darf)
if not getgenv().GoonHub then
    getgenv().GoonHub = {
        Import = function(path)
            local baseUrl = "https://raw.githubusercontent.com/L5ks8/GoonHub/main/"
            local success, content = pcall(game.HttpGet, game, baseUrl .. path .. ".lua")
            if success then
                local func, err = loadstring(content)
                if func then return func() end
            end
            warn("Goon Hub: Error loading " .. path)
        end
    }
end

-- UI Pfad und Layout laden
local UILayout = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/uilayout")

-- UI Instanziieren (Tabs und Buttons werden nun intern in uilayout.lua erstellt)
local window = UILayout.Create()

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
    
    local devConsole = game:GetService("CoreGui"):WaitForChild("DevConsoleMaster", 5)
    if devConsole then
        for _, v in pairs(devConsole:GetDescendants()) do fix(v) end
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

local LoadTime = string.format("%.2f", tick() - StartTime)
Modules.ChangeColor()
Modules.print("Green", "[MM2]: [   SUCCESS   ] - Authenticated in (" .. LoadTime .. "s)")
