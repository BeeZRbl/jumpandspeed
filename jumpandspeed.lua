-- SPEED & JUMP CONTROL - CHẮC CHẮN HOẠT ĐỘNG
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ========== TẠO GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedJumpGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0.25, 0, 0.35, 0)
mainFrame.Position = UDim2.new(0.73, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.05, 0)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 100)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0.12, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ SPEED & JUMP CONTROL"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- ========== TỐC ĐỘ CHẠY ==========
local speedSection = Instance.new("Frame")
speedSection.Name = "SpeedSection"
speedSection.Parent = mainFrame
speedSection.Size = UDim2.new(0.9, 0, 0.2, 0)
speedSection.Position = UDim2.new(0.05, 0, 0.15, 0)
speedSection.BackgroundTransparency = 1

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Parent = speedSection
speedLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "🏃 TỐC ĐỘ CHẠY:"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
speedLabel.Font = Enum.Font.GothamMedium
speedLabel.TextScaled = true
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

local speedValue = Instance.new("TextLabel")
speedValue.Name = "SpeedValue"
speedValue.Parent = speedSection
speedValue.Size = UDim2.new(0.4, 0, 0.5, 0)
speedValue.Position = UDim2.new(0.6, 0, 0, 0)
speedValue.BackgroundTransparency = 1
speedValue.Text = "16"
speedValue.TextColor3 = Color3.fromRGB(0, 255, 100)
speedValue.Font = Enum.Font.GothamBold
speedValue.TextScaled = true

-- Thanh trượt tốc độ
local speedSliderBg = Instance.new("Frame")
speedSliderBg.Name = "SpeedSliderBg"
speedSliderBg.Parent = speedSection
speedSliderBg.Size = UDim2.new(1, 0, 0.25, 0)
speedSliderBg.Position = UDim2.new(0, 0, 0.6, 0)
speedSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
speedSliderBg.BorderSizePixel = 0

local speedSliderFill = Instance.new("Frame")
speedSliderFill.Name = "SpeedSliderFill"
speedSliderFill.Parent = speedSliderBg
speedSliderFill.Size = UDim2.new(0.16, 0, 1, 0) -- 16/100 = 0.16
speedSliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
speedSliderFill.BorderSizePixel = 0

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0.3, 0)
sliderCorner.Parent = speedSliderBg
sliderCorner:Clone().Parent = speedSliderFill

-- Nút điều chỉnh tốc độ
local speedControls = Instance.new("Frame")
speedControls.Name = "SpeedControls"
speedControls.Parent = speedSection
speedControls.Size = UDim2.new(1, 0, 0.25, 0)
speedControls.Position = UDim2.new(0, 0, 0.85, 0)
speedControls.BackgroundTransparency = 1

local speedMinusBtn = Instance.new("TextButton")
speedMinusBtn.Name = "SpeedMinusBtn"
speedMinusBtn.Parent = speedControls
speedMinusBtn.Size = UDim2.new(0.2, 0, 1, 0)
speedMinusBtn.Text = "-"
speedMinusBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
speedMinusBtn.TextColor3 = Color3.white
speedMinusBtn.Font = Enum.Font.GothamBold
speedMinusBtn.TextScaled = true

local speedPlusBtn = Instance.new("TextButton")
speedPlusBtn.Name = "SpeedPlusBtn"
speedPlusBtn.Parent = speedControls
speedPlusBtn.Size = UDim2.new(0.2, 0, 1, 0)
speedPlusBtn.Position = UDim2.new(0.8, 0, 0, 0)
speedPlusBtn.Text = "+"
speedPlusBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
speedPlusBtn.TextColor3 = Color3.white
speedPlusBtn.Font = Enum.Font.GothamBold
speedPlusBtn.TextScaled = true

-- ========== NHẢY CAO ==========
local jumpSection = Instance.new("Frame")
jumpSection.Name = "JumpSection"
jumpSection.Parent = mainFrame
jumpSection.Size = UDim2.new(0.9, 0, 0.2, 0)
jumpSection.Position = UDim2.new(0.05, 0, 0.38, 0)
jumpSection.BackgroundTransparency = 1

local jumpLabel = Instance.new("TextLabel")
jumpLabel.Name = "JumpLabel"
jumpLabel.Parent = jumpSection
jumpLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "⬆️ ĐỘ CAO NHẢY:"
jumpLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
jumpLabel.Font = Enum.Font.GothamMedium
jumpLabel.TextScaled = true
jumpLabel.TextXAlignment = Enum.TextXAlignment.Left

