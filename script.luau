-- Super Secret Grandma Hacks (SSGH)
-- Mobile Hacks GUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local PathfindingService = game:GetService("PathfindingService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Get screen size for mobile optimization
local screenSize = workspace.CurrentCamera.ViewportSize

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SSGH"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

-- Main Frame (smaller for phone)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, math.min(screenSize.Y - 60, 380))
mainFrame.Position = UDim2.new(1, -225, 0.5, -math.min(screenSize.Y - 60, 380)/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 10
mainFrame.Parent = screenGui

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 22)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Super Secret Grandma Hacks"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 11
titleLabel.ZIndex = 11
titleLabel.Parent = mainFrame

-- Close/Open Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 22, 0, 22)
toggleButton.Position = UDim2.new(1, -22, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "-"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 16
toggleButton.ZIndex = 11
toggleButton.Parent = mainFrame

-- Tab Frame
local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.Size = UDim2.new(1, 0, 0, 20)
tabFrame.Position = UDim2.new(0, 0, 0, 22)
tabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabFrame.BorderSizePixel = 0
tabFrame.ZIndex = 10
tabFrame.Parent = mainFrame

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -42)
contentFrame.Position = UDim2.new(0, 0, 0, 42)
contentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
contentFrame.BorderSizePixel = 0
contentFrame.ZIndex = 10
contentFrame.Parent = mainFrame

-- Rainbow Title Animation
local function rainbowEffect()
    local hue = tick() * 0.5 % 1
    local color = Color3.fromHSV(hue, 1, 1)
    titleLabel.TextColor3 = color
end

spawn(function()
    while true do
        RunService.RenderStepped:Wait()
        if screenGui and screenGui.Parent then
            rainbowEffect()
        else
            break
        end
    end
end)

-- Sound Functions
local function playSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1
    sound.Parent = screenGui
    sound:Play()
    game:GetService("Debris"):AddItem(sound, sound.TimeLength)
end

-- Toggle GUI Open/Close
local isOpen = true
toggleButton.MouseButton1Click:Connect(function()
    playSound("87437544236708")
    if isOpen then
        mainFrame:TweenSize(UDim2.new(0, 220, 0, 22), "Out", "Quad", 0.3, true)
        toggleButton.Text = "+"
        for _, v in pairs(mainFrame:GetChildren()) do
            if v ~= toggleButton and v.Name ~= "Title" then
                v.Visible = false
            end
        end
        titleLabel.Visible = true
    else
        mainFrame:TweenSize(UDim2.new(0, 220, 0, math.min(screenSize.Y - 60, 380)), "Out", "Quad", 0.3, true)
        toggleButton.Text = "-"
        for _, v in pairs(mainFrame:GetChildren()) do
            v.Visible = true
        end
    end
    isOpen = not isOpen
end)

-- Tabs System
local tabButtons = {}
local tabPages = {}

local function createTab(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.5, 0, 1, 0)
    button.Position = UDim2.new(position, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 11
    button.ZIndex = 11
    button.Parent = tabFrame

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(0, 0, 0, 0)
    page.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.ZIndex = 10
    page.Parent = contentFrame

    button.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        for _, p in pairs(tabPages) do
            p.Visible = false
        end
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        page.Visible = true
    end)

    table.insert(tabButtons, button)
    table.insert(tabPages, page)
    return page
end

local mainPage = createTab("Main", 0)
local trollPage = createTab("Troll", 0.5)
tabButtons[1].BackgroundColor3 = Color3.fromRGB(70, 70, 70)
tabPages[1].Visible = true

-- UI List Layout for pages
local mainList = Instance.new("UIListLayout")
mainList.Padding = UDim.new(0, 2)
mainList.SortOrder = Enum.SortOrder.LayoutOrder
mainList.Parent = mainPage

local trollList = Instance.new("UIListLayout")
trollList.Padding = UDim.new(0, 2)
trollList.SortOrder = Enum.SortOrder.LayoutOrder
trollList.Parent = trollPage

