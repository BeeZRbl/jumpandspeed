
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- Tạo GUI Local
local SpeedJumpGUI = Instance.new("ScreenGui")
SpeedJumpGUI.Name = "SpeedJumpControl"
SpeedJumpGUI.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Parent = SpeedJumpGUI
Main.Size = UDim2.new(0.28, 0, 0.35, 0)
Main.Position = UDim2.new(0.7, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.06, 0)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 200, 255)
UIStroke.Thickness = 2
UIStroke.Parent = Main

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0.12, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SPEED & JUMP CONTROL"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- === TỐC ĐỘ CHẠY ===
local SpeedSection = Instance.new("Frame")
SpeedSection.Parent = Main
SpeedSection.Size = UDim2.new(0.9, 0, 0.22, 0)
SpeedSection.Position = UDim2.new(0.05, 0, 0.15, 0)
SpeedSection.BackgroundTransparency = 1

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedSection
SpeedLabel.Size = UDim2.new(1, 0, 0.4, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "🏃 TỐC ĐỘ CHẠY: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextScaled = true
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedValue = Instance.new("TextLabel")
SpeedValue.Parent = SpeedSection
SpeedValue.Size = UDim2.new(0.2, 0, 0.4, 0)
SpeedValue.Position = UDim2.new(0.8, 0, 0, 0)
SpeedValue.BackgroundTransparency = 1
SpeedValue.Text = "16"
SpeedValue.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextScaled = true

local SpeedBar = Instance.new("Frame")
SpeedBar.Parent = SpeedSection
SpeedBar.Size = UDim2.new(1, 0, 0.3, 0)
SpeedBar.Position = UDim2.new(0, 0, 0.5, 0)
SpeedBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)

local SpeedFill = Instance.new("Frame")
SpeedFill.Parent = SpeedBar
SpeedFill.Size = UDim2.new(0.32, 0, 1, 0) -- Mặc định 16/50 = 0.32
SpeedFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0.3, 0)
BarCorner.Parent = SpeedBar
BarCorner:Clone().Parent = SpeedFill

-- Nút điều chỉnh tốc độ
local SpeedControls = Instance.new("Frame")
SpeedControls.Parent = SpeedSection
SpeedControls.Size = UDim2.new(1, 0, 0.2, 0)
SpeedControls.Position = UDim2.new(0, 0, 0.85, 0)
SpeedControls.BackgroundTransparency = 1

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Parent = SpeedControls
SpeedMinus.Size = UDim2.new(0.18, 0, 1, 0)
SpeedMinus.Text = "-"
SpeedMinus.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
SpeedMinus.TextColor3 = Color3.white
SpeedMinus.Font = Enum.Font.GothamBold

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Parent = SpeedControls
SpeedPlus.Size = UDim2.new(0.18, 0, 1, 0)
SpeedPlus.Position = UDim2.new(0.82, 0, 0, 0)
SpeedPlus.Text = "+"
SpeedPlus.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
SpeedPlus.TextColor3 = Color3.white
SpeedPlus.Font = Enum.Font.GothamBold

-- === NHẢY CAO ===
local JumpSection = Instance.new("Frame")
JumpSection.Parent = Main
JumpSection.Size = UDim2.new(0.9, 0, 0.22, 0)
JumpSection.Position = UDim2.new(0.05, 0, 0.4, 0)
JumpSection.BackgroundTransparency = 1

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Parent = JumpSection
JumpLabel.Size = UDim2.new(1, 0, 0.4, 0)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "⬆️ ĐỘ CAO NHẢY: 50"
JumpLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
JumpLabel.Font = Enum.Font.GothamMedium
JumpLabel.TextScaled = true
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left

local JumpValue = Instance.new("TextLabel")
JumpValue.Parent = JumpSection
JumpValue.Size = UDim2.new(0.2, 0, 0.4, 0)
JumpValue.Position = UDim2.new(0.8, 0, 0, 0)
JumpValue.BackgroundTransparency = 1
JumpValue.Text = "50"
JumpValue.TextColor3 = Color3.fromRGB(0, 200, 255)
JumpValue.Font = Enum.Font.GothamBold
JumpValue.TextScaled = true

