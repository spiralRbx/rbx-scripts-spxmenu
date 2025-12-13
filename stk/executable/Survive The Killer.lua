-- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)

-- Instances:

local Converted = {
	["_VectorGui"] = Instance.new("ScreenGui");
	["_VectorFrame"] = Instance.new("Frame");
	["_UICorner"] = Instance.new("UICorner");
	["_VectorTitler"] = Instance.new("TextLabel");
	["_UICorner1"] = Instance.new("UICorner");
	["_UIGradient"] = Instance.new("UIGradient");
	["_LocalScript"] = Instance.new("LocalScript");
	["_VectorMainFrame"] = Instance.new("Frame");
	["_UIStroke"] = Instance.new("UIStroke");
	["_UICorner2"] = Instance.new("UICorner");
	["_Inf_map"] = Instance.new("TextLabel");
	["_Inf_players"] = Instance.new("TextLabel");
	["_Btnautoloot"] = Instance.new("TextButton");
	["_UIGradient1"] = Instance.new("UIGradient");
	["_UICorner3"] = Instance.new("UICorner");
	["_Btnautoescape"] = Instance.new("TextButton");
	["_UIGradient2"] = Instance.new("UIGradient");
	["_UICorner4"] = Instance.new("UICorner");
	["_Btnkillerevade"] = Instance.new("TextButton");
	["_UIGradient3"] = Instance.new("UIGradient");
	["_UICorner5"] = Instance.new("UICorner");
	["_BtnAutoFarm"] = Instance.new("TextButton");
	["_UIGradient4"] = Instance.new("UIGradient");
	["_UICorner6"] = Instance.new("UICorner");
	["_GameTitler"] = Instance.new("TextLabel");
	["_UIGradient5"] = Instance.new("UIGradient");
	["_UIDragDetector"] = Instance.new("UIDragDetector");
	["_LocalScript1"] = Instance.new("LocalScript");
}

-- Properties:

Converted["_VectorGui"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["_VectorGui"].Name = "VectorGui"
Converted["_VectorGui"].Parent = game:GetService("CoreGui")

Converted["_VectorFrame"].BackgroundColor3 = Color3.fromRGB(59.00000408291817, 57.00000420212746, 61.00000396370888)
Converted["_VectorFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_VectorFrame"].BorderSizePixel = 0
Converted["_VectorFrame"].Position = UDim2.new(0.433432311, 316, 0.24257426, 53)
Converted["_VectorFrame"].Size = UDim2.new(0.198221087, 0, 0.507425725, 0)
Converted["_VectorFrame"].Name = "VectorFrame"
Converted["_VectorFrame"].Parent = Converted["_VectorGui"]

Converted["_UICorner"].Parent = Converted["_VectorFrame"]

Converted["_VectorTitler"].Font = Enum.Font.FredokaOne
Converted["_VectorTitler"].Text = "Universal Vector"
Converted["_VectorTitler"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_VectorTitler"].TextSize = 22
Converted["_VectorTitler"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_VectorTitler"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_VectorTitler"].BorderSizePixel = 0
Converted["_VectorTitler"].Position = UDim2.new(0.10897436, 0, -0.0658536553, 0)
Converted["_VectorTitler"].Size = UDim2.new(0.785256386, 0, 0.121951222, 0)
Converted["_VectorTitler"].ZIndex = 2
Converted["_VectorTitler"].Name = "VectorTitler"
Converted["_VectorTitler"].Parent = Converted["_VectorFrame"]

Converted["_UICorner1"].Parent = Converted["_VectorTitler"]

Converted["_UIGradient"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32.00000189244747, 50.000000819563866, 154.00000602006912)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(47.0000009983778, 112.000000923872, 216.00000232458115))
}
Converted["_UIGradient"].Parent = Converted["_VectorTitler"]

Converted["_VectorMainFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_VectorMainFrame"].BackgroundTransparency = 1
Converted["_VectorMainFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_VectorMainFrame"].BorderSizePixel = 0
Converted["_VectorMainFrame"].ClipsDescendants = true
Converted["_VectorMainFrame"].Size = UDim2.new(1, 0, 1, 0)
Converted["_VectorMainFrame"].Name = "VectorMainFrame"
Converted["_VectorMainFrame"].Parent = Converted["_VectorFrame"]

Converted["_UIStroke"].Parent = Converted["_VectorMainFrame"]

Converted["_UICorner2"].Parent = Converted["_VectorMainFrame"]

