local cloneref = cloneref or function(o) return o end
local HttpService = cloneref(game:GetService("HttpService"))

local Config = {}

local CONFIG_BASE_PATH = "goonhub/Configs"
local GAME_ID = tostring(game.GameId)
local GAME_CONFIG_FOLDER = CONFIG_BASE_PATH .. "/" .. GAME_ID

-- Ensure the game-specific config folder exists
if not isfolder(CONFIG_BASE_PATH) then
    makefolder(CONFIG_BASE_PATH)
end
if not isfolder(GAME_CONFIG_FOLDER) then
    makefolder(GAME_CONFIG_FOLDER)
end

function Config.Load(gameName)
    local filePath = GAME_CONFIG_FOLDER .. "/" .. gameName .. ".json"
    if isfile(filePath) then
        local success, content = pcall(readfile, filePath)
        if success and content then
            local decoded, err = pcall(HttpService.JSONDecode, HttpService, content)
            if decoded then return decoded end
            warn("Config.Load: Error decoding JSON for " .. gameName .. ": " .. tostring(err))
        else
            warn("Config.Load: Error reading file " .. filePath .. ": " .. tostring(err))
        end
    end
    return {} -- Return empty table if file doesn't exist or error
end

function Config.Save(gameName, data)
    local filePath = GAME_CONFIG_FOLDER .. "/" .. gameName .. ".json"
    local encoded = HttpService:JSONEncode(data)
    writefile(filePath, encoded)
end

return Config