-- LocalScript - Universal Vector GUI - Color or Die
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer

local GUI_NAME = "UniversalVectorGUI"
local TITLE = "Universal Vector"

local COLORS = {
    background = Color3.fromRGB(30, 30, 30),
    button_off = Color3.fromRGB(60, 60, 60),
    button_on = Color3.fromRGB(60, 180, 60),
    button_warning = Color3.fromRGB(180, 140, 60),
    text_white = Color3.fromRGB(255, 255, 255),
    text_gray = Color3.fromRGB(150, 150, 150),
    text_dark = Color3.fromRGB(100, 100, 100)
}

local gui, mainFrame
local btnAutoFarm, btnDoor
local statusFarm
local infoLabel1, infoLabel2, infoLabel3

local autoFarmEnabled = false
local selectedDoor = 1

local paths = {
    {"GameplayParts.Doors.Normal.Paintable.Black.Core.ClickDetector", 11, 3, -1, 1},
    {"GameplayAssets.Items.Normal.PaintBucket.Red.Root.ProximityPrompt", 44, 3, 0, 2},
    {"GameplayParts.Doors.Normal.Paintable.Red.Core.ClickDetector", 193, 3, 31, 1},
    {"GameplayAssets.Items.Normal.Tool.ScrewDriver.Root.ProximityPrompt", 227, 3, 21, 2},
    {"GameplayParts.Doors.Normal.Unlockable.ScrewDriver.Core.ClickDetector", 142, 3, 54, 3},
    {"GameplayAssets.Items.Normal.PaintBucket.Orange.Root.ProximityPrompt", 822, 69, -626, 2},
    {"GameplayParts.Doors.Normal.Paintable.Orange.Core.ClickDetector", 255, 3, 41, 1},
    {"GameplayAssets.Items.Normal.PaintBucket.Yellow.Root.ProximityPrompt", 275, 3, 43, 2},
    {"GameplayParts.Doors.Normal.Paintable.Yellow.Core.ClickDetector", 204, 3, -33, 1},
    {"GameplayAssets.Items.Normal.PaintBucket.Green.Root.ProximityPrompt", 720, 152, 373, 2},
    {"GameplayParts.Doors.Normal.Paintable.Green.Core.ClickDetector", 322, 3, 67, 1},
    {"GameplayAssets.Items.Normal.PaintBucket.Teal.Root.ProximityPrompt", 355, 3, 103, 2},
    {"GameplayParts.Doors.Normal.Paintable.Teal.Core.ClickDetector", 835, 69, -595, 1},
    {"GameplayAssets.Items.Normal.Tool.Puzzle.Root.ProximityPrompt", 863, 69, -596, 2},
    {"GameplayParts.Doors.Normal.Unlockable.Puzzle.Core.ClickDetector", 324, 3, 91, 3},
    {"GameplayAssets.Items.Normal.PaintBucket.Blue.Root.ProximityPrompt", 324, 3, 112, 2},
    {"GameplayParts.Doors.Normal.Paintable.Blue.Core.ClickDetector", 288, 3, -104, 1},
    {"GameplayAssets.Items.Normal.Tool.Saw.Root.ProximityPrompt", 255, 3, -126, 2},
    {"GameplayParts.Doors.Normal.Unlockable.Saw.Core.ClickDetector", 192, 3, -55, 3},
    {"GameplayAssets.Items.Normal.Tool.Plank.Root.ProximityPrompt", 192, 3, -73, 2},
    {"GameplayAssets.Items.Normal.PaintBucket.Purple.Root.ProximityPrompt", 851, 42, -77, 2},
    {"GameplayParts.Doors.Normal.Paintable.Purple.Core.ClickDetector", 216, 3, -127, 1},
    {"GameplayParts.Doors.Normal.Buildable.Plank.Core.ClickDetector", 246, 28, -65, 3},
    {"GameplayAssets.Items.Normal.Tool.Hammer.Root.ProximityPrompt", 247, 28, -26, 2},
    {"GameplayParts.Doors.Normal.Unlockable.Hammer.Core.ClickDetector", 228, 3, 14, 3},
    {"GameplayAssets.Items.Normal.PaintBucket.Pink.Root.ProximityPrompt", 229, 3, 8, 2},
    {"GameplayParts.Doors.Normal.Paintable.Pink.Core.ClickDetector", 326, 3, 6, 1},
    {"GameplayAssets.Items.Normal.Tool.Key.Root.ProximityPrompt", 358, 3, 5, 2},
    {"GameplayParts.Doors.Normal.Unlockable.Key.Core.ClickDetector", 710, 152, 327, 3},
    {"GameplayAssets.Items.Collectable.Collectable.1.Root.ProximityPrompt", 108, 3, -57, 2},
    {"GameplayAssets.Items.Collectable.Collectable.2.Root.ProximityPrompt", 108, 3, 78, 2},
    {"GameplayAssets.Items.Collectable.Collectable.3.Root.ProximityPrompt", 215, 3, 69, 2},
    {"GameplayAssets.Items.Collectable.Collectable.4.Root.ProximityPrompt", 178, 3, -127, 2},
    {"GameplayAssets.Items.Collectable.Collectable.5.Root.ProximityPrompt", 107, 3, -7, 2},
    {"GameplayAssets.Items.Collectable.Collectable.6.Root.ProximityPrompt", 309, 28, -125, 2},
    {"GameplayAssets.Items.Collectable.Collectable.7.Root.ProximityPrompt", 823, 69, -612, 2},
    {"GameplayAssets.Items.Collectable.Collectable.8.Root.ProximityPrompt", 714, 152, 363, 2},
    {"GameplayAssets.Items.Collectable.Collectable.9.Root.ProximityPrompt", 364, 3, 101, 2},
    {"GameplayAssets.Items.Collectable.Collectable.10.Root.ProximityPrompt", 864, 69, -593, 2},
    {"GameplayAssets.Items.Collectable.Collectable.11.Root.ProximityPrompt", 856, 42, -65, 2},
    {"GameplayAssets.Items.Collectable.Collectable.12.Root.ProximityPrompt", 197, 28, -115, 2},
    {"GameplayAssets.Items.Collectable.Collectable.13.Root.ProximityPrompt", 707, 152, 303, 2},
    {"GameplayAssets.Items.Normal.PaintBucket.White.Root.ProximityPrompt", -171, -64, -367, 2},
    {"GameplayParts.Doors.Normal.Paintable.White.Core.ClickDetector", -23, 3, 19, 1},
}