local jumpValue = Instance.new("TextLabel")
jumpValue.Name = "JumpValue"
jumpValue.Parent = jumpSection
jumpValue.Size = UDim2.new(0.4, 0, 0.5, 0)
jumpValue.Position = UDim2.new(0.6, 0, 0, 0)
jumpValue.BackgroundTransparency = 1
jumpValue.Text = "50"
jumpValue.TextColor3 = Color3.fromRGB(0, 255, 100)
jumpValue.Font = Enum.Font.GothamBold
jumpValue.TextScaled = true

-- Thanh trượt nhảy cao
local jumpSliderBg = Instance.new("Frame")
jumpSliderBg.Name = "JumpSliderBg"
jumpSliderBg.Parent = jumpSection
jumpSliderBg.Size = UDim2.new(1, 0, 0.25, 0)
jumpSliderBg.Position = UDim2.new(0, 0, 0.6, 0)
jumpSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
jumpSliderBg.BorderSizePixel = 0

local jumpSliderFill = Instance.new("Frame")
jumpSliderFill.Name = "JumpSliderFill"
jumpSliderFill.Parent = jumpSliderBg
jumpSliderFill.Size = UDim2.new(0.33, 0, 1, 0) -- 50/150 = 0.33
jumpSliderFill.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
jumpSliderFill.BorderSizePixel = 0

local jumpSliderCorner = Instance.new("UICorner")
jumpSliderCorner.CornerRadius = UDim.new(0.3, 0)
jumpSliderCorner.Parent = jumpSliderBg
jumpSliderCorner:Clone().Parent = jumpSliderFill

-- Nút điều chỉnh nhảy cao
local jumpControls = Instance.new("Frame")
jumpControls.Name = "JumpControls"
jumpControls.Parent = jumpSection
jumpControls.Size = UDim2.new(1, 0, 0.25, 0)
jumpControls.Position = UDim2.new(0, 0, 0.85, 0)
jumpControls.BackgroundTransparency = 1

local jumpMinusBtn = Instance.new("TextButton")
jumpMinusBtn.Name = "JumpMinusBtn"
jumpMinusBtn.Parent = jumpControls
jumpMinusBtn.Size = UDim2.new(0.2, 0, 1, 0)
jumpMinusBtn.Text = "-"
jumpMinusBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
jumpMinusBtn.TextColor3 = Color3.white
jumpMinusBtn.Font = Enum.Font.GothamBold
jumpMinusBtn.TextScaled = true

local jumpPlusBtn = Instance.new("TextButton")
jumpPlusBtn.Name = "JumpPlusBtn"
jumpPlusBtn.Parent = jumpControls
jumpPlusBtn.Size = UDim2.new(0.2, 0, 1, 0)
jumpPlusBtn.Position = UDim2.new(0.8, 0, 0, 0)
jumpPlusBtn.Text = "+"
jumpPlusBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
jumpPlusBtn.TextColor3 = Color3.white
jumpPlusBtn.Font = Enum.Font.GothamBold
jumpPlusBtn.TextScaled = true

-- ========== NÚT HÀNH ĐỘNG ==========
local actionSection = Instance.new("Frame")
actionSection.Name = "ActionSection"
actionSection.Parent = mainFrame
actionSection.Size = UDim2.new(0.9, 0, 0.3, 0)
actionSection.Position = UDim2.new(0.05, 0, 0.62, 0)
actionSection.BackgroundTransparency = 1

local jumpBtn = Instance.new("TextButton")
jumpBtn.Name = "JumpBtn"
jumpBtn.Parent = actionSection
jumpBtn.Size = UDim2.new(0.48, 0, 0.4, 0)
jumpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
jumpBtn.Text = "🚀 NHẢY"
jumpBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.TextScaled = true

local superJumpBtn = Instance.new("TextButton")
superJumpBtn.Name = "SuperJumpBtn"
superJumpBtn.Parent = actionSection
superJumpBtn.Size = UDim2.new(0.48, 0, 0.4, 0)
superJumpBtn.Position = UDim2.new(0.52, 0, 0, 0)
superJumpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
superJumpBtn.Text = "🔥 SIÊU NHẢY"
superJumpBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
superJumpBtn.Font = Enum.Font.GothamBold
superJumpBtn.TextScaled = true

