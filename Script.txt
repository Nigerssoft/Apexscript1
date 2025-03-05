print("Hello Apex Script Subscribe Telegram t.me/Apex_Script")

local function createMenu()
    -- Создаем ScreenGui в PlayerGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ApexMenu"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 150, 0, 120) -- Уменьшил размер для вертикального расположения
    mainFrame.Position = UDim2.new(0.5, -75, 0.5, -60)
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true -- Позволяет фрейму быть активным
    mainFrame.Draggable = true -- Позволяет двигать фрейм
    mainFrame.Visible = true -- Меню изначально видимо
    mainFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Text = "APEX"
    title.Size = UDim2.new(1, 0, 0, 20)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 16
    title.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -20, 0, 0)
    closeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 16
    closeButton.Parent = mainFrame

    local openButton = Instance.new("TextButton")
    openButton.Text = "O"
    openButton.Size = UDim2.new(0, 20, 0, 20)
    openButton.Position = UDim2.new(0, 10, 0, 10)
    openButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    openButton.TextColor3 = Color3.new(1, 1, 1)
    openButton.Font = Enum.Font.SourceSansBold
    openButton.TextSize = 16
    openButton.Visible = false -- Изначально скрыт
    openButton.Parent = screenGui

    closeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false -- Скрываем меню
        openButton.Visible = true -- Показываем круг
    end)

    openButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = true -- Показываем меню
        openButton.Visible = false -- Скрываем круг
    end)

    local function setSpeed(value)
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end

    local speedCheckbox = Instance.new("TextButton")
    speedCheckbox.Text = "☐ Speed 50"
    speedCheckbox.Size = UDim2.new(0.8, 0, 0, 20)
    speedCheckbox.Position = UDim2.new(0.1, 0, 0.3, 0)
    speedCheckbox.BackgroundTransparency = 1 -- Прозрачный фон
    speedCheckbox.TextColor3 = Color3.new(1, 1, 1) -- Белый текст
    speedCheckbox.Font = Enum.Font.SourceSans
    speedCheckbox.TextSize = 14
    speedCheckbox.Parent = mainFrame

    local speedEnabled = false
    speedCheckbox.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        setSpeed(speedEnabled and 50 or 16) -- 16 - стандартная скорость
        speedCheckbox.Text = speedEnabled and "☑ Speed 50" or "☐ Speed 50"
    end)

    local function createESP(player)
        local character = player.Character
        if not character then return end

        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 0.5  -- Прозрачность заливки
        highlight.OutlineTransparency = 0  -- Прозрачность контура
        highlight.FillColor = Color3.new(0.5, 0, 0.5)  -- Фиолетовый цвет заливки
        highlight.OutlineColor = Color3.new(1, 1, 1)  -- Белый цвет контура
        highlight.Parent = character

        player.CharacterAdded:Connect(function(newCharacter)
            highlight.Parent = newCharacter
        end)

        player.AncestryChanged:Connect(function()
            if not player:IsDescendantOf(game) then
                highlight:Destroy()
            end
        end)
    end

    local function toggleESP(activated)
        if activated then
            -- Применяем ESP ко всем игрокам
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    createESP(player)
                end
            end

            game.Players.PlayerAdded:Connect(function(player)
                createESP(player)
            end)
        else
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end

    local espCheckbox = Instance.new("TextButton")
    espCheckbox.Text = "☐ ESP"
    espCheckbox.Size = UDim2.new(0.8, 0, 0, 20)
    espCheckbox.Position = UDim2.new(0.1, 0, 0.5, 0)
    espCheckbox.BackgroundTransparency = 1 -- Прозрачный фон
    espCheckbox.TextColor3 = Color3.new(1, 1, 1) -- Белый текст
    espCheckbox.Font = Enum.Font.SourceSans
    espCheckbox.TextSize = 14
    espCheckbox.Parent = mainFrame

    local espEnabled = false
    espCheckbox.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        toggleESP(espEnabled)
        espCheckbox.Text = espEnabled and "☑ ESP" or "☐ ESP"
    end)
end

local function restoreMenu()
    -- Убедимся, что PlayerGui загружен
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Если меню уже существует, удалим его
    if playerGui:FindFirstChild("ApexMenu") then
        playerGui.ApexMenu:Destroy()
    end

    -- Создаем новое меню
    createMenu()
end

game.Players.LocalPlayer.CharacterAdded:Connect(restoreMenu)

local function askForKey()
    -- Создаем ScreenGui для ввода ключа
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "KeyGui"
    keyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Основной фрейм для ввода ключа
    local keyFrame = Instance.new("Frame")
    keyFrame.Size = UDim2.new(0, 300, 0, 150)
    keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    keyFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    keyFrame.BorderSizePixel = 0
    keyFrame.Parent = keyGui

    local title = Instance.new("TextLabel")
    title.Text = "Введите ключ"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.Parent = keyFrame

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 30)
    keyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    keyBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    keyBox.TextColor3 = Color3.new(1, 1, 1)
    keyBox.Font = Enum.Font.SourceSans
    keyBox.TextSize = 16
    keyBox.PlaceholderText = "Введите ключ..."
    keyBox.Parent = keyFrame

    -- Кнопка для подтверждения ключа
    local submitButton = Instance.new("TextButton")
    submitButton.Text = "Подтвердить"
    submitButton.Size = UDim2.new(0.8, 0, 0, 30)
    submitButton.Position = UDim2.new(0.1, 0, 0.7, 0)
    submitButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    submitButton.TextColor3 = Color3.new(1, 1, 1)
    submitButton.Font = Enum.Font.SourceSans
    submitButton.TextSize = 16
    submitButton.Parent = keyFrame

    -- Обработка ввода ключа
    submitButton.MouseButton1Click:Connect(function()
        if keyBox.Text == "t.me/Apex_Script" then
            keyGui:Destroy() 
            createMenu() 
        else
            keyBox.Text = "NO WORK KEY"
        end
    end)
end

-- Запуск ввода ключа при старте скрипта
askForKey()