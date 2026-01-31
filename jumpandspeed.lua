
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- Tạo GUI
local SpeedJumpGUI = Instance.new("ScreenGui")
SpeedJumpGUI.Name = "SpeedJumpControl"
SpeedJumpGUI.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = SpeedJumpGUI
Main.Size = UDim2.new(0.25, 0, 0.35, 0)
Main.Position = UDim2.new(0.73, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.05, 0)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 100)
UIStroke.Thickness = 2
UIStroke.Parent = Main

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0.12, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SPEED & JUMP CONTROL"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- === PHẦN TỐC ĐỘ ===
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Name = "SpeedFrame"
SpeedFrame.Parent = Main
SpeedFrame.Size = UDim2.new(0.9, 0, 0.18, 0)
SpeedFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
SpeedFrame.BackgroundTransparency = 1

local SpeedText = Instance.new("TextLabel")
SpeedText.Name = "SpeedText"
SpeedText.Parent = SpeedFrame
SpeedText.Size = UDim2.new(0.7, 0, 0.5, 0)
SpeedText.BackgroundTransparency = 1
SpeedText.Text = "🏃 TỐC ĐỘ CHẠY:"
SpeedText.TextColor3 = Color3.fromRGB(200, 200, 255)
SpeedText.Font = Enum.Font.GothamMedium
SpeedText.TextScaled = true
SpeedText.TextXAlignment = Enum.TextXAlignment.Left

local SpeedNumber = Instance.new("TextLabel")
SpeedNumber.Name = "SpeedNumber"
SpeedNumber.Parent = SpeedFrame
SpeedNumber.Size = UDim2.new(0.3, 0, 0.5, 0)
SpeedNumber.Position = UDim2.new(0.7, 0, 0, 0)
SpeedNumber.BackgroundTransparency = 1
SpeedNumber.Text = "16"
SpeedNumber.TextColor3 = Color3.fromRGB(0, 255, 100)
SpeedNumber.Font = Enum.Font.GothamBold
SpeedNumber.TextScaled = true

-- Thanh trượt Tốc độ
local SpeedSliderBg = Instance.new("Frame")
SpeedSliderBg.Name = "SpeedSliderBg"
SpeedSliderBg.Parent = SpeedFrame
SpeedSliderBg.Size = UDim2.new(1, 0, 0.35, 0)
SpeedSliderBg.Position = UDim2.new(0, 0, 0.6, 0)
SpeedSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)

local SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Name = "SpeedSliderFill"
SpeedSliderFill.Parent = SpeedSliderBg
SpeedSliderFill.Size = UDim2.new(0.32, 0, 1, 0) -- 16/50
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
SpeedSliderFill.BorderSizePixel = 0

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0.3, 0)
SliderCorner.Parent = SpeedSliderBg

local SliderCorner2 = Instance.new("UICorner")
SliderCorner2.CornerRadius = UDim.new(0.3, 0)
SliderCorner2.Parent = SpeedSliderFill

-- Nút điều chỉnh Tốc độ
local SpeedButtons = Instance.new("Frame")
SpeedButtons.Name = "SpeedButtons"
SpeedButtons.Parent = SpeedFrame
SpeedButtons.Size = UDim2.new(1, 0, 0.2, 0)
SpeedButtons.Position = UDim2.new(0, 0, 0.95, 0)
SpeedButtons.BackgroundTransparency = 1

local SpeedMinusBtn = Instance.new("TextButton")
SpeedMinusBtn.Name = "SpeedMinusBtn"
SpeedMinusBtn.Parent = SpeedButtons
SpeedMinusBtn.Size = UDim2.new(0.2, 0, 1, 0)
SpeedMinusBtn.Text = "-"
SpeedMinusBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
SpeedMinusBtn.TextColor3 = Color3.white
SpeedMinusBtn.Font = Enum.Font.GothamBold
SpeedMinusBtn.TextScaled = true

