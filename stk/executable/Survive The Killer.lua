-- LocalScript - Auto Collect Loot v12

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui, mainFrame, toggleLoot, toggleEscape, toggleSafe, statusLoot, statusEscape, statusSafe
local lootEnabled, escapeEnabled, safeEnabled = false, false, false
local mapModel, lootSpawns, exitGateway = nil, nil, nil
local doorsOpened = false
local isEscaping = false

local SAFE_DISTANCE = 25
local MIN_ESCAPE_DISTANCE = 50

-- Verificar se está no team de sobrevivente
local function isInSurvivorTeam()
    local team = player.Team
    if not team then return false end
    local name = team.Name:lower()
    return name:find("surviv") or name:find("alive") or name:find("player")
end

-- Pegar killers próximos
local function getNearbyKillers()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return {} end
    
    local killers = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Team then
            local teamName = p.Team.Name:lower()
            if teamName:find("killer") or teamName:find("beast") or teamName:find("hunter") or teamName:find("monster") then
                local pChar = p.Character
                local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
                if pRoot then
                    local dist = (root.Position - pRoot.Position).Magnitude
                    if dist < SAFE_DISTANCE then
                        table.insert(killers, {player = p, root = pRoot, distance = dist})
                    end
                end
            end
        end
    end
    return killers
end

-- Pegar spawn seguro longe do killer
local function getSafeSpawn(killerPos)
    if not lootSpawns or not lootSpawns.Parent then return nil end
    
    local bestSpawn = nil
    local bestDist = 0
    
    for _, spawn in ipairs(lootSpawns:GetChildren()) do
        if spawn:IsA("BasePart") then
            local dist = (spawn.Position - killerPos).Magnitude
            if dist > MIN_ESCAPE_DISTANCE and dist > bestDist then
                bestDist = dist
                bestSpawn = spawn
            end
        end
    end
    
    if not bestSpawn then
        for _, spawn in ipairs(lootSpawns:GetChildren()) do
            if spawn:IsA("BasePart") then
                local dist = (spawn.Position - killerPos).Magnitude
                if dist > bestDist then
                    bestDist = dist
                    bestSpawn = spawn
                end
            end
        end
    end
    
    return bestSpawn
end

-- Criar UI
local function createUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "AutoCollectGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 220)
    mainFrame.Position = UDim2.new(0, 10, 0.5, -110)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundTransparency = 1
    title.Text = "Auto Script"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    toggleLoot = Instance.new("TextButton")
    toggleLoot.Size = UDim2.new(0.8, 0, 0, 28)
    toggleLoot.Position = UDim2.new(0.1, 0, 0, 26)
    toggleLoot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleLoot.Text = "Auto Loot: OFF"
    toggleLoot.TextColor3 = Color3.new(1, 1, 1)
    toggleLoot.TextSize = 11
    toggleLoot.Font = Enum.Font.GothamBold
    toggleLoot.Parent = mainFrame
    Instance.new("UICorner", toggleLoot).CornerRadius = UDim.new(0, 6)
    
    statusLoot = Instance.new("TextLabel")
    statusLoot.Size = UDim2.new(1, 0, 0, 12)
    statusLoot.Position = UDim2.new(0, 0, 0, 55)
    statusLoot.BackgroundTransparency = 1
    statusLoot.Text = ""
    statusLoot.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusLoot.TextSize = 9
    statusLoot.Font = Enum.Font.Gotham
    statusLoot.Parent = mainFrame
    
    toggleEscape = Instance.new("TextButton")
    toggleEscape.Size = UDim2.new(0.8, 0, 0, 28)
    toggleEscape.Position = UDim2.new(0.1, 0, 0, 70)
    toggleEscape.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleEscape.Text = "Auto Escape: OFF"
    toggleEscape.TextColor3 = Color3.new(1, 1, 1)
    toggleEscape.TextSize = 11
    toggleEscape.Font = Enum.Font.GothamBold
    toggleEscape.Parent = mainFrame
    Instance.new("UICorner", toggleEscape).CornerRadius = UDim.new(0, 6)
    
    statusEscape = Instance.new("TextLabel")
    statusEscape.Size = UDim2.new(1, 0, 0, 12)
    statusEscape.Position = UDim2.new(0, 0, 0, 99)
    statusEscape.BackgroundTransparency = 1
    statusEscape.Text = ""
    statusEscape.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusEscape.TextSize = 9
    statusEscape.Font = Enum.Font.Gotham
    statusEscape.Parent = mainFrame
    
    toggleSafe = Instance.new("TextButton")
    toggleSafe.Size = UDim2.new(0.8, 0, 0, 28)
    toggleSafe.Position = UDim2.new(0.1, 0, 0, 114)
    toggleSafe.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleSafe.Text = "Killer Evade: OFF"
    toggleSafe.TextColor3 = Color3.new(1, 1, 1)
    toggleSafe.TextSize = 11
    toggleSafe.Font = Enum.Font.GothamBold
    toggleSafe.Parent = mainFrame
    Instance.new("UICorner", toggleSafe).CornerRadius = UDim.new(0, 6)
    
    statusSafe = Instance.new("TextLabel")
    statusSafe.Size = UDim2.new(1, 0, 0, 12)
    statusSafe.Position = UDim2.new(0, 0, 0, 143)
    statusSafe.BackgroundTransparency = 1
    statusSafe.Text = ""
    statusSafe.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusSafe.TextSize = 9
    statusSafe.Font = Enum.Font.Gotham
    statusSafe.Parent = mainFrame
    
    local mapStatus = Instance.new("TextLabel")
    mapStatus.Name = "MapStatus"
    mapStatus.Size = UDim2.new(1, 0, 0, 18)
    mapStatus.Position = UDim2.new(0, 0, 0, 160)
    mapStatus.BackgroundTransparency = 1
    mapStatus.Text = "Mapa: --"
    mapStatus.TextColor3 = Color3.fromRGB(100, 100, 100)
    mapStatus.TextSize = 9
    mapStatus.Font = Enum.Font.Gotham
    mapStatus.Parent = mainFrame
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 30)
    infoLabel.Position = UDim2.new(0, 0, 0, 180)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Evade: " .. SAFE_DISTANCE .. " studs"
    infoLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
    infoLabel.TextSize = 8
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = mainFrame
    
    -- Drag
    local dragging, dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging, dragStart, startPos = true, input.Position, mainFrame.Position
        end
    end)
    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Encontrar Mapa
