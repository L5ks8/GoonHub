local AutoRoll = {}
local rollConnection

function AutoRoll.Toggle(state)
    local config = getgenv().SlimeConfig
    if config then
        config.AutoRoll = state
    end

    if rollConnection then 
        task.cancel(rollConnection)
        rollConnection = nil
    end

    if state then
        rollConnection = task.spawn(function()
            while task.wait() do
                local currentConfig = getgenv().SlimeConfig
                local services = getgenv().SlimeServices
                local delay = (currentConfig and currentConfig.RollDelay) or 0.1

                if services and services.Roll then
                    local success, result = pcall(function() 
                        return services.Roll:InvokeServer("requestRoll") 
                    end)

                    if success and result then
                        if getgenv().handleNewRoll then
                            getgenv().handleNewRoll(result)
                        end
                    end
                end
                
                task.wait(delay)
            end
        end)
    end
end

return AutoRoll