-- Create Toggle Element Function
local function createToggle(page, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -4, 0, 24)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.ZIndex = 10
    toggleFrame.Parent = page

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.Position = UDim2.new(0, 3, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 11
    label.Parent = toggleFrame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 32, 0, 16)
    toggle.Position = UDim2.new(1, -35, 0.5, -8)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    toggle.BorderSizePixel = 0
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 9
    toggle.ZIndex = 11
    toggle.Parent = toggleFrame

    local enabled = false
    local connection = nil
    
    toggle.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        enabled = not enabled
        toggle.Text = enabled and "ON" or "OFF"
        toggle.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(80, 80, 80)
        if callback then
            connection = callback(enabled, connection)
        end
    end)

    page.CanvasSize = UDim2.new(0, 0, 0, page.CanvasSize.Y.Offset + 26)
    return toggle
end

-- Create Slider Element Function
local function createSlider(page, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -4, 0, 45)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.ZIndex = 10
    sliderFrame.Parent = page

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 16)
    label.Position = UDim2.new(0, 3, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 10
    label.ZIndex = 11
    label.Parent = sliderFrame

    local minusButton = Instance.new("TextButton")
    minusButton.Size = UDim2.new(0, 22, 0, 20)
    minusButton.Position = UDim2.new(0, 2, 0.6, -5)
    minusButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    minusButton.BorderSizePixel = 0
    minusButton.Text = "-"
    minusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusButton.Font = Enum.Font.SourceSansBold
    minusButton.TextSize = 14
    minusButton.ZIndex = 11
    minusButton.Parent = sliderFrame

    local setButton = Instance.new("TextButton")
    setButton.Size = UDim2.new(0, 30, 0, 20)
    setButton.Position = UDim2.new(0.5, -15, 0.6, -5)
    setButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    setButton.BorderSizePixel = 0
    setButton.Text = "SET"
    setButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    setButton.Font = Enum.Font.SourceSansBold
    setButton.TextSize = 9
    setButton.ZIndex = 11
    setButton.Parent = sliderFrame

    local plusButton = Instance.new("TextButton")
    plusButton.Size = UDim2.new(0, 22, 0, 20)
    plusButton.Position = UDim2.new(1, -24, 0.6, -5)
    plusButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    plusButton.BorderSizePixel = 0
    plusButton.Text = "+"
    plusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusButton.Font = Enum.Font.SourceSansBold
    plusButton.TextSize = 14
    plusButton.ZIndex = 11
    plusButton.Parent = sliderFrame

    local currentValue = default
    minusButton.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        currentValue = math.max(min, currentValue - 1)
        label.Text = text .. ": " .. currentValue
    end)

    plusButton.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        currentValue = math.min(max, currentValue + 1)
        label.Text = text .. ": " .. currentValue
    end)

    setButton.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        if callback then
            callback(currentValue)
        end
    end)

    page.CanvasSize = UDim2.new(0, 0, 0, page.CanvasSize.Y.Offset + 47)
    return {minusButton, plusButton, setButton, label}
end

-- Settings Tab
local settingsButton = Instance.new("TextButton")
settingsButton.Size = UDim2.new(0, 20, 0, 20)
settingsButton.Position = UDim2.new(0, 2, 0, 1)
settingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
settingsButton.BorderSizePixel = 0
settingsButton.Text = "S"
settingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsButton.Font = Enum.Font.SourceSansBold
settingsButton.TextSize = 10
settingsButton.ZIndex = 11
settingsButton.Parent = mainFrame

local settingsPage = Instance.new("Frame")
settingsPage.Size = UDim2.new(1, 0, 1, -42)
settingsPage.Position = UDim2.new(0, 0, 0, 42)
settingsPage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
settingsPage.BorderSizePixel = 0
settingsPage.Visible = false
settingsPage.ZIndex = 10
settingsPage.Parent = mainFrame

local settingsList = Instance.new("UIListLayout")
settingsList.Padding = UDim.new(0, 2)
settingsList.SortOrder = Enum.SortOrder.LayoutOrder
settingsList.Parent = settingsPage

