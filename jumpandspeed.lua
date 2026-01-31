
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- Tạo GUI Local
local NameHub = Instance.new("ScreenGui")
NameHub.Name = "NameHub"
NameHub.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Parent = NameHub
Main.Size = UDim2.new(0.25, 0, 0.3, 0)
Main.Position = UDim2.new(0.73, 0, 0.35, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0.05, 0)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 100)
Stroke.Thickness = 2
Stroke.Parent = Main

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚀 Speed And Jump"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Thanh trượt Tốc độ
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Parent = Main
SpeedFrame.Size = UDim2.new(0.9, 0, 0.15, 0)
SpeedFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
SpeedFrame.BackgroundTransparency = 1

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedFrame
SpeedLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "🏃 Tốc độ: 16"
SpeedLabel.TextColor3 = Color3.white
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextScaled = true
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedBar = Instance.new("Frame")
SpeedBar.Parent = SpeedFrame
SpeedBar.Size = UDim2.new(1, 0, 0.3, 0)
SpeedBar.Position = UDim2.new(0, 0, 0.7, 0)
SpeedBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)

local SpeedFill = Instance.new("Frame")
SpeedFill.Parent = SpeedBar
SpeedFill.Size = UDim2.new(0.32, 0, 1, 0) -- 16/50
SpeedFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)

local SC = Instance.new("UICorner")
SC.CornerRadius = UDim.new(0.3, 0)
SC.Parent = SpeedBar
SC:Clone().Parent = SpeedFill

-- Thanh trượt Nhảy cao
local JumpFrame = Instance.new("Frame")
JumpFrame.Parent = Main
JumpFrame.Size = UDim2.new(0.9, 0, 0.15, 0)
JumpFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
JumpFrame.BackgroundTransparency = 1

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Parent = JumpFrame
JumpLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "⬆️ Nhảy cao: 50"
JumpLabel.TextColor3 = Color3.white
JumpLabel.Font = Enum.Font.GothamMedium
JumpLabel.TextScaled = true
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left

local JumpBar = Instance.new("Frame")
JumpBar.Parent = JumpFrame
JumpBar.Size = UDim2.new(1, 0, 0.3, 0)
JumpBar.Position = UDim2.new(0, 0, 0.7, 0)
JumpBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)

local JumpFill = Instance.new("Frame")
JumpFill.Parent = JumpBar
JumpFill.Size = UDim2.new(0.5, 0, 1, 0) -- 50/100
JumpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)

local JC = Instance.new("UICorner")
JC.CornerRadius = UDim.new(0.3, 0)
JC.Parent = JumpBar
JC:Clone().Parent = JumpFill

-- Nút điều khiển
local BtnFrame = Instance.new("Frame")
BtnFrame.Parent = Main
BtnFrame.Size = UDim2.new(0.9, 0, 0.3, 0)
BtnFrame.Position = UDim2.new(0.05, 0, 0.6, 0)
BtnFrame.BackgroundTransparency = 1

