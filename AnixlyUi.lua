-- Anixly UI Framework - Reusable UI Library with Key System & Particle Background
local AnixlyUI = {}
local IsMobile = game:GetService("UserInputService").TouchEnabled

-- ===== KEY SYSTEM (ENHANCED VERSION) =====
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
    
    -- Background blur dengan efek gelap
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.6
    bg.Parent = popupGui
    
    -- Efek particle background (sederhana)
    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.Parent = popupGui
    
    -- Buat beberapa particle bergerak
    local particles = {}
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        particle.BackgroundTransparency = math.random(3, 8)/10
        particle.BorderSizePixel = 0
        particle.Parent = particleContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        table.insert(particles, {
            frame = particle,
            speedX = (math.random() - 0.5) * 0.05,
            speedY = (math.random() - 0.5) * 0.05,
            pos = {X = particle.Position.X.Scale, Y = particle.Position.Y.Scale}
        })
    end
    
    -- Animasi particle
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, p in ipairs(particles) do
            p.pos.X = p.pos.X + p.speedX * 0.01
            p.pos.Y = p.pos.Y + p.speedY * 0.01
            
            -- Wrap around screen
            if p.pos.X > 1 then p.pos.X = 0 end
            if p.pos.X < 0 then p.pos.X = 1 end
            if p.pos.Y > 1 then p.pos.Y = 0 end
            if p.pos.Y < 0 then p.pos.Y = 1 end
            
            p.frame.Position = UDim2.new(p.pos.X, 0, p.pos.Y, 0)
        end
    end)
    
    -- Main Popup Frame dengan efek glassmorphism
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 320)
    frame.Position = UDim2.new(0.5, -200, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = popupGui
    
    -- Efek blur (menggunakan background transparan + gradient)
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
    
    -- Animated border glow
    local hue = 0
    game:GetService("RunService").Heartbeat:Connect(function()
        hue = (hue + 0.002) % 1
        borderGlow.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
    end)
    
    -- Decorative elements
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, -20, 0, 4)
    topBar.Position = UDim2.new(0, 10, 0, 10)
    topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    topBar.BackgroundTransparency = 0.7
    topBar.BorderSizePixel = 0
    topBar.Parent = frame
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(1, 0)
    topBarCorner.Parent = topBar
    
    -- Title with icon
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 70)
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
    
    -- Rainbow title effect
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
    
    -- Input container
    local inputContainer = Instance.new("Frame")
    inputContainer.Size = UDim2.new(1, -40, 0, 70)
    inputContainer.Position = UDim2.new(0, 20, 0, 135)
    inputContainer.BackgroundTransparency = 1
    inputContainer.Parent = frame
    
    -- TextBox dengan efek modern
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
    
    -- Input icon
    local inputIcon = Instance.new("TextLabel")
    inputIcon.Size = UDim2.new(0, 30, 1, 0)
    inputIcon.Position = UDim2.new(0, 10, 0, 0)
    inputIcon.BackgroundTransparency = 1
    inputIcon.Text = "🔑"
    inputIcon.TextColor3 = Color3.fromRGB(200, 200, 255)
    inputIcon.Font = Enum.Font.GothamBold
    inputIcon.TextSize = 20
    inputIcon.Parent = textBox
    
    -- Adjust text padding
    local boxPadding = Instance.new("UIPadding")
    boxPadding.PaddingLeft = UDim.new(0, 45)
    boxPadding.Parent = textBox
    
    -- Focus effect
    textBox.Focused:Connect(function()
        textBox:TweenSize(UDim2.new(1, 0, 0, 54), "Out", "Quad", 0.2)
    end)
    
    textBox.FocusLost:Connect(function()
        textBox:TweenSize(UDim2.new(1, 0, 0, 50), "Out", "Quad", 0.2)
    end)
    
    -- Button container
    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(1, -40, 0, 60)
    btnContainer.Position = UDim2.new(0, 20, 0, 215)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = frame
    
    -- Submit button dengan efek gradient
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
    
    -- Button gradient
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 40, 200))
    })
    btnGradient.Parent = submitBtn
    
    -- Button glow
    local btnGlow = Instance.new("UIStroke")
    btnGlow.Color = Color3.fromRGB(180, 160, 255)
    btnGlow.Thickness = 2
    btnGlow.Transparency = 0.5
    btnGlow.Parent = submitBtn
    
    -- Button shine effect
    local btnShine = Instance.new("Frame")
    btnShine.Size = UDim2.new(0, 40, 1, -10)
    btnShine.Position = UDim2.new(0, -40, 0, 5)
    btnShine.BackgroundColor3 = Color3.new(1, 1, 1)
    btnShine.BackgroundTransparency = 0.5
    btnShine.BorderSizePixel = 0
    btnShine.Parent = submitBtn
    btnShine.ZIndex = 5
    
    local shineCorner = Instance.new("UICorner")
    shineCorner.CornerRadius = UDim.new(0, 16)
    shineCorner.Parent = btnShine
    
    -- Shine animation
    spawn(function()
        while submitBtn and submitBtn.Parent do
            btnShine:TweenPosition(UDim2.new(1, 20, 0, 5), "Out", "Quad", 1.5)
            wait(1.5)
            btnShine.Position = UDim2.new(0, -40, 0, 5)
            wait(0.5)
        end
    end)
    
    -- Error message dengan animasi
    local errorMsg = Instance.new("TextLabel")
    errorMsg.Size = UDim2.new(1, -40, 0, 25)
    errorMsg.Position = UDim2.new(0, 20, 1, -35)
    errorMsg.BackgroundTransparency = 1
    errorMsg.Text = ""
    errorMsg.TextColor3 = Color3.fromRGB(255, 80, 80)
    errorMsg.Font = Enum.Font.GothamBold
    errorMsg.TextSize = 12
    errorMsg.Parent = frame
    
    -- Close button dengan desain modern
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
    
    -- Close button hover effect
    closePopup.MouseEnter:Connect(function()
        closePopup:TweenSize(UDim2.new(0, 34, 0, 34), "Out", "Quad", 0.1)
    end)
    
    closePopup.MouseLeave:Connect(function()
        closePopup:TweenSize(UDim2.new(0, 32, 0, 32), "Out", "Quad", 0.1)
    end)
    
    -- Submit function dengan animasi
    local function checkKey()
        if textBox.Text == correctKey then
            -- Animasi sukses
            errorMsg.Text = "✓ ACCESS GRANTED!"
            errorMsg.TextColor3 = Color3.fromRGB(0, 255, 100)
            
            -- Scale up animation
            frame:TweenSize(UDim2.new(0, 420, 0, 340), "Out", "Back", 0.3, true)
            
            -- Fade out
            wait(0.5)
            for i = 0, 1, 0.1 do
                frame.BackgroundTransparency = i
                bg.BackgroundTransparency = 0.6 + i * 0.4
                wait(0.03)
            end
            
            popupGui:Destroy()
            callback(true)
        else
            -- Animasi error
            errorMsg.Text = "✗ Invalid key! Please try again."
            errorMsg.TextColor3 = Color3.fromRGB(255, 80, 80)
            
            -- Shake effect yang lebih halus
            local originalPos = frame.Position
            for i = 1, 5 do
                frame:TweenPosition(UDim2.new(0.5, -200 + math.random(-8, 8), 0.5, -160 + math.random(-4, 4)), "Out", "Quad", 0.02, true)
                wait(0.02)
            end
            frame:TweenPosition(originalPos, "Out", "Quad", 0.1, true)
            
            -- Flash red on textbox
            textBox.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            wait(0.1)
            textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            
            textBox.Text = ""
        end
    end
    
    submitBtn.MouseButton1Click:Connect(checkKey)
    
    -- Enter key support
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            checkKey()
        end
    end)
    
    -- Hover effects
    submitBtn.MouseEnter:Connect(function()
        submitBtn:TweenSize(UDim2.new(1, 0, 0, 52), "Out", "Quad", 0.1)
    end)
    
    submitBtn.MouseLeave:Connect(function()
        submitBtn:TweenSize(UDim2.new(1, 0, 0, 50), "Out", "Quad", 0.1)
    end)
    
    closePopup.MouseButton1Click:Connect(function()
        -- Fade out animation
        for i = 0, 1, 0.1 do
            frame.BackgroundTransparency = i
            bg.BackgroundTransparency = 0.6 + i * 0.4
            wait(0.03)
        end
        popupGui:Destroy()
        callback(false)
    end)
    
    -- Tampilkan popup dengan animasi fade in
    frame.BackgroundTransparency = 1
    bg.BackgroundTransparency = 1
    
    for i = 0, 1, 0.1 do
        frame.BackgroundTransparency = 1 - i
        bg.BackgroundTransparency = 1 - i * 0.6
        wait(0.02)
    end
    frame.BackgroundTransparency = 0.1
    bg.BackgroundTransparency = 0.6
