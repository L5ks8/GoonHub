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
            while true do
                local config = getgenv().SlimeConfig
                local services = getgenv().SlimeServices

                if services and services.Roll and config then
                    local delay = config.RollDelay or 0.1
                    
                    local success, result = pcall(function() 
                        return services.Roll:InvokeServer("requestRoll") 
                    end)

                    if success and result and getgenv().handleNewRoll then
                        getgenv().handleNewRoll(result)
                    end
                    
                    task.wait(delay)
                else
                    -- Falls Services noch nicht bereit sind, kurz warten
                    task.wait(1)
                end
            end
        end)
    end
end

return AutoRoll