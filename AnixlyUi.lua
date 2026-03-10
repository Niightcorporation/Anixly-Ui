-- Anixly UI Framework - Complete Edition
local AnixlyUI = {}
local IsMobile = game:GetService("UserInputService").TouchEnabled

-- ===== NOTIFICATION SYSTEM =====
function AnixlyUI:ShowNotification(config)
    config = config or {}
    local message = config.Message or "Notification"
    local duration = config.Duration or 3
    local theme = config.Theme or "info"
    local title = config.Title or "INFO"
    
    local colors = {
        info = {bg = Color3.fromRGB(0, 150, 255), icon = "ℹ"},
        success = {bg = Color3.fromRGB(0, 255, 100), icon = "✓"},
        error = {bg = Color3.fromRGB(255, 50, 50), icon = "✗"},
        warning = {bg = Color3.fromRGB(255, 200, 0), icon = "⚠"}
    }
    
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "Notification"
    notifGui.Parent = game:GetService("CoreGui")
    notifGui.IgnoreGuiInset = true
    notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 70)
    frame.Position = UDim2.new(1, -340, 1, -90)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = notifGui
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 16)
    frameCorner.Parent = frame
    
    -- Left accent bar
    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 6, 1, 0)
    accentBar.BackgroundColor3 = colors[theme].bg
    accentBar.BorderSizePixel = 0
    accentBar.Parent = frame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 3)
    barCorner.Parent = accentBar
    
    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 16, 0.5, -15)
    icon.BackgroundColor3 = colors[theme].bg
    icon.BackgroundTransparency = 0.3
    icon.Text = colors[theme].icon
    icon.TextColor3 = Color3.new(1, 1, 1)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 20
    icon.Parent = frame
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = icon
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -70, 0, 20)
    titleLabel.Position = UDim2.new(0, 55, 0, 12)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = colors[theme].bg
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    -- Message
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -70, 0, 30)
    msgLabel.Position = UDim2.new(0, 55, 0, 30)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = message
    msgLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextSize = 13
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextYAlignment = Enum.TextYAlignment.Top
    msgLabel.Parent = frame
    
    -- Close button
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -28, 0, 10)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Image = "rbxassetid://6023426923"
    closeBtn.ImageColor3 = Color3.fromRGB(150, 150, 150)
    closeBtn.Parent = frame
    
    closeBtn.MouseButton1Click:Connect(function()
        frame:TweenPosition(UDim2.new(1, 20, 1, -90), "Out", "Quad", 0.3)
        task.wait(0.3)
        notifGui:Destroy()
    end)
    
    -- Hover effect
    frame.MouseEnter:Connect(function()
        frame:TweenSize(UDim2.new(0, 330, 0, 75), "Out", "Quad", 0.2)
    end)
    
    frame.MouseLeave:Connect(function()
        frame:TweenSize(UDim2.new(0, 320, 0, 70), "Out", "Quad", 0.2)
    end)
    
    -- Animasi masuk
    frame.Position = UDim2.new(1, 20, 1, -90)
    frame:TweenPosition(UDim2.new(1, -340, 1, -90), "Out", "Quad", 0.3)
    
    -- Auto close
    if duration > 0 then
        task.wait(duration)
        if notifGui and notifGui.Parent then
            frame:TweenPosition(UDim2.new(1, 20, 1, -90), "Out", "Quad", 0.3)
            task.wait(0.3)
            notifGui:Destroy()
        end
    end
end

