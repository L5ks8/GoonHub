local AutoRoll = {
    Running = false
}

function AutoRoll.Toggle(state)
    AutoRoll.Running = state
    
    if state then
        task.spawn(function()
            while AutoRoll.Running do
                local Services = getgenv().SlimeServices
                local Config = getgenv().SlimeConfig
                local handle = getgenv().handleNewRoll
                
                task.wait(Config and Config.RollDelay or 0.1)
                if not AutoRoll.Running then break end
                
                if Services and Services.Roll and handle then
                    pcall(function()
                        local results = Services.Roll:InvokeServer("requestRoll")
                        if results and type(results) == "table" then
                            for _, rollResult in ipairs(results) do
                                local slime = rollResult[#rollResult]
                                if slime and type(slime) == "table" and slime.id then
                                    handle(slime)
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
end

return AutoRoll