local JumpBar = Instance.new("Frame")
JumpBar.Parent = JumpSection
JumpBar.Size = UDim2.new(1, 0, 0.3, 0)
JumpBar.Position = UDim2.new(0, 0, 0.5, 0)
JumpBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)

local JumpFill = Instance.new("Frame")
JumpFill.Parent = JumpBar
JumpFill.Size = UDim2.new(0.5, 0, 1, 0) -- Mặc định 50/100 = 0.5
JumpFill.BackgroundColor3 = Color3.fromRGB(255, 150, 50)

local JumpBarCorner = Instance.new("UICorner")
JumpBarCorner.CornerRadius = UDim.new(0.3, 0)
JumpBarCorner.Parent = JumpBar
JumpBarCorner:Clone().Parent = JumpFill

-- Nút điều chỉnh nhảy
local JumpControls = Instance.new("Frame")
JumpControls.Parent = JumpSection
JumpControls.Size = UDim2.new(1, 0, 0.2, 0)
JumpControls.Position = UDim2.new(0, 0, 0.85, 0)
JumpControls.BackgroundTransparency = 1

local JumpMinus = Instance.new("TextButton")
JumpMinus.Parent = JumpControls
JumpMinus.Size = UDim2.new(0.18, 0, 1, 0)
JumpMinus.Text = "-"
JumpMinus.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
JumpMinus.TextColor3 = Color3.white
JumpMinus.Font = Enum.Font.GothamBold

local JumpPlus = Instance.new("TextButton")
JumpPlus.Parent = JumpControls
JumpPlus.Size = UDim2.new(0.18, 0, 1, 0)
JumpPlus.Position = UDim2.new(0.82, 0, 0, 0)
JumpPlus.Text = "+"
JumpPlus.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
Plus.TextColor3 = Color3.white
Plus.Font = Enum.Font.GothamBold

-- === NÚT HÀNH ĐỘNG ===
local ActionFrame = Instance.new("Frame")
ActionFrame.Parent = Main
ActionFrame.Size = UDim2.new(0.9, 0, 0.3, 0)
ActionFrame.Position = UDim2.new(0.05, 0, 0.65, 0)
ActionFrame.BackgroundTransparency = 1