local endDoors = {
    "GameplayParts.EndRooms.VisualAssets.EndingDoor1.Core",
    "GameplayParts.EndRooms.VisualAssets.EndingDoor2.Core",
    "GameplayParts.EndRooms.VisualAssets.EndingDoor3.Core",
    "GameplayParts.EndRooms.VisualAssets.EndingDoor4.Core",
}

local function getPath(p)
    local obj = workspace
    for part in p:gmatch("[^.]+") do
        obj = obj:FindFirstChild(part)
        if not obj then return nil end
    end
    return obj
end

local function getGui(p)
    local obj = player.PlayerGui
    for part in p:gmatch("[^.]+") do
        obj = obj:FindFirstChild(part)
        if not obj then return nil end
    end
    return obj
end

local function waitChar()
    repeat task.wait(0.2) until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    task.wait(0.5)
end

local function tp(pos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z) end
end

local function lookAt(targetPos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then workspace.CurrentCamera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 2, 0), targetPos) end
end

local function lookDown(targetPos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then workspace.CurrentCamera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 5, 0), targetPos) end
end

local function clickReal(part)
    if not part then return end
    local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(part.Position)
    if onScreen then
        VIM:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 1)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 1)
    end
end

local function clickCD(cd, clicks)
    if not cd then return end
    local part = cd.Parent
    if not part then return end
    cd.MaxActivationDistance = 9999
    lookAt(part.Position)
    task.wait(0.1)
    for i = 1, clicks do
        clickReal(part)
        task.wait(0.3)
    end
