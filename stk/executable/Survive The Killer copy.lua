local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local gui, mainFrame, toggleLoot, toggleEscape, toggleSafe, toggleFarm
local statusLoot, statusEscape, statusSafe, statusFarm
local lootEnabled, escapeEnabled, safeEnabled, farmEnabled = false, false, false, false
local mapModel, lootSpawns, exitGateway = nil, nil, nil
local doorsOpened = false
local isEscaping = false

local lootConn, escapeConn, safeConn, farmConn = nil, nil, nil, nil

local SAFE_DISTANCE = 25
local MIN_ESCAPE_DISTANCE = 50
local WALK_SPEED = 20
local MIN_PLAYERS = 3

local AUTO_START = false
if getgenv then
    AUTO_START = getgenv().AutoFarmStart == true
    getgenv().AutoFarmStart = nil
end

local function isInSurvivorTeam()
    local team = player.Team
    if not team then return false end
    local name = team.Name:lower()
    return name:find("surviv") or name:find("alive") or name:find("player")
end

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

local function getSafeSpawn(killerPos)
    if not lootSpawns or not lootSpawns.Parent then return nil end
    
    local bestSpawn, bestDist = nil, 0
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

local function createUI()

    local oldGui = player:WaitForChild("PlayerGui"):FindFirstChild("AutoCollectGUI")
    if oldGui then oldGui:Destroy() end
    
    gui = Instance.new("ScreenGui")
    gui.Name = "AutoCollectGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 270)
    mainFrame.Position = UDim2.new(0, 10, 0.5, -135)
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
    
    toggleFarm = Instance.new("TextButton")
    toggleFarm.Size = UDim2.new(0.8, 0, 0, 28)
    toggleFarm.Position = UDim2.new(0.1, 0, 0, 158)
    toggleFarm.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleFarm.Text = "Auto Farm: OFF"
    toggleFarm.TextColor3 = Color3.new(1, 1, 1)
    toggleFarm.TextSize = 11
    toggleFarm.Font = Enum.Font.GothamBold
    toggleFarm.Parent = mainFrame
    Instance.new("UICorner", toggleFarm).CornerRadius = UDim.new(0, 6)
    
    statusFarm = Instance.new("TextLabel")
    statusFarm.Size = UDim2.new(1, 0, 0, 12)
    statusFarm.Position = UDim2.new(0, 0, 0, 187)
    statusFarm.BackgroundTransparency = 1
    statusFarm.Text = ""
    statusFarm.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusFarm.TextSize = 9
    statusFarm.Font = Enum.Font.Gotham
    statusFarm.Parent = mainFrame
    
    local mapStatus = Instance.new("TextLabel")
    mapStatus.Name = "MapStatus"
    mapStatus.Size = UDim2.new(1, 0, 0, 18)
    mapStatus.Position = UDim2.new(0, 0, 0, 205)
    mapStatus.BackgroundTransparency = 1
    mapStatus.Text = "Mapa: --"
    mapStatus.TextColor3 = Color3.fromRGB(100, 100, 100)
    mapStatus.TextSize = 9
    mapStatus.Font = Enum.Font.Gotham
    mapStatus.Parent = mainFrame
    
    local playerCount = Instance.new("TextLabel")
    playerCount.Name = "PlayerCount"
    playerCount.Size = UDim2.new(1, 0, 0, 18)
    playerCount.Position = UDim2.new(0, 0, 0, 222)
    playerCount.BackgroundTransparency = 1
    playerCount.Text = "Players: 0 | Anti-AFK: ON"
    playerCount.TextColor3 = Color3.fromRGB(100, 100, 100)
    playerCount.TextSize = 9
    playerCount.Font = Enum.Font.Gotham
    playerCount.Parent = mainFrame
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 20)
    infoLabel.Position = UDim2.new(0, 0, 0, 240)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Hop se <= " .. MIN_PLAYERS .. " players"
    infoLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
    infoLabel.TextSize = 8
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = mainFrame
    
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
                    local children = exits:GetChildren()
                    if children[1] then
                        exitGateway = children[1]
                    end
                end
                return true
            end
        end
    end
    return false
end

