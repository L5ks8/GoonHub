local UI = GoonHub.Import("Assets/ui")
local Widgets = GoonHub.Import("Assets/Components/widgets")
local UIFunctions = GoonHub.Import("Assets/Components/uifunctions")
local _ok, Coins = pcall(function()
    return GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/coins")
end)
if not _ok then
    warn("Failed to import Coins module:", Coins)
    Coins = nil
end

local _okP, PlayerLogic = pcall(function()
    return GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/PlayerTab/players")
end)
if not _okP then
    PlayerLogic = nil
end

local Misc = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MiscTab/misc")
local Status = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/status")
local Visuals = GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/EspTab/visuals")
local _ok2, AutoKill = pcall(function()
    return GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/autokillall")
end)
if not _ok2 then
    AutoKill = nil
end
local _ok3, Evade = pcall(function()
    return GoonHub.Import("Scripts/6c1e9d4ab827f350de471ac98b2f63aa/Components/Functions/MainTab/evade_murder")
end)
if not _ok3 then
    Evade = nil
end

local UILayout = {}

function UILayout.Create()

    local MarketplaceService = game:GetService("MarketplaceService")
    local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    local gameName = success and info.Name or "Unknown Game"

    local G2L = UI.CreateBase(gameName, "1.0.0")
    local window = {
        TabCount = 0, 
        Stats = {
            FPS = G2L["fps_label"],
            Ping = G2L["ping_label"],
            Memory = G2L["mem_label"]
        }
    }

    Widgets.Init(window, G2L)

    UIFunctions.Init(G2L, window)

    -- Game Tabs
    local mainTab = window:CreateTab("Main", false)
    local EspTab = window:CreateTab("Player", false)
    local MiscTab = window:CreateTab("Misc", false)
    local ShopTab = window:CreateTab("Shop", false)
    
    -- Main Tab
    local coinsSection = mainTab:CreateSection("Coins", "Left")
    coinsSection:CreateToggle({
        Title = "Coin farm",
        Column = "Left",
        Default = false,
        Callback = function(state)
            if not Coins then
                warn("Coins module not loaded; cannot Toggle")
                return
            end
            Coins.Toggle(state)
        end
    })
    coinsSection:CreateDropdown({
        Title = "Farm Mode",
        Options = {"Teleport", "Tween"},
        Column = "Left",
        Default = "Tween",
        Callback = function(value)
            if not Coins then
                warn("Coins module not loaded; cannot change mode")
                return
            end
            Coins.SetMode(value)
        end
    })
    coinsSection:CreateToggle({
        Title = "Auto Reset (Full Bag)",
        SubTitle = "Resets if bag full",
        Column = "Left",
        Default = false
        ,
        Callback = function(state)
            if not Coins then
                warn("Coins module not loaded; cannot Toggle Reset")
                return
            end
            if Coins.SetReset then
                Coins.SetReset(state)
            else
                -- fallback: set global directly
                getgenv().GH_Sys = getgenv().GH_Sys or {}
                getgenv().GH_Sys.State = getgenv().GH_Sys.State or {}
                getgenv().GH_Sys.State.Reset = state
            end
        end
    })
    coinsSection:CreateToggle({
        Title = "Auto kill all",
        SubTitle = "Only Murderer",
        Column = "Left",
        Default = false
        ,
        Callback = function(state)
            if not AutoKill then
                warn("AutoKill module not loaded; cannot Toggle")
                return
            end
            AutoKill.Toggle(state)
        end
    })
    local statusSection = mainTab:CreateSection("Status", "Right")
    local murderLabel = statusSection:CreateLabel("Murderer:", "Wait...")
    local sheriffLabel = statusSection:CreateLabel("Sheriff:", "Wait...")
    local heroLabel = statusSection:CreateLabel("Hero:", "nil")
    local otherSection = mainTab:CreateSection("Other", "Right")

    otherSection:CreateToggle({
        Title = "Survive Round",
        Column = "Right",
        Default = true,
        Callback = function(state)
            getgenv().GH_Sys = getgenv().GH_Sys or {}
            getgenv().GH_Sys.State = getgenv().GH_Sys.State or {}
            getgenv().GH_Sys.State.SurviveRound = state
        end
    })
    otherSection:CreateToggle({
        Title = "Auto Evade Murderer",
        Column = "Right",
        Default = true
        ,
        Callback = function(state)
            if not Evade then
                warn("Evade module not loaded; cannot Toggle")
                return
            end
            if Evade.Toggle then Evade.Toggle(state) end
        end
    })
    -- Status Update Loop
    task.spawn(function()
        while task.wait(1) do
            local murd = Status.getMurderer()
            local sher = Status.getSheriff()
            local hero = Status.getHero()
            
            murderLabel:Set(murd)
            sheriffLabel:Set(sher)
            heroLabel:Set(hero)
        end
    end)

    -- Esp Tab
    local VisualSection = EspTab:CreateSection("Visuals", "Left")
    VisualSection:CreateToggle({
        Title = "Esp",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Visuals.ToggleEsp(state)
        end
    })
    VisualSection:CreateToggle({
        Title = "Self Esp",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Visuals.SetSelfEsp(state)
        end
    })
    
    local PlayerSection = EspTab:CreateSection("Player", "Right")
    local playerDropdown = PlayerSection:CreateDropdown({
        Title = "Select Player",
        Options = {},
        Column = "Right",
        Callback = function(value)
            if PlayerLogic then PlayerLogic.SetSelectedPlayer(value) end
        end
    })
    -- Auto-refresh player list
    task.spawn(function()
        while task.wait(5) do
            if PlayerLogic and playerDropdown then
                playerDropdown:Refresh(PlayerLogic.GetPlayerNames())
            end
        end
    end)

    PlayerSection:CreateToggle({
        Title = "Spectate Selected",
        Column = "Right",
        Default = false,
        Callback = function(state)
            if PlayerLogic then PlayerLogic.ToggleSpectate(state) end
        end
    })
    PlayerSection:CreateToggle({
        Title = "Fling Selected",
        Column = "Right",
        Default = false,
        Callback = function(state)
            if PlayerLogic then PlayerLogic.ToggleFling(state) end
        end
    })
    PlayerSection:CreateButton({
        Title = "Fling Random",
        Column = "Right",
        Callback = function()
            if PlayerLogic then PlayerLogic.FlingRandom() end
        end
    })
    PlayerSection:CreateButton({
        Title = "Fling Murderer",
        Column = "Right",
        Callback = function()
            if PlayerLogic then PlayerLogic.FlingMurderer() end
        end
    })
    PlayerSection:CreateButton({
        Title = "Fling Sheriff",
        Column = "Right",
        Callback = function()
            if PlayerLogic then PlayerLogic.FlingSheriff() end
        end
    })
    PlayerSection:CreateToggle({
        Title = "Loop Fling All",
        Column = "Right",
        Default = false,
        Callback = function(state)
            if PlayerLogic then PlayerLogic.ToggleLoopFling(state) end
        end
    })
    -- Misc Tab

    local misc = MiscTab:CreateSection("Misc", "Left")
    misc:CreateToggle({
        Title = "Noclip",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Misc.ToggleNoclip(state)
        end
    })
    misc:CreateToggle({
        Title = "Anti-Fling",
        Column = "Left",
        Default = false,
        Callback = function(state)
            Misc.ToggleAntiFling(state)
        end
    })
    misc:CreateButton({
        Title = "Enable Performance Mode",
        Column = "Left",
        Callback = function()
            Misc.EnablePerformanceMode()
        end
    })
    -- Shop Tab
    local shop = ShopTab:CreateSection("Shop", "Left")
    shop:CreateToggle({
        Title = "Auto Open Boxes",
        Column = "Left",
        Default = false,
        Callback = function(state)
        end
    })
    shop:CreateSlider({
        Title = "Delay",
        Min = 1,
        Max = 5,
        Default = 1,
        Column = "Left",
        Callback = function(value)
            -- Logic for delay
        end
    })
    shop:CreateDropdown({
        Title = "Boxes",
        Options = {
            "MysteryBox1",
            "MysteryBox2",
            "KniveBox1",
            "KniveBox2",
            "KniveBox3",
            "KniveBox4",
            "KniveBox5",
            "MLG Box",
            "Gun Box1",
            "Gun Box2",
            "Gun Box3"
        },
        Column = "Left",
        Default = "MysteryBox1",
        Callback = function(value)
            -- Logic for selection
        end
    })

    return window
end
return UILayout