local SpeedPlusBtn = Instance.new("TextButton")
SpeedPlusBtn.Name = "SpeedPlusBtn"
SpeedPlusBtn.Parent = SpeedButtons
SpeedPlusBtn.Size = UDim2.new(0.2, 0, 1, 0)
SpeedPlusBtn.Position = UDim2.new(0.8, 0, 0, 0)
SpeedPlusBtn.Text = "+"
SpeedPlusBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
SpeedPlusBtn.TextColor3 = Color3.white
SpeedPlusBtn.Font = Enum.Font.GothamBold
SpeedPlusBtn.TextScaled = true

-- === PHẦN NHẢY CAO ===
local JumpFrame = Instance.new("Frame")
JumpFrame.Name = "JumpFrame"
JumpFrame.Parent = Main
JumpFrame.Size = UDim2.new(0.9, 0, 0.18, 0)
JumpFrame.Position = UDim2.new(0.05, 0, 0.38, 0)
JumpFrame.BackgroundTransparency = 1

local JumpText = Instance.new("TextLabel")
JumpText.Name = "JumpText"
JumpText.Parent = JumpFrame
JumpText.Size = UDim2.new(0.7, 0, 0.5, 0)
JumpText.BackgroundTransparency = 1
JumpText.Text = "⬆️ ĐỘ CAO NHẢY:"
JumpText.TextColor3 = Color3.fromRGB(200, 200, 255)
JumpText.Font = Enum.Font.GothamMedium
JumpText.TextScaled = true
JumpText.TextXAlignment = Enum.TextXAlignment.Left

local JumpNumber = Instance.new("TextLabel")
JumpNumber.Name = "JumpNumber"
JumpNumber.Parent = JumpFrame
JumpNumber.Size = UDim2.new(0.3, 0, 0.5, 0)
JumpNumber.Position = UDim2.new(0.7, 0, 0, 0)
JumpNumber.BackgroundTransparency = 1
JumpNumber.Text = "50"
JumpNumber.TextColor3 = Color3.fromRGB(0, 255, 100)
JumpNumber.Font = Enum.Font.GothamBold
JumpNumber.TextScaled = true

-- Thanh trượt Nhảy cao
local JumpSliderBg = Instance.new("Frame")
JumpSliderBg.Name = "JumpSliderBg"
JumpSliderBg.Parent = JumpFrame
JumpSliderBg.Size = UDim2.new(1, 0, 0.35, 0)
JumpSliderBg.Position = UDim2.new(0, 0, 0.6, 0)
JumpSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)

local JumpSliderFill = Instance.new("Frame")
JumpSliderFill.Name = "JumpSliderFill"
JumpSliderFill.Parent = JumpSliderBg
JumpSliderFill.Size = UDim2.new(0.5, 0, 1, 0) -- 50/100
JumpSliderFill.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
JumpSliderFill.BorderSizePixel = 0

local SliderCorner3 = Instance.new("UICorner")
SliderCorner3.CornerRadius = UDim.new(0.3, 0)
SliderCorner3.Parent = JumpSliderBg

local SliderCorner4 = Instance.new("UICorner")
SliderCorner4.CornerRadius = UDim.new(0.3, 0)
SliderCorner4.Parent = JumpSliderFill

-- Nút điều chỉnh Nhảy cao
local JumpButtons = Instance.new("Frame")
JumpButtons.Name = "JumpButtons"
JumpButtons.Parent = JumpFrame
JumpButtons.Size = UDim2.new(1, 0, 0.2, 0)
JumpButtons.Position = UDim2.new(0, 0, 0.95, 0)
JumpButtons.BackgroundTransparency = 1