local function updateMapStatus()
    local mapLabel = mainFrame and mainFrame:FindFirstChild("MapStatus")
    if mapLabel then
        mapLabel.Text = mapModel and ("Mapa: " .. mapModel.Name) or "Mapa: --"
    end
end

local function updatePlayerCount()
    local countLabel = mainFrame and mainFrame:FindFirstChild("PlayerCount")
    if countLabel then
        countLabel.Text = "Players: " .. #Players:GetPlayers() .. " | Anti-AFK: ON"
    end
end

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

local function checkDoorsOpened()
    if not exitGateway then return false end
    if doorsOpened then return true end
    
    local doorway = exitGateway:FindFirstChild("Doorway")
    if not doorway then return false end
    
    local door1 = doorway:FindFirstChild("Door1")
    local door2 = doorway:FindFirstChild("Door2")
    local door1Dest = doorway:FindFirstChild("Door1Destination")
    local door2Dest = doorway:FindFirstChild("Door2Destination")
    
    if not door1 and not door2 then
        doorsOpened = true
        return true
    end
    
    if door1 and door1Dest then
        if (door1.Position - door1Dest.Position).Magnitude < 2 then
            doorsOpened = true
            return true
        end
    end
    
    if door2 and door2Dest then
        if (door2.Position - door2Dest.Position).Magnitude < 2 then
            doorsOpened = true
            return true
        end
    end
    
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

local function walkToEscape()
    if not exitGateway then return false end
    
    local doorway = exitGateway:FindFirstChild("Doorway")
    local trigger = exitGateway:FindFirstChild("Trigger")
    if not doorway or not trigger then return false end
    
    local frame = doorway:FindFirstChild("Frame")
    if not frame then return false end
    
    local frameChildren = frame:GetChildren()
    local part4 = frameChildren[4]
    if not part4 or not part4:IsA("BasePart") then return false end
    
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    local floorY = part4.Position.Y + 3
    local startPos = Vector3.new(part4.Position.X, floorY, part4.Position.Z)
    local endPos = Vector3.new(trigger.Position.X, floorY, trigger.Position.Z)
    
    root.CFrame = CFrame.new(startPos)
    task.wait(0.1)
    
    local direction = (endPos - startPos).Unit
    local distance = (endPos - startPos).Magnitude
    
    local walked = 0
    while walked < distance and isEscaping and isInSurvivorTeam() and escapeEnabled do
        local step = WALK_SPEED * 0.03
        walked = walked + step
        
        if walked > distance then
            walked = distance
        end
        
        local newPos = startPos + (direction * walked)
        root.CFrame = CFrame.new(newPos) * CFrame.Angles(0, math.atan2(direction.X, direction.Z), 0)
        
        task.wait(0.03)
    end
    
    return true
end

