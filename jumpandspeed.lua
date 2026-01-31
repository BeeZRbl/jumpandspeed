-- LOCAL SPEED & JUMP CONTROL - ĐÃ FIX LỖI KÉO THANH TRƯỢT
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- ===== TẠO GUI ĐƠN GIẢN =====
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedJumpGUI"
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = gui
main.Size = UDim2.new(0.25, 0, 0.35, 0)
main.Position = UDim2.new(0.73, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.05, 0)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 100)
stroke.Thickness = 2
stroke.Parent = main

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ SPEED & JUMP"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- === PHẦN TỐC ĐỘ ===
local speedFrame = Instance.new("Frame")
speedFrame.Parent = main
speedFrame.Size = UDim2.new(0.9, 0, 0.2, 0)
speedFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
speedFrame.BackgroundTransparency = 1

local speedText = Instance.new("TextLabel")
speedText.Parent = speedFrame
speedText.Size = UDim2.new(0.7, 0, 0.5, 0)
speedText.BackgroundTransparency = 1
speedText.Text = "🏃 TỐC ĐỘ:"
speedText.TextColor3 = Color3.white
speedText.Font = Enum.Font.GothamMedium
speedText.TextScaled = true
speedText.TextXAlignment = Enum.TextXAlignment.Left

local speedNum = Instance.new("TextLabel")
speedNum.Name = "SpeedNum"
speedNum.Parent = speedFrame
speedNum.Size = UDim2.new(0.3, 0, 0.5, 0)
speedNum.Position = UDim2.new(0.7, 0, 0, 0)
speedNum.BackgroundTransparency = 1
speedNum.Text = "16"
speedNum.TextColor3 = Color3.fromRGB(0, 255, 100)
speedNum.Font = Enum.Font.GothamBold
speedNum.TextScaled = true

-- Thanh trượt TỐC ĐỘ (ĐƠN GIẢN HƠN)
local speedBarBg = Instance.new("TextButton") -- DÙNG TEXTBUTTON THAY VÌ FRAME
speedBarBg.Name = "SpeedBarBg"
speedBarBg.Parent = speedFrame
speedBarBg.Size = UDim2.new(1, 0, 0.3, 0)
speedBarBg.Position = UDim2.new(0, 0, 0.6, 0)
speedBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
speedBarBg.Text = ""
speedBarBg.AutoButtonColor = false
speedBarBg.BorderSizePixel = 0

local speedBarFill = Instance.new("Frame")
speedBarFill.Name = "SpeedBarFill"
speedBarFill.Parent = speedBarBg
speedBarFill.Size = UDim2.new(0.16, 0, 1, 0)
speedBarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
speedBarFill.BorderSizePixel = 0

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0.3, 0)
barCorner.Parent = speedBarBg
barCorner:Clone().Parent = speedBarFill

-- Nút điều chỉnh tốc độ
local speedBtnFrame = Instance.new("Frame")
speedBtnFrame.Parent = speedFrame
speedBtnFrame.Size = UDim2.new(1, 0, 0.2, 0)
speedBtnFrame.Position = UDim2.new(0, 0, 0.9, 0)
speedBtnFrame.BackgroundTransparency = 1

local speedMinus = Instance.new("TextButton")
speedMinus.Parent = speedBtnFrame
speedMinus.Size = UDim2.new(0.2, 0, 1, 0)
speedMinus.Text = "-"
speedMinus.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
speedMinus.TextColor3 = Color3.white
speedMinus.Font = Enum.Font.GothamBold

local speedPlus = Instance.new("TextButton")
speedPlus.Parent = speedBtnFrame
speedPlus.Size = UDim2.new(0.2, 0, 1, 0)
speedPlus.Position = UDim2.new(0.8, 0, 0, 0)
speedPlus.Text = "+"
speedPlus.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
speedPlus.TextColor3 = Color3.white
speedPlus.Font = Enum.Font.GothamBold

-- === PHẦN NHẢY CAO ===
local jumpFrame = Instance.new("Frame")
jumpFrame.Parent = main
jumpFrame.Size = UDim2.new(0.9, 0, 0.2, 0)
jumpFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
jumpFrame.BackgroundTransparency = 1