-- ===== KEY SYSTEM =====
function AnixlyUI:ShowKeySystem(config)
    config = config or {}
    local correctKey = config.Key or "admin123"
    local title = config.Title or "🔐 KEY SYSTEM"
    local subtitle = config.Subtitle or "Masukkan key untuk melanjutkan"
    local callback = config.Callback or function() end
    
    local popupGui = Instance.new("ScreenGui")
    popupGui.Name = "KeySystem"
    popupGui.Parent = game:GetService("CoreGui")
    popupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    popupGui.Enabled = true
    popupGui.IgnoreGuiInset = true
    
    -- Particle background
    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.BorderSizePixel = 0
    particleContainer.Parent = popupGui
    
    local particles = {}
    for i = 1, 30 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        local colorChoice = math.random(1, 3)
        if colorChoice == 1 then
            particle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        elseif colorChoice == 2 then
            particle.BackgroundColor3 = Color3.fromRGB(180, 180, 255)
        else
            particle.BackgroundColor3 = Color3.fromRGB(220, 180, 255)
        end
        particle.BackgroundTransparency = math.random(2, 7)/10
        particle.BorderSizePixel = 0
        particle.Parent = particleContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        table.insert(particles, {
            frame = particle,
            speedX = (math.random() - 0.5) * 0.08,
            speedY = (math.random() - 0.5) * 0.08,
            pos = {X = particle.Position.X.Scale, Y = particle.Position.Y.Scale}
        })
    end
    
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, p in ipairs(particles) do
            p.pos.X = p.pos.X + p.speedX * 0.01
            p.pos.Y = p.pos.Y + p.speedY * 0.01
            if p.pos.X > 1 then p.pos.X = 0 end
            if p.pos.X < 0 then p.pos.X = 1 end
            if p.pos.Y > 1 then p.pos.Y = 0 end
            if p.pos.Y < 0 then p.pos.Y = 1 end
            p.frame.Position = UDim2.new(p.pos.X, 0, p.pos.Y, 0)
        end
    end)
    
    -- Main Popup
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 320)
    frame.Position = UDim2.new(0.5, -200, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = popupGui
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 24)
    frameCorner.Parent = frame
    
    -- Gradient overlay
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 255))
    })
    gradient.Transparency = NumberSequence.new(0.95)
    gradient.Rotation = 45
    gradient.Parent = frame
    
    -- Border glow
    local borderGlow = Instance.new("Frame")
    borderGlow.Size = UDim2.new(1, 4, 1, 4)
    borderGlow.Position = UDim2.new(0, -2, 0, -2)
    borderGlow.BackgroundTransparency = 0.8
    borderGlow.BorderSizePixel = 0
    borderGlow.Parent = frame
    borderGlow.ZIndex = -1
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 26)
    borderCorner.Parent = borderGlow
    
    local hue = 0
    game:GetService("RunService").Heartbeat:Connect(function()
        hue = (hue + 0.002) % 1
        borderGlow.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
    end)
    
    -- Title
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 70)
    titleFrame.Position = UDim2.new(0, 0, 0, 10)
    titleFrame.BackgroundTransparency = 1
    titleFrame.Parent = frame
    
    local titleIcon = Instance.new("TextLabel")
    titleIcon.Size = UDim2.new(0, 40, 0, 40)
    titleIcon.Position = UDim2.new(0.5, -20, 0, 15)
    titleIcon.BackgroundTransparency = 1
    titleIcon.Text = "🔐"
    titleIcon.TextColor3 = Color3.new(1, 1, 1)
    titleIcon.Font = Enum.Font.GothamBold
    titleIcon.TextSize = 32
    titleIcon.Parent = titleFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 55)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 22
    titleLabel.Parent = titleFrame
    
    local titleHue = 0
    game:GetService("RunService").Heartbeat:Connect(function()
        titleHue = (titleHue + 0.003) % 1
        titleLabel.TextColor3 = Color3.fromHSV(titleHue, 0.8, 1)
    end)
    
    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(1, -40, 0, 40)
    subtitleLabel.Position = UDim2.new(0, 20, 0, 85)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = subtitle
    subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextSize = 14
    subtitleLabel.TextWrapped = true
    subtitleLabel.Parent = frame
    
    -- Input
    local inputContainer = Instance.new("Frame")
    inputContainer.Size = UDim2.new(1, -40, 0, 70)
    inputContainer.Position = UDim2.new(0, 20, 0, 135)
    inputContainer.BackgroundTransparency = 1
    inputContainer.Parent = frame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 50)
    textBox.Position = UDim2.new(0, 0, 0, 10)
    textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    textBox.BackgroundTransparency = 0.3
    textBox.PlaceholderText = "••••••••"
    textBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 180)
    textBox.Text = ""
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 18
    textBox.ClearTextOnFocus = false
    textBox.Parent = inputContainer
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 16)
    boxCorner.Parent = textBox
    
    local inputIcon = Instance.new("TextLabel")
    inputIcon.Size = UDim2.new(0, 30, 1, 0)
    inputIcon.Position = UDim2.new(0, 10, 0, 0)
    inputIcon.BackgroundTransparency = 1
    inputIcon.Text = "🔑"
    inputIcon.TextColor3 = Color3.fromRGB(200, 200, 255)
    inputIcon.Font = Enum.Font.GothamBold
    inputIcon.TextSize = 20
    inputIcon.Parent = textBox
    
    local boxPadding = Instance.new("UIPadding")
    boxPadding.PaddingLeft = UDim.new(0, 45)
    boxPadding.Parent = textBox
    
    -- Button
    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(1, -40, 0, 60)
    btnContainer.Position = UDim2.new(0, 20, 0, 215)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = frame
    
    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(1, 0, 0, 50)
    submitBtn.Position = UDim2.new(0, 0, 0, 5)
    submitBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 200)
    submitBtn.Text = "VERIFY KEY"
    submitBtn.TextColor3 = Color3.new(1, 1, 1)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 16
    submitBtn.AutoButtonColor = false
    submitBtn.Parent = btnContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 16)
    btnCorner.Parent = submitBtn
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 40, 200))
    })
    btnGradient.Parent = submitBtn
    
    -- Error message
    local errorMsg = Instance.new("TextLabel")
    errorMsg.Size = UDim2.new(1, -40, 0, 25)
    errorMsg.Position = UDim2.new(0, 20, 1, -35)
    errorMsg.BackgroundTransparency = 1
    errorMsg.Text = ""
    errorMsg.TextColor3 = Color3.fromRGB(255, 80, 80)
    errorMsg.Font = Enum.Font.GothamBold
    errorMsg.TextSize = 12
    errorMsg.Parent = frame
    
    -- Close button
    local closePopup = Instance.new("ImageButton")
    closePopup.Size = UDim2.new(0, 32, 0, 32)
    closePopup.Position = UDim2.new(1, -42, 0, 12)
    closePopup.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    closePopup.BackgroundTransparency = 0.2
    closePopup.Image = "rbxassetid://6023426923"
    closePopup.ImageColor3 = Color3.new(1, 1, 1)
    closePopup.Parent = frame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closePopup
    
    local function checkKey()
        if textBox.Text == correctKey then
            errorMsg.Text = "✓ ACCESS GRANTED!"
            errorMsg.TextColor3 = Color3.fromRGB(0, 255, 100)
            frame:TweenSize(UDim2.new(0, 420, 0, 340), "Out", "Back", 0.3, true)
            wait(0.5)
            popupGui:Destroy()
            callback(true)
            AnixlyUI:ShowNotification({
                Message = "Welcome! Key verified successfully",
                Theme = "success",
                Title = "SUCCESS",
                Duration = 3
            })
        else
            errorMsg.Text = "✗ Invalid key! Please try again."
            errorMsg.TextColor3 = Color3.fromRGB(255, 80, 80)
            local originalPos = frame.Position
            for i = 1, 5 do
                frame:TweenPosition(UDim2.new(0.5, -200 + math.random(-8, 8), 0.5, -160 + math.random(-4, 4)), "Out", "Quad", 0.02, true)
                wait(0.02)
            end
            frame:TweenPosition(originalPos, "Out", "Quad", 0.1, true)
            textBox.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            wait(0.1)
            textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            textBox.Text = ""
        end
    end
    
    submitBtn.MouseButton1Click:Connect(checkKey)
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then checkKey() end
    end)
    
    closePopup.MouseButton1Click:Connect(function()
        popupGui:Destroy()
        callback(false)
    end)
    
    -- Fade in
    frame.BackgroundTransparency = 1
    for i = 0, 1, 0.1 do
        frame.BackgroundTransparency = 1 - i * 0.85
        wait(0.02)
    end
    frame.BackgroundTransparency = 0.15
end

-- ===== THEMES =====
local THEMES = {
    TOKYO_NIGHT = {
        name = "Tokyo Night",
        primary = Color3.fromRGB(0, 255, 255),
        mid = Color3.fromRGB(255, 0, 255),
        dark = Color3.fromRGB(10, 10, 30),
        headerBg = Color3.fromRGB(20, 20, 50),
        accent = Color3.fromRGB(255, 255, 0),
        glow = Color3.fromRGB(255, 105, 180),
        activeTab = Color3.fromRGB(138, 43, 226),
        logText = Color3.fromRGB(200, 200, 255)
    },
    DRACULA = {
        name = "Dracula",
        primary = Color3.fromRGB(189, 147, 249),
        mid = Color3.fromRGB(98, 114, 164),
        dark = Color3.fromRGB(40, 42, 54),
        headerBg = Color3.fromRGB(68, 71, 90),
        accent = Color3.fromRGB(255, 184, 108),
        glow = Color3.fromRGB(255, 121, 198),
        activeTab = Color3.fromRGB(80, 250, 123),
        logText = Color3.fromRGB(241, 250, 140)
    },
    BLOOD = {
        name = "Blood Moon",
        primary = Color3.fromRGB(139, 0, 0),
        mid = Color3.fromRGB(178, 34, 34),
        dark = Color3.fromRGB(80, 0, 0),
        headerBg = Color3.fromRGB(120, 0, 0),
        accent = Color3.fromRGB(255, 215, 0),
        glow = Color3.fromRGB(220, 20, 60),
        activeTab = Color3.fromRGB(255, 69, 0),
        logText = Color3.fromRGB(255, 160, 122)
    },
    FOREST = {
        name = "Forest",
        primary = Color3.fromRGB(34, 139, 34),
        mid = Color3.fromRGB(0, 100, 0),
        dark = Color3.fromRGB(0, 50, 0),
        headerBg = Color3.fromRGB(1, 68, 33),
        accent = Color3.fromRGB(255, 215, 0),
        glow = Color3.fromRGB(50, 205, 50),
        activeTab = Color3.fromRGB(60, 179, 113),
        logText = Color3.fromRGB(144, 238, 144)
    },
    LAVENDER = {
        name = "Lavender",
        primary = Color3.fromRGB(230, 230, 250),
        mid = Color3.fromRGB(216, 191, 216),
        dark = Color3.fromRGB(147, 112, 219),
        headerBg = Color3.fromRGB(138, 43, 226),
        accent = Color3.fromRGB(255, 105, 180),
        glow = Color3.fromRGB(221, 160, 221),
        activeTab = Color3.fromRGB(186, 85, 211),
        logText = Color3.fromRGB(255, 240, 245)
    }
}