settingsButton.MouseButton1Click:Connect(function()
    playSound("87437544236708")
    local showing = not settingsPage.Visible
    for _, p in pairs(tabPages) do
        p.Visible = false
    end
    contentFrame.Visible = not showing
    settingsPage.Visible = showing
    for _, b in pairs(tabButtons) do
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- Settings Content
local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(1, -4, 0, 20)
colorLabel.Position = UDim2.new(0, 2, 0, 2)
colorLabel.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
colorLabel.BorderSizePixel = 0
colorLabel.Text = "UI Color Presets"
colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
colorLabel.Font = Enum.Font.SourceSans
colorLabel.TextSize = 10
colorLabel.ZIndex = 11
colorLabel.Parent = settingsPage

local colors = {
    {name = "Gray", color = Color3.fromRGB(40, 40, 40)},
    {name = "Blue", color = Color3.fromRGB(30, 30, 80)},
    {name = "Red", color = Color3.fromRGB(80, 30, 30)},
    {name = "Green", color = Color3.fromRGB(30, 80, 30)},
    {name = "Purple", color = Color3.fromRGB(60, 30, 80)},
    {name = "Black", color = Color3.fromRGB(20, 20, 20)}
}

for i, colorData in ipairs(colors) do
    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(0.9, 0, 0, 20)
    colorButton.Position = UDim2.new(0.05, 0, 0, 2 + (i * 22))
    colorButton.BackgroundColor3 = colorData.color
    colorButton.BorderSizePixel = 0
    colorButton.Text = colorData.name
    colorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorButton.Font = Enum.Font.SourceSans
    colorButton.TextSize = 10
    colorButton.ZIndex = 11
    colorButton.Parent = settingsPage

    colorButton.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        -- Store color values
        local mainColor = colorData.color
        local contentColor = Color3.fromRGB(
            math.clamp(math.floor(mainColor.R * 255 + 5), 0, 255) / 255,
            math.clamp(math.floor(mainColor.G * 255 + 5), 0, 255) / 255,
            math.clamp(math.floor(mainColor.B * 255 + 5), 0, 255) / 255
        )
        
        -- Apply colors
        mainFrame.BackgroundColor3 = mainColor
        contentFrame.BackgroundColor3 = contentColor
        
        -- Update tab frame
        tabFrame.BackgroundColor3 = Color3.fromRGB(
            math.clamp(math.floor(mainColor.R * 255 - 5), 0, 255) / 255,
            math.clamp(math.floor(mainColor.G * 255 - 5), 0, 255) / 255,
            math.clamp(math.floor(mainColor.B * 255 - 5), 0, 255) / 255
        )
        
        -- Update title
        titleLabel.BackgroundColor3 = Color3.fromRGB(
            math.clamp(math.floor(mainColor.R * 255 - 10), 0, 255) / 255,
            math.clamp(math.floor(mainColor.G * 255 - 10), 0, 255) / 255,
            math.clamp(math.floor(mainColor.B * 255 - 10), 0, 255) / 255
        )
    end)
end

-- Variables for features
local tapToFlingEnabled = false
local clickToMoveEnabled = false
local autoJumpEnabled = false
local espEnabled = false
local xrayEnabled = false
local spectating = false
local spectateTarget = nil
local espConnections = {}
local xrayConnections = {}
local pathConnection = nil
local clickMarker = nil
local cancelMoveButton = nil

-- Create Click Marker
local function createClickMarker(position)
    if clickMarker then
        clickMarker:Destroy()
    end
    
    clickMarker = Instance.new("Part")
    clickMarker.Size = Vector3.new(0.2, 0.2, 0.2)
    clickMarker.Position = position
    clickMarker.Anchored = true
    clickMarker.CanCollide = false
    clickMarker.BrickColor = BrickColor.new("White")
    clickMarker.Material = Enum.Material.Neon
    clickMarker.Parent = workspace
    
    -- Add a beam or cylinder to make it more visible
    local attachment0 = Instance.new("Attachment")
    attachment0.Position = Vector3.new(0, 0, 0)
    attachment0.Parent = clickMarker
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Position = Vector3.new(0, 3, 0)
    attachment1.Parent = clickMarker
    
    local beam = Instance.new("Beam")
    beam.Attachment0 = attachment0
    beam.Attachment1 = attachment1
    beam.Color = ColorSequence.new(Color3.new(1, 1, 1))
    beam.Width0 = 0.15
    beam.Width1 = 0.15
    beam.Parent = clickMarker
    
    -- Remove after 3 seconds if not moving
    spawn(function()
        wait(3)
        if clickMarker then
            clickMarker:Destroy()
            clickMarker = nil
        end
    end)
end