local jumpText = Instance.new("TextLabel")
jumpText.Parent = jumpFrame
jumpText.Size = UDim2.new(0.7, 0, 0.5, 0)
jumpText.BackgroundTransparency = 1
jumpText.Text = "⬆️ NHẢY CAO:"
jumpText.TextColor3 = Color3.white
jumpText.Font = Enum.Font.GothamMedium
jumpText.TextScaled = true
jumpText.TextXAlignment = Enum.TextXAlignment.Left

local jumpNum = Instance.new("TextLabel")
jumpNum.Name = "JumpNum"
jumpNum.Parent = jumpFrame
jumpNum.Size = UDim2.new(0.3, 0, 0.5, 0)
jumpNum.Position = UDim2.new(0.7, 0, 0, 0)
jumpNum.BackgroundTransparency = 1
jumpNum.Text = "50"
jumpNum.TextColor3 = Color3.fromRGB(0, 255, 100)
jumpNum.Font = Enum.Font.GothamBold
jumpNum.TextScaled = true

-- Thanh trượt NHẢY CAO
local jumpBarBg = Instance.new("TextButton") -- DÙNG TEXTBUTTON
jumpBarBg.Name = "JumpBarBg"
jumpBarBg.Parent = jumpFrame
jumpBarBg.Size = UDim2.new(1, 0, 0.3, 0)
jumpBarBg.Position = UDim2.new(0, 0, 0.6, 0)
jumpBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
jumpBarBg.Text = ""
jumpBarBg.AutoButtonColor = false
jumpBarBg.BorderSizePixel = 0

local jumpBarFill = Instance.new("Frame")
jumpBarFill.Name = "JumpBarFill"
jumpBarFill.Parent = jumpBarBg
jumpBarFill.Size = UDim2.new(0.33, 0, 1, 0)
jumpBarFill.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
jumpBarFill.BorderSizePixel = 0

local jumpBarCorner = Instance.new("UICorner")
jumpBarCorner.CornerRadius = UDim.new(0.3, 0)
jumpBarCorner.Parent = jumpBarBg
jumpBarCorner:Clone().Parent = jumpBarFill

-- Nút điều chỉnh nhảy cao
local jumpBtnFrame = Instance.new("Frame")
jumpBtnFrame.Parent = jumpFrame
jumpBtnFrame.Size = UDim2.new(1, 0, 0.2, 0)
jumpBtnFrame.Position = UDim2.new(0, 0, 0.9, 0)
jumpBtnFrame.BackgroundTransparency = 1

local jumpMinus = Instance.new("TextButton")
jumpMinus.Parent = jumpBtnFrame
jumpMinus.Size = UDim2.new(0.2, 0, 1, 0)
jumpMinus.Text = "-"
jumpMinus.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
jumpMinus.TextColor3 = Color3.white
jumpMinus.Font = Enum.Font.GothamBold

local jumpPlus = Instance.new("TextButton")
jumpPlus.Parent = jumpBtnFrame
jumpPlus.Size = UDim2.new(0.2, 0, 1, 0)
jumpPlus.Position = UDim2.new(0.8, 0, 0, 0)
jumpPlus.Text = "+"
jumpPlus.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
jumpPlus.TextColor3 = Color3.white
jumpPlus.Font = Enum.Font.GothamBold

-- === NÚT HÀNH ĐỘNG ===
local actionFrame = Instance.new("Frame")
actionFrame.Parent = main
actionFrame.Size = UDim2.new(0.9, 0, 0.3, 0)
actionFrame.Position = UDim2.new(0.05, 0, 0.65, 0)
actionFrame.BackgroundTransparency = 1

local jumpBtn = Instance.new("TextButton")
jumpBtn.Parent = actionFrame
jumpBtn.Size = UDim2.new(0.48, 0, 0.4, 0)
jumpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
jumpBtn.Text = "🚀 NHẢY"
jumpBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
jumpBtn.Font = Enum.Font.GothamBold

local superJumpBtn = Instance.new("TextButton")
superJumpBtn.Parent = actionFrame
superJumpBtn.Size = UDim2.new(0.48, 0, 0.4, 0)
superJumpBtn.Position = UDim2.new(0.52, 0, 0, 0)
superJumpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
superJumpBtn.Text = "🔥 SIÊU NHẢY"
superJumpBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
superJumpBtn.Font = Enum.Font.GothamBold

local autoBtn = Instance.new("TextButton")
autoBtn.Parent = actionFrame
autoBtn.Size = UDim2.new(1, 0, 0.4, 0)
autoBtn.Position = UDim2.new(0, 0, 0.55, 0)
autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
autoBtn.Text = "🤖 AUTO JUMP: OFF"
autoBtn.TextColor3 = Color3.white
autoBtn.Font = Enum.Font.GothamMedium

