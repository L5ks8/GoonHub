local RS = game:GetService("ReplicatedStorage")

local AutoRoll = {}
local rollLoop = nil

local function getRemote(serviceName)
    local success, result = pcall(function()
        return RS:WaitForChild("Packages")
            :WaitForChild("_Index")
            :WaitForChild("leifstout_networker@0.3.1")
            :WaitForChild("networker")
            :WaitForChild("_remotes")
            :WaitForChild(serviceName)
            :WaitForChild("RemoteFunction")
    end)
    return success and result or nil
end

local RollRemote = getRemote("RollService")

function AutoRoll.Toggle(state)
    if rollLoop then
        task.cancel(rollLoop)
        rollLoop = nil
    end

    if state then
        rollLoop = task.spawn(function()
            while true do
                if RollRemote then
                    pcall(function() RollRemote:InvokeServer("requestRoll") end)
                end
                task.wait(0.1)
            end
        end)
    end
end

return AutoRoll