local JumpMinusBtn = Instance.new("TextButton")
JumpMinusBtn.Name = "JumpMinusBtn"
JumpMinusBtn.Parent = JumpButtons
JumpMinusBtn.Size = UDim2.new(0.2, 0, 1, 0)
JumpMinusBtn.Text = "-"
JumpMinusBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
JumpMinusBtn.TextColor3 = Color3.white
JumpMinusBtn.Font = Enum.Font.GothamBold
JumpMinusBtn.TextScaled = true

local JumpPlusBtn = Instance.new("TextButton")
JumpPlusBtn.Name = "JumpPlusBtn"
JumpPlusBtn.Parent = JumpButtons
JumpPlusBtn.Size = UDim2.new(0.2, 0, 1, 0)
JumpPlusBtn.Position = UDim2.new(0.8, 0, 0, 0)
JumpPlusBtn.Text = "+"
JumpPlusBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
JumpPlusBtn.TextColor3 = Color3.white
JumpPlusBtn.Font = Enum.Font.GothamBold
JumpPlusBtn.TextScaled = true

-- === NÚT HÀNH ĐỘNG ===
local ActionFrame = Instance.new("Frame")
ActionFrame.Name = "ActionFrame"
ActionFrame.Parent = Main
ActionFrame.Size = UDim2.new(0.9, 0, 0.25, 0)
ActionFrame.Position = UDim2.new(0.05, 0, 0.62, 0)
ActionFrame.BackgroundTransparency = 1

local JumpBtn = Instance.new("TextButton")
JumpBtn.Name = "JumpBtn"
JumpBtn.Parent = ActionFrame
JumpBtn.Size = UDim2.new(0.48, 0, 0.4, 0)
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
JumpBtn.Text = "🚀 NHẢY"
JumpBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.TextScaled = true

local SuperJumpBtn = Instance.new("TextButton")
SuperJumpBtn.Name = "SuperJumpBtn"
SuperJumpBtn.Parent = ActionFrame
SuperJumpBtn.Size = UDim2.new(0.48, 0, 0.4, 0)
SuperJumpBtn.Position = UDim2.new(0.52, 0, 0, 0)
SuperJumpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
SuperJumpBtn.Text = "🔥 SIÊU NHẢY"
SuperJumpBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
SuperJumpBtn.Font = Enum.Font.GothamBold
SuperJumpBtn.TextScaled = true

local AutoJumpBtn = Instance.new("TextButton")
AutoJumpBtn.Name = "AutoJumpBtn"
AutoJumpBtn.Parent = ActionFrame
AutoJumpBtn.Size = UDim2.new(1, 0, 0.4, 0)
AutoJumpBtn.Position = UDim2.new(0, 0, 0.55, 0)
AutoJumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
AutoJumpBtn.Text = "🤖 BẬT AUTO JUMP"
AutoJumpBtn.TextColor3 = Color3.white
AutoJumpBtn.Font = Enum.Font.GothamMedium
AutoJumpBtn.TextScaled = true

-- Bo góc cho tất cả nút
local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.1, 0)

for _, btn in pairs({
    SpeedMinusBtn, SpeedPlusBtn, 
    JumpMinusBtn, JumpPlusBtn,
    JumpBtn, SuperJumpBtn, AutoJumpBtn
}) do
    ButtonCorner:Clone().Parent = btn
end