-- Bo góc cho nút
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0.1, 0)

for _, btn in pairs({speedMinus, speedPlus, jumpMinus, jumpPlus, jumpBtn, superJumpBtn, autoBtn}) do
    btnCorner:Clone().Parent = btn
end

-- Trạng thái
local status = Instance.new("TextLabel")
status.Parent = main
status.Size = UDim2.new(0.9, 0, 0.08, 0)
status.Position = UDim2.new(0.05, 0, 0.95, 0)
status.BackgroundTransparency = 1
status.Text = "🟢 SẴN SÀNG"
status.TextColor3 = Color3.fromRGB(0, 255, 100)
status.Font = Enum.Font.GothamMedium

-- ===== BIẾN VÀ HÀM =====
local settings = {
    speed = 16,
    jump = 50,
    auto = false
}

-- Hàm cập nhật GUI
local function updateUI()
    -- Cập nhật số
    speedNum.Text = tostring(settings.speed)
    jumpNum.Text = tostring(settings.jump)
    
    -- Cập nhật thanh trượt
    speedBarFill.Size = UDim2.new(settings.speed / 100, 0, 1, 0)
    jumpBarFill.Size = UDim2.new(settings.jump / 150, 0, 1, 0)
    
    -- Áp dụng vào nhân vật
    hum.WalkSpeed = settings.speed
    hum.JumpPower = settings.jump
    
    -- Cập nhật nút auto
    autoBtn.Text = settings.auto and "⏹️ AUTO JUMP: ON" or "🤖 AUTO JUMP: OFF"
    autoBtn.BackgroundColor3 = settings.auto and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 90)
    
    -- Cập nhật trạng thái
    status.Text = string.format("⚡ SPD: %d | JMP: %d", settings.speed, settings.jump)
    
    print("UPDATE: Speed =", settings.speed, "Jump =", settings.jump)
end

-- Hàm điều chỉnh giá trị
local function changeValue(type, amount)
    if type == "speed" then
        settings.speed = math.clamp(settings.speed + amount, 0, 100)
    elseif type == "jump" then
        settings.jump = math.clamp(settings.jump + amount, 0, 150)
    end
    updateUI()
end

-- Hàm nhảy
local lastJumpTime = 0
local function doJump(isSuper)
    local now = tick()
    if now - lastJumpTime < 0.3 then return end
    lastJumpTime = now
    
    if hum.FloorMaterial ~= Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        
        local force = settings.jump * (isSuper and 2.0 or 1.0)
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, force, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Parent = char.HumanoidRootPart
        
        game.Debris:AddItem(bv, 0.2)
        
        -- Hiệu ứng
        local btn = isSuper and superJumpBtn or jumpBtn
        local original = btn.BackgroundColor3
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        status.Text = isSuper and "🔥 SIÊU NHẢY!" or "🚀 NHẢY!"
        
        task.wait(0.2)
        btn.BackgroundColor3 = original
        updateUI()
    end
end

-- Auto Jump
local autoConn
local function toggleAuto()
    settings.auto = not settings.auto
    
    if settings.auto then
        autoConn = RunService.Heartbeat:Connect(function()
            if hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, settings.jump * 0.7, 0)
                bv.MaxForce = Vector3.new(0, math.huge, 0)
                bv.Parent = char.HumanoidRootPart
                
                game.Debris:AddItem(bv, 0.15)
            end
        end)
    else
        if autoConn then
            autoConn:Disconnect()
            autoConn = nil
        end
    end
    
    updateUI()
end

