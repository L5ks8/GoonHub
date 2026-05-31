local AutoRoll = {}
local rollConnection

function AutoRoll.Toggle(state)
    if rollConnection then 
        task.cancel(rollConnection)
        rollConnection = nil
    end

    if state then
        rollConnection = task.spawn(function()
            while true do
                local config = getgenv().SlimeConfig
                local services = getgenv().SlimeServices
                local delay = (config and config.RollDelay) or 0.1
                
                task.wait(delay)

                if services and services.Roll then
                    local success, result = pcall(function() return services.Roll:InvokeServer("requestRoll") end)
                    if success and result and getgenv().handleNewRoll then
                        getgenv().handleNewRoll(result)
                    end
                end
            end
        end)
    end
end

return AutoRoll