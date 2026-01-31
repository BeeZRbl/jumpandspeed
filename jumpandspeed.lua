-- NameHub LocalScript - Chạy trên Client (Local Player)
-- Tác giả: Local Game Developer
-- Ngày: 2024

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Biến lưu trữ local
local savedSettings = {
    JumpPower = 50,
    WalkSpeed = 16,
    Gravity = 196.2,
    AutoJump = false,
    JumpCooldown = 0.3,
    Theme = "Dark"
}

-- Hàm tải cài đặt từ DataStore
local function loadSettings()
    local success, data = pcall(function()
        return player:GetAttribute("NameHubSettings") or savedSettings
    end)
    
    if success and data then
        for key, value in pairs(data) do
            savedSettings[key] = value
        end
    end
end

-- Hàm lưu cài đặt
local function saveSettings()
    player:SetAttribute("NameHubSettings", savedSettings)
end

-- Hàm ẩn tên
local function hideName(name)
    if string.len(name) <= 3 then
        return name
    end
    
    local visibleLength = math.floor(string.len(name) * 0.6)
    local hiddenPart = string.rep("*", string.len(name) - visibleLength)
    local firstPart = string.sub(name, 1, visibleLength)
    
    return firstPart .. hiddenPart
end

-- Tạo GUI
local playerGui = player:WaitForChild("PlayerGui")

local NameHub = Instance.new("ScreenGui")
NameHub.Name = "NameHubUI"
NameHub.Parent = playerGui
NameHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = NameHub
MainFrame.Size = UDim2.new(0.25, 0, 0.35, 0)
MainFrame.Position = UDim2.new(0.72, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Corner
local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0.08, 0)

-- Stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(0, 255, 157)
UIStroke.Thickness = 2

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0.12, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TopBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚀 NAME HUB LOCAL"
Title.TextColor3 = Color3.fromRGB(0, 255, 157)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.Size = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Position = UDim2.new(0.88, 0, 0.1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.white
CloseButton.Font = Enum.Font.GothamBold

-- Player Info
local PlayerFrame = Instance.new("Frame")
PlayerFrame.Name = "PlayerFrame"
PlayerFrame.Parent = MainFrame
PlayerFrame.Size = UDim2.new(0.9, 0, 0.15, 0)
PlayerFrame.Position = UDim2.new(0.05, 0, 0.14, 0)
PlayerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
PlayerFrame.BorderSizePixel = 0

local UICorner2 = Instance.new("UICorner")
UICorner2.Parent = PlayerFrame
UICorner2.CornerRadius = UDim.new(0.1, 0)

local PlayerIcon = Instance.new("ImageLabel")
PlayerIcon.Name = "PlayerIcon"
PlayerIcon.Parent = PlayerFrame
PlayerIcon.Size = UDim2.new(0.2, 0, 0.7, 0)
PlayerIcon.Position = UDim2.new(0.03, 0, 0.15, 0)
PlayerIcon.BackgroundTransparency = 1
PlayerIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"

local PlayerName = Instance.new("TextLabel")
PlayerName.Name = "PlayerName"
PlayerName.Parent = PlayerFrame
PlayerName.Size = UDim2.new(0.7, 0, 0.5, 0)
PlayerName.Position = UDim2.new(0.25, 0, 0.25, 0)
PlayerName.BackgroundTransparency = 1
PlayerName.Text = "Player: " .. hideName(player.Name)
PlayerName.TextColor3 = Color3.fromRGB(200, 200, 255)
PlayerName.TextScaled = true
PlayerName.Font = Enum.Font.GothamMedium
PlayerName.TextXAlignment = Enum.TextXAlignment.Left

-- Controls Container
local ControlsContainer = Instance.new("Frame")
ControlsContainer.Name = "ControlsContainer"
ControlsContainer.Parent = MainFrame
ControlsContainer.Size = UDim2.new(0.9, 0, 0.6, 0)
ControlsContainer.Position = UDim2.new(0.05, 0, 0.32, 0)
ControlsContainer.BackgroundTransparency = 1

-- Jump Power Control
local JumpPowerFrame = Instance.new("Frame")
JumpPowerFrame.Name = "JumpPowerFrame"
JumpPowerFrame.Parent = ControlsContainer
JumpPowerFrame.Size = UDim2.new(1, 0, 0.2, 0)
JumpPowerFrame.BackgroundTransparency = 1

local JumpPowerLabel = Instance.new("TextLabel")
JumpPowerLabel.Name = "JumpPowerLabel"
JumpPowerLabel.Parent = JumpPowerFrame
JumpPowerLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
JumpPowerLabel.Position = UDim2.new(0, 0, 0, 0)
JumpPowerLabel.BackgroundTransparency = 1
JumpPowerLabel.Text = "⬆️ Độ Cao Nhảy: 50"
JumpPowerLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
JumpPowerLabel.TextScaled = true
JumpPowerLabel.Font = Enum.Font.GothamMedium
JumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left

local JumpPowerSlider = Instance.new("Frame")
JumpPowerSlider.Name = "JumpPowerSlider"
JumpPowerSlider.Parent = JumpPowerFrame
JumpPowerSlider.Size = UDim2.new(1, 0, 0.35, 0)
JumpPowerSlider.Position = UDim2.new(0, 0, 0.6, 0)
JumpPowerSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
JumpPowerSlider.BorderSizePixel = 0

local JumpPowerFill = Instance.new("Frame")
JumpPowerFill.Name = "JumpPowerFill"
JumpPowerFill.Parent = JumpPowerSlider
JumpPowerFill.Size = UDim2.new(0.5, 0, 1, 0)
JumpPowerFill.BackgroundColor3 = Color3.fromRGB(0, 255, 157)
JumpPowerFill.BorderSizePixel = 0

local UICorner3 = Instance.new("UICorner")
UICorner3.Parent = JumpPowerSlider
UICorner3.CornerRadius = UDim.new(0.2, 0)

local UICorner4 = Instance.new("UICorner")
UICorner4.Parent = JumpPowerFill
UICorner4.CornerRadius = UDim.new(0.2, 0)

-- Walk Speed Control
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Parent = ControlsContainer
WalkSpeedFrame.Size = UDim2.new(1, 0, 0.2, 0)
WalkSpeedFrame.Position = UDim2.new(0, 0, 0.25, 0)
WalkSpeedFrame.BackgroundTransparency = 1

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Name = "WalkSpeedLabel"
WalkSpeedLabel.Parent = WalkSpeedFrame
WalkSpeedLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
WalkSpeedLabel.Position = UDim2.new(0, 0, 0, 0)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "🏃 Tốc Độ Chạy: 16"
WalkSpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
WalkSpeedLabel.TextScaled = true
WalkSpeedLabel.Font = Enum.Font.GothamMedium
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local WalkSpeedSlider = Instance.new("Frame")
WalkSpeedSlider.Name = "WalkSpeedSlider"
WalkSpeedSlider.Parent = WalkSpeedFrame
WalkSpeedSlider.Size = UDim2.new(1, 0, 0.35, 0)
WalkSpeedSlider.Position = UDim2.new(0, 0, 0.6, 0)
WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
WalkSpeedSlider.BorderSizePixel = 0

local WalkSpeedFill = Instance.new("Frame")
WalkSpeedFill.Name = "WalkSpeedFill"
WalkSpeedFill.Parent = WalkSpeedSlider
WalkSpeedFill.Size = UDim2.new(0.5, 0, 1, 0)
WalkSpeedFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
WalkSpeedFill.BorderSizePixel = 0

local UICorner5 = Instance.new("UICorner")
UICorner5.Parent = WalkSpeedSlider

local UICorner6 = Instance.new("UICorner")
UICorner6.Parent = WalkSpeedFill

-- Jump Button
local JumpButton = Instance.new("TextButton")
JumpButton.Name = "JumpButton"
JumpButton.Parent = ControlsContainer
JumpButton.Size = UDim2.new(1, 0, 0.15, 0)
JumpButton.Position = UDim2.new(0, 0, 0.55, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 157)
JumpButton.Text = "🚀 NHẢY CAO!"
JumpButton.TextColor3 = Color3.fromRGB(20, 20, 30)
JumpButton.Font = Enum.Font.GothamBold
JumpButton.TextScaled = true

local UICorner7 = Instance.new("UICorner")
UICorner7.Parent = JumpButton
UICorner7.CornerRadius = UDim.new(0.1, 0)

-- Auto Jump Toggle
local AutoJumpFrame = Instance.new("Frame")
AutoJumpFrame.Name = "AutoJumpFrame"
AutoJumpFrame.Parent = ControlsContainer
AutoJumpFrame.Size = UDim2.new(1, 0, 0.15, 0)
AutoJumpFrame.Position = UDim2.new(0, 0, 0.75, 0)
AutoJumpFrame.BackgroundTransparency = 1

local AutoJumpButton = Instance.new("TextButton")
AutoJumpButton.Name = "AutoJumpButton"
AutoJumpButton.Parent = AutoJumpFrame
AutoJumpButton.Size = UDim2.new(0.5, 0, 0.8, 0)
AutoJumpButton.Position = UDim2.new(0.25, 0, 0.1, 0)
AutoJumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
AutoJumpButton.Text = "🤖 AUTO JUMP: OFF"
AutoJumpButton.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoJumpButton.Font = Enum.Font.GothamMedium
AutoJumpButton.TextScaled = true

local UICorner8 = Instance.new("UICorner")
UICorner8.Parent = AutoJumpButton
UICorner8.CornerRadius = UDim.new(0.1, 0)

-- Status Display
local StatusFrame = Instance.new("Frame")
StatusFrame.Name = "StatusFrame"
StatusFrame.Parent = MainFrame
StatusFrame.Size = UDim2.new(0.9, 0, 0.1, 0)
StatusFrame.Position = UDim2.new(0.05, 0, 0.9, 0)
StatusFrame.BackgroundTransparency = 1

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Parent = StatusFrame
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🟢 SẴN SÀNG - LOCAL MODE"
StatusText.TextColor3 = Color3.fromRGB(0, 255, 157)
StatusText.TextScaled = true
StatusText.Font = Enum.Font.GothamMedium

-- Cập nhật thanh trượt
local function updateSliders()
    JumpPowerFill:TweenSize(
        UDim2.new(savedSettings.JumpPower / 100, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2,
        true
    )
    JumpPowerLabel.Text = "⬆️ Độ Cao Nhảy: " .. math.floor(savedSettings.JumpPower)
    
    WalkSpeedFill:TweenSize(
        UDim2.new(savedSettings.WalkSpeed / 50, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2,
        true
    )
    WalkSpeedLabel.Text = "🏃 Tốc Độ Chạy: " .. math.floor(savedSettings.WalkSpeed)
    
    humanoid.JumpPower = savedSettings.JumpPower
    humanoid.WalkSpeed = savedSettings.WalkSpeed
end

-- Xử lý nhảy cao
local lastJumpTime = 0
local function superJump()
    local currentTime = tick()
    
    if currentTime - lastJumpTime < savedSettings.JumpCooldown then
        StatusText.Text = "⏳ Đang hồi chiêu..."
        task.wait(0.3)
        StatusText.Text = "🟢 SẴN SÀNG - LOCAL MODE"
        return
    end
    
    lastJumpTime = currentTime
    
    -- Hiệu ứng nhảy
    JumpButton.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
    StatusText.Text = "🚀 ĐANG NHẢY..."
    
    -- Áp dụng lực nhảy
    if humanoid.FloorMaterial ~= Enum.Material.Air then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        
        -- Tăng lực nhảy
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, savedSettings.JumpPower * 2, 0)
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        bodyVelocity.Parent = character.HumanoidRootPart
        
        game.Debris:AddItem(bodyVelocity, 0.2)
    end
    
    -- Hiệu ứng âm thanh
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9116998330" -- ID âm thanh nhảy
    sound.Volume = 0.5
    sound.Parent = character.HumanoidRootPart
    sound:Play()
    game.Debris:AddItem(sound, 2)
    
    task.wait(0.3)
    JumpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 157)
    StatusText.Text = "🟢 SẴN SÀNG - LOCAL MODE"
end

-- Xử lý Auto Jump
local autoJumpConnection
local function toggleAutoJump()
    savedSettings.AutoJump = not savedSettings.AutoJump
    
    if savedSettings.AutoJump then
        AutoJumpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        AutoJumpButton.Text = "🤖 AUTO JUMP: ON"
        StatusText.Text = "🤖 ĐÃ BẬT AUTO JUMP"
        
        -- Bật auto jump
        autoJumpConnection = RunService.Heartbeat:Connect(function()
            if humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, savedSettings.JumpPower * 1.5, 0)
                bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVelocity.Parent = character.HumanoidRootPart
                
                game.Debris:AddItem(bodyVelocity, 0.15)
            end
        end)
    else
        AutoJumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        AutoJumpButton.Text = "🤖 AUTO JUMP: OFF"
        StatusText.Text = "🟢 ĐÃ TẮT AUTO JUMP"
        
        -- Tắt auto jump
        if autoJumpConnection then
            autoJumpConnection:Disconnect()
            autoJumpConnection = nil
        end
    end
    
    saveSettings()