-- ===== CUSTOM THEME BUILDER =====
function AnixlyUI:CreateTheme(name, colors)
    if not name or not colors then
        AnixlyUI:ShowNotification({
            Message = "Theme name and colors required!",
            Theme = "error",
            Duration = 3
        })
        return
    end
    
    THEMES[name] = colors
    AnixlyUI:ShowNotification({
        Message = "Theme '" .. name .. "' created successfully!",
        Theme = "success",
        Duration = 2
    })
    return THEMES[name]
end

function AnixlyUI:GetThemes()
    local themeList = {}
    for name, _ in pairs(THEMES) do
        table.insert(themeList, name)
    end
    return themeList
end

-- ===== SAVE/LOAD SYSTEM =====
local ConfigStore = {}

function AnixlyUI:SaveConfig(name, data)
    if not name or not data then
        AnixlyUI:ShowNotification({
            Message = "Config name and data required!",
            Theme = "error",
            Duration = 3
        })
        return false
    end
    
    -- Bersihin nama file dari karakter aneh
    local safeName = name:gsub("[^%w_%-]", "_")
    
    -- Simpan ke store
    ConfigStore[safeName] = data
    
    -- Simpan ke file (untuk persistent storage)
    local success, err = pcall(function()
        writefile("AnixlyConfig_" .. safeName .. ".json", game:GetService("HttpService"):JSONEncode(data))
    end)
    
    if success then
        AnixlyUI:ShowNotification({
            Message = "Config '" .. name .. "' saved successfully!",
            Theme = "success",
            Duration = 2
        })
        return true
    else
        AnixlyUI:ShowNotification({
            Message = "Failed to save config: " .. tostring(err),
            Theme = "error",
            Duration = 3
        })
        return false
    end
end

function AnixlyUI:LoadConfig(name)
    -- Bersihin nama file
    local safeName = name:gsub("[^%w_%-]", "_")
    
    -- Coba load dari file
    local success, data = pcall(function()
        local content = readfile("AnixlyConfig_" .. safeName .. ".json")
        return game:GetService("HttpService"):JSONDecode(content)
    end)
    
    if success then
        ConfigStore[safeName] = data
        AnixlyUI:ShowNotification({
            Message = "Config '" .. name .. "' loaded successfully!",
            Theme = "success",
            Duration = 2
        })
        return data
    else
        -- Fallback ke store
        if ConfigStore[safeName] then
            return ConfigStore[safeName]
        end
        
        AnixlyUI:ShowNotification({
            Message = "Config '" .. name .. "' not found!",
            Theme = "error",
            Duration = 3
        })
        return nil
    end
end

function AnixlyUI:DeleteConfig(name)
    local safeName = name:gsub("[^%w_%-]", "_")
    
    -- Hapus dari store
    ConfigStore[safeName] = nil
    
    -- Hapus dari file
    local success, err = pcall(function()
        delfile("AnixlyConfig_" .. safeName .. ".json")
    end)
    
    if success then
        AnixlyUI:ShowNotification({
            Message = "Config '" .. name .. "' deleted!",
            Theme = "warning",
            Duration = 2
        })
        return true
    else
        AnixlyUI:ShowNotification({
            Message = "Failed to delete config: " .. tostring(err),
            Theme = "error",
            Duration = 3
        })
        return false
    end
end

function AnixlyUI:GetSavedConfigs()
    local configs = {}
    
    -- Scan files
    local success, files = pcall(function()
        return listfiles()
    end)
    
    if success then
        for _, file in ipairs(files) do
            if file:match("AnixlyConfig_(.+)%.json$") then
                local name = file:match("AnixlyConfig_(.+)%.json$")
                table.insert(configs, name)
            end
        end
    end
    
    -- Tambahin dari store juga
    for name, _ in pairs(ConfigStore) do
        if not table.find(configs, name) then
            table.insert(configs, name)
        end
    end
    
    return configs
end

-- UI Sizes
local UI_WIDTH = IsMobile and 300 or 460
local UI_HEIGHT = IsMobile and 250 or 310
local SIDEBAR_WIDTH = IsMobile and 85 or 105
local HEADER_HEIGHT = IsMobile and 42 or 46
local COMPONENT_HEIGHT = IsMobile and 32 or 36
local TEXT_SIZE_NORMAL = IsMobile and 10 or 12
local MIN_WIDTH = IsMobile and 260 or 300
local MAX_WIDTH = IsMobile and 600 or 800
local MIN_HEIGHT = IsMobile and 200 or 250
local MAX_HEIGHT = IsMobile and 500 or 600

