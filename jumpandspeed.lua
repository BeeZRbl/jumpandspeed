-- Tạo LocalScript mới với code test này:
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character
local hum = char.Humanoid

local speed = 16

-- Tạo nút đơn giản
local gui = Instance.new("ScreenGui", player.PlayerGui)
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 100, 0, 50)
btn.Text = "Tăng tốc độ"
btn.Position = UDim2.new(0, 50, 0, 50)

btn.MouseButton1Click:Connect(function()
    speed = speed + 5
    hum.WalkSpeed = speed
    print("Tốc độ mới:", speed)
    btn.Text = "Tốc độ: " .. speed
end)

print("✅ Test script loaded")