local function serverHop()
    local placeId = game.PlaceId
    local currentJobId = game.JobId
    
    statusFarm.Text = "Buscando servidor..."
    
    local success, servers = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if success and servers and servers.data then
        for _, server in ipairs(servers.data) do
            if server.id ~= currentJobId and server.playing and server.playing > MIN_PLAYERS and server.playing < server.maxPlayers then
                statusFarm.Text = "Entrando: " .. server.playing .. " players"
                
                if queue_on_teleport then
                    queue_on_teleport([[
                        task.wait(3)
                        if getgenv then
                            getgenv().AutoFarmStart = true
                        end
                        loadstring(game:HttpGet("]] .. (getgenv and getgenv().ScriptURL or "https://raw.githubusercontent.com/spiralRbx/rbx-scripts-spxmenu/refs/heads/main/stk/executable/Survive%20The%20Killer.lua") .. [["))()
                    ]])
                end
                
                task.wait(1)
                TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
                return true
            end
        end
    end
    
    statusFarm.Text = "Hop simples..."
    
    if queue_on_teleport then
        queue_on_teleport([[
            task.wait(3)
            if getgenv then
                getgenv().AutoFarmStart = true
            end
            loadstring(game:HttpGet("]] .. (getgenv and getgenv().ScriptURL or "https://raw.githubusercontent.com/spiralRbx/rbx-scripts-spxmenu/refs/heads/main/stk/executable/Survive%20The%20Killer.lua") .. [["))()
        ]])
    end
    
    task.wait(1)
    TeleportService:Teleport(placeId, player)
    return true
end

local function startAntiAFK()
    pcall(function()
        player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
    
    task.spawn(function()
        while true do
            task.wait(60)
            pcall(function()
                local char = player.Character
                local humanoid = char and char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Jump = true
                end
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
end

local function collectLoop(threadId)
    while lootEnabled and lootConn == threadId do
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
                if not lootEnabled or lootConn ~= threadId or not isInSurvivorTeam() or isEscaping then break end
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

local function escapeLoop(threadId)
    while escapeEnabled and escapeConn == threadId do
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
                statusEscape.Text = "Andando para saída..."
                walkToEscape()
                statusEscape.Text = "Escapou!"
            else
                statusEscape.Text = "Monitorando portas..."
            end
        else
            statusEscape.Text = "Buscando mapa..."
        end
        
        task.wait(0.1)
    end
end

local function safeLoop(threadId)
    while safeEnabled and safeConn == threadId do
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

local function farmLoop(threadId)
    while farmEnabled and farmConn == threadId do
        updatePlayerCount()
        
        local playerCount = #Players:GetPlayers()
        
        if playerCount <= MIN_PLAYERS then
            statusFarm.Text = "Poucos players! Hop em 5s..."
            task.wait(5)
            
            if farmEnabled and farmConn == threadId and #Players:GetPlayers() <= MIN_PLAYERS then
                serverHop()
            end
        else
            statusFarm.Text = "Farmando... (" .. playerCount .. " players)"
        end
        
        task.wait(3)
    end
end

local function toggleLootScript()
    if not lootEnabled then
        lootEnabled = true
        local threadId = tick()
        lootConn = threadId
        toggleLoot.Text = "Auto Loot: ON"
        toggleLoot.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        findMap()
        updateMapStatus()
        task.spawn(function() collectLoop(threadId) end)
    else
        lootEnabled = false
        lootConn = nil
        toggleLoot.Text = "Auto Loot: OFF"
        toggleLoot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusLoot.Text = ""
    end
end

local function toggleEscapeScript()
    if not escapeEnabled then
        escapeEnabled = true
        doorsOpened = false
        local threadId = tick()
        escapeConn = threadId
        toggleEscape.Text = "Auto Escape: ON"
        toggleEscape.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        findMap()
        updateMapStatus()
        task.spawn(function() escapeLoop(threadId) end)
    else
        escapeEnabled = false
        isEscaping = false
        escapeConn = nil
        toggleEscape.Text = "Auto Escape: OFF"
        toggleEscape.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusEscape.Text = ""
    end
end

local function toggleSafeScript()
    if not safeEnabled then
        safeEnabled = true
        local threadId = tick()
        safeConn = threadId
        toggleSafe.Text = "Killer Evade: ON"
        toggleSafe.BackgroundColor3 = Color3.fromRGB(180, 140, 60)
        findMap()
        updateMapStatus()
        task.spawn(function() safeLoop(threadId) end)
    else
        safeEnabled = false
        safeConn = nil
        toggleSafe.Text = "Killer Evade: OFF"
        toggleSafe.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusSafe.Text = ""
    end
end

local function toggleFarmScript()
    if not farmEnabled then
        farmEnabled = true
        local threadId = tick()
        farmConn = threadId
        toggleFarm.Text = "Auto Farm: ON"
        toggleFarm.BackgroundColor3 = Color3.fromRGB(140, 60, 180)
        
        if not lootEnabled then toggleLootScript() end
        if not escapeEnabled then toggleEscapeScript() end
        if not safeEnabled then toggleSafeScript() end
        
        task.spawn(function() farmLoop(threadId) end)
    else
        farmEnabled = false
        farmConn = nil
        toggleFarm.Text = "Auto Farm: OFF"
        toggleFarm.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        statusFarm.Text = ""
    end
end

createUI()
toggleLoot.MouseButton1Click:Connect(toggleLootScript)
toggleEscape.MouseButton1Click:Connect(toggleEscapeScript)
toggleSafe.MouseButton1Click:Connect(toggleSafeScript)
toggleFarm.MouseButton1Click:Connect(toggleFarmScript)

startAntiAFK()

task.spawn(function()
    while true do
        updatePlayerCount()
        task.wait(5)
    end
end)

if AUTO_START then
    task.wait(2)
    toggleFarmScript()
end