local JumpButton = Instance.new("TextButton")
JumpButton.Parent = ActionFrame
JumpButton.Size = UDim2.new(0.48, 0, 0.4, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
JumpButton.Text = "🚀 NHẢY CAO"
JumpButton.TextColor3 = Color3.fromRGB(20, 20, 30)
JumpButton.Font = Enum.Font.GothamBold
JumpButton.TextScaled = true

local SuperJumpButton = Instance.new("TextButton")
SuperJumpButton.Parent = ActionFrame
SuperJumpButton.Size = UDim2.new(0.48, 0, 0.4, 0)
SuperJumpButton.Position = UDim2.new(0.52, 0, 0, 0)
SuperJumpButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
SuperJumpButton.Text = "🔥 SIÊU NHẢY"
SuperJumpButton.TextColor3 = Color3.fromRGB(20, 20, 30)
SuperJumpButton.Font = Enum.Font.GothamBold
SuperJumpButton.TextScaled = true

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ActionFrame
ToggleButton.Size = UDim2.new(1, 0, 0.4, 0)
ToggleButton.Position = UDim2.new(0, 0, 0.55, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
ToggleButton.Text = "🤖 BẬT AUTO JUMP"
ToggleButton.TextColor3 = Color3.white
ToggleButton.Font = Enum.Font.GothamMedium
ToggleButton.TextScaled = true

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.1, 0)
ButtonCorner.Parent = JumpButton
ButtonCorner:Clone().Parent = SuperJumpButton
ButtonCorner:Clone().Parent = ToggleButton
ButtonCorner:Clone().Parent = SpeedMinus
ButtonCorner:Clone().Parent = SpeedPlus
ButtonCorner:Clone().Parent = JumpMinus
ButtonCorner:Clone().Parent = JumpPlus

-- Trạng thái
local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Size = UDim2.new(0.9, 0, 0.08, 0)
Status.Position = UDim2.new(0.05, 0, 0.95, 0)
Status.BackgroundTransparency = 1
Status.Text = "⚡ ĐÃ SẴN SÀNG | TỐC ĐỘ: 16 | NHẢY: 50"
Status.TextColor3 = Color3.fromRGB(0, 200, 255)
Status.Font = Enum.Font.GothamMedium
Status.TextScaled = true

-- Biến lưu trữ
local settings = {
    WalkSpeed = 16,    -- Tốc độ chạy (16 mặc định Roblox)
    JumpPower = 50,    -- Độ cao nhảy (50 mặc định Roblox)
    AutoJump = false,
    SuperJumpMultiplier = 2.0
}

-- Hàm cập nhật hiển thị
local function updateDisplay()
    -- Cập nhật thanh trượt
    SpeedFill:TweenSize(
        UDim2.new(settings.WalkSpeed/100, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2
    )
    SpeedLabel.Text = "🏃 TỐC ĐỘ CHẠY: " .. settings.WalkSpeed
    SpeedValue.Text = tostring(settings.WalkSpeed)
    
    JumpFill:TweenSize(
        UDim2.new(settings.JumpPower/150, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2
    )
    JumpLabel.Text = "⬆️ ĐỘ CAO NHẢY: " .. settings.JumpPower
    JumpValue.Text = tostring(settings.JumpPower)
    
    -- Áp dụng vào nhân vật
    hum.WalkSpeed = settings.WalkSpeed
    hum.JumpPower = settings.JumpPower
    
    -- Cập nhật trạng thái
    Status.Text = string.format("⚡ TỐC ĐỘ: %d | NHẢY: %d | %s",
        settings.WalkSpeed,
        settings.JumpPower,
        settings.AutoJump and "AUTO: ON" or "AUTO: OFF"
    )
    
    -- Cập nhật nút Auto
    ToggleButton.Text = settings.AutoJump and "⏹️ TẮT AUTO JUMP" or "🤖 BẬT AUTO JUMP"
    ToggleButton.BackgroundColor3 = settings.AutoJump and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(50, 50, 80)
end

-- Hàm điều chỉnh giá trị
local function adjustValue(type, amount)
    if type == "speed" then
        settings.WalkSpeed = math.clamp(settings.WalkSpeed + amount, 0, 100)
    elseif type == "jump" then
        settings.JumpPower = math.clamp(settings.JumpPower + amount, 0, 150)
    end
    updateDisplay()
end

-- Hàm nhảy
local lastJumpTime = 0
local function performJump(multiplier)
    local currentTime = tick()
    if currentTime - lastJumpTime < 0.3 then return end
    lastJumpTime = currentTime
    
    if hum.FloorMaterial ~= Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        
        -- Áp dụng lực nhảy
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, settings.JumpPower * multiplier, 0)
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        bodyVelocity.Parent = char.HumanoidRootPart
        
        game.Debris:AddItem(bodyVelocity, 0.25)
        
        -- Hiệu ứng
        local originalColor = multiplier == 1 and JumpButton.BackgroundColor3 or SuperJumpButton.BackgroundColor3
        local button = multiplier == 1 and JumpButton or SuperJumpButton
        
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        Status.Text = multiplier == 1 and "🚀 ĐANG NHẢY..." or "🔥 ĐANG SIÊU NHẢY..."
        
        task.wait(0.2)
        button.BackgroundColor3 = originalColor
        updateDisplay()
    end
end

-- Hàm nhảy thường
local function normalJump()
    performJump(1.0)
end

-- Hàm siêu nhảy
local function superJump()
    performJump(settings.SuperJumpMultiplier)
end

-- Auto Jump
local autoJumpConnection
local function toggleAutoJump()
    settings.AutoJump = not settings.AutoJump
    
    if settings.AutoJump then
        -- Bật auto jump
        autoJumpConnection = RS.Heartbeat:Connect(function()
            if hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, settings.JumpPower * 0.8, 0)
                bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVelocity.Parent = char.HumanoidRootPart
                
                game.Debris:AddItem(bodyVelocity, 0.15)
            end
        end)
    else
        -- Tắt auto jump
        if autoJumpConnection then
            autoJumpConnection:Disconnect()
            autoJumpConnection = nil
        end
    end
    
    updateDisplay()
end

-- Kéo thanh trượt
local function setupSlider(bar, type)
    local dragging = false
    
    local function updateFromMouse()
        if not dragging then return end
        
        local mouse = player:GetMouse()
        local absoluteX = bar.AbsolutePosition.X
        local absoluteWidth = bar.AbsoluteSize.X
        
        local relativeX = math.clamp(mouse.X - absoluteX, 0, absoluteWidth)
        local percentage = relativeX / absoluteWidth
        
        if type == "speed" then
            settings.WalkSpeed = math.floor(percentage * 100)
        elseif type == "jump" then
            settings.JumpPower = math.floor(percentage * 150)
        end
        
        updateDisplay()
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateFromMouse()
        end
    end)
    
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            updateFromMouse()
        end
    end)
