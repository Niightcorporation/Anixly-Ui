-- Anixly UI Framework - Reusable UI Library
local AnixlyUI = {}
local IsMobile = game:GetService("UserInputService").TouchEnabled

-- Themes
local THEMES = {
    TOKYO_NIGHT = {
        primary = Color3.fromRGB(0, 255, 255),
        mid = Color3.fromRGB(255, 0, 255),
        dark = Color3.fromRGB(10, 10, 30),
        headerBg = Color3.fromRGB(20, 20, 50),
        accent = Color3.fromRGB(255, 255, 0),
        glow = Color3.fromRGB(255, 105, 180),
        activeTab = Color3.fromRGB(138, 43, 226),
        logText = Color3.fromRGB(200, 200, 255)
    },
    GALAXY = {
        primary = Color3.fromRGB(75, 0, 130),
        mid = Color3.fromRGB(48, 25, 52),
        dark = Color3.fromRGB(10, 5, 20),
        headerBg = Color3.fromRGB(45, 15, 70),
        accent = Color3.fromRGB(255, 215, 0),
        glow = Color3.fromRGB(138, 43, 226),
        activeTab = Color3.fromRGB(90, 30, 150),
        logText = Color3.fromRGB(173, 216, 230)
    },
    ROYAL = {
        primary = Color3.fromRGB(128, 0, 128),
        mid = Color3.fromRGB(85, 26, 139),
        dark = Color3.fromRGB(25, 10, 40),
        headerBg = Color3.fromRGB(75, 0, 130),
        accent = Color3.fromRGB(255, 215, 0),
        glow = Color3.fromRGB(147, 112, 219),
        activeTab = Color3.fromRGB(106, 90, 205),
        logText = Color3.fromRGB(230, 230, 250)
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
    
    -- Minimize Button
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, controlSize, 0, controlSize)
    MinimizeBtn.Position = UDim2.new(1, -(controlSize * 2 + 10), 0.5, -controlSize / 2)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(250, 190, 0)
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(30, 20, 0)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = IsMobile and 14 or 18
    MinimizeBtn.Parent = Header
    MinimizeBtn.ZIndex = 10
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(1, 0)
    MinCorner.Parent = MinimizeBtn
    
    -- Close Button
        -- Close
    local CloseBtn = Instance.new("ImageButton")
CloseBtn.Size = UDim2.new(0, controlSize, 0, controlSize)
CloseBtn.Position = UDim2.new(1, -(controlSize + 6), 0.5, -controlSize / 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 50, 60)
CloseBtn.Image = "rbxassetid://6023426923"  -- Icon close
CloseBtn.ImageColor3 = Color3.new(1, 1, 1)
CloseBtn.Parent = Header
CloseBtn.ZIndex = 10

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    IsRunning = false
end)
    
    -- RESIZE HANDLE (untuk resize window)
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
    game:GetService("UserInputService").InputChanged:Connect(function(input)
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
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
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
                
                local state = config.Default
                
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