Converted["_Inf_map"].Font = Enum.Font.FredokaOne
Converted["_Inf_map"].Text = "Auto Loot"
Converted["_Inf_map"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Inf_map"].TextSize = 11
Converted["_Inf_map"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Inf_map"].BackgroundTransparency = 1
Converted["_Inf_map"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Inf_map"].BorderSizePixel = 0
Converted["_Inf_map"].Position = UDim2.new(0.0229997355, 0, 0.792122006, 0)
Converted["_Inf_map"].Size = UDim2.new(0.953503489, 0, 0.0390243903, 0)
Converted["_Inf_map"].Name = "Inf_map"
Converted["_Inf_map"].Parent = Converted["_VectorMainFrame"]

Converted["_Inf_players"].Font = Enum.Font.FredokaOne
Converted["_Inf_players"].Text = "Auto Loot"
Converted["_Inf_players"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Inf_players"].TextSize = 11
Converted["_Inf_players"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Inf_players"].BackgroundTransparency = 1
Converted["_Inf_players"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Inf_players"].BorderSizePixel = 0
Converted["_Inf_players"].Position = UDim2.new(0.0229997355, 0, 0.872609794, 0)
Converted["_Inf_players"].Size = UDim2.new(0.953503489, 0, 0.0390243903, 0)
Converted["_Inf_players"].Name = "Inf_players"
Converted["_Inf_players"].Parent = Converted["_VectorMainFrame"]

Converted["_Btnautoloot"].Font = Enum.Font.FredokaOne
Converted["_Btnautoloot"].Text = "Auto Loot"
Converted["_Btnautoloot"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Btnautoloot"].TextSize = 24
Converted["_Btnautoloot"].Active = false
Converted["_Btnautoloot"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Btnautoloot"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Btnautoloot"].BorderSizePixel = 0
Converted["_Btnautoloot"].Position = UDim2.new(0.0298906155, 0, 0.102439024, 0)
Converted["_Btnautoloot"].Selectable = false
Converted["_Btnautoloot"].Size = UDim2.new(0.936572671, 0, 0.121951222, 0)
Converted["_Btnautoloot"].Name = "Btnautoloot"
Converted["_Btnautoloot"].Parent = Converted["_VectorMainFrame"]

Converted["_UIGradient1"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32.00000189244747, 50.000000819563866, 154.00000602006912)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(47.0000009983778, 112.000000923872, 216.00000232458115))
}
Converted["_UIGradient1"].Parent = Converted["_Btnautoloot"]

Converted["_UICorner3"].Parent = Converted["_Btnautoloot"]

Converted["_Btnautoescape"].Font = Enum.Font.FredokaOne
Converted["_Btnautoescape"].Text = "     Auto Escape"
Converted["_Btnautoescape"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Btnautoescape"].TextSize = 24
Converted["_Btnautoescape"].Active = false
Converted["_Btnautoescape"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Btnautoescape"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Btnautoescape"].BorderSizePixel = 0
Converted["_Btnautoescape"].Position = UDim2.new(0.0298906155, 0, 0.268292695, 0)
Converted["_Btnautoescape"].Selectable = false
Converted["_Btnautoescape"].Size = UDim2.new(0.936572671, 0, 0.121951222, 0)
Converted["_Btnautoescape"].Name = "Btnautoescape"
Converted["_Btnautoescape"].Parent = Converted["_VectorMainFrame"]

Converted["_UIGradient2"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32.00000189244747, 50.000000819563866, 154.00000602006912)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(47.0000009983778, 112.000000923872, 216.00000232458115))
}
Converted["_UIGradient2"].Parent = Converted["_Btnautoescape"]

Converted["_UICorner4"].Parent = Converted["_Btnautoescape"]

Converted["_Btnkillerevade"].Font = Enum.Font.FredokaOne
Converted["_Btnkillerevade"].Text = "     Killer Evade"
Converted["_Btnkillerevade"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Btnkillerevade"].TextSize = 24
Converted["_Btnkillerevade"].Active = false
Converted["_Btnkillerevade"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Btnkillerevade"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Btnkillerevade"].BorderSizePixel = 0
Converted["_Btnkillerevade"].Position = UDim2.new(0.0332117975, 0, 0.439024389, 0)
Converted["_Btnkillerevade"].Selectable = false
Converted["_Btnkillerevade"].Size = UDim2.new(0.936572671, 0, 0.121951222, 0)
Converted["_Btnkillerevade"].Name = "Btnkillerevade"
Converted["_Btnkillerevade"].Parent = Converted["_VectorMainFrame"]

Converted["_UIGradient3"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32.00000189244747, 50.000000819563866, 154.00000602006912)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(47.0000009983778, 112.000000923872, 216.00000232458115))
}
Converted["_UIGradient3"].Parent = Converted["_Btnkillerevade"]

Converted["_UICorner5"].Parent = Converted["_Btnkillerevade"]

Converted["_BtnAutoFarm"].Font = Enum.Font.FredokaOne
Converted["_BtnAutoFarm"].Text = "  Auto Farm"
Converted["_BtnAutoFarm"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_BtnAutoFarm"].TextSize = 24
Converted["_BtnAutoFarm"].Active = false
Converted["_BtnAutoFarm"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_BtnAutoFarm"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_BtnAutoFarm"].BorderSizePixel = 0
Converted["_BtnAutoFarm"].Position = UDim2.new(0.0332117975, 0, 0.612195134, 0)
Converted["_BtnAutoFarm"].Selectable = false
Converted["_BtnAutoFarm"].Size = UDim2.new(0.936572671, 0, 0.121951222, 0)
Converted["_BtnAutoFarm"].Name = "BtnAutoFarm"
Converted["_BtnAutoFarm"].Parent = Converted["_VectorMainFrame"]

Converted["_UIGradient4"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32.00000189244747, 50.000000819563866, 154.00000602006912)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(47.0000009983778, 112.000000923872, 216.00000232458115))
}
Converted["_UIGradient4"].Parent = Converted["_BtnAutoFarm"]

Converted["_UICorner6"].Parent = Converted["_BtnAutoFarm"]

Converted["_GameTitler"].Font = Enum.Font.FredokaOne
Converted["_GameTitler"].Text = "Auto Loot"
Converted["_GameTitler"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_GameTitler"].TextSize = 10
Converted["_GameTitler"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_GameTitler"].BackgroundTransparency = 1
Converted["_GameTitler"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_GameTitler"].BorderSizePixel = 0
Converted["_GameTitler"].Position = UDim2.new(0.0229997355, 0, 0.943341494, 0)
Converted["_GameTitler"].Size = UDim2.new(0.953503489, 0, 0.0390243903, 0)
Converted["_GameTitler"].Name = "GameTitler"
Converted["_GameTitler"].Parent = Converted["_VectorMainFrame"]

Converted["_UIGradient5"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(32.00000189244747, 50.000000819563866, 154.00000602006912)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(47.0000009983778, 112.000000923872, 216.00000232458115))
}
Converted["_UIGradient5"].Parent = Converted["_VectorFrame"]

Converted["_UIDragDetector"].DragUDim2 = UDim2.new(0, 282, 0, 50)
Converted["_UIDragDetector"].Parent = Converted["_VectorFrame"]

-- Fake Module Scripts:

local fake_module_scripts = {}


-- Fake Local Scripts:

local function GHUUAU_fake_script() -- Fake Script: StarterGui.VectorGui.VectorFrame.VectorTitler.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_VectorTitler"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local stroke = Instance.new("UIStroke")
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Thickness = 2
	stroke.Parent = script.Parent
	
	local h = 0
	game:GetService("RunService").Heartbeat:Connect(function(dt)
		h = (h + dt * 0.5) % 1
		stroke.Color = Color3.fromHSV(h, 1, 1)
	end)
end
local function YOAICIT_fake_script() -- Fake Script: StarterGui.VectorGui.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_VectorGui"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	-- LocalScript dentro de VectorGui
	
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local TeleportService = game:GetService("TeleportService")
	local HttpService = game:GetService("HttpService")
	local VirtualUser = game:GetService("VirtualUser")
	
	local player = Players.LocalPlayer
	
	-- Referências da GUI
	local VectorGui = script.Parent
	local VectorFrame = VectorGui:WaitForChild("VectorFrame")
	local VectorMainFrame = VectorFrame:WaitForChild("VectorMainFrame")
	
	local Btnautoloot = VectorMainFrame:WaitForChild("Btnautoloot")
	local Btnautoescape = VectorMainFrame:WaitForChild("Btnautoescape")
	local Btnkillerevade = VectorMainFrame:WaitForChild("Btnkillerevade")
	local BtnAutoFarm = VectorMainFrame:WaitForChild("BtnAutoFarm")
	
	local Inf_map = VectorMainFrame:WaitForChild("Inf_map")
	local Inf_players = VectorMainFrame:WaitForChild("Inf_players")
	local GameTitler = VectorMainFrame:WaitForChild("GameTitler")
	
	-- Estados
	local lootEnabled, escapeEnabled, safeEnabled, farmEnabled = false, false, false, false
	local lootConn, escapeConn, safeConn, farmConn = nil, nil, nil, nil
	local mapModel, lootSpawns, exitGateway = nil, nil, nil
	local doorsOpened = false
	local isEscaping = false
	
	-- Configurações
	local SAFE_DISTANCE = 25
	local MIN_ESCAPE_DISTANCE = 50
	local WALK_SPEED = 20
	local MIN_PLAYERS = 3
	
	-- Cores
	local COLOR_ON = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(32, 154, 50)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(47, 216, 80))
	}
	local COLOR_OFF = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(32, 50, 154)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(47, 112, 216))
	}
	local COLOR_FARM = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(154, 32, 140)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 47, 216))
	}
	
	-- Auto Start
	local AUTO_START = false
	if getgenv then
		AUTO_START = getgenv().AutoFarmStart == true
		getgenv().AutoFarmStart = nil
	
		local teleportTime = getgenv().TeleportTime or 0
		if os.time() - teleportTime > 10 then
			AUTO_START = false
		end
		getgenv().TeleportTime = nil
	end
	
	-- Funções auxiliares
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
	
	local function updateInfo()
		Inf_map.Text = mapModel and ("Map: " .. mapModel.Name) or "Map: --"
		Inf_players.Text = "Players: " .. #Players:GetPlayers() .. " | Anti-AFK: ON"
		GameTitler.Text = "Flee The Facility"
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
			if walked > distance then walked = distance end
	
			local newPos = startPos + (direction * walked)
			root.CFrame = CFrame.new(newPos) * CFrame.Angles(0, math.atan2(direction.X, direction.Z), 0)
			task.wait(0.03)
		end
	
		return true
	end
	
	-- Server Hop
	local function serverHop()
		local placeId = game.PlaceId
		local currentJobId = game.JobId
	
		local success, servers = pcall(function()
			local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
			return HttpService:JSONDecode(game:HttpGet(url))
		end)
	
		if success and servers and servers.data then
			for _, server in ipairs(servers.data) do
				if server.id ~= currentJobId and server.playing and server.playing > MIN_PLAYERS and server.playing < server.maxPlayers then
					if queue_on_teleport then
						queue_on_teleport([[
	                        task.wait(3)
	                        if getgenv then
	                            getgenv().AutoFarmStart = true
	                            getgenv().TeleportTime = os.time()
	                        end
	                        loadstring(game:HttpGet("]] .. (getgenv and getgenv().ScriptURL or "http://raw.githubusercontent.com/spiralRbx/rbx-scripts-spxmenu/refs/heads/main/stk/executable/Survive%20The%20Killer.lua") .. [["))()
	                    ]])
					end
					task.wait(1)
					TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
					return true
				end
			end
		end
	
		if queue_on_teleport then
			queue_on_teleport([[
	            task.wait(3)
	            if getgenv then
	                getgenv().AutoFarmStart = true
	                getgenv().TeleportTime = os.time()
	            end
	            loadstring(game:HttpGet("]] .. (getgenv and getgenv().ScriptURL or "http://raw.githubusercontent.com/spiralRbx/rbx-scripts-spxmenu/refs/heads/main/stk/executable/Survive%20The%20Killer.lua") .. [["))()
	        ]])
		end
	
		task.wait(1)
		TeleportService:Teleport(placeId, player)
		return true
	end
	
	-- Anti-AFK
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
					if humanoid then humanoid.Jump = true end
					VirtualUser:CaptureController()
					VirtualUser:ClickButton2(Vector2.new())
				end)
			end
		end)
	end
	
	-- Loops
	local function collectLoop(threadId)
		while lootEnabled and lootConn == threadId do
			if not isInSurvivorTeam() then
				task.wait(1)
				continue
			end
	
			if isEscaping then
				task.wait(0.5)
				continue
			end
	
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if not root then task.wait(0.5) continue end
	
			local spawns = getAvailableSpawns()
	
			if #spawns > 0 then
				for _, spawn in ipairs(spawns) do
					if not lootEnabled or lootConn ~= threadId or not isInSurvivorTeam() or isEscaping then break end
					if hasAvailableLoot(spawn) then
						root.CFrame = CFrame.new(spawn.Position + Vector3.new(0, 2, 0))
						task.wait(0.08)
					end
				end
			end
			task.wait(0.1)
		end
	end
	
	local function escapeLoop(threadId)
		while escapeEnabled and escapeConn == threadId do
			if not isInSurvivorTeam() then
				doorsOpened = false
				isEscaping = false
				mapModel = nil
				task.wait(1)
				continue
			end
	
			if not exitGateway or not exitGateway.Parent then
				findMap()
				updateInfo()
			end
	
			if exitGateway then
				if checkDoorsOpened() then
					isEscaping = true
					walkToEscape()
				end
			end
	
			task.wait(0.1)
		end
	end
	
	local function safeLoop(threadId)
		while safeEnabled and safeConn == threadId do
			if not isInSurvivorTeam() then
				task.wait(1)
				continue
			end
	
			if isEscaping then
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
					if k.distance < nearest.distance then nearest = k end
				end
	
				local safeSpawn = getSafeSpawn(nearest.root.Position)
				if safeSpawn then
					local char = player.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")
					if root then
						root.CFrame = CFrame.new(safeSpawn.Position + Vector3.new(0, 3, 0))
						task.wait(0.3)
					end
				end
			end
	
			task.wait(0.1)
		end
	end
	
	local function farmLoop(threadId)
		while farmEnabled and farmConn == threadId do
			updateInfo()
	
			local playerCount = #Players:GetPlayers()
	
			if playerCount <= MIN_PLAYERS then
				task.wait(5)
				if farmEnabled and farmConn == threadId and #Players:GetPlayers() <= MIN_PLAYERS then
					serverHop()
				end
			end
	
			task.wait(3)
		end
	end
	
	-- Toggle Functions
	local function toggleLoot()
		if not lootEnabled then
			lootEnabled = true
			local threadId = tick()
			lootConn = threadId
			Btnautoloot:FindFirstChild("UIGradient").Color = COLOR_ON
			findMap()
			updateInfo()
			task.spawn(function() collectLoop(threadId) end)
		else
			lootEnabled = false
			lootConn = nil
			Btnautoloot:FindFirstChild("UIGradient").Color = COLOR_OFF
		end
	end
	
	local function toggleEscape()
		if not escapeEnabled then
			escapeEnabled = true
			doorsOpened = false
			local threadId = tick()
			escapeConn = threadId
			Btnautoescape:FindFirstChild("UIGradient").Color = COLOR_ON
			findMap()
			updateInfo()
			task.spawn(function() escapeLoop(threadId) end)
		else
			escapeEnabled = false
			isEscaping = false
			escapeConn = nil
			Btnautoescape:FindFirstChild("UIGradient").Color = COLOR_OFF
		end
	end
	
	local function toggleSafe()
		if not safeEnabled then
			safeEnabled = true
			local threadId = tick()
			safeConn = threadId
			Btnkillerevade:FindFirstChild("UIGradient").Color = COLOR_ON
			findMap()
			updateInfo()
			task.spawn(function() safeLoop(threadId) end)
		else
			safeEnabled = false
			safeConn = nil
			Btnkillerevade:FindFirstChild("UIGradient").Color = COLOR_OFF
		end
	end
	
	local function toggleFarm()
		if not farmEnabled then
			farmEnabled = true
			local threadId = tick()
			farmConn = threadId
			BtnAutoFarm:FindFirstChild("UIGradient").Color = COLOR_FARM
	
			if not lootEnabled then toggleLoot() end
			if not escapeEnabled then toggleEscape() end
			if not safeEnabled then toggleSafe() end
	
			task.spawn(function() farmLoop(threadId) end)
		else
			farmEnabled = false
			farmConn = nil
			BtnAutoFarm:FindFirstChild("UIGradient").Color = COLOR_OFF
		end
	end
	
	-- Conectar botões
	Btnautoloot.MouseButton1Click:Connect(toggleLoot)
	Btnautoescape.MouseButton1Click:Connect(toggleEscape)
	Btnkillerevade.MouseButton1Click:Connect(toggleSafe)
	BtnAutoFarm.MouseButton1Click:Connect(toggleFarm)
	
	-- Drag da GUI
	local dragging, dragStart, startPos
	VectorFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging, dragStart, startPos = true, input.Position, VectorFrame.Position
		end
	end)
	VectorFrame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			VectorFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	
	-- Iniciar
	startAntiAFK()
	updateInfo()
	
	task.spawn(function()
		while true do
			updateInfo()
			task.wait(5)
		end
	end)
	
	-- Auto start após server hop
	if AUTO_START then
		task.wait(2)
		toggleFarm()
	end
end

coroutine.wrap(GHUUAU_fake_script)()
coroutine.wrap(YOAICIT_fake_script)()