local autoJumpBtn = Instance.new("TextButton")
autoJumpBtn.Name = "AutoJumpBtn"
autoJumpBtn.Parent = actionSection
autoJumpBtn.Size = UDim2.new(1, 0, 0.4, 0)
autoJumpBtn.Position = UDim2.new(0, 0, 0.55, 0)
autoJumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
autoJumpBtn.Text = "🤖 BẬT AUTO JUMP"
autoJumpBtn.TextColor3 = Color3.white
autoJumpBtn.Font = Enum.Font.GothamMedium
autoJumpBtn.TextScaled = true

-- Bo góc cho tất cả nút
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.1, 0)

for _, btn in pairs({
    speedMinusBtn, speedPlusBtn,
    jumpMinusBtn, jumpPlusBtn,
    jumpBtn, superJumpBtn, autoJumpBtn
}) do
    buttonCorner:Clone().Parent = btn
end

-- Trạng thái
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Parent = mainFrame
statusLabel.Size = UDim2.new(0.9, 0, 0.08, 0)
statusLabel.Position = UDim2.new(0.05, 0, 0.94, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "🟢 SẴN SÀNG | TỐC ĐỘ: 16 | NHẢY: 50"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextScaled = true

-- ========== BIẾN VÀ HÀM ==========
local settings = {
    speed = 16,
    jump = 50,
    autoJump = false,
    superMultiplier = 2.0
}

-- Hàm cập nhật GUI
local function updateDisplay()
    -- Cập nhật giá trị hiển thị
    speedValue.Text = tostring(settings.speed)
    jumpValue.Text = tostring(settings.jump)
    
    -- Cập nhật thanh trượt
    speedSliderFill.Size = UDim2.new(settings.speed / 100, 0, 1, 0)
    jumpSliderFill.Size = UDim2.new(settings.jump / 150, 0, 1, 0)
    
    -- Áp dụng vào nhân vật
    humanoid.WalkSpeed = settings.speed
    humanoid.JumpPower = settings.jump
    
    -- Cập nhật trạng thái
    statusLabel.Text = string.format("🟢 TỐC ĐỘ: %d | NHẢY: %d | %s",
        settings.speed,
        settings.jump,
        settings.autoJump and "AUTO: ON" or "AUTO: OFF"
    )
    
    -- Cập nhật nút auto jump
    autoJumpBtn.Text = settings.autoJump and "⏹️ TẮT AUTO JUMP" or "🤖 BẬT AUTO JUMP"
    autoJumpBtn.BackgroundColor3 = settings.autoJump and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 90)
    
    -- Debug
    print(string.format("Speed: %d | Jump: %d", settings.speed, settings.jump))
end

-- Hàm điều chỉnh giá trị
local function adjustSetting(type, amount)
    if type == "speed" then
        settings.speed = math.clamp(settings.speed + amount, 0, 100)
        print("Speed adjusted to:", settings.speed)
    elseif type == "jump" then
        settings.jump = math.clamp(settings.jump + amount, 0, 150)
        print("Jump adjusted to:", settings.jump)
    end
    updateDisplay()
end

-- Hàm nhảy
local lastJump = 0
local function performJump(isSuper)
    local now = tick()
    if now - lastJump < 0.3 then return end
    lastJump = now
    
    if humanoid.FloorMaterial ~= Enum.Material.Air then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        
        local multiplier = isSuper and settings.superMultiplier or 1
        local jumpForce = settings.jump * multiplier
        
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, jumpForce, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Parent = character.HumanoidRootPart
        
        game.Debris:AddItem(bv, 0.2)
        
        -- Hiệu ứng
        local btn = isSuper and superJumpBtn or jumpBtn
        local originalColor = btn.BackgroundColor3
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        statusLabel.Text = isSuper and "🔥 ĐANG SIÊU NHẢY..." or "🚀 ĐANG NHẢY..."
        
        task.delay(0.2, function()
            if btn then
                btn.BackgroundColor3 = originalColor
                updateDisplay()
            end
        end)
    end
end

-- Auto Jump
local autoConnection
local function toggleAutoJump()
    settings.autoJump = not settings.autoJump
    
    if settings.autoJump then
        autoConnection = RunService.Heartbeat:Connect(function()
            if humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, settings.jump * 0.6, 0)
                bv.MaxForce = Vector3.new(0, math.huge, 0)
                bv.Parent = character.HumanoidRootPart
                
                game.Debris:AddItem(bv, 0.15)
            end
        end)
    else
        if autoConnection then
            autoConnection:Disconnect()
            autoConnection = nil
        end
    end
    
    updateDisplay()
end