local function findMap()
    mapModel, lootSpawns, exitGateway = nil, nil, nil
    doorsOpened = false
    isEscaping = false
    
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") or obj:IsA("Folder") then
            local loots = obj:FindFirstChild("LootSpawns")
            local exits = obj:FindFirstChild("Exits")
            if loots or exits then
                mapModel = obj
                lootSpawns = loots
                if exits then
                    exitGateway = exits:FindFirstChild("ExitGateway")
                end
                return true
            end
        end
    end
    return false
end

local function updateMapStatus()
    local mapLabel = mainFrame:FindFirstChild("MapStatus")
    if mapLabel then
        mapLabel.Text = mapModel and ("Mapa: " .. mapModel.Name) or "Mapa: --"
    end
end

-- Verificar loot
local function hasAvailableLoot(spawnPart)
    for _, model in ipairs(spawnPart:GetChildren()) do
        if model:IsA("Model") then
            for _, part in ipairs(model:GetDescendants()) do
                if part:IsA("BasePart") and part.Transparency == 0 then
                    return true
                end
            end
        end
    end
    return false
end

local function getAvailableSpawns()
    if not lootSpawns or not lootSpawns.Parent then
        findMap()
        if not lootSpawns then return {} end
    end
    local available = {}
    for _, spawn in ipairs(lootSpawns:GetChildren()) do
        if spawn:IsA("BasePart") and hasAvailableLoot(spawn) then
            table.insert(available, spawn)
        end
    end
    return available
end

-- Verificar se portas estão abertas
local function checkDoorsOpened()
    if not exitGateway then return false end
    if doorsOpened then return true end
    
    local doorway = exitGateway:FindFirstChild("Doorway")
    if not doorway then return false end
    
    local door1 = doorway:FindFirstChild("Door1")
    local door2 = doorway:FindFirstChild("Door2")
    local door1Dest = doorway:FindFirstChild("Door1Destination")
    local door2Dest = doorway:FindFirstChild("Door2Destination")
    
    -- Se não tem portas, considera aberto
    if not door1 and not door2 then
        doorsOpened = true
        return true
    end
    
    -- Verifica se portas estão perto do Destination (já abertas)
    if door1 and door1Dest then
        local dist1 = (door1.Position - door1Dest.Position).Magnitude
        if dist1 < 2 then
            doorsOpened = true
            return true
        end
    end
    
    if door2 and door2Dest then
        local dist2 = (door2.Position - door2Dest.Position).Magnitude
        if dist2 < 2 then
            doorsOpened = true
            return true
        end
    end
    
    -- Verifica se portas estão se movendo (CFrame mudando)
    if door1 and door1.AssemblyLinearVelocity.Magnitude > 0.1 then
        doorsOpened = true
        return true
    end
    
    if door2 and door2.AssemblyLinearVelocity.Magnitude > 0.1 then
        doorsOpened = true
        return true
    end
    
    return false
end

-- Pegar Bouncer e calcular posição
local function getBouncer()
    if not exitGateway then return nil end
    return exitGateway:FindFirstChild("Bouncer")
end