end

-- Kéo thanh trượt
local dragging = false
local function setupSlider(sliderFrame, fillFrame, label, min, max, settingKey)
    local isDragging = false
    
    local function updateFromMouse()
        if not isDragging then return end
        
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local absolutePosition = sliderFrame.AbsolutePosition.X
        local absoluteSize = sliderFrame.AbsoluteSize.X
        
        local relativeX = math.clamp(mouse.X - absolutePosition, 0, absoluteSize)
        local percentage = relativeX / absoluteSize
        
        savedSettings[settingKey] = math.floor(min + (max - min) * percentage)
        updateSliders()
        saveSettings()
    end
    
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            updateFromMouse()
        end
    end)
    
    sliderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
            updateFromMouse()
        end
    end)
end

-- Kết nối sự kiện
CloseButton.MouseButton1Click:Connect(function()
    NameHub.Enabled = not NameHub.Enabled
    CloseButton.Text = NameHub.Enabled and "✕" or "☰"
end)

JumpButton.MouseButton1Click:Connect(superJump)
AutoJumpButton.MouseButton1Click:Connect(toggleAutoJump)

-- Thiết lập thanh trượt
setupSlider(JumpPowerSlider, JumpPowerFill, JumpPowerLabel, 20, 100, "JumpPower")
setupSlider(WalkSpeedSlider, WalkSpeedFill, WalkSpeedLabel, 16, 100, "WalkSpeed")

