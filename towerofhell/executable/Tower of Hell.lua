-- Universal Vector - Tower Items

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer

local COLORS = {
    bg = Color3.fromRGB(20, 20, 25),
    card = Color3.fromRGB(35, 35, 45),
    btn = Color3.fromRGB(50, 130, 50),
    btn_hover = Color3.fromRGB(70, 160, 70),
    text = Color3.fromRGB(255, 255, 255),
    text2 = Color3.fromRGB(160, 160, 160),
    text3 = Color3.fromRGB(100, 100, 100)
}

local gui, mainFrame

local function getAllTools()
    local tools = {}
    local gear = RS:FindFirstChild("Assets") and RS.Assets:FindFirstChild("Gear")
    if gear then
        for _, v in pairs(gear:GetChildren()) do
            if v:IsA("Tool") then
                table.insert(tools, v.Name)
            end
        end
    end
    table.sort(tools)
    return tools
end

local function cloneLocal(toolName)
    local gear = RS:FindFirstChild("Assets") and RS.Assets:FindFirstChild("Gear")
    if not gear then return false end
    
    local tool = gear:FindFirstChild(toolName)
    if not tool or not tool:IsA("Tool") then return false end
    
    local bp = player.Backpack:FindFirstChild(toolName)
    if bp then bp:Destroy() end
    
    local ch = player.Character and player.Character:FindFirstChild(toolName)
    if ch then ch:Destroy() end
    
    local clone = tool:Clone()
    clone.Parent = player.Backpack
    
    task.delay(0.1, function()
        if player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and clone.Parent == player.Backpack then
                hum:EquipTool(clone)
            end
        end
    end)
    
    return true
end

local function getGameName()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and info then
        return info.Name
    end
    return "Unknown Game"
end

local function createUI()
    local old = player:WaitForChild("PlayerGui"):FindFirstChild("UniversalVectorItems")
    if old then old:Destroy() end
    
    local ITEMS = getAllTools()
    local gameName = getGameName()
    
    gui = Instance.new("ScreenGui")
    gui.Name = "UniversalVectorItems"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 280, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
    mainFrame.BackgroundColor3 = COLORS.bg
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 36)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Universal Vector"
    title.TextColor3 = COLORS.text
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -32, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
    closeBtn.Text = "x"
    closeBtn.TextColor3 = COLORS.text
    closeBtn.TextSize = 12
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = header
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)
    
    -- Scroll
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -16, 1, -62)
    scroll.Position = UDim2.new(0, 8, 0, 42)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = mainFrame
    
    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 82, 0, 90)
    grid.CellPadding = UDim2.new(0, 6, 0, 6)
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid.Parent = scroll
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 4)
    padding.Parent = scroll
    
    -- Cards
    for i, itemName in ipairs(ITEMS) do
        local card = Instance.new("Frame")
        card.BackgroundColor3 = COLORS.card
        card.BorderSizePixel = 0
        card.LayoutOrder = i
        card.Parent = scroll
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
        
        local imgHolder = Instance.new("Frame")
        imgHolder.Size = UDim2.new(0, 44, 0, 44)
        imgHolder.Position = UDim2.new(0.5, -22, 0, 6)
        imgHolder.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        imgHolder.BorderSizePixel = 0
        imgHolder.Parent = card
        Instance.new("UICorner", imgHolder).CornerRadius = UDim.new(0, 6)
        
        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(1, -6, 1, -6)
        img.Position = UDim2.new(0, 3, 0, 3)
        img.BackgroundTransparency = 1
        img.ScaleType = Enum.ScaleType.Fit
        img.Parent = imgHolder
        
        task.spawn(function()
            local gear = RS.Assets and RS.Assets.Gear
            local tool = gear and gear:FindFirstChild(itemName)
            if tool and tool:IsA("Tool") and tool.TextureId ~= "" then
                img.Image = tool.TextureId
            end
        end)
        
        local name = Instance.new("TextLabel")
        name.Size = UDim2.new(1, -4, 0, 14)
        name.Position = UDim2.new(0, 2, 0, 51)
        name.BackgroundTransparency = 1
        name.Text = #itemName > 11 and itemName:sub(1,10).."." or itemName
        name.TextColor3 = COLORS.text2
        name.TextSize = 9
        name.Font = Enum.Font.Gotham
        name.TextTruncate = Enum.TextTruncate.AtEnd
        name.Parent = card
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 18)
        btn.Position = UDim2.new(0, 5, 1, -23)
        btn.BackgroundColor3 = COLORS.btn
        btn.Text = "Get"
        btn.TextColor3 = COLORS.text
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.Parent = card
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseButton1Click:Connect(function()
            btn.Text = "..."
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            local ok = cloneLocal(itemName)
            btn.Text = ok and "✓" or "✗"
            btn.BackgroundColor3 = ok and Color3.fromRGB(50, 160, 50) or Color3.fromRGB(160, 50, 50)
            task.delay(0.8, function()
                if btn then
                    btn.Text = "Get"
                    btn.BackgroundColor3 = COLORS.btn
                end
            end)
        end)
        
        btn.MouseEnter:Connect(function()
            if btn.Text == "Get" then btn.BackgroundColor3 = COLORS.btn_hover end
        end)
        btn.MouseLeave:Connect(function()
            if btn.Text == "Get" then btn.BackgroundColor3 = COLORS.btn end
        end)
    end
    
    -- Footer
    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, 0, 0, 18)
    footer.Position = UDim2.new(0, 0, 1, -20)
    footer.BackgroundTransparency = 1
    footer.Text = gameName
    footer.TextColor3 = COLORS.text3
    footer.TextSize = 9
    footer.Font = Enum.Font.Gotham
    footer.Parent = mainFrame
    
    -- Drag
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging, dragStart, startPos = true, input.Position, mainFrame.Position
        end
    end)
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local d = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    
    UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)
end

createUI()
print("Universal Vector | RightShift = Toggle")