-- ===== WINDOW CLASS =====
function AnixlyUI:CreateWindow(config)
    config = config or {}
    local window = {}
    window.Title = config.Title or "Anixly UI"
    window.Theme = THEMES[config.Theme or "TOKYO_NIGHT"]
    window.Width = config.Size and config.Size.Width or UI_WIDTH
    window.Height = config.Size and config.Size.Height or UI_HEIGHT
    window.UseParticles = config.UseParticles ~= false
    window.ConfigData = {} -- Untuk menyimpan state semua komponen
    
    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AnixlyUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Glow
    local Glow = Instance.new("Frame")
    Glow.Name = "Glow"
    Glow.Size = UDim2.new(0, window.Width + 4, 0, window.Height + 4)
    Glow.Position = UDim2.new(0.5, -(window.Width/2) - 2, 0.5, -(window.Height/2) - 2)
    Glow.BackgroundColor3 = window.Theme.glow
    Glow.BackgroundTransparency = 0.6
    Glow.BorderSizePixel = 0
    Glow.Parent = ScreenGui
    
    local GlowCorner = Instance.new("UICorner")
    GlowCorner.CornerRadius = UDim.new(0, 18)
    GlowCorner.Parent = Glow
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, window.Width, 0, window.Height)
    MainFrame.Position = UDim2.new(0.5, -window.Width/2, 0.5, -window.Height/2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(7, 7, 13)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, HEADER_HEIGHT)
    Header.BackgroundColor3 = window.Theme.headerBg
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = Header
    
    -- Title dengan efek rainbow
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = window.Title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header
    
    local hue = 0
    local rainbowConnection
    rainbowConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not TitleLabel or not TitleLabel.Parent then
            rainbowConnection:Disconnect()
            return
        end
        hue = (hue + 0.005) % 1
        TitleLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end)
    
    -- Window Controls
    local controlSize = IsMobile and 18 or 26
    
    -- Minimize Button
    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Size = UDim2.new(0, controlSize, 0, controlSize)
    MinimizeBtn.Position = UDim2.new(1, -(controlSize * 2 + 10), 0.5, -controlSize / 2)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(250, 190, 0)
    MinimizeBtn.Image = "rbxassetid://6023426955"
    MinimizeBtn.ImageColor3 = Color3.fromRGB(30, 20, 0)
    MinimizeBtn.Parent = Header
    MinimizeBtn.ZIndex = 10
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(1, 0)
    MinCorner.Parent = MinimizeBtn
    
    -- Close Button
    local CloseBtn = Instance.new("ImageButton")
    CloseBtn.Size = UDim2.new(0, controlSize, 0, controlSize)
    CloseBtn.Position = UDim2.new(1, -(controlSize + 6), 0.5, -controlSize / 2)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 50, 60)
    CloseBtn.Image = "rbxassetid://6023426923"
    CloseBtn.ImageColor3 = Color3.new(1, 1, 1)
    CloseBtn.Parent = Header
    CloseBtn.ZIndex = 10
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        AnixlyUI:ShowNotification({
            Message = "Window closed",
            Theme = "info",
            Duration = 2
        })
    end)
    
    -- RESIZE HANDLE
    local ResizeHandle = Instance.new("TextButton")
    ResizeHandle.Name = "ResizeHandle"
    ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
    ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
    ResizeHandle.BackgroundColor3 = window.Theme.mid
    ResizeHandle.Text = "↘️"
    ResizeHandle.TextColor3 = Color3.new(1, 1, 1)
    ResizeHandle.Font = Enum.Font.GothamBold
    ResizeHandle.TextSize = 14
    ResizeHandle.ZIndex = 10
    ResizeHandle.Parent = MainFrame
    ResizeHandle.Visible = true
    
    local ResizeCorner = Instance.new("UICorner")
    ResizeCorner.CornerRadius = UDim.new(0, 4)
    ResizeCorner.Parent = ResizeHandle
    
    -- Resize Logic
    local isResizing = false
    local resizeStartPos, startWidth, startHeight
    
    local function clampSize(width, height)
        return math.clamp(width, MIN_WIDTH, MAX_WIDTH), math.clamp(height, MIN_HEIGHT, MAX_HEIGHT)
    end
    
    local function updateGlow()
        Glow.Size = UDim2.new(0, MainFrame.Size.X.Offset + 4, 0, MainFrame.Size.Y.Offset + 4)
        Glow.Position = UDim2.new(
            MainFrame.Position.X.Scale, MainFrame.Position.X.Offset - 2,
            MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset - 2
        )
    end
    
    ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = true
            resizeStartPos = input.Position
            startWidth = MainFrame.Size.X.Offset
            startHeight = MainFrame.Size.Y.Offset
        end
    end)
    
    -- Mini Icon
    local MiniIcon = Instance.new("TextButton")
    MiniIcon.Name = "MiniIcon"
    MiniIcon.Size = UDim2.new(0, IsMobile and 45 or 60, 0, IsMobile and 45 or 60)
    MiniIcon.Position = UDim2.new(0, 10, 0.5, -30)
    MiniIcon.BackgroundColor3 = window.Theme.headerBg
    MiniIcon.Text = "☕"
    MiniIcon.TextColor3 = Color3.new(1, 1, 1)
    MiniIcon.Font = Enum.Font.GothamBold
    MiniIcon.TextSize = IsMobile and 30 or 40
    MiniIcon.Visible = false
    MiniIcon.Parent = ScreenGui
    MiniIcon.ZIndex = 100
    
    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 14)
    MiniCorner.Parent = MiniIcon
    
    local MiniStroke = Instance.new("UIStroke")
    MiniStroke.Color = window.Theme.accent
    MiniStroke.Thickness = 2
    MiniStroke.Transparency = 0.1
    MiniStroke.Parent = MiniIcon
    
    -- Minimize Logic
    local miniDragDist = 0
    local isDraggingMini = false
    local dragStartPos, miniStartPos
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        Glow.Visible = false
        ResizeHandle.Visible = false
        MiniIcon.Visible = true
        miniDragDist = 0
    end)
    
    -- Drag Mini Icon
    MiniIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingMini = true
            miniDragDist = 0
            dragStartPos = input.Position
            miniStartPos = MiniIcon.Position
        end
    end)
    
    MiniIcon.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            isDraggingMini = false
            local dragDist = dragStartPos and (input.Position - dragStartPos).Magnitude or 999
            
            if dragDist <= 12 then
                MainFrame.Visible = true
                Glow.Visible = true
                ResizeHandle.Visible = true
                MiniIcon.Visible = false
            end
            miniDragDist = 0
        end
    end)
    
    MiniIcon.MouseButton1Click:Connect(function()
        if IsMobile then return end
        
        if miniDragDist > 10 then
            miniDragDist = 0
            return
        end
        
        MainFrame.Visible = true
        Glow.Visible = true
        ResizeHandle.Visible = true
        MiniIcon.Visible = false
        miniDragDist = 0
    end)
    
    -- Drag Header
    local DragBtn = Instance.new("TextButton")
    DragBtn.Size = UDim2.new(1, -(controlSize * 2 + 40), 1, 0)
    DragBtn.BackgroundTransparency = 1
    DragBtn.Text = ""
    DragBtn.ZIndex = 5
    DragBtn.Parent = Header
    
    local dragging = false
    local dragStart, dragStartPos
    
    DragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            dragStartPos = MainFrame.Position
        end
    end)
    
    -- Input handling
    local UIS = game:GetService("UserInputService")
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if isResizing then
                local delta = input.Position - resizeStartPos
                local newW, newH = clampSize(startWidth + delta.X, startHeight + delta.Y)
                MainFrame.Size = UDim2.new(0, newW, 0, newH)
                updateGlow()
                ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
                return
            end
            
            if dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(
                    dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X,
                    dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y
                )
                updateGlow()
                return
            end
            
            if isDraggingMini then
                local delta = input.Position - dragStartPos
                miniDragDist = delta.Magnitude
                MiniIcon.Position = UDim2.new(
                    miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X,
                    miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y
                )
            end
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            isResizing = false
        end
    end)
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, SIDEBAR_WIDTH, 1, -HEADER_HEIGHT)
    Sidebar.Position = UDim2.new(0, 0, 0, HEADER_HEIGHT)
    Sidebar.BackgroundColor3 = Color3.fromRGB(11, 11, 18)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 16)
    SidebarCorner.Parent = Sidebar
    
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Padding = UDim.new(0, IsMobile and 4 or 5)
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Parent = Sidebar
    
    -- Content Area
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -(SIDEBAR_WIDTH + 7), 1, -(HEADER_HEIGHT + 6))
    contentArea.Position = UDim2.new(0, SIDEBAR_WIDTH + 7, 0, HEADER_HEIGHT + 4)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = MainFrame
    
    -- Search Bar
    local searchFrame = Instance.new("Frame")
    searchFrame.Size = UDim2.new(1, -10, 0, 30)
    searchFrame.Position = UDim2.new(0, 5, 0, 5)
    searchFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    searchFrame.BackgroundTransparency = 0.2
    searchFrame.BorderSizePixel = 0
    searchFrame.Visible = false
    searchFrame.Parent = contentArea
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 8)
    searchCorner.Parent = searchFrame
    
    local searchIcon = Instance.new("TextLabel")
    searchIcon.Size = UDim2.new(0, 30, 1, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "🔍"
    searchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
    searchIcon.Font = Enum.Font.Gotham
    searchIcon.TextSize = 16
    searchIcon.Parent = searchFrame
    
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -35, 1, 0)
    searchBox.Position = UDim2.new(0, 30, 0, 0)
    searchBox.BackgroundTransparency = 1
    searchBox.PlaceholderText = "Cari fitur..."
    searchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.new(1, 1, 1)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 14
    searchBox.ClearTextOnFocus = false
    searchBox.Parent = searchFrame
    
    -- Tab System
    window.Tabs = {}
    window.TabButtons = {}
    
    function window:CreateTab(name, icon)
        local tab = {}
        tab.Name = name
        tab.Icon = icon
        tab.Container = Instance.new("ScrollingFrame")
        tab.Container.Size = UDim2.new(1, 0, 1, 0)
        tab.Container.Position = UDim2.new(0, 0, 0, 40)
        tab.Container.BackgroundTransparency = 1
        tab.Container.Visible = false
        tab.Container.ScrollBarThickness = IsMobile and 3 or 2
        tab.Container.ScrollBarImageColor3 = window.Theme.accent
        tab.Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tab.Container.Parent = contentArea
        
        -- Show search bar untuk tab biasa, hide untuk settings
        if name ~= "Settings" then
            searchFrame.Visible = true
            tab.Container.Position = UDim2.new(0, 0, 0, 40)
        else
            searchFrame.Visible = false
            tab.Container.Position = UDim2.new(0, 0, 0, 5)
        end
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, IsMobile and 5 or 7)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tab.Container
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 5)
        padding.PaddingRight = UDim.new(0, 5)
        padding.PaddingTop = UDim.new(0, 5)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.Parent = tab.Container
        
        -- Tab Button
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, IsMobile and 48 or 52)
        btn.LayoutOrder = #window.Tabs + 1
        btn.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
        btn.Text = ""
        btn.Parent = Sidebar
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 9)
        btnCorner.Parent = btn
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(50, 30, 90)
        btnStroke.Thickness = 1
        btnStroke.Transparency = 0.6
        btnStroke.Parent = btn
        
        -- Icon
        local iconLabel = Instance.new("ImageLabel")
        iconLabel.Size = UDim2.new(0, IsMobile and 22 or 28, 0, IsMobile and 22 or 28)
        iconLabel.Position = UDim2.new(0.5, -(IsMobile and 11 or 14), 0.25, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Image = icon
        iconLabel.ImageColor3 = Color3.fromRGB(120, 110, 150)
        iconLabel.Parent = btn
        
        -- Label
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 0, 15)
        textLabel.Position = UDim2.new(0, 0, 0.7, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = name
        textLabel.TextColor3 = Color3.fromRGB(120, 110, 150)
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = IsMobile and 9 or 10
        textLabel.Parent = btn
        
        table.insert(window.Tabs, tab)
        table.insert(window.TabButtons, {btn = btn, stroke = btnStroke, icon = iconLabel, label = textLabel, container = tab.Container})
        
        btn.MouseButton1Click:Connect(function()
            for _, t in ipairs(window.TabButtons) do
                t.container:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.1)
                task.wait(0.05)
                t.container.Visible = false
                t.btn.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
                t.stroke.Color = Color3.fromRGB(50, 30, 90)
                t.icon.ImageColor3 = Color3.fromRGB(120, 110, 150)
                t.label.TextColor3 = Color3.fromRGB(120, 110, 150)
            end
            
            tab.Container.Visible = true
            tab.Container.Size = UDim2.new(0, 0, 1, 0)
            tab.Container:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Back", 0.3)
            
            btn.BackgroundColor3 = window.Theme.activeTab
            btnStroke.Color = window.Theme.accent
            iconLabel.ImageColor3 = Color3.new(1, 1, 1)
            textLabel.TextColor3 = Color3.new(1, 1, 1)
        end)
        
        -- Search functionality
        searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = searchBox.Text:lower()
            for _, section in ipairs(tab.Sections) do
                for _, item in ipairs(section.Items) do
                    if item:IsA("TextLabel") or (item:IsA("TextButton") and item.Text) then
                        local text = item.Text:lower()
                        if searchText == "" then
                            item.Visible = section.Expanded
                        else
                            item.Visible = section.Expanded and text:find(searchText) ~= nil
                        end
                    elseif item:IsA("Frame") then
                        local found = false
                        for _, child in ipairs(item:GetChildren()) do
                            if child:IsA("TextLabel") and child.Text then
                                if child.Text:lower():find(searchText) then
                                    found = true
                                    break
                                end
                            end
                        end
                        item.Visible = section.Expanded and (found or searchText == "")
                    end
                end
            end
        end)
        
        -- Section system
        tab.Sections = {}
        tab.CurrentOrder = 1
        
        function tab:AddSection(title)
            local section = {}
            section.Title = title
            section.Container = tab.Container
            section.Order = tab.CurrentOrder
            section.Items = {}
            
            -- Section Header
            local header = Instance.new("TextButton")
            header.Size = UDim2.new(1, 0, 0, 35)
            header.LayoutOrder = tab.CurrentOrder
            header.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
            header.Text = ""
            header.AutoButtonColor = false
            header.Parent = tab.Container
            tab.CurrentOrder = tab.CurrentOrder + 1
            
            local headerCorner = Instance.new("UICorner")
            headerCorner.CornerRadius = UDim.new(0, 8)
            headerCorner.Parent = header
            
            local headerStroke = Instance.new("UIStroke")
            headerStroke.Color = window.Theme.mid
            headerStroke.Thickness = 1
            headerStroke.Transparency = 0.5
            headerStroke.Parent = header
            
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 18, 0, 18)
            icon.Position = UDim2.new(0, 10, 0.5, -9)
            icon.BackgroundTransparency = 1
            icon.Image = "rbxassetid://6023426945"
            icon.ImageColor3 = window.Theme.accent
            icon.Parent = header
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Size = UDim2.new(1, -80, 1, 0)
            titleLabel.Position = UDim2.new(0, 35, 0, 0)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = title
            titleLabel.TextColor3 = window.Theme.logText
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 13
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.Parent = header
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 0, 20)
            arrow.Position = UDim2.new(1, -25, 0.5, -10)
            arrow.BackgroundTransparency = 1
            arrow.Text = "▼"
            arrow.TextColor3 = window.Theme.accent
            arrow.Font = Enum.Font.GothamBold
            arrow.TextSize = 14
            arrow.Parent = header
            
            section.Header = header
            section.Arrow = arrow
            section.Expanded = true
            
            header.MouseButton1Click:Connect(function()
                section.Expanded = not section.Expanded
                arrow.Text = section.Expanded and "▼" or "▶"
                for _, item in ipairs(section.Items) do
                    item.Visible = section.Expanded
                end
            end)
            
            table.insert(tab.Sections, section)
            
            -- TOGGLE
            function section:AddToggle(config)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 0, COMPONENT_HEIGHT)
                frame.LayoutOrder = tab.CurrentOrder
                frame.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
                frame.BorderSizePixel = 0
                frame.Parent = tab.Container
                frame.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, frame)
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 8)
                frameCorner.Parent = frame
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -60, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Text
                label.TextColor3 = Color3.fromRGB(210, 200, 230)
                label.Font = Enum.Font.GothamBold
                label.TextSize = TEXT_SIZE_NORMAL
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = frame
                
                local toggle = Instance.new("Frame")
                toggle.Size = UDim2.new(0, 44, 0, 22)
                toggle.Position = UDim2.new(1, -50, 0.5, -11)
                toggle.BackgroundColor3 = config.Default and Color3.fromRGB(30, 180, 110) or Color3.fromRGB(180, 40, 50)
                toggle.BorderSizePixel = 0
                toggle.Parent = frame
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(1, 0)
                toggleCorner.Parent = toggle
                
                local knob = Instance.new("Frame")
                knob.Size = UDim2.new(0, 16, 0, 16)
                knob.Position = config.Default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                knob.BackgroundColor3 = Color3.new(1, 1, 1)
                knob.BorderSizePixel = 0
                knob.Parent = toggle
                
                local knobCorner = Instance.new("UICorner")
                knobCorner.CornerRadius = UDim.new(1, 0)
                knobCorner.Parent = knob
                
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 1, 0)
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Parent = frame
                
                local state = config.Default or false
                
                -- Simpan state untuk config
                local configKey = "Toggle_" .. config.Text
                window.ConfigData[configKey] = state
                
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    toggle.BackgroundColor3 = state and Color3.fromRGB(30, 180, 110) or Color3.fromRGB(180, 40, 50)
                    knob.Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                    window.ConfigData[configKey] = state
                    if config.Callback then config.Callback(state) end
                end)
            end
            
            -- BUTTON
            function section:AddButton(config)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, COMPONENT_HEIGHT)
                btn.LayoutOrder = tab.CurrentOrder
                btn.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
                btn.Text = config.Text
                btn.TextColor3 = Color3.fromRGB(200, 190, 220)
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = TEXT_SIZE_NORMAL
                btn.Parent = tab.Container
                btn.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, btn)
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 8)
                btnCorner.Parent = btn
                
                btn.MouseButton1Click:Connect(function()
                    if config.Callback then 
                        config.Callback()
                        AnixlyUI:ShowNotification({
                            Message = "Button '" .. config.Text .. "' clicked!",
                            Theme = "info",
                            Duration = 2
                        })
                    end
                end)
            end
            
            -- LABEL
            function section:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 25)
                label.LayoutOrder = tab.CurrentOrder
                label.BackgroundTransparency = 1
                label.Text = text
                label.TextColor3 = Color3.fromRGB(200, 200, 255)
                label.Font = Enum.Font.Gotham
                label.TextSize = 12
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = tab.Container
                label.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, label)
            end
            
            -- DROPDOWN
            function section:AddDropdown(config)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 0, COMPONENT_HEIGHT)
                frame.LayoutOrder = tab.CurrentOrder
                frame.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
                frame.BorderSizePixel = 0
                frame.Parent = tab.Container
                frame.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, frame)
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 8)
                frameCorner.Parent = frame
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -80, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Text
                label.TextColor3 = Color3.fromRGB(210, 200, 230)
                label.Font = Enum.Font.GothamBold
                label.TextSize = TEXT_SIZE_NORMAL
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = frame
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Size = UDim2.new(0, 70, 1, 0)
                valueLabel.Position = UDim2.new(1, -75, 0, 0)
                valueLabel.BackgroundTransparency = 1
                valueLabel.Text = config.Default or "-"
                valueLabel.TextColor3 = window.Theme.accent
                valueLabel.Font = Enum.Font.GothamBold
                valueLabel.TextSize = TEXT_SIZE_NORMAL
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
                valueLabel.Parent = frame
                
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 1, 0)
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Parent = frame
                
                local dropdownOpen = false
                local dropdownFrame = Instance.new("Frame")
                dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
                dropdownFrame.Position = UDim2.new(0, 0, 0, COMPONENT_HEIGHT + 2)
                dropdownFrame.BackgroundColor3 = Color3.fromRGB(14, 13, 22)
                dropdownFrame.ClipsDescendants = true
                dropdownFrame.BorderSizePixel = 0
                dropdownFrame.Parent = frame
                dropdownFrame.Visible = false
                dropdownFrame.ZIndex = 10
                
                local dropdownStroke = Instance.new("UIStroke")
                dropdownStroke.Color = window.Theme.mid
                dropdownStroke.Thickness = 1
                dropdownStroke.Transparency = 0.4
                dropdownStroke.Parent = dropdownFrame
                
                local itemHeight = 28
                
                -- Simpan state untuk config
                local configKey = "Dropdown_" .. config.Text
                window.ConfigData[configKey] = config.Default or "-"
                
                local function updateDropdown()
                    for _, child in pairs(dropdownFrame:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    for i, option in ipairs(config.Options) do
                        local itemBtn = Instance.new("TextButton")
                        itemBtn.Size = UDim2.new(1, -10, 0, itemHeight)
                        itemBtn.Position = UDim2.new(0, 5, 0, (i-1) * itemHeight + 2)
                        itemBtn.BackgroundColor3 = (config.Default == option) and Color3.fromRGB(80, 30, 170) or Color3.fromRGB(28, 25, 42)
                        itemBtn.Text = option
                        itemBtn.TextColor3 = (config.Default == option) and Color3.new(1, 1, 1) or Color3.fromRGB(200, 190, 220)
                        itemBtn.Font = Enum.Font.Gotham
                        itemBtn.TextSize = 12
                        itemBtn.Parent = dropdownFrame
                        itemBtn.ZIndex = 11
                        
                        local btnCorner = Instance.new("UICorner")
                        btnCorner.CornerRadius = UDim.new(0, 4)
                        btnCorner.Parent = itemBtn
                        
                        itemBtn.MouseButton1Click:Connect(function()
                            valueLabel.Text = option
                            config.Default = option
                            window.ConfigData[configKey] = option
                            dropdownOpen = false
                            dropdownFrame.Visible = false
                            dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
                            if config.Callback then config.Callback(option) end
                        end)
                    end
                end
                
                btn.MouseButton1Click:Connect(function()
                    dropdownOpen = not dropdownOpen
                    dropdownFrame.Visible = dropdownOpen
                    if dropdownOpen then
                        updateDropdown()
                        dropdownFrame.Size = UDim2.new(1, 0, 0, #config.Options * itemHeight + 5)
                    else
                        dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
                    end
                end)
            end
            
            -- SLIDER (FIXED - BISA DIGESER)
            function section:AddSlider(config)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 0, 50)
                frame.LayoutOrder = tab.CurrentOrder
                frame.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
                frame.BorderSizePixel = 0
                frame.Parent = tab.Container
                frame.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, frame)
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 8)
                frameCorner.Parent = frame
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -80, 0, 20)
                label.Position = UDim2.new(0, 10, 0, 5)
                label.BackgroundTransparency = 1
                label.Text = config.Text
                label.TextColor3 = Color3.fromRGB(210, 200, 230)
                label.Font = Enum.Font.GothamBold
                label.TextSize = TEXT_SIZE_NORMAL
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = frame
                
                local valueLabel = Instance.new("TextBox")
                valueLabel.Size = UDim2.new(0, 70, 0, 20)
                valueLabel.Position = UDim2.new(1, -75, 0, 5)
                valueLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                valueLabel.BackgroundTransparency = 0.3
                valueLabel.Text = tostring(config.Default or config.Min or 0)
                valueLabel.TextColor3 = window.Theme.accent
                valueLabel.Font = Enum.Font.GothamBold
                valueLabel.TextSize = TEXT_SIZE_NORMAL
                valueLabel.TextXAlignment = Enum.TextXAlignment.Center
                valueLabel.Parent = frame
                
                local valueCorner = Instance.new("UICorner")
                valueCorner.CornerRadius = UDim.new(0, 4)
                valueCorner.Parent = valueLabel
                
                local sliderBg = Instance.new("Frame")
                sliderBg.Size = UDim2.new(1, -20, 0, 8)
                sliderBg.Position = UDim2.new(0, 10, 0, 30)
                sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                sliderBg.BorderSizePixel = 0
                sliderBg.Parent = frame
                
                local bgCorner = Instance.new("UICorner")
                bgCorner.CornerRadius = UDim.new(1, 0)
                bgCorner.Parent = sliderBg
                
                local minVal = config.Min or 0
                local maxVal = config.Max or 100
                local defaultValue = config.Default or minVal
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Size = UDim2.new((defaultValue - minVal) / (maxVal - minVal), 0, 1, 0)
                sliderFill.BackgroundColor3 = window.Theme.accent
                sliderFill.BorderSizePixel = 0
                sliderFill.Parent = sliderBg
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(1, 0)
                fillCorner.Parent = sliderFill
                
                -- BUTTON UNTUK DRAG
                local dragButton = Instance.new("TextButton")
                dragButton.Size = UDim2.new(1, 0, 1, 0)
                dragButton.BackgroundTransparency = 1
                dragButton.Text = ""
                dragButton.Parent = sliderBg
                dragButton.ZIndex = 10
                
                local value = defaultValue
                local dragging = false
                
                local configKey = "Slider_" .. config.Text
                window.ConfigData[configKey] = value
                
                local function updateValue(newValue)
                    newValue = math.clamp(newValue, minVal, maxVal)
                    newValue = math.floor(newValue * 100) / 100
                    value = newValue
                    valueLabel.Text = tostring(value)
                    
                    local percent = (value - minVal) / (maxVal - minVal)
                    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    
                    window.ConfigData[configKey] = value
                    if config.Callback then config.Callback(value) end
                end
                
                -- DRAG FUNCTIONALITY
                local function onDrag(input)
                    local mousePos = input.Position.X
                    local sliderPos = sliderBg.AbsolutePosition.X
                    local sliderSize = sliderBg.AbsoluteSize.X
                    
                    if sliderSize <= 0 then return end
                    
                    local relativePos = (mousePos - sliderPos) / sliderSize
                    relativePos = math.clamp(relativePos, 0, 1)
                    
                    local newValue = minVal + (maxVal - minVal) * relativePos
                    updateValue(newValue)
                end
                
                -- MOUSE BUTTON DOWN
                dragButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        onDrag(input)
                    end
                end)
                
                -- MOUSE BUTTON UP
                dragButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                -- MOUSE MOVE
                game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        onDrag(input)
                    end
                end)
                
                -- TEXTBOX MANUAL INPUT
                valueLabel.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        local newValue = tonumber(valueLabel.Text)
                        if newValue then
                            updateValue(newValue)
                        else
                            valueLabel.Text = tostring(value)
                        end
                    end
                end)
                
                -- DRAG DARI FILL LANGSUNG
                sliderFill.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        onDrag(input)
                    end
                end)
            end
            
            -- KEYBIND
            function section:AddKeybind(config)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 0, COMPONENT_HEIGHT)
                frame.LayoutOrder = tab.CurrentOrder
                frame.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
                frame.BorderSizePixel = 0
                frame.Parent = tab.Container
                frame.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, frame)
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 8)
                frameCorner.Parent = frame
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -80, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Text
                label.TextColor3 = Color3.fromRGB(210, 200, 230)
                label.Font = Enum.Font.GothamBold
                label.TextSize = TEXT_SIZE_NORMAL
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = frame
                
                local keyLabel = Instance.new("TextLabel")
                keyLabel.Size = UDim2.new(0, 70, 1, 0)
                keyLabel.Position = UDim2.new(1, -75, 0, 0)
                keyLabel.BackgroundTransparency = 1
                keyLabel.Text = config.Default or "None"
                keyLabel.TextColor3 = window.Theme.accent
                keyLabel.Font = Enum.Font.GothamBold
                keyLabel.TextSize = TEXT_SIZE_NORMAL
                keyLabel.TextXAlignment = Enum.TextXAlignment.Right
                keyLabel.Parent = frame
                
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 1, 0)
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Parent = frame
                
                local listening = false
                local currentKey = config.Default or "None"
                
                local configKey = "Keybind_" .. config.Text
                window.ConfigData[configKey] = currentKey
                
                btn.MouseButton1Click:Connect(function()
                    listening = true
                    keyLabel.Text = "..."
                end)
                
                game:GetService("UserInputService").InputBegan:Connect(function(input)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                        listening = false
                        local keyName = input.KeyCode.Name
                        keyLabel.Text = keyName
                        currentKey = keyName
                        window.ConfigData[configKey] = keyName
                        if config.Callback then config.Callback(keyName) end
                    end
                end)
            end
            
            -- PROGRESS BAR
            function section:AddProgressBar(config)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 0, 40)
                frame.LayoutOrder = tab.CurrentOrder
                frame.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
                frame.BorderSizePixel = 0
                frame.Parent = tab.Container
                frame.Visible = section.Expanded
                tab.CurrentOrder = tab.CurrentOrder + 1
                
                table.insert(section.Items, frame)
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 8)
                frameCorner.Parent = frame
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -80, 0, 20)
                label.Position = UDim2.new(0, 10, 0, 5)
                label.BackgroundTransparency = 1
                label.Text = config.Text
                label.TextColor3 = Color3.fromRGB(210, 200, 230)
                label.Font = Enum.Font.GothamBold
                label.TextSize = TEXT_SIZE_NORMAL
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = frame
                
                local percentLabel = Instance.new("TextLabel")
                percentLabel.Size = UDim2.new(0, 70, 0, 20)
                percentLabel.Position = UDim2.new(1, -75, 0, 5)
                percentLabel.BackgroundTransparency = 1
                percentLabel.Text = "0%"
                percentLabel.TextColor3 = window.Theme.accent
                percentLabel.Font = Enum.Font.GothamBold
                percentLabel.TextSize = TEXT_SIZE_NORMAL
                percentLabel.TextXAlignment = Enum.TextXAlignment.Right
                percentLabel.Parent = frame
                
                local progressBg = Instance.new("Frame")
                progressBg.Size = UDim2.new(1, -20, 0, 8)
                progressBg.Position = UDim2.new(0, 10, 0, 27)
                progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                progressBg.BorderSizePixel = 0
                progressBg.Parent = frame
                
                local bgCorner = Instance.new("UICorner")
                bgCorner.CornerRadius = UDim.new(1, 0)
                bgCorner.Parent = progressBg
                
                local progressFill = Instance.new("Frame")
                progressFill.Size = UDim2.new(0, 0, 1, 0)
                progressFill.BackgroundColor3 = window.Theme.accent
                progressFill.BorderSizePixel = 0
                progressFill.Parent = progressBg
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(1, 0)
                fillCorner.Parent = progressFill
                
                return {
                    SetProgress = function(percent)
                        percent = math.clamp(percent, 0, 100)
                        progressFill.Size = UDim2.new(percent/100, 0, 1, 0)
                        percentLabel.Text = math.floor(percent) .. "%"
                        window.ConfigData[config.Text .. "_progress"] = percent
                    end
                }
            end
            
            return section
        end
        
        return tab
    end
    
    -- SAVE/LOAD METHODS
    function window:SaveConfig(name)
        local data = {
            window = {
                title = self.Title,
                theme = self.Theme.name,
                size = {width = self.Width, height = self.Height}
            },
            components = self.ConfigData
        }
        
        return AnixlyUI:SaveConfig(name, data)
    end
    
    function window:LoadConfig(name)
        local data = AnixlyUI:LoadConfig(name)
        if data and data.components then
            self.ConfigData = data.components
            AnixlyUI:ShowNotification({
                Message = "Config loaded! UI state restored.",
                Theme = "success",
                Duration = 3
            })
            return true
        end
        return false
    end
    
    -- THEME METHODS
    function window:SetTheme(themeName)
        if THEMES[themeName] then
            self.Theme = THEMES[themeName]
            
            -- Update UI elements
            Glow.BackgroundColor3 = self.Theme.glow
            Header.BackgroundColor3 = self.Theme.headerBg
            MiniStroke.Color = self.Theme.accent
            
            AnixlyUI:ShowNotification({
                Message = "Theme changed to " .. self.Theme.name,
                Theme = "info",
                Duration = 2
            })
        else
            AnixlyUI:ShowNotification({
                Message = "Theme '" .. themeName .. "' not found!",
                Theme = "error",
                Duration = 3
            })
        end
    end
    
    function window:GetCurrentTheme()
        return self.Theme
    end
    
    -- SETTINGS TAB - THEME DI ATAS SENDIRI
    local settingsTab = window:CreateTab("Settings", "rbxassetid://6023426945")
    
    -- SECTION THEME (DI ATAS)
    local themeSection = settingsTab:AddSection("Theme Settings")
    
    local themeOptions = AnixlyUI:GetThemes()
    themeSection:AddDropdown({
        Text = "Select Theme",
        Options = themeOptions,
        Default = window.Theme.name,
        Callback = function(option)
            window:SetTheme(option)
        end
    })
    
    -- SECTION CONFIGURATION (DI BAWAH)
    local configSection = settingsTab:AddSection("Configuration")
    
    -- Frame untuk save dengan nama kustom
    local saveFrame = Instance.new("Frame")
    saveFrame.Size = UDim2.new(1, 0, 0, 70)
    saveFrame.LayoutOrder = settingsTab.CurrentOrder
    saveFrame.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
    saveFrame.BorderSizePixel = 0
    saveFrame.Parent = settingsTab.Container
    settingsTab.CurrentOrder = settingsTab.CurrentOrder + 1
    
    table.insert(configSection.Items, saveFrame)
    
    local saveCorner = Instance.new("UICorner")
    saveCorner.CornerRadius = UDim.new(0, 8)
    saveCorner.Parent = saveFrame
    
    local saveLabel = Instance.new("TextLabel")
    saveLabel.Size = UDim2.new(1, -20, 0, 20)
    saveLabel.Position = UDim2.new(0, 10, 0, 5)
    saveLabel.BackgroundTransparency = 1
    saveLabel.Text = "Save Configuration"
    saveLabel.TextColor3 = Color3.fromRGB(210, 200, 230)
    saveLabel.Font = Enum.Font.GothamBold
    saveLabel.TextSize = 13
    saveLabel.TextXAlignment = Enum.TextXAlignment.Left
    saveLabel.Parent = saveFrame
    
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(0.7, -5, 0, 30)
    nameBox.Position = UDim2.new(0, 10, 0, 30)
    nameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    nameBox.PlaceholderText = "Nama config (contoh: setting_1)"
    nameBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 180)
    nameBox.Text = ""
    nameBox.TextColor3 = Color3.new(1, 1, 1)
    nameBox.Font = Enum.Font.Gotham
    nameBox.TextSize = 12
    nameBox.ClearTextOnFocus = false
    nameBox.Parent = saveFrame
    
    local nameCorner = Instance.new("UICorner")
    nameCorner.CornerRadius = UDim.new(0, 6)
    nameCorner.Parent = nameBox
    
    local saveBtn = Instance.new("TextButton")
    saveBtn.Size = UDim2.new(0.3, -5, 0, 30)
    saveBtn.Position = UDim2.new(0.7, 5, 0, 30)
    saveBtn.BackgroundColor3 = window.Theme.accent
    saveBtn.Text = "SAVE"
    saveBtn.TextColor3 = Color3.new(1, 1, 1)
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.TextSize = 12
    saveBtn.Parent = saveFrame
    
    local saveBtnCorner = Instance.new("UICorner")
    saveBtnCorner.CornerRadius = UDim.new(0, 6)
    saveBtnCorner.Parent = saveBtn
    
    saveBtn.MouseButton1Click:Connect(function()
        local configName = nameBox.Text
        if configName and configName ~= "" then
            window:SaveConfig(configName)
            nameBox.Text = ""
        else
            AnixlyUI:ShowNotification({
                Message = "Masukkan nama config terlebih dahulu!",
                Theme = "warning",
                Duration = 2
            })
        end
    end)
    
    -- Load Config dropdown
    local configs = AnixlyUI:GetSavedConfigs()
    if #configs > 0 then
        configSection:AddDropdown({
            Text = "Load Config",
            Options = configs,
            Default = configs[#configs],
            Callback = function(option)
                window:LoadConfig(option)
            end
        })
    end
    
    -- Delete Config dropdown
    if #configs > 0 then
        configSection:AddDropdown({
            Text = "Delete Config",
            Options = configs,
            Default = configs[1],
            Callback = function(option)
                AnixlyUI:DeleteConfig(option)
            end
        })
    end
    
    -- Quick save
    configSection:AddButton({
        Text = "Quick Save (Auto Name)",
        Callback = function()
            local name = "Config_" .. os.date("%Y%m%d_%H%M%S")
            window:SaveConfig(name)
        end
    })
    
    configSection:AddButton({
        Text = "Load Last Config",
        Callback = function()
            local configs = AnixlyUI:GetSavedConfigs()
            if #configs > 0 then
                window:LoadConfig(configs[#configs])
            else
                AnixlyUI:ShowNotification({
                    Message = "No saved configs found!",
                    Theme = "warning",
                    Duration = 3
                })
            end
        end
    })
    
    configSection:AddLabel("Version 2.0 - Complete Edition")
    
    -- Show first tab
    if #window.Tabs > 0 then
        window.Tabs[1].Container.Visible = true
        local btn = window.TabButtons[1]
        btn.btn.BackgroundColor3 = window.Theme.activeTab
        btn.stroke.Color = window.Theme.accent
        btn.icon.ImageColor3 = Color3.new(1, 1, 1)
        btn.label.TextColor3 = Color3.new(1, 1, 1)
    end
    
    return window
end

return AnixlyUI