local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local fly = false
local target = nil
local speed = 50
local gui = Instance.new("ScreenGui")
gui.Parent = plr.PlayerGui
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.5, 0)
frame.Position = UDim2.new(0.05, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = gui
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.1, 0, 0.1, 0)
closeBtn.Position = UDim2.new(0.9, 0, 0, 0)
closeBtn.Text = "Đóng"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = frame
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0.1, 0, 0.1, 0)
minimizeBtn.Position = UDim2.new(0.8, 0, 0, 0)
minimizeBtn.Text = "Thu gọn"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Text = "Danh sách"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Parent = frame
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 0.1, 0)
refreshBtn.Position = UDim2.new(0, 0, 0.9, 0)
refreshBtn.Text = "Làm mới"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
refreshBtn.Parent = frame
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 0.7, 0)
scroll.Position = UDim2.new(0, 0, 0.1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 5, 0)
scroll.ScrollBarThickness = 8
scroll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scroll.Parent = frame
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1, 0, 0.1, 0)
flyBtn.Position = UDim2.new(0, 0, 0.8, 0)
flyBtn.Text = "Bật/Tắt Bay"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
flyBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

minimizeBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local function updateList()
    scroll:ClearAllChildren()
    for _, p in ipairs(game.Players:GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, -10, 0, 30)
        pBtn.Position = UDim2.new(0, 5, 0, (#scroll:GetChildren() - 1) * 35)
        pBtn.Text = p.Name
        pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        pBtn.Parent = scroll
        pBtn.MouseButton1Click:Connect(function()
            target = p
        end)
    end
end

refreshBtn.MouseButton1Click:Connect(updateList)

local function toggleFly()
    if fly then
        fly = false
        if target then target = nil end
        plr.Character.Humanoid.PlatformStand = false
    else
        fly = true
        plr.Character.Humanoid.PlatformStand = true
        flyLoop()
    end
end

flyBtn.MouseButton1Click:Connect(toggleFly)

local function flyLoop()
    game:GetService("RunService").RenderStepped:Connect(function()
        if fly and target and target.Character then
            local dir = (target.Character.PrimaryPart.Position - plr.Character.PrimaryPart.Position).unit
            plr.Character.PrimaryPart.Velocity = dir * speed
            target.Character:SetPrimaryPartCFrame(plr.Character.PrimaryPart.CFrame * CFrame.new(0, 2, 0))
        else
            plr.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

updateList()
