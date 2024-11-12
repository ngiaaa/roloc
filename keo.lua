local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local nbfly = Instance.new("TextButton")
local cngch = Instance.new("TextButton")
local nbdong = Instance.new("TextButton")
local nblmo = Instance.new("TextButton")
local dsngch = Instance.new("ScrollingFrame")
local UIPadding = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.CoreGui

Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.Parent = ScreenGui
Frame.Draggable = true
Frame.Active = true

nbfly.Size = UDim2.new(0.8, 0, 0.1, 0)
nbfly.Position = UDim2.new(0.1, 0, 0.1, 0)
nbfly.Text = "FLY"
nbfly.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
nbfly.TextScaled = true
nbfly.Parent = Frame

cngch.Size = UDim2.new(0.8, 0, 0.1, 0)
cngch.Position = UDim2.new(0.1, 0, 0.25, 0)
cngch.Text = "chọn"
cngch.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
cngch.TextScaled = true
cngch.Parent = Frame

nbdong.Size = UDim2.new(0.2, 0, 0.1, 0)
nbdong.Position = UDim2.new(0.8, 0, 0, 0)
nbdong.Text = "X"
nbdong.BackgroundColor3 = Color3.new(1, 0, 0)
nbdong.TextScaled = true
nbdong.Parent = Frame

nblmo.Size = UDim2.new(0.8, 0, 0.1, 0)
nblmo.Position = UDim2.new(0.1, 0, 0.4, 0)
nblmo.Text = "làm mới"
nblmo.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
nblmo.TextScaled = true
nblmo.Parent = Frame

dsngch.Size = UDim2.new(0.8, 0, 0.4, 0)
dsngch.Position = UDim2.new(0.1, 0, 0.55, 0)
dsngch.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
dsngch.CanvasSize = UDim2.new(0, 0, 1, 0)
dsngch.ScrollBarThickness = 6
dsngch.Parent = Frame

UIPadding.PaddingTop = UDim.new(0, 5)
UIPadding.Parent = dsngch

UIListLayout.Parent = dsngch
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local isFlying = false
local selectedPlayer

local function lmdsa()
    dsngch:ClearAllChildren()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 30)
            Btn.Text = p.Name
            Btn.TextScaled = true
            Btn.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
            Btn.Parent = dsngch
            Btn.MouseButton1Click:Connect(function()
                selectedPlayer = p
            end)
        end
    end
end

local function nbfly()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        isFlying = not isFlying
        if isFlying then
            local hrp = selectedPlayer.Character.HumanoidRootPart
            local bp = Instance.new("BodyPosition", hrp)
            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bp.D = 10
            bp.P = 10000
            local loop
            loop = game:GetService("RunService").RenderStepped:Connect(function()
                if not isFlying then
                    bp:Destroy()
                    loop:Disconnect()
                else
                    bp.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
                end
            end)
        end
    end
end

nbfly.MouseButton1Click:Connect(nbfly)
nbdong.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
nblmo.MouseButton1Click:Connect(lmdsa)

lmdsa()