-- === TRẠNG THÁI ===
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = Main
StatusLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
StatusLabel.Position = UDim2.new(0.05, 0, 0.92, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🟢 SẴN SÀNG | TỐC ĐỘ: 16 | NHẢY: 50"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextScaled = true

-- === BIẾN VÀ HÀM ===
local settings = {
    Speed = 16,
    Jump = 50,
    AutoJump = false,
    SuperJumpMultiplier = 1.8
}

-- Hàm cập nhật GUI
local function updateGUI()
    -- Cập nhật tốc độ
    SpeedNumber.Text = tostring(settings.Speed)
    SpeedText.Text = "🏃 TỐC ĐỘ CHẠY:"
    
    -- Tính % thanh trượt (0-100 scale)
    local speedPercent = settings.Speed / 100
    SpeedSliderFill.Size = UDim2.new(speedPercent, 0, 1, 0)
    
    -- Cập nhật nhảy
    JumpNumber.Text = tostring(settings.Jump)
    JumpText.Text = "⬆️ ĐỘ CAO NHẢY:"
    
    -- Tính % thanh trượt (0-150 scale)
    local jumpPercent = settings.Jump / 150
    JumpSliderFill.Size = UDim2.new(jumpPercent, 0, 1, 0)
    
    -- Áp dụng vào nhân vật
    hum.WalkSpeed = settings.Speed
    hum.JumpPower = settings.Jump
    
    -- Cập nhật trạng thái
    StatusLabel.Text = string.format("🟢 TỐC ĐỘ: %d | NHẢY: %d | %s", 
        settings.Speed, 
        settings.Jump, 
        settings.AutoJump and "AUTO: ON" or "AUTO: OFF"
    )
    
    -- Cập nhật nút Auto Jump
    AutoJumpBtn.Text = settings.AutoJump and "⏹️ TẮT AUTO JUMP" or "🤖 BẬT AUTO JUMP"
    AutoJumpBtn.BackgroundColor3 = settings.AutoJump and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 90)
end

-- Hàm điều chỉnh giá trị
local function adjustValue(type, amount)
    if type == "speed" then
        settings.Speed = math.clamp(settings.Speed + amount, 0, 100)
    elseif type == "jump" then
        settings.Jump = math.clamp(settings.Jump + amount, 0, 150)
    end
    updateGUI()
end

-- Hàm nhảy
local lastJumpTime = 0
local function performJump(isSuper)
    local currentTime = tick()
    if currentTime - lastJumpTime < 0.3 then return end
    lastJumpTime = currentTime
    
    if hum.FloorMaterial ~= Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        
        -- Áp dụng lực nhảy
        local multiplier = isSuper and settings.SuperJumpMultiplier or 1
        local jumpForce = settings.Jump * multiplier
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, jumpForce, 0)
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        bodyVelocity.Parent = char.HumanoidRootPart
        
        game.Debris:AddItem(bodyVelocity, 0.2)
        
        -- Hiệu ứng visual
        local btn = isSuper and SuperJumpBtn or JumpBtn
        local originalColor = btn.BackgroundColor3
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        
        StatusLabel.Text = isSuper and "🔥 ĐANG SIÊU NHẢY..." or "🚀 ĐANG NHẢY..."
        
        -- Khôi phục màu sau 0.2s
        task.delay(0.2, function()
            if btn then
                btn.BackgroundColor3 = originalColor
                updateGUI()
            end
        end)
    end
end

-- Hàm Auto Jump
local autoJumpConnection
local function toggleAutoJump()
    settings.AutoJump = not settings.AutoJump
    
    if settings.AutoJump then
        -- Bật auto jump
        autoJumpConnection = RunService.Heartbeat:Connect(function()
            if hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, settings.Jump * 0.7, 0)
                bv.MaxForce = Vector3.new(0, math.huge, 0)
                bv.Parent = char.HumanoidRootPart
                
                game.Debris:AddItem(bv, 0.15)
            end
        end)
    else
        -- Tắt auto jump
        if autoJumpConnection then
            autoJumpConnection:Disconnect()
            autoJumpConnection = nil
        end
    end
    
    updateGUI()
end

-- === KÉO THANH TRƯỢT ===
local function setupSliderDrag(sliderBg, fill, type)
    local dragging = false
    
    local function updateFromMouse()
        if not dragging then return end
        
        local mouse = player:GetMouse()
        local sliderAbsPos = sliderBg.AbsolutePosition.X
        local sliderWidth = sliderBg.AbsoluteSize.X
        
        -- Tính vị trí chuột trong thanh trượt
        local mouseX = math.clamp(mouse.X - sliderAbsPos, 0, sliderWidth)
        local percentage = mouseX / sliderWidth
        
        -- Cập nhật giá trị
        if type == "speed" then
            settings.Speed = math.floor(percentage * 100)
        elseif type == "jump" then
            settings.Jump = math.floor(percentage * 150)
        end
        
        updateGUI()
    end
    
    -- Bắt đầu kéo
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateFromMouse()
        end
    end)
    
    -- Kết thúc kéo
    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Di chuyển chuột
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            updateFromMouse()
        end
    end)
