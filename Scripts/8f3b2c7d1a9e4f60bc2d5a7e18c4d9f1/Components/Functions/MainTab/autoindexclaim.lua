local AutoIndexClaim = {}
local claimConnection

function AutoIndexClaim.Toggle(state)
    local config = getgenv().SlimeConfig
    if config then
        config.AutoClaimIndex = state
    end

    if claimConnection then 
        task.cancel(claimConnection)
        claimConnection = nil
    end

    if state then
        claimConnection = task.spawn(function()
            local categories = { "basic", "big", "huge", "shiny", "inverted" }
            while task.wait(5) do -- Kurzer Delay, um den Server nicht zu überlasten
                local services = getgenv().SlimeServices or {}
                
                if services and services.Index then
                    for _, category in ipairs(categories) do
                        pcall(function()
                            services.Index:InvokeServer("requestClaimReward", category)
                        end)
                    end
                end
            end
        end)
    end
end

return AutoIndexClaim