-- ===== KÉO THANH TRƯỢT - FIX CHÍNH =====
local function setupDrag(barBg, type)
    local dragging = false
    
    -- Khi nhấn vào thanh trượt
    barBg.MouseButton1Down:Connect(function(x, y)
        dragging = true
        print("START DRAG:", type)
        
        -- Cập nhật ngay khi nhấn
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local absoluteX = barBg.AbsolutePosition.X
        local absoluteWidth = barBg.AbsoluteSize.X
        
        local mouseX = math.clamp(mouse.X - absoluteX, 0, absoluteWidth)
        local percent = mouseX / absoluteWidth
        
        if type == "speed" then
            settings.speed = math.floor(percent * 100)
        elseif type == "jump" then
            settings.jump = math.floor(percent * 150)
        end
        
        updateUI()
    end)
    
    -- Khi di chuyển chuột
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local absoluteX = barBg.AbsolutePosition.X
            local absoluteWidth = barBg.AbsoluteSize.X
            
            local mouseX = math.clamp(mouse.X - absoluteX, 0, absoluteWidth)
            local percent = mouseX / absoluteWidth
            
            if type == "speed" then
                settings.speed = math.floor(percent * 100)
            elseif type == "jump" then
                settings.jump = math.floor(percent * 150)
            end
            
            updateUI()
        end
    end)
    
    -- Khi thả chuột
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Cũng cho phép click để đặt giá trị
    barBg.MouseButton1Click:Connect(function()
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local absoluteX = barBg.AbsolutePosition.X
        local absoluteWidth = barBg.AbsoluteSize.X
        
        local mouseX = math.clamp(mouse.X - absoluteX, 0, absoluteWidth)
        local percent = mouseX / absoluteWidth
        
        if type == "speed" then
            settings.speed = math.floor(percent * 100)
        elseif type == "jump" then
            settings.jump = math.floor(percent * 150)
        end
        
        updateUI()
    end)
end

-- ===== KẾT NỐI SỰ KIỆN =====
-- Nút tốc độ
speedMinus.MouseButton1Click:Connect(function()
    changeValue("speed", -5)
end)

speedPlus.MouseButton1Click:Connect(function()
    changeValue("speed", 5)
end)

-- Nút nhảy cao
jumpMinus.MouseButton1Click:Connect(function()
    changeValue("jump", -5)
end)

jumpPlus.MouseButton1Click:Connect(function()
    changeValue("jump", 5)
end)

-- Nút nhảy
jumpBtn.MouseButton1Click:Connect(function()
    doJump(false)
end)

superJumpBtn.MouseButton1Click:Connect(function()
    doJump(true)
end)

-- Nút auto
autoBtn.MouseButton1Click:Connect(toggleAuto)

-- Thiết lập kéo thanh trượt
setupDrag(speedBarBg, "speed")
setupDrag(jumpBarBg, "jump")

-- ===== PHÍM TẮT =====
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.Q then
        changeValue("speed", -5)
    elseif input.KeyCode == Enum.KeyCode.E then
        changeValue("speed", 5)
    
    elseif input.KeyCode == Enum.KeyCode.Z then
        changeValue("jump", -5)
    elseif input.KeyCode == Enum.KeyCode.X then
        changeValue("jump", 5)
    
    elseif input.KeyCode == Enum.KeyCode.Space then
        doJump(false)
    elseif input.KeyCode == Enum.KeyCode.J then
        doJump(true)
    
    elseif input.KeyCode == Enum.KeyCode.U then
        toggleAuto()
    
    elseif input.KeyCode == Enum.KeyCode.H then
        main.Visible = not main.Visible
    
    elseif input.KeyCode == Enum.KeyCode.R then
        settings.speed = 16
        settings.jump = 50
        updateUI()
    end
end)

-- ===== KHỞI ĐỘNG =====
updateUI()

print("=" .. string.rep("=", 50))
print("🎮 SPEED & JUMP CONTROL - ĐÃ SỬA LỖI KÉO")
print("✅ ĐÃ TẢI THÀNH CÔNG!")
print("")
print("🎯 CÁCH KIỂM TRA KÉO THANH TRƯỢT:")
print("   1. NHẤN VÀ GIỮ chuột trái trên thanh màu xám")
print("   2. KÉO SANG TRÁI/PHAI")
print("   3. SỐ và THANH MÀU phải thay đổi")
print("")
print("🎮 PHÍM TẮT:")
print("   Q/E: Tăng/giảm tốc độ")
print("   Z/X: Tăng/giảm nhảy cao")
print("   Space: Nhảy thường")
print("   J: Siêu nhảy")
print("   U: Bật/tắt Auto Jump")
print("   H: Ẩn/hiện GUI")
print("   R: Reset về mặc định")
print("=" .. string.rep("=", 50))

-- Xử lý respawn
char.Died:Connect(function()
    task.wait(3)
    if char and char.Parent then
        hum = char:WaitForChild("Humanoid")
        updateUI()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = newChar:WaitForChild("Humanoid")
    task.wait(0.5)
    updateUI()
end)
