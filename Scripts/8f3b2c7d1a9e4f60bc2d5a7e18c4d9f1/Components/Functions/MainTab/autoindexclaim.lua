local RS = game:GetService("ReplicatedStorage")

local AutoIndexClaim = {}
local claimLoop = nil

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

local IndexRemote = getRemote("IndexService")

function AutoIndexClaim.Toggle(state)
    if claimLoop then
        task.cancel(claimLoop)
        claimLoop = nil
    end

    if state then
        claimLoop = task.spawn(function()
            while true do
                if IndexRemote then
                    local types = {"basic", "big", "huge", "shiny", "inverted"}
                    for _, t in ipairs(types) do
                        pcall(function() IndexRemote:InvokeServer("requestClaimReward", t) end)
                        task.wait(0.2)
                    end
                end
                task.wait(30)
            end
        end)
    end
end

return AutoIndexClaim