-- Phím tắt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.J then
        superJump()
    elseif input.KeyCode == Enum.KeyCode.H then
        NameHub.Enabled = not NameHub.Enabled
        CloseButton.Text = NameHub.Enabled and "✕" or "☰"
    elseif input.KeyCode == Enum.KeyCode.U then
        toggleAutoJump()
    elseif input.KeyCode == Enum.KeyCode.LeftBracket then
        savedSettings.JumpPower = math.max(20, savedSettings.JumpPower - 5)
        updateSliders()
        saveSettings()
    elseif input.KeyCode == Enum.KeyCode.RightBracket then
        savedSettings.JumpPower = math.min(100, savedSettings.JumpPower + 5)
        updateSliders()
        saveSettings()
    end
end)

-- Tải cài đặt
loadSettings()
updateSliders()

-- Hiển thị thông báo khởi động
StatusText.Text = "⚡ NAME HUB LOCAL ĐÃ KHỞI ĐỘNG!"
task.wait(2)
StatusText.Text = "🟢 SẴN SÀNG - LOCAL MODE"

print("✅ NameHub LocalScript đã tải thành công!")
print("📋 Phím tắt:")
print("   • J: Nhảy cao")
print("   • H: Ẩn/hiện GUI")
print("   • U: Bật/tắt Auto Jump")
print("   • [: Giảm độ cao nhảy")
print("   • ]: Tăng độ cao nhảy")

-- Đảm bảo GUI không bị mất khi respawn
character.Died:Connect(function()
    task.wait(5)
    if character and character.Parent then
        humanoid = character:WaitForChild("Humanoid")
        updateSliders()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    task.wait(1)
    updateSliders()
end)