end

local function firePrompt(pp)
    if not pp then return end
    local root = pp.Parent
    if root and root:IsA("BasePart") then lookDown(root.Position) task.wait(0.2) end
    pp.MaxActivationDistance = 9999
    pp.HoldDuration = 0
    pp.RequiresLineOfSight = false
    task.wait(0.1)
    if fireproximityprompt then
        for i = 1, 3 do fireproximityprompt(pp) task.wait(0.15) end
    end
end

local function scanProgress()
    for i = #paths, 1, -1 do
        if not getPath(paths[i][1]) then return i + 1 end
    end
    return 1
end

local function waitGone(path, timeout)
    local t = 0
    while t < timeout do
        if not getPath(path) then return true end
        task.wait(0.15)
        t = t + 0.15
    end
    return false
end

local function clickLobby()
    task.wait(1)
    for i = 1, 10 do
        local lobbyBtn = getGui("MainGui.FullScreen.EndScreen.EscapeScreen.Buttons.LobbyButton")
        if lobbyBtn then
            local pos = lobbyBtn.AbsolutePosition + lobbyBtn.AbsoluteSize / 2
            pos = Vector2.new(pos.X, pos.Y + 20)
            VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
            task.wait(0.5)
        end
        if not getGui("MainGui.FullScreen.EndScreen.EscapeScreen") then break end
        task.wait(0.3)
    end
    task.wait(1)
end

local function createUI()
    local oldGui = player:WaitForChild("PlayerGui"):FindFirstChild(GUI_NAME)
    if oldGui then oldGui:Destroy() end
    
    gui = Instance.new("ScreenGui")
    gui.Name = GUI_NAME
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 170)
    mainFrame.Position = UDim2.new(0, 10, 0.5, -85)
    mainFrame.BackgroundColor3 = COLORS.background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = TITLE .. " - Color or Die"
    title.TextColor3 = COLORS.text_white
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    btnAutoFarm = Instance.new("TextButton")
    btnAutoFarm.Size = UDim2.new(0.8, 0, 0, 28)
    btnAutoFarm.Position = UDim2.new(0.1, 0, 0, 35)
    btnAutoFarm.BackgroundColor3 = COLORS.button_off
    btnAutoFarm.Text = "Auto Farm: OFF"
    btnAutoFarm.TextColor3 = COLORS.text_white
    btnAutoFarm.TextSize = 11
    btnAutoFarm.Font = Enum.Font.GothamBold
    btnAutoFarm.Parent = mainFrame
    Instance.new("UICorner", btnAutoFarm).CornerRadius = UDim.new(0, 6)
    
    statusFarm = Instance.new("TextLabel")
    statusFarm.Size = UDim2.new(1, 0, 0, 12)
    statusFarm.Position = UDim2.new(0, 0, 0, 64)
    statusFarm.BackgroundTransparency = 1
    statusFarm.Text = ""
    statusFarm.TextColor3 = COLORS.text_gray
    statusFarm.TextSize = 9
    statusFarm.Font = Enum.Font.Gotham
    statusFarm.Parent = mainFrame
    
    btnDoor = Instance.new("TextButton")
    btnDoor.Size = UDim2.new(0.8, 0, 0, 28)
    btnDoor.Position = UDim2.new(0.1, 0, 0, 80)
    btnDoor.BackgroundColor3 = COLORS.button_warning
    btnDoor.Text = "Porta Final: 1"
    btnDoor.TextColor3 = COLORS.text_white
    btnDoor.TextSize = 11
    btnDoor.Font = Enum.Font.GothamBold
    btnDoor.Parent = mainFrame
    Instance.new("UICorner", btnDoor).CornerRadius = UDim.new(0, 6)
    
    infoLabel1 = Instance.new("TextLabel")
    infoLabel1.Size = UDim2.new(1, 0, 0, 15)
    infoLabel1.Position = UDim2.new(0, 0, 0, 115)
    infoLabel1.BackgroundTransparency = 1
    infoLabel1.Text = "Progresso: 0/" .. #paths
    infoLabel1.TextColor3 = COLORS.text_dark
    infoLabel1.TextSize = 9
    infoLabel1.Font = Enum.Font.Gotham
    infoLabel1.Parent = mainFrame
    
    infoLabel2 = Instance.new("TextLabel")
    infoLabel2.Size = UDim2.new(1, 0, 0, 15)
    infoLabel2.Position = UDim2.new(0, 0, 0, 132)
    infoLabel2.BackgroundTransparency = 1
    infoLabel2.Text = "Players: " .. #Players:GetPlayers()
    infoLabel2.TextColor3 = COLORS.text_dark
    infoLabel2.TextSize = 9
    infoLabel2.Font = Enum.Font.Gotham
    infoLabel2.Parent = mainFrame
    
    infoLabel3 = Instance.new("TextLabel")
    infoLabel3.Size = UDim2.new(1, 0, 0, 15)
    infoLabel3.Position = UDim2.new(0, 0, 0, 149)
    infoLabel3.BackgroundTransparency = 1
    infoLabel3.Text = "Universal Vector v1.0"
    infoLabel3.TextColor3 = COLORS.text_dark
    infoLabel3.TextSize = 8
    infoLabel3.Font = Enum.Font.Gotham
    infoLabel3.Parent = mainFrame
    
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