-- Create Cancel Move Button
local function createCancelButton()
    if cancelMoveButton then
        cancelMoveButton:Destroy()
    end
    
    cancelMoveButton = Instance.new("TextButton")
    cancelMoveButton.Size = UDim2.new(0, 100, 0, 25)
    cancelMoveButton.Position = UDim2.new(0.5, -50, 0.7, 0)
    cancelMoveButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    cancelMoveButton.BorderSizePixel = 0
    cancelMoveButton.Text = "CANCEL MOVE"
    cancelMoveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelMoveButton.Font = Enum.Font.SourceSansBold
    cancelMoveButton.TextSize = 10
    cancelMoveButton.ZIndex = 5
    cancelMoveButton.Parent = screenGui
    
    cancelMoveButton.MouseButton1Click:Connect(function()
        clickToMoveEnabled = false
        if pathConnection then
            pathConnection:Disconnect()
            pathConnection = nil
        end
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid"):Move(Vector3.new(0, 0, 0), false)
        end
        if clickMarker then
            clickMarker:Destroy()
            clickMarker = nil
        end
        if cancelMoveButton then
            cancelMoveButton:Destroy()
            cancelMoveButton = nil
        end
    end)
end

-- ESP Function
local function createESP(targetPlayer)
    if targetPlayer == player then return end
    
    local function setupESP(character)
        if not character:FindFirstChild("Head") then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Size = UDim2.new(0, 100, 0, 25)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = character.Head
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = targetPlayer.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 12
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Parent = billboard
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Size = UDim2.new(1, 0, 0.4, 0)
        distanceLabel.Position = UDim2.new(0, 0, 0.6, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = ""
        distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distanceLabel.Font = Enum.Font.SourceSans
        distanceLabel.TextSize = 10
        distanceLabel.TextStrokeTransparency = 0
        distanceLabel.Parent = billboard
        
        local connection = RunService.RenderStepped:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. " studs"
            end
        end)
        
        table.insert(espConnections, connection)
        table.insert(espConnections, character.AncestryChanged:Connect(function()
            if not character:IsDescendantOf(workspace) then
                connection:Disconnect()
            end
        end))
    end
    
    if targetPlayer.Character then
        setupESP(targetPlayer.Character)
    end
    
    local charConnection = targetPlayer.CharacterAdded:Connect(setupESP)
    table.insert(espConnections, charConnection)
end

local function clearESP()
    for _, v in pairs(espConnections) do
        pcall(function() v:Disconnect() end)
    end
    espConnections = {}
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            pcall(function()
                if plr.Character then
                    local highlight = plr.Character:FindFirstChild("ESP_Highlight")
                    if highlight then highlight:Destroy() end
                    if plr.Character.Head then
                        local billboard = plr.Character.Head:FindFirstChild("ESP_Billboard")
                        if billboard then billboard:Destroy() end
                    end
                end
            end)
        end
    end
end

local function enableESP()
    clearESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            createESP(plr)
        end
    end
    
    local playerAdded = Players.PlayerAdded:Connect(function(plr)
        if plr ~= player then
            createESP(plr)
        end
    end)
    table.insert(espConnections, playerAdded)
end

-- X-Ray Function
local function enableXRay()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency < 0.5 and not v.Parent:FindFirstChildOfClass("Humanoid") then
            local originalTransparency = v.Transparency
            v.Transparency = 0.7
            local connection = v:GetPropertyChangedSignal("Transparency"):Connect(function()
                v.Transparency = 0.7
            end)
            table.insert(xrayConnections, {part = v, original = originalTransparency, connection = connection})
        end
    end
end

local function disableXRay()
    for _, data in pairs(xrayConnections) do
        pcall(function()
            data.connection:Disconnect()
            data.part.Transparency = data.original
        end)
    end
    xrayConnections = {}
end

-- Click To Move Function
local function moveToPosition(targetPosition)
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    if pathConnection then
        pathConnection:Disconnect()
        pathConnection = nil
    end
    
    -- Create visual marker
    createClickMarker(targetPosition)
    createCancelButton()
    
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentMaxSlope = 45,
        WaypointSpacing = 3,
        Costs = {}
    })
    
    local success, errorMessage = pcall(function()
        path:ComputeAsync(rootPart.Position, targetPosition)
    end)
    
    if success and path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        
        pathConnection = RunService.Heartbeat:Connect(function()
            if not clickToMoveEnabled then
                humanoid:Move(Vector3.new(0, 0, 0), false)
                if pathConnection then
                    pathConnection:Disconnect()
                    pathConnection = nil
                end
                return
            end
            
            for _, waypoint in ipairs(waypoints) do
                if waypoint.Action == Enum.PathWaypointAction.Jump then
                    humanoid.Jump = true
                end
                humanoid:MoveTo(waypoint.Position)
            end
            
            if (rootPart.Position - targetPosition).Magnitude < 3 then
                humanoid:Move(Vector3.new(0, 0, 0), false)
                if pathConnection then
                    pathConnection:Disconnect()
                    pathConnection = nil
                end
                if clickMarker then
                    clickMarker:Destroy()
                    clickMarker = nil
                end
                if cancelMoveButton then
                    cancelMoveButton:Destroy()
                    cancelMoveButton = nil
                end
            end
        end)
    end
