local Theme = {}
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local folder = "goonhub/Configs/" .. tostring(LocalPlayer.UserId)
local filePath = folder .. "/theme.json"

function Theme.Save(themeName)
    if not isfolder(folder) then makefolder(folder) end
    
    local data = { SelectedTheme = themeName }
    local success, json = pcall(HttpService.JSONEncode, HttpService, data)
    if success then
        writefile(filePath, json)
    end
end

function Theme.Load()
    if isfile(filePath) then
        local content = readfile(filePath)
        local success, data = pcall(HttpService.JSONDecode, HttpService, content)
        if success and data and data.SelectedTheme then
            return data.SelectedTheme
        end
    end
    return "Dark" 
end

return Theme