-- ========== KÉO THANH TRƯỢT - FIXED ==========
local function setupSlider(sliderBg, type)
    local dragging = false
    
    local function updateValueFromMouse()
        if not dragging then return end
        
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local absoluteX = sliderBg.AbsolutePosition.X
        local absoluteWidth = sliderBg.AbsoluteSize.X
        
        local mouseX = math.clamp(mouse.X - absoluteX, 0, absoluteWidth)
        local percentage = mouseX / absoluteWidth
        
        if type == "speed" then
            settings.speed = math.floor(percentage * 100)
        elseif type == "jump" then
            settings.jump = math.floor(percentage * 150)
        end
        
        updateDisplay()
    end
    
    -- Bắt đầu kéo
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateValueFromMouse()
        end
    end)
    
    -- Kết thúc kéo
    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Di chuyển chuột
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                updateValueFromMouse()
            end
        end
    end)
end

-- ========== KẾT NỐI SỰ KIỆN - SIMPLE ==========
-- Nút Tốc độ
speedMinusBtn.MouseButton1Click:Connect(function()
    print("Speed - clicked")
    adjustSetting("speed", -5)
end)

speedPlusBtn.MouseButton1Click:Connect(function()
    print("Speed + clicked")
    adjustSetting("speed", 5)
end)

-- Nút Nhảy
jumpMinusBtn.MouseButton1Click:Connect(function()
    print("Jump - clicked")
    adjustSetting("jump", -5)
end)

jumpPlusBtn.MouseButton1Click:Connect(function()
    print("Jump + clicked")
    adjustSetting("jump", 5)
end)

-- Nút hành động
jumpBtn.MouseButton1Click:Connect(function()
    print("Normal Jump clicked")
    performJump(false)
end)

superJumpBtn.MouseButton1Click:Connect(function()
    print("Super Jump clicked")
    performJump(true)
end)

autoJumpBtn.MouseButton1Click:Connect(function()
    print("Auto Jump clicked")
    toggleAutoJump()
end)

-- Thiết lập thanh trượt kéo
setupSlider(speedSliderBg, "speed")
setupSlider(jumpSliderBg, "jump")

-- ========== PHÍM TẮT ==========
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    -- Điều chỉnh tốc độ
    if input.KeyCode == Enum.KeyCode.Q then
        adjustSetting("speed", -5)
    elseif input.KeyCode == Enum.KeyCode.E then
        adjustSetting("speed", 5)
    
    -- Điều chỉnh nhảy
    elseif input.KeyCode == Enum.KeyCode.Z then
        adjustSetting("jump", -5)
    elseif input.KeyCode == Enum.KeyCode.X then
        adjustSetting("jump", 5)
    
    -- Nhảy
    elseif input.KeyCode == Enum.KeyCode.Space then
        performJump(false)
    elseif input.KeyCode == Enum.KeyCode.J then
        performJump(true)
    
    -- Auto Jump
    elseif input.KeyCode == Enum.KeyCode.U then
        toggleAutoJump()
    
    -- Ẩn/hiện GUI
    elseif input.KeyCode == Enum.KeyCode.H then
        mainFrame.Visible = not mainFrame.Visible
    
    -- Reset
    elseif input.KeyCode == Enum.KeyCode.R then
        settings.speed = 16
        settings.jump = 50
        updateDisplay()
    end
end)

-- ========== KHỞI ĐỘNG ==========
updateDisplay()

print("=" .. string.rep("=", 50))
print("✅ SPEED & JUMP CONTROL ĐÃ TẢI")
print("📊 KIỂM TRA HOẠT ĐỘNG:")
print("   1. Nhấn nút '+' bên cạnh số 16")
print("   2. Số phải tăng lên 21")
print("   3. Thanh màu xanh phải dài ra")
print("   4. Nhân vật phải chạy nhanh hơn")
print("🎮 PHÍM TẮT:")
print("   Q/E: Điều chỉnh Tốc độ")
print("   Z/X: Điều chỉnh Nhảy cao")
print("   Space: Nhảy thường")
print("   J: Siêu nhảy")
print("   U: Auto Jump")
print("   H: Ẩn/hiện GUI")
print("   R: Reset")
print("=" .. string.rep("=", 50))

-- Xử lý respawn
character.Died:Connect(function()
    task.wait(3)
    if character and character.Parent then
        humanoid = character:WaitForChild("Humanoid")
        updateDisplay()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    task.wait(0.5)
    updateDisplay()
end)