end

-- Auto Jump Function
local function autoJumpCheck()
    if not autoJumpEnabled then return end
    if not player.Character then return end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    if humanoid.FloorMaterial == Enum.Material.Air then return end
    if rootPart.Velocity.Magnitude < 2 then return end
    
    local moveDirection = rootPart.Velocity.Unit
    if moveDirection.Magnitude < 0.1 then return end
    
    local rayOrigin = rootPart.Position + Vector3.new(0, 2, 0)
    local rayDirection = moveDirection * 4
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {player.Character}
    
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    if raycastResult then
        local hitHeight = raycastResult.Position.Y - rootPart.Position.Y
        
        if hitHeight > 2.1 then
            humanoid.Jump = true
        elseif hitHeight > 0.5 then
            local aboveOrigin = raycastResult.Position + Vector3.new(0, 2.1, 0)
            local aboveDirection = Vector3.new(0, -3, 0)
            local aboveRaycast = workspace:Raycast(aboveOrigin, aboveDirection, raycastParams)
            
            if aboveRaycast then
                humanoid.Jump = true
            end
        end
    end
end

-- Fling Function
local function SkidFling(TargetPlayer)
    local Character = player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    local TCharacter = TargetPlayer.Character
    if not TCharacter then return end
    
    local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and THumanoid.RootPart
    local THead = TCharacter:FindFirstChild("Head")
    local Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    local Handle = Accessory and Accessory:FindFirstChild("Handle")
    
    if Character and Humanoid and RootPart then
        if THumanoid and THumanoid.Sit then return end
        
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then return end
        
        local OriginalPosition = RootPart.CFrame
        local OriginalFPDH = workspace.FallenPartsDestroyHeight
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                end
            until Time + TimeToWait < tick()
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        elseif Handle then
            SFBasePart(Handle)
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = OriginalPosition * CFrame.new(0, 0.5, 0)
            Character:SetPrimaryPartCFrame(OriginalPosition * CFrame.new(0, 0.5, 0))
            Humanoid:ChangeState("GettingUp")
            for _, part in pairs(Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()
                end
            end
            task.wait()
        until (RootPart.Position - OriginalPosition.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = OriginalFPDH
    end
end

-- TP To Player Function
local function tpToPlayer(targetPlayer)
    if not targetPlayer then return end
    local targetChar = targetPlayer.Character
    if not targetChar then return end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    
    local myChar = player.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    myRoot.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0))
end

-- Spectate Function
local function startSpectate(targetPlayer)
    if not targetPlayer then return end
    spectating = true
    spectateTarget = targetPlayer
    
    spawn(function()
        while spectating and spectateTarget do
            local targetChar = spectateTarget.Character
            if targetChar then
                local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    workspace.CurrentCamera.CameraSubject = humanoid
                else
                    workspace.CurrentCamera.CameraSubject = targetChar
                end
            end
            RunService.RenderStepped:Wait()
        end
        if player.Character then
            local myHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if myHumanoid then
                workspace.CurrentCamera.CameraSubject = myHumanoid
            end
        end
    end)
end

local function stopSpectate()
    spectating = false
    spectateTarget = nil
end

-- Fling All Function
local function flingAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            spawn(function()
                SkidFling(plr)
            end)
        end
    end
end

-- Main Tab Content
createToggle(mainPage, "Click To TP", function(enabled, oldConnection)
    if oldConnection then oldConnection:Disconnect() end
    if enabled then
        return mouse.Button1Down:Connect(function()
            if not tapToFlingEnabled and not clickToMoveEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 5, 0))
            end
        end)
    end
end)