end

-- [REST OF THE CODE REMAINS THE SAME - Themes, Window Class, etc.]

-- Themes
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
    window.UseParticles = config.UseParticles ~= false  -- Default true
    
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
    
    -- Efek rainbow berjalan
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
    
    -- Minimize Button (ImageButton)
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
    
    -- Close Button (ImageButton)
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
    
    -- Mini Icon (bisa di-drag)
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
    
    -- Input handling (drag + resize)
    local UIS = game:GetService("UserInputService")
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            
            -- RESIZE
            if isResizing then
                local delta = input.Position - resizeStartPos
                local newW, newH = clampSize(startWidth + delta.X, startHeight + delta.Y)
                MainFrame.Size = UDim2.new(0, newW, 0, newH)
                updateGlow()
                ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
                return
            end
            
            -- DRAG MAIN WINDOW
            if dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(
                    dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X,
                    dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y
                )
                updateGlow()
                return
            end
            
            -- DRAG MINI ICON
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
    
    -- Tab System
    window.Tabs = {}
    window.TabButtons = {}
    
    function window:CreateTab(name, icon)
        local tab = {}
        tab.Name = name
        tab.Icon = icon
        tab.Container = Instance.new("ScrollingFrame")
        tab.Container.Size = UDim2.new(1, 0, 1, 0)
        tab.Container.BackgroundTransparency = 1
        tab.Container.Visible = false
        tab.Container.ScrollBarThickness = IsMobile and 3 or 2
        tab.Container.ScrollBarImageColor3 = window.Theme.accent
        tab.Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tab.Container.Parent = contentArea
        
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
                t.container.Visible = false
                t.btn.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
                t.stroke.Color = Color3.fromRGB(50, 30, 90)
                t.icon.ImageColor3 = Color3.fromRGB(120, 110, 150)
                t.label.TextColor3 = Color3.fromRGB(120, 110, 150)
            end
            
            tab.Container.Visible = true
            btn.BackgroundColor3 = window.Theme.activeTab
            btnStroke.Color = window.Theme.accent
            iconLabel.ImageColor3 = Color3.new(1, 1, 1)
            textLabel.TextColor3 = Color3.new(1, 1, 1)
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
            
            -- Methods
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
                
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    toggle.BackgroundColor3 = state and Color3.fromRGB(30, 180, 110) or Color3.fromRGB(180, 40, 50)
                    knob.Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                    if config.Callback then config.Callback(state) end
                end)
            end
            
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
                    if config.Callback then config.Callback() end
                end)
            end
            
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
            
            return section
        end
        
        return tab
    end
    
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