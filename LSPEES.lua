 --// Legends of Speed //--
showNotification("Script Active", "t.me/Apex_Script")
getgenv().collectHoopsToggle = false
getgenv().collectOrbsToggle = false
getgenv().autoRebirth = false


local starterGui = game:GetService("StarterGui")

local function showNotification(title, text)
    starterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5,
    })
end

function collectHoopsToggle() -- Auto Collects Hoops
    spawn(function()
        local playerHead = game.Players.LocalPlayer.Character.Head
        while wait() do
            if not getgenv().collectHoopsToggle then break end
            for i, v in pairs(game:GetService("Workspace").Hoops:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    -- Fire the Touch Interest
                    firetouchinterest(playerHead, v.Parent, 0)
                    wait(0.01)
                    firetouchinterest(playerHead, v.Parent, 1)
                end
            end 
        end
    end)
end

function TPTOJUNGLE()
    local player = game.Players.LocalPlayer
    local chest = workspace.jungleChest.Chest -- Убедитесь, что путь правильный

    -- Телепортируем игрока к сундуку с небольшим смещением по высоте
    player.Character.HumanoidRootPart.CFrame = chest.CFrame + Vector3.new(0, 5, 0)
end

function collectOrbsToggle() -- Auto Collects Orbs
    spawn(function()
        local playerHead = game.Players.LocalPlayer.Character.Head
        while wait() do
            if not getgenv().collectOrbsToggle then break end
            for i, v in pairs(game:GetService("Workspace").orbFolder:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    -- Fire the Touch Interest
                    firetouchinterest(playerHead, v.Parent, 1)
                    wait(0.1)
                    firetouchinterest(playerHead, v.Parent, 0)
                end
            end
        end
    end)
end

function autoRebirth() -- Well it says auto rebirth, I'm sure we all know what that is
    spawn(function() 
        while wait(5) do
            if not getgenv().autoRebirth then break end
            local args = {[1] = "rebirthRequest"}
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
         end
    end)
end

function autorace() -- Well it says auto rebirth, I'm sure we all know what that is
    spawn(function() 
        while wait(5) do
            if not getgenv().autoRebirth then break end
            local args = {[1] = "rebirthRequest"}
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
         end
    end)
end

spawn(function() -- Anti AFK
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end) 
end)


local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("Apex Legends of Speed v1.5")

local b = w:CreateFolder("AutoFarm")

b:Toggle("Auto Hoops",function(bool)
    getgenv().collectHoopsToggle = bool
    print(shared.toggle)
    if bool then
        collectHoopsToggle()
    end
end)

b:Toggle("Auto Collect",function(bool)
    getgenv().collectOrbsToggle = bool
    print(shared.toggle)
    if bool then
        collectOrbsToggle()
    end
end)

b:Toggle("Auto Rebirth",function(bool)
    getgenv().autoRebirth = bool
    print(shared.toggle)
    if bool then
        autoRebirth()
    end
end)

b:Toggle("Auto Race",function(bool)
    getgenv().autoRebirth = bool
    print(shared.toggle)
    if bool then
    end
end)


local a = w:CreateFolder("Teleport")

a:Button("TP TO JUNGLE", function()
    TPTOJUNGLE() -- Просто вызываем функцию телепортации
end)

local e = w:CreateFolder("EXIT")
e:DestroyGui()