local function runAutoFarm()
    while autoFarmEnabled do
        waitChar()
        local startIndex = scanProgress()
        
        for i = startIndex, #paths do
            if not autoFarmEnabled then return end
            local data = paths[i]
            local path, x, y, z, tipo = data[1], data[2], data[3], data[4], data[5]
            statusFarm.Text = "Passo " .. i .. "/" .. #paths
            tp(Vector3.new(x, y, z))
            task.wait(0.4)
            local obj = getPath(path)
            if obj then
                for attempt = 1, 8 do
                    if not autoFarmEnabled then return end
                    obj = getPath(path)
                    if not obj then break end
                    if tipo == 1 then clickCD(obj, 5)
                    elseif tipo == 3 then clickCD(obj, 1)
                    else firePrompt(obj) end
                    task.wait(0.4)
                end
            end
            waitGone(path, 3)
            task.wait(0.2)
        end
        
        if autoFarmEnabled then
            statusFarm.Text = "Indo para porta..."
            local door = getPath(endDoors[selectedDoor])
            if door then tp(door.Position) end
            task.wait(0.5)
            if player.Character then
                local hum = player.Character:FindFirstChild("Humanoid")
                if hum then hum.Health = 0 end
            end
            statusFarm.Text = "Renascendo..."
            clickLobby()
        end
    end
end

local function toggleAutoFarm()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        btnAutoFarm.Text = "Auto Farm: ON"
        btnAutoFarm.BackgroundColor3 = COLORS.button_on
        statusFarm.Text = "Iniciando..."
        task.spawn(runAutoFarm)
    else
        btnAutoFarm.Text = "Auto Farm: OFF"
        btnAutoFarm.BackgroundColor3 = COLORS.button_off
        statusFarm.Text = "Parado"
    end
end

local function toggleDoor()
    selectedDoor = selectedDoor % 4 + 1
    btnDoor.Text = "Porta Final: " .. selectedDoor
end

local function updateInfo()
    local progress = scanProgress() - 1
    if progress < 0 then progress = 0 end
    infoLabel1.Text = "Progresso: " .. progress .. "/" .. #paths
    infoLabel2.Text = "Players: " .. #Players:GetPlayers()
end

createUI()
btnAutoFarm.MouseButton1Click:Connect(toggleAutoFarm)
btnDoor.MouseButton1Click:Connect(toggleDoor)

task.spawn(function()
    while true do updateInfo() task.wait(2) end
end)

updateInfo()
print("Universal Vector - Color or Die carregado!")