end

-- === KẾT NỐI SỰ KIỆN ===
-- Nút Tốc độ
SpeedMinusBtn.MouseButton1Click:Connect(function()
    adjustValue("speed", -5)
end)

SpeedPlusBtn.MouseButton1Click:Connect(function()
    adjustValue("speed", 5)
end)

-- Nút Nhảy cao
JumpMinusBtn.MouseButton1Click:Connect(function()
    adjustValue("jump", -5)
end)

JumpPlusBtn.MouseButton1Click:Connect(function()
    adjustValue("jump", 5)
end)

-- Nút hành động
JumpBtn.MouseButton1Click:Connect(function()
    performJump(false)
end)

SuperJumpBtn.MouseButton1Click:Connect(function()
    performJump(true)
end)

AutoJumpBtn.MouseButton1Click:Connect(toggleAutoJump)

-- Thiết lập thanh trượt kéo
setupSliderDrag(SpeedSliderBg, SpeedSliderFill, "speed")
setupSliderDrag(JumpSliderBg, JumpSliderFill, "jump")

-- === PHÍM TẮT ===
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.LeftControl then
        adjustValue("speed", -5) -- Giảm tốc độ
    elseif input.KeyCode == Enum.KeyCode.RightControl then
        adjustValue("speed", 5) -- Tăng tốc độ
    
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        adjustValue("jump", -5) -- Giảm độ cao nhảy
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        adjustValue("jump", 5) -- Tăng độ cao nhảy
    
    elseif input.KeyCode == Enum.KeyCode.Space then
        performJump(false) -- Nhảy thường
    
    elseif input.KeyCode == Enum.KeyCode.J then
        performJump(true) -- Siêu nhảy
    
    elseif input.KeyCode == Enum.KeyCode.U then
        toggleAutoJump() -- Bật/tắt Auto Jump
    
    elseif input.KeyCode == Enum.KeyCode.H then
        Main.Visible = not Main.Visible -- Ẩn/hiện GUI
    
    elseif input.KeyCode == Enum.KeyCode.R then
        -- Reset về mặc định
        settings.Speed = 16
        settings.Jump = 50
        updateGUI()
        StatusLabel.Text = "🔄 ĐÃ RESET VỀ MẶC ĐỊNH"
        task.wait(1)
        updateGUI()
    end
end)

-- === KHỞI ĐỘNG ===
updateGUI()

print("✅ SPEED & JUMP CONTROL ĐÃ TẢI THÀNH CÔNG!")
print("📊 CÀI ĐẶT HIỆN TẠI:")
print("   • Tốc độ: " .. settings.Speed)
print("   • Nhảy cao: " .. settings.Jump)
print("   • Auto Jump: " .. tostring(settings.AutoJump))

print("🎮 PHÍM TẮT:")
print("   Ctrl Trái/Phải: Điều chỉnh Tốc độ")
print("   Shift Trái/Phải: Điều chỉnh Nhảy cao")
print("   Space: Nhảy thường")
print("   J: Siêu nhảy")
print("   U: Bật/tắt Auto Jump")
print("   H: Ẩn/hiện GUI")
print("   R: Reset về mặc định")

-- Xử lý khi respawn
char.Died:Connect(function()
    task.wait(3) -- Chờ respawn
    if char and char.Parent then
        hum = char:WaitForChild("Humanoid")
        updateGUI()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
    task.wait(1) -- Chờ character load
    updateGUI()
end)
