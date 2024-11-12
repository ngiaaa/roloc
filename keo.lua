local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local isFlying = false
local targetPlayer = nil
local flySpeed = 50

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.15, 0, 0.3, 0)
frame.Position = UDim2.new(0.05, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Text = "ds"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.3, 0, 0.2, 0)
closeButton.Position = UDim2.new(0.7, 0, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeButton.Parent = frame
closeButton.MouseButton1Click:Connect(function() gui:Destroy() end)

local refreshButton = Instance.new("TextButton")
refreshButton.Size = UDim2.new(1, 0, 0.2, 0)
refreshButton.Position = UDim2.new(0, 0, 0.8, 0)
refreshButton.Text = "lammoi"
refreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
refreshButton.Parent = frame

local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(1, 0, 0.6, 0)
playerList.Position = UDim2.new(0, 0, 0.2, 0)
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.ScrollBarThickness = 8
playerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerList.Parent = frame

local function updateList()
    playerList:ClearAllChildren()
    for _, p in ipairs(game.Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, -10, 0, 30)
        playerButton.Position = UDim2.new(0, 5, 0, (#playerList:GetChildren() - 1) * 35)
        playerButton.Text = p.Name
        playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        playerButton.Parent = playerList
        playerButton.MouseButton1Click:Connect(function() targetPlayer = p end)
    end
end

refreshButton.MouseButton1Click:Connect(updateList)

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.4, 0, 0.1, 0)
flyButton.Position = UDim2.new(0.3, 0, 0.9, 0)
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(0, 255, 0)
flyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
flyButton.Parent = frame

local function toggleFly()
    if isFlying then
        isFlying = false
        targetPlayer = nil
        player.Character.Humanoid.PlatformStand = false
    else
        isFlying = true
        player.Character.Humanoid.PlatformStand = true
        flyLoop()
    end
end

flyButton.MouseButton1Click:Connect(toggleFly)

local function flyLoop()
    game:GetService("RunService").RenderStepped:Connect(function()
        if isFlying and targetPlayer and targetPlayer.Character then
            local dir = (targetPlayer.Character.PrimaryPart.Position - player.Character.PrimaryPart.Position).unit
            player.Character.PrimaryPart.Velocity = dir * flySpeed
            targetPlayer.Character:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame * CFrame.new(0, 2, 0))
        else
            player.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

updateList()