local JumpBtn = Instance.new("TextButton")
JumpBtn.Parent = BtnFrame
JumpBtn.Size = UDim2.new(0.48, 0, 0.85, 0)
JumpBtn.Position = UDim2.new(0, 0, 0.1, 0)
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
JumpBtn.Text = "🚀 NHẢY"
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.TextScaled = true
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0.1, 0)
BtnCorner.Parent = JumpBtn

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = BtnFrame
ToggleBtn.Size = UDim2.new(0.48, 0, 0.85, 0)
ToggleBtn.Position = UDim2.new(0.52, 0, 0.1, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ToggleBtn.Text = "🔄 BẬT AUTO"
ToggleBtn.Font = Enum.Font.GothamMedium
ToggleBtn.TextScaled = true
BtnCorner:Clone().Parent = ToggleBtn

-- Trạng thái
local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Size = UDim2.new(0.9, 0, 0.1, 0)
Status.Position = UDim2.new(0.05, 0, 0.92, 0)
Status.BackgroundTransparency = 1
Status.Text = "🟢 LOCAL READY"
Status.TextColor3 = Color3.fromRGB(0, 255, 100)
Status.Font = Enum.Font.GothamMedium
Status.TextScaled = true

-- Biến lưu trữ
local settings = {
    Speed = 16,
    Jump = 50,
    Auto = false
}

-- Hàm cập nhật thanh trượt
local function updateBars()
    SpeedFill:TweenSize(UDim2.new(settings.Speed/50, 0, 1, 0), "Out", "Quad", 0.2)
    SpeedLabel.Text = "🏃 Tốc độ: "..settings.Speed
    
    JumpFill:TweenSize(UDim2.new(settings.Jump/100, 0, 1, 0), "Out", "Quad", 0.2)
    JumpLabel.Text = "⬆️ Nhảy cao: "..settings.Jump
    
    hum.WalkSpeed = settings.Speed
    hum.JumpPower = settings.Jump
end

-- Hàm nhảy cao
local lastJump = 0
local function superJump()
    if tick() - lastJump < 0.3 then return end
    lastJump = tick()
    
    if hum.FloorMaterial ~= Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, settings.Jump * 1.8, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Parent = char.HumanoidRootPart
        game.Debris:AddItem(bv, 0.2)
        
        JumpBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        Status.Text = "🚀 ĐANG NHẢY..."
        task.wait(0.2)
        JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        Status.Text = "🟢 LOCAL READY"
    end
end

-- Auto Jump
local autoConn
local function toggleAuto()
    settings.Auto = not settings.Auto
    
    if settings.Auto then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        ToggleBtn.Text = "⏹️ TẮT AUTO"
        Status.Text = "🤖 AUTO JUMP: ON"
        
        autoConn = RS.Heartbeat:Connect(function()
            if hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, settings.Jump * 1.5, 0)
                bv.MaxForce = Vector3.new(0, math.huge, 0)
                bv.Parent = char.HumanoidRootPart
                game.Debris:AddItem(bv, 0.15)
            end
        end)
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        ToggleBtn.Text = "🔄 BẬT AUTO"
        Status.Text = "🟢 AUTO JUMP: OFF"
        if autoConn then autoConn:Disconnect() end
    end
end

-- Kéo thanh trượt
local function setupSlider(bar, fill, label, min, max, key)
    local dragging = false
    
    local function updatePos()
        if not dragging then return end
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local x = math.clamp(mouse.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        local perc = x / bar.AbsoluteSize.X
        settings[key] = math.floor(min + (max - min) * perc)
        updateBars()
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updatePos()
        end
    end)
    
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            updatePos()
        end
    end)
end

-- Kết nối sự kiện
JumpBtn.MouseButton1Click:Connect(superJump)
ToggleBtn.MouseButton1Click:Connect(toggleAuto)

setupSlider(SpeedBar, SpeedFill, SpeedLabel, 16, 100, "Speed")
setupSlider(JumpBar, JumpFill, JumpLabel, 20, 100, "Jump")

-- Phím tắt
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.J then
        superJump()
    elseif input.KeyCode == Enum.KeyCode.U then
        toggleAuto()
    elseif input.KeyCode == Enum.KeyCode.LeftBracket then
        settings.Jump = math.max(20, settings.Jump - 5)
        updateBars()
    elseif input.KeyCode == Enum.KeyCode.RightBracket then
        settings.Jump = math.min(100, settings.Jump + 5)
        updateBars()
    elseif input.KeyCode == Enum.KeyCode.H then
        Main.Visible = not Main.Visible
    end
end)

-- Khởi động
updateBars()

-- Respawn handler
char.Died:Connect(function()
    task.wait(5)
    if char and char.Parent then
        hum = char:WaitForChild("Humanoid")
        updateBars()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
    task.wait(1)
    updateBars()
end)

print("✅ NameHub Local đã tải! Phím tắt: J=Jump, U=Auto, H=Hide, []=Adjust Jump")