createToggle(mainPage, "Click To Move", function(enabled, oldConnection)
    clickToMoveEnabled = enabled
    if oldConnection then oldConnection:Disconnect() end
    
    -- Clean up if disabled
    if not enabled then
        if pathConnection then
            pathConnection:Disconnect()
            pathConnection = nil
        end
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid"):Move(Vector3.new(0, 0, 0), false)
        end
        if clickMarker then
            clickMarker:Destroy()
            clickMarker = nil
        end
        if cancelMoveButton then
            cancelMoveButton:Destroy()
            cancelMoveButton = nil
        end
        return
    end
    
    if enabled then
        return mouse.Button1Down:Connect(function()
            if clickToMoveEnabled and not tapToFlingEnabled and mouse.Target then
                moveToPosition(mouse.Hit.p)
            end
        end)
    end
end)

createToggle(mainPage, "INF Jump", function(enabled, oldConnection)
    if oldConnection then oldConnection:Disconnect() end
    if enabled then
        return UserInputService.JumpRequest:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

createToggle(mainPage, "Auto Jump (Broken)", function(enabled, oldConnection)
    autoJumpEnabled = enabled
end)

createToggle(mainPage, "Walk On Air", function(enabled, oldConnection)
    if oldConnection then oldConnection:Disconnect() end
    if enabled then
        return RunService.Stepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                local velocity = root.Velocity
                root.Velocity = Vector3.new(velocity.X, math.max(velocity.Y, 0), velocity.Z)
                if velocity.Y <= 0 then
                    root.Velocity = Vector3.new(velocity.X, 0, velocity.Z)
                end
            end
        end)
    end
end)

createToggle(mainPage, "X-Ray", function(enabled, oldConnection)
    xrayEnabled = enabled
    if enabled then
        enableXRay()
    else
        disableXRay()
    end
end)

createToggle(mainPage, "ESP (Names)", function(enabled, oldConnection)
    espEnabled = enabled
    if enabled then
        enableESP()
    else
        clearESP()
    end
end)

local speedSlider = createSlider(mainPage, "Speed", 16, 200, 16, function(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)

local jumpSlider = createSlider(mainPage, "Jump", 50, 300, 50, function(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = value
    end
end)

-- Auto Jump runs every frame
RunService.Stepped:Connect(function()
    autoJumpCheck()
end)

mainPage.CanvasSize = UDim2.new(0, 0, 0, mainPage.CanvasSize.Y.Offset + 10)

-- Troll Tab Content
tabButtons[2].Visible = true

-- Player Selection Dropdown Container
local playerSelectContainer = Instance.new("Frame")
playerSelectContainer.Size = UDim2.new(1, -4, 0, 50)
playerSelectContainer.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
playerSelectContainer.BorderSizePixel = 0
playerSelectContainer.ZIndex = 10
playerSelectContainer.Parent = trollPage

local playerSelectLabel = Instance.new("TextLabel")
playerSelectLabel.Size = UDim2.new(1, 0, 0, 16)
playerSelectLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerSelectLabel.BorderSizePixel = 0
playerSelectLabel.Text = "Select Player"
playerSelectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerSelectLabel.Font = Enum.Font.SourceSansBold
playerSelectLabel.TextSize = 10
playerSelectLabel.ZIndex = 11
playerSelectLabel.Parent = playerSelectContainer

local playerDropdown = Instance.new("TextButton")
playerDropdown.Size = UDim2.new(0.8, 0, 0, 20)
playerDropdown.Position = UDim2.new(0.1, 0, 0, 18)
playerDropdown.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
playerDropdown.BorderSizePixel = 0
playerDropdown.Text = "Select Player"
playerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
playerDropdown.Font = Enum.Font.SourceSans
playerDropdown.TextSize = 9
playerDropdown.ZIndex = 11
playerDropdown.Parent = playerSelectContainer

-- Dropdown List as separate ScreenGui
local dropdownGui = Instance.new("ScreenGui")
dropdownGui.Name = "DropdownGui"
dropdownGui.Parent = player:WaitForChild("PlayerGui")
dropdownGui.ResetOnSpawn = false
dropdownGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
dropdownGui.IgnoreGuiInset = true

local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(0, 176, 0, 0)
dropdownList.Position = UDim2.new(1, -225 + 22, 0.5, -math.min(screenSize.Y - 60, 380)/2 + 42 + 18 + 20)
dropdownList.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
dropdownList.BorderSizePixel = 0
dropdownList.ClipsDescendants = true
dropdownList.Visible = false
dropdownList.ZIndex = 100
dropdownList.Parent = dropdownGui

local dropdownLayout = Instance.new("UIListLayout")
dropdownLayout.Parent = dropdownList

local function refreshPlayerDropdown()
    for _, child in pairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local playerCount = 0
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            playerCount = playerCount + 1
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0, 16)
            playerButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            playerButton.BorderSizePixel = 0
            playerButton.Text = plr.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Font = Enum.Font.SourceSans
            playerButton.TextSize = 9
            playerButton.ZIndex = 101
            playerButton.Parent = dropdownList
            
            playerButton.MouseButton1Click:Connect(function()
                playSound("87437544236708")
                playerDropdown.Text = plr.Name
                dropdownOpen = false
                dropdownList.Visible = false
            end)
        end
    end
    
    dropdownList.Size = UDim2.new(0, 176, 0, playerCount * 16)
end

local dropdownOpen = false
playerDropdown.MouseButton1Click:Connect(function()
    playSound("87437544236708")
    dropdownOpen = not dropdownOpen
    if dropdownOpen then
        refreshPlayerDropdown()
        dropdownList.Visible = true
    else
        dropdownList.Visible = false
    end
end)

-- Tap To Fling Toggle
createToggle(trollPage, "Tap Player To Fling", function(enabled, oldConnection)
    if oldConnection then oldConnection:Disconnect() end
    tapToFlingEnabled = enabled
    if enabled then
        return mouse.Button1Down:Connect(function()
            if not tapToFlingEnabled then return end
            local target = mouse.Target
            if target then
                local targetPlayer = Players:GetPlayerFromCharacter(target.Parent)
                if not targetPlayer then
                    targetPlayer = Players:GetPlayerFromCharacter(target.Parent.Parent)
                end
                if targetPlayer and targetPlayer ~= player then
                    playerDropdown.Text = targetPlayer.Name
                    SkidFling(targetPlayer)
                end
            end
        end)
    end
end)

-- Action Buttons
local function createTrollButton(text, color, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 20)
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 9
    button.ZIndex = 11
    button.Parent = trollPage
    
    button.MouseButton1Click:Connect(function()
        playSound("87437544236708")
        callback()
    end)
    
    trollPage.CanvasSize = UDim2.new(0, 0, 0, trollPage.CanvasSize.Y.Offset + 22)
    return button
end

createTrollButton("FLING SELECTED", Color3.fromRGB(200, 50, 50), function()
    local targetName = playerDropdown.Text
    if targetName ~= "Select Player" then
        local target = Players:FindFirstChild(targetName)
        if target then SkidFling(target) end
    end
end)

createTrollButton("FLING ALL", Color3.fromRGB(255, 0, 0), function()
    flingAll()
end)

createTrollButton("SPECTATE PLAYER", Color3.fromRGB(50, 100, 200), function()
    local targetName = playerDropdown.Text
    if targetName ~= "Select Player" then
        local target = Players:FindFirstChild(targetName)
        if target then
            if not spectating then
                startSpectate(target)
            else
                stopSpectate()
            end
        end
    end
end)

createTrollButton("TP TO PLAYER", Color3.fromRGB(50, 200, 100), function()
    local targetName = playerDropdown.Text
    if targetName ~= "Select Player" then
        local target = Players:FindFirstChild(targetName)
        if target then
            tpToPlayer(target)
        end
    end
end)

createTrollButton("TOUCH BACK FLING", Color3.fromRGB(200, 100, 50), function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/miso517/scirpt/refs/heads/main/main.lua"))()
    end)
    if not success then warn("Touch Back Fling failed: " .. tostring(err)) end
end)

trollPage.CanvasSize = UDim2.new(0, 0, 0, trollPage.CanvasSize.Y.Offset + 10)

-- Opening Animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(1, -110, 0.5, -math.min(screenSize.Y - 60, 380)/2)

playSound("138158731526545")
local openTween = TweenService:Create(mainFrame, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 220, 0, math.min(screenSize.Y - 60, 380)),
    Position = UDim2.new(1, -225, 0.5, -math.min(screenSize.Y - 60, 380)/2)
})
openTween:Play()