end

-- Kết nối sự kiện nút
SpeedMinus.MouseButton1Click:Connect(function() adjustValue("speed", -5) end)
SpeedPlus.MouseButton1Click:Connect(function() adjustValue("speed", 5) end)
JumpMinus.MouseButton1Click:Connect(function() adjustValue("jump", -5) end)
JumpPlus.MouseButton1Click:Connect(function() adjustValue("jump", 5) end)

JumpButton.MouseButton1Click:Connect(normalJump)
SuperJumpButton.MouseButton1Click:Connect(superJump)
ToggleButton.MouseButton1Click:Connect(toggleAutoJump)

-- Thiết lập thanh trượt kéo
setupSlider(SpeedBar, "speed")
setupSlider(JumpBar, "jump")

-- Phím tắt
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Điều chỉnh tốc độ
    if input.KeyCode == Enum.KeyCode.LeftControl then
        adjustValue("speed", -5)
    elseif input.KeyCode == Enum.KeyCode.RightControl then
        adjustValue("speed", 5)
    
    -- Điều chỉnh nhảy cao
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        adjustValue("jump", -5)
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        adjustValue("jump", 5)
    
    -- Nhảy
    elseif input.KeyCode == Enum.KeyCode.Space then
        normalJump()
    elseif input.KeyCode == Enum.KeyCode.J then
        superJump()
    
    -- Auto Jump
    elseif input.KeyCode == Enum.KeyCode.U then
        toggleAutoJump()
    
    -- Ẩn/hiện GUI
    elseif input.KeyCode == Enum.KeyCode.H then
        Main.Visible = not Main.Visible
    
    -- Reset về mặc định
    elseif input.KeyCode == Enum.KeyCode.R then
        settings.WalkSpeed = 16
        settings.JumpPower = 50
        updateDisplay()
    end
end)

-- Khởi động
updateDisplay()

-- Xử lý respawn
char.Died:Connect(function()
    task.wait(3) -- Đợi respawn
    if char and char.Parent then
        hum = char:WaitForChild("Humanoid")
        updateDisplay()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
    task.wait(1) -- Đợi load character
    updateDisplay()
end)

print("✅ SPEED & JUMP CONTROL ĐÃ TẢI!")
print("📋 PHÍM TẮT:")
print("   Ctrl Trái/Phải: Giảm/Tăng tốc độ")
print("   Shift Trái/Phải: Giảm/Tăng độ cao nhảy")
print("   Space: Nhảy thường")
print("   J: Siêu nhảy")
print("   U: Bật/tắt Auto Jump")
print("   H: Ẩn/hiện GUI")
print("   R: Reset về mặc định")