-- Teleportar para dentro do Bouncer (pés no chão)
local function teleportToBouncer()
    local bouncer = getBouncer()
    if not bouncer then return false end
    
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    -- Calcular posição com pés no chão dentro do Bouncer
    -- Bouncer Size Y = 7, então o chão é Position.Y - (Size.Y / 2)
    -- HumanoidRootPart fica ~3 studs acima dos pés
    local bouncerPos = bouncer.Position
    local bouncerSizeY = bouncer.Size.Y
    local floorY = bouncerPos.Y - (bouncerSizeY / 2) + 3
    
    root.CFrame = CFrame.new(bouncerPos.X, floorY, bouncerPos.Z)
    return true
end

-- Loop de coleta
local function collectLoop()
    while lootEnabled do
        if not isInSurvivorTeam() then
            statusLoot.Text = "Aguardando partida..."
            task.wait(1)
            continue
        end
        
        if isEscaping then
            statusLoot.Text = "Escape ativo..."
            task.wait(0.5)
            continue
        end
        
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then task.wait(0.5) continue end
        
        local spawns = getAvailableSpawns()
        
        if #spawns > 0 then
            statusLoot.Text = "Coletando " .. #spawns .. " loots..."
            for _, spawn in ipairs(spawns) do
                if not lootEnabled or not isInSurvivorTeam() or isEscaping then break end
                if hasAvailableLoot(spawn) then
                    root.CFrame = CFrame.new(spawn.Position + Vector3.new(0, 2, 0))
                    task.wait(0.08)
                end
            end
        else
            statusLoot.Text = "Aguardando loot..."
        end
        task.wait(0.1)
    end
end

-- Loop de escape
local function escapeLoop()
    while escapeEnabled do
        if not isInSurvivorTeam() then
            statusEscape.Text = "Aguardando partida..."
            doorsOpened = false
            isEscaping = false
            mapModel = nil
            task.wait(1)
            continue
        end
        
        if not exitGateway or not exitGateway.Parent then
            findMap()
            updateMapStatus()
        end
        
        if exitGateway then
            if checkDoorsOpened() then
                isEscaping = true
                statusEscape.Text = "Escapando..."
                teleportToBouncer()
            else
                statusEscape.Text = "Monitorando portas..."
            end
        else
            statusEscape.Text = "Buscando mapa..."
        end
        
        task.wait(0.1)
    end
end

-- Loop de Killer Evade
local function safeLoop()
    while safeEnabled do
        if not isInSurvivorTeam() then
            statusSafe.Text = "Aguardando partida..."
            task.wait(1)
            continue
        end
        
        if isEscaping then
            statusSafe.Text = "Escape ativo..."
            task.wait(0.5)
            continue
        end
        
        if not lootSpawns or not lootSpawns.Parent then
            findMap()
        end
        
        local killers = getNearbyKillers()
        
        if #killers > 0 then
            local nearest = killers[1]
            for _, k in ipairs(killers) do
                if k.distance < nearest.distance then
                    nearest = k
                end
            end
            
            statusSafe.Text = "PERIGO! " .. string.format("%.1f", nearest.distance) .. " studs"
            
            local safeSpawn = getSafeSpawn(nearest.root.Position)
            if safeSpawn then
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(safeSpawn.Position + Vector3.new(0, 3, 0))
                    statusSafe.Text = "Evadido!"
                    task.wait(0.3)
                end
            end
        else
            statusSafe.Text = "Seguro"
        end
        
        task.wait(0.1)
    end
end

-- Toggles
local function toggleLootScript()
    if not lootEnabled then
        lootEnabled = true
        toggleLoot.Text = "Auto Loot: ON"
        toggleLoot.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        findMap()
        updateMapStatus()
        task.spawn(collectLoop)
    else
        lootEnabled = false
        toggleLoot.Text = "Auto Loot: OFF"
        toggleLoot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusLoot.Text = ""
    end
end

local function toggleEscapeScript()
    if not escapeEnabled then
        escapeEnabled = true
        doorsOpened = false -- Reset para verificar novamente
        toggleEscape.Text = "Auto Escape: ON"
        toggleEscape.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        findMap()
        updateMapStatus()
        task.spawn(escapeLoop)
    else
        escapeEnabled = false
        isEscaping = false
        toggleEscape.Text = "Auto Escape: OFF"
        toggleEscape.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusEscape.Text = ""
    end
end

local function toggleSafeScript()
    if not safeEnabled then
        safeEnabled = true
        toggleSafe.Text = "Killer Evade: ON"
        toggleSafe.BackgroundColor3 = Color3.fromRGB(180, 140, 60)
        findMap()
        updateMapStatus()
        task.spawn(safeLoop)
    else
        safeEnabled = false
        toggleSafe.Text = "Killer Evade: OFF"
        toggleSafe.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusSafe.Text = ""
    end
end

createUI()
toggleLoot.MouseButton1Click:Connect(toggleLootScript)
toggleEscape.MouseButton1Click:Connect(toggleEscapeScript)
toggleSafe.MouseButton1Click:Connect(toggleSafeScript)