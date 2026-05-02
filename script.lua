-- ============================================================
-- GHXST HUB - Basketball Legends
-- Key System powered by Junkie | Script by @wrl11 & @aylonthegiant
-- ============================================================

local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "BasketBall Legends"
Junkie.identifier = "1091693"
Junkie.provider = "BasketBall Legends"

-- ============================================================
-- KEY SYSTEM UI
-- ============================================================
local keyResult = (function()
    getgenv().UI_CLOSED = false
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    local Colors = {
        background = Color3.fromRGB(13, 17, 23),
        surface = Color3.fromRGB(22, 27, 34),
        surfaceLight = Color3.fromRGB(30, 36, 44),
        primary = Color3.fromRGB(88, 166, 255),
        primaryDark = Color3.fromRGB(58, 136, 225),
        primaryGlow = Color3.fromRGB(120, 180, 255),
        accent = Color3.fromRGB(136, 87, 224),
        success = Color3.fromRGB(47, 183, 117),
        successDark = Color3.fromRGB(37, 153, 97),
        successGlow = Color3.fromRGB(67, 203, 137),
        error = Color3.fromRGB(248, 81, 73),
        textPrimary = Color3.fromRGB(230, 237, 243),
        textSecondary = Color3.fromRGB(139, 148, 158),
        textMuted = Color3.fromRGB(110, 118, 129),
        border = Color3.fromRGB(48, 54, 61),
        borderLight = Color3.fromRGB(63, 71, 79),
        glass = Color3.fromRGB(255, 255, 255),
        neonBlue = Color3.fromRGB(0, 229, 255),
        neonPurple = Color3.fromRGB(187, 134, 252)
    }

    local function hasFileSystemSupport()
        local hasWritefile = pcall(function() return type(writefile) == "function" end)
        local hasReadfile = pcall(function() return type(readfile) == "function" end)
        local hasIsfile = pcall(function() return type(isfile) == "function" end)
        return hasWritefile and hasReadfile and hasIsfile
    end

    local fileSystemSupported = hasFileSystemSupport()

    local function saveVerifiedKey(key)
        if not fileSystemSupported then return false end
        local ok = pcall(function()
            writefile("verified_key.txt", key)
        end)
        return ok
    end

    local function loadVerifiedKey()
        if not fileSystemSupported then return nil end
        local ok, content = pcall(function()
            return readfile("verified_key.txt")
        end)
        if not ok or not content then return nil end
        return content
    end

    local function clearSavedKey()
        if not fileSystemSupported then return false end
        local ok = pcall(function() delfile("verified_key.txt") end)
        return ok
    end

    local function loadUIFactory()
        return function(Colors, Players, TweenService, UserInputService, Lighting)
            local IconAssets = {
                shield = 84528813312016,
                x = 73070135088117,
                key = 128426502701541,
                link = 73034596791310,
                check = 83827110621355
            }

            local function createIconImage(name, size, color)
                local id = IconAssets[name]
                if id then
                    local img = Instance.new("ImageLabel")
                    img.BackgroundTransparency = 1
                    img.Size = UDim2.new(0, size or 18, 0, size or 18)
                    img.Image = "rbxassetid://" .. tostring(id)
                    img.ImageColor3 = color or Color3.fromRGB(255, 255, 255)
                    img.ScaleType = Enum.ScaleType.Fit
                    return img
                end
                local lbl = Instance.new("TextLabel")
                lbl.BackgroundTransparency = 1
                lbl.Size = UDim2.new(0, size or 18, 0, size or 18)
                lbl.TextScaled = true
                lbl.Font = Enum.Font.SourceSansBold
                lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
                lbl.Text = ({ shield = "🛡️", key = "🔑", link = "🔗", x = "✕", check = "✓" })[name] or "🔘"
                return lbl
            end

            return function(self)
                if self.gui then self.gui:Destroy() end

                self.gui = Instance.new("ScreenGui")
                self.gui.Name = "JunkieKeySystemUI"
                self.gui.ResetOnSpawn = false
                self.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                self.gui.IgnoreGuiInset = true

                local backdrop = Instance.new("Frame")
                backdrop.Name = "Backdrop"
                backdrop.Size = UDim2.new(1, 0, 1, 0)
                backdrop.Position = UDim2.new(0, 0, 0, 0)
                backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                backdrop.BackgroundTransparency = 0.4
                backdrop.BorderSizePixel = 0
                backdrop.Parent = self.gui

                local blur = Instance.new("BlurEffect")
                blur.Size = 16
                blur.Name = "JunkieUIBlur"
                blur.Parent = Lighting

                local container = Instance.new("Frame")
                container.Name = "Container"

                local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
                local viewportSize = workspace.CurrentCamera.ViewportSize

                if isMobile then
                    container.Size = UDim2.new(0.6, 0, 0, math.min(320, viewportSize.Y * 0.8))
                    container.Position = UDim2.new(0.5, 0, 0.5, 0)
                    container.AnchorPoint = Vector2.new(0.5, 0.5)
                else
                    container.Size = UDim2.new(0, 580, 0, 320)
                    container.Position = UDim2.new(0.5, 0, 0.5, 0)
                    container.AnchorPoint = Vector2.new(0.5, 0.5)
                end

                container.BackgroundColor3 = Colors.surface
                container.BorderSizePixel = 0
                container.Parent = backdrop
                container:SetAttribute("IsMobile", isMobile)

                local containerCorner = Instance.new("UICorner")
                containerCorner.CornerRadius = UDim.new(0, 14)
                containerCorner.Parent = container

                local containerStroke = Instance.new("UIStroke")
                containerStroke.Color = Colors.border
                containerStroke.Thickness = 1
                containerStroke.Transparency = 0.3
                containerStroke.Parent = container

                local shadow = Instance.new("Frame")
                shadow.Name = "Shadow"
                shadow.Size = UDim2.new(1, 40, 1, 40)
                shadow.Position = UDim2.new(0.5, 0, 0.5, 6)
                shadow.AnchorPoint = Vector2.new(0.5, 0.5)
                shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                shadow.BackgroundTransparency = 0.7
                shadow.BorderSizePixel = 0
                shadow.ZIndex = 0
                shadow.Parent = backdrop

                local shadowCorner = Instance.new("UICorner")
                shadowCorner.CornerRadius = UDim.new(0, 18)
                shadowCorner.Parent = shadow

                local glowFrame = Instance.new("Frame")
                glowFrame.Name = "GlowEffect"
                glowFrame.Size = UDim2.new(1, 60, 1, 60)
                glowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                glowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                glowFrame.BackgroundColor3 = Colors.primary
                glowFrame.BackgroundTransparency = 0.95
                glowFrame.BorderSizePixel = 0
                glowFrame.ZIndex = -1
                glowFrame.Parent = backdrop

                local glowCorner = Instance.new("UICorner")
                glowCorner.CornerRadius = UDim.new(0, 30)
                glowCorner.Parent = glowFrame

                local glowTween = TweenService:Create(glowFrame,
                    TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                    {BackgroundTransparency = 0.9, Size = UDim2.new(1, 80, 1, 80)}
                )
                glowTween:Play()

                local glassOverlay = Instance.new("Frame")
                glassOverlay.Name = "GlassOverlay"
                glassOverlay.Size = UDim2.new(1, 0, 1, 0)
                glassOverlay.Position = UDim2.new(0, 0, 0, 0)
                glassOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                glassOverlay.BackgroundTransparency = 0.98
                glassOverlay.BorderSizePixel = 0
                glassOverlay.ZIndex = 1
                glassOverlay.Parent = container

                local glassCorner = Instance.new("UICorner")
                glassCorner.CornerRadius = UDim.new(0, 14)
                glassCorner.Parent = glassOverlay

                local glassGradient = Instance.new("UIGradient")
                glassGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
                }
                glassGradient.Rotation = 45
                glassGradient.Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0.96),
                    NumberSequenceKeypoint.new(0.5, 0.98),
                    NumberSequenceKeypoint.new(1, 1)
                }
                glassGradient.Parent = glassOverlay

                local topBar = Instance.new("Frame")
                topBar.Name = "TopBar"
                topBar.Size = UDim2.new(1, 0, 0, 45)
                topBar.Position = UDim2.new(0, 0, 0, 0)
                topBar.BackgroundColor3 = Colors.background
                topBar.BorderSizePixel = 0
                topBar.ZIndex = 10
                topBar.Parent = container

                local topBarCorner = Instance.new("UICorner")
                topBarCorner.CornerRadius = UDim.new(0, 14)
                topBarCorner.Parent = topBar

                local topBarFix = Instance.new("Frame")
                topBarFix.Size = UDim2.new(1, 0, 0, 10)
                topBarFix.Position = UDim2.new(0, 0, 1, -10)
                topBarFix.BackgroundColor3 = Colors.background
                topBarFix.BorderSizePixel = 0
                topBarFix.Parent = topBar

                local brandLogo = Instance.new("Frame")
                brandLogo.Name = "BrandLogo"
                brandLogo.Size = UDim2.new(0, 200, 1, 0)
                brandLogo.Position = UDim2.new(0, 20, 0, 0)
                brandLogo.BackgroundTransparency = 1
                brandLogo.ZIndex = 11
                brandLogo.Parent = topBar

                local brandLogoIcon = createIconImage("shield", 20, Colors.primary)
                brandLogoIcon.AnchorPoint = Vector2.new(0, 0.5)
                brandLogoIcon.Position = UDim2.new(0, 0, 0.5, 0)
                brandLogoIcon.ZIndex = 11
                brandLogoIcon.Parent = brandLogo

                local brandLogoText = Instance.new("TextLabel")
                brandLogoText.BackgroundTransparency = 1
                brandLogoText.Size = UDim2.new(1, -30, 1, 0)
                brandLogoText.Position = UDim2.new(0, 28, 0, 0)
                brandLogoText.Text = "Junkie Key System"
                brandLogoText.TextColor3 = Colors.textPrimary
                brandLogoText.TextSize = 15
                brandLogoText.TextXAlignment = Enum.TextXAlignment.Left
                brandLogoText.Font = Enum.Font.GothamSemibold
                brandLogoText.ZIndex = 11
                brandLogoText.Parent = brandLogo

                local closeButton = Instance.new("TextButton")
                closeButton.Name = "CloseButton"
                closeButton.Size = UDim2.new(0, 30, 0, 30)
                closeButton.Position = UDim2.new(1, -40, 0.5, 0)
                closeButton.AnchorPoint = Vector2.new(0, 0.5)
                closeButton.BackgroundColor3 = Colors.error
                closeButton.BackgroundTransparency = 0.8
                closeButton.BorderSizePixel = 0
                closeButton.Text = ""
                closeButton.AutoButtonColor = false
                closeButton.ZIndex = 11
                closeButton.Parent = topBar

                local closeCorner = Instance.new("UICorner")
                closeCorner.CornerRadius = UDim.new(0, 8)
                closeCorner.Parent = closeButton

                local closeIcon = createIconImage("x", 16, Colors.textPrimary)
                closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                closeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                closeIcon.ZIndex = 12
                closeIcon.Parent = closeButton

                local contentArea = Instance.new("Frame")
                contentArea.Name = "ContentArea"
                contentArea.Size = UDim2.new(1, -40, 1, -65)
                contentArea.Position = UDim2.new(0, 20, 0, 55)
                contentArea.BackgroundTransparency = 1
                contentArea.Parent = container

                local titleSection = Instance.new("Frame")
                titleSection.Name = "TitleSection"
                titleSection.Size = UDim2.new(1, 0, 0, 85)
                titleSection.Position = UDim2.new(0, 0, 0, 5)
                titleSection.BackgroundTransparency = 1
                titleSection.Parent = contentArea

                local iconFrame = Instance.new("Frame")
                iconFrame.Name = "IconFrame"
                iconFrame.Size = UDim2.new(0, 52, 0, 52)
                iconFrame.Position = UDim2.new(0.5, -26, 0, 0)
                iconFrame.BackgroundColor3 = Colors.surfaceLight
                iconFrame.BorderSizePixel = 0
                iconFrame.Parent = titleSection

                local iconCorner = Instance.new("UICorner")
                iconCorner.CornerRadius = UDim.new(0, 12)
                iconCorner.Parent = iconFrame

                local iconGradient = Instance.new("UIGradient")
                iconGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Colors.primary),
                    ColorSequenceKeypoint.new(0.5, Colors.primaryGlow),
                    ColorSequenceKeypoint.new(1, Colors.accent)
                }
                iconGradient.Rotation = 45
                iconGradient.Parent = iconFrame

                local iconStroke = Instance.new("UIStroke")
                iconStroke.Color = Colors.primary
                iconStroke.Thickness = 2
                iconStroke.Transparency = 0.5
                iconStroke.Parent = iconFrame

                local strokeGradient = Instance.new("UIGradient")
                strokeGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Colors.neonBlue),
                    ColorSequenceKeypoint.new(0.5, Colors.primary),
                    ColorSequenceKeypoint.new(1, Colors.neonPurple)
                }
                strokeGradient.Rotation = 0
                strokeGradient.Parent = iconStroke

                local strokeTween = TweenService:Create(strokeGradient,
                    TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
                    {Rotation = 360}
                )
                strokeTween:Play()

                local mainIcon = createIconImage("shield", 26, Color3.fromRGB(255, 255, 255))
                mainIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                mainIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                mainIcon.Parent = iconFrame

                local titleText = Instance.new("TextLabel")
                titleText.Name = "TitleText"
                titleText.Size = UDim2.new(1, 0, 0, 24)
                titleText.Position = UDim2.new(0, 0, 0, 58)
                titleText.BackgroundTransparency = 1
                titleText.Text = self.title
                titleText.TextColor3 = Colors.textPrimary
                titleText.TextSize = 17
                titleText.TextXAlignment = Enum.TextXAlignment.Center
                titleText.Font = Enum.Font.GothamBold
                titleText.Parent = titleSection

                local subtitleText = Instance.new("TextLabel")
                subtitleText.Name = "SubtitleText"
                subtitleText.Size = UDim2.new(1, 0, 0, 18)
                subtitleText.Position = UDim2.new(0, 0, 0, 82)
                subtitleText.BackgroundTransparency = 1
                subtitleText.Text = self.subtitle
                subtitleText.TextColor3 = Colors.textSecondary
                subtitleText.TextSize = 13
                subtitleText.TextXAlignment = Enum.TextXAlignment.Center
                subtitleText.Font = Enum.Font.Gotham
                subtitleText.Parent = titleSection

                local inputSection = Instance.new("Frame")
                inputSection.Name = "InputSection"
                inputSection.Size = UDim2.new(1, 0, 0, 46)
                inputSection.Position = UDim2.new(0, 0, 0, 115)
                inputSection.BackgroundColor3 = Colors.surfaceLight
                inputSection.BorderSizePixel = 0
                inputSection.Parent = contentArea

                local inputCorner = Instance.new("UICorner")
                inputCorner.CornerRadius = UDim.new(0, 10)
                inputCorner.Parent = inputSection

                local inputStroke = Instance.new("UIStroke")
                inputStroke.Color = Colors.border
                inputStroke.Thickness = 1
                inputStroke.Transparency = 0.5
                inputStroke.Parent = inputSection

                local keyIcon = createIconImage("key", 18, Colors.primary)
                keyIcon.AnchorPoint = Vector2.new(0, 0.5)
                keyIcon.Position = UDim2.new(0, 14, 0.5, 0)
                keyIcon.Parent = inputSection

                local keyInput = Instance.new("TextBox")
                keyInput.Name = "KeyInput"
                keyInput.Size = UDim2.new(1, -50, 1, 0)
                keyInput.Position = UDim2.new(0, 40, 0, 0)
                keyInput.BackgroundTransparency = 1
                keyInput.PlaceholderText = "Enter your verification key"
                keyInput.PlaceholderColor3 = Colors.textMuted
                keyInput.Text = ""
                keyInput.TextColor3 = Colors.textPrimary
                keyInput.TextSize = 14
                keyInput.TextXAlignment = Enum.TextXAlignment.Left
                keyInput.TextTruncate = Enum.TextTruncate.AtEnd
                keyInput.Font = Enum.Font.Gotham
                keyInput.ClearTextOnFocus = false
                keyInput.Parent = inputSection

                local buttonSection = Instance.new("Frame")
                buttonSection.Name = "ButtonSection"
                buttonSection.Size = UDim2.new(1, 0, 0, 40)
                buttonSection.Position = UDim2.new(0, 0, 0, 175)
                buttonSection.BackgroundTransparency = 1
                buttonSection.Parent = contentArea

                local getLinkButton = Instance.new("TextButton")
                getLinkButton.Name = "GetLinkButton"
                getLinkButton.Size = UDim2.new(0.48, 0, 1, 0)
                getLinkButton.Position = UDim2.new(0, 0, 0, 0)
                getLinkButton.BackgroundColor3 = Colors.primary
                getLinkButton.Text = ""
                getLinkButton.Font = Enum.Font.GothamSemibold
                getLinkButton.TextSize = 14
                getLinkButton.BorderSizePixel = 0
                getLinkButton.AutoButtonColor = false
                getLinkButton.Parent = buttonSection

                local getLinkCorner = Instance.new("UICorner")
                getLinkCorner.CornerRadius = UDim.new(0, 10)
                getLinkCorner.Parent = getLinkButton

                local getLinkGradient = Instance.new("UIGradient")
                getLinkGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Colors.primary),
                    ColorSequenceKeypoint.new(1, Colors.primaryDark)
                }
                getLinkGradient.Rotation = 90
                getLinkGradient.Parent = getLinkButton

                local getLinkGlow = Instance.new("UIStroke")
                getLinkGlow.Color = Colors.primaryGlow
                getLinkGlow.Thickness = 0
                getLinkGlow.Transparency = 0.8
                getLinkGlow.Parent = getLinkButton

                local getLinkIcon = createIconImage("link", 16, Color3.fromRGB(255, 255, 255))
                getLinkIcon.AnchorPoint = Vector2.new(0, 0.5)
                getLinkIcon.Position = UDim2.new(0, 12, 0.5, 0)
                getLinkIcon.Parent = getLinkButton

                local getLinkText = Instance.new("TextLabel")
                getLinkText.Name = "ButtonText"
                getLinkText.Size = UDim2.new(1, 0, 1, 0)
                getLinkText.Position = UDim2.new(0, 0, 0, 0)
                getLinkText.BackgroundTransparency = 1
                getLinkText.Text = "Get Link"
                getLinkText.TextColor3 = Color3.fromRGB(255, 255, 255)
                getLinkText.Font = Enum.Font.GothamSemibold
                getLinkText.TextSize = 14
                getLinkText.TextXAlignment = Enum.TextXAlignment.Center
                getLinkText.Parent = getLinkButton

                local verifyButton = Instance.new("TextButton")
                verifyButton.Name = "VerifyButton"
                verifyButton.Size = UDim2.new(0.48, 0, 1, 0)
                verifyButton.Position = UDim2.new(0.52, 0, 0, 0)
                verifyButton.BackgroundColor3 = Colors.success
                verifyButton.BorderSizePixel = 0
                verifyButton.Text = ""
                verifyButton.TextSize = 14
                verifyButton.Font = Enum.Font.GothamSemibold
                verifyButton.AutoButtonColor = false
                verifyButton.Parent = buttonSection

                local verifyCorner = Instance.new("UICorner")
                verifyCorner.CornerRadius = UDim.new(0, 10)
                verifyCorner.Parent = verifyButton

                local verifyGradient = Instance.new("UIGradient")
                verifyGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Colors.success),
                    ColorSequenceKeypoint.new(1, Colors.successDark)
                }
                verifyGradient.Rotation = 90
                verifyGradient.Parent = verifyButton

                local verifyGlow = Instance.new("UIStroke")
                verifyGlow.Color = Colors.successGlow
                verifyGlow.Thickness = 0
                verifyGlow.Transparency = 0.8
                verifyGlow.Parent = verifyButton

                local verifyIcon = createIconImage("check", 16, Color3.fromRGB(255, 255, 255))
                verifyIcon.AnchorPoint = Vector2.new(0, 0.5)
                verifyIcon.Position = UDim2.new(0, 12, 0.5, 0)
                verifyIcon.Parent = verifyButton

                local verifyText = Instance.new("TextLabel")
                verifyText.Name = "ButtonText"
                verifyText.Size = UDim2.new(1, 0, 1, 0)
                verifyText.Position = UDim2.new(0, 0, 0, 0)
                verifyText.BackgroundTransparency = 1
                verifyText.Text = "Verify Key"
                verifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
                verifyText.Font = Enum.Font.GothamSemibold
                verifyText.TextSize = 14
                verifyText.TextXAlignment = Enum.TextXAlignment.Center
                verifyText.Parent = verifyButton

                local statusBar = Instance.new("Frame")
                statusBar.Name = "StatusBar"
                statusBar.Size = UDim2.new(1, -40, 0, 2)
                statusBar.Position = UDim2.new(0.5, 0, 1, -14)
                statusBar.AnchorPoint = Vector2.new(0.5, 0)
                statusBar.BackgroundColor3 = Colors.border
                statusBar.BorderSizePixel = 0
                statusBar.Parent = container

                local statusText = Instance.new("TextLabel")
                statusText.Name = "StatusText"
                statusText.BackgroundTransparency = 1
                statusText.Text = ""
                statusText.TextColor3 = Colors.textSecondary
                statusText.Font = Enum.Font.Gotham
                statusText.TextSize = 12
                statusText.TextXAlignment = Enum.TextXAlignment.Center
                statusText.Size = UDim2.new(1, -40, 0, 20)
                statusText.Position = UDim2.new(0.5, 0, 1, -38)
                statusText.AnchorPoint = Vector2.new(0.5, 0)
                statusText.Visible = false
                statusText.Parent = container

                self.elements = {
                    backdrop = backdrop,
                    container = container,
                    iconFrame = iconFrame,
                    brandLogo = brandLogo,
                    title = titleText,
                    subtitle = subtitleText,
                    getLinkButton = getLinkButton,
                    inputContainer = inputSection,
                    inputFrame = inputSection,
                    keyInput = keyInput,
                    verifyButton = verifyButton,
                    statusBar = statusBar,
                    statusText = statusText,
                    inputStroke = inputStroke,
                    closeButton = closeButton,
                    glassOverlay = glassOverlay,
                    glowFrame = glowFrame
                }

                local function createAmbientParticle()
                    local particle = Instance.new("Frame")
                    particle.Name = "AmbientParticle"
                    particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
                    particle.Position = UDim2.new(math.random(), 0, 1, 0)
                    particle.BackgroundColor3 = Colors.primaryGlow
                    particle.BackgroundTransparency = 0.7
                    particle.BorderSizePixel = 0
                    particle.Parent = container
                    local particleCorner = Instance.new("UICorner")
                    particleCorner.CornerRadius = UDim.new(1, 0)
                    particleCorner.Parent = particle
                    local floatTween = TweenService:Create(particle,
                        TweenInfo.new(math.random(8, 12), Enum.EasingStyle.Linear),
                        {Position = UDim2.new(particle.Position.X.Scale, 0, -0.1, 0), BackgroundTransparency = 1}
                    )
                    floatTween:Play()
                    floatTween.Completed:Connect(function() particle:Destroy() end)
                end

                task.spawn(function()
                    while container and container.Parent do
                        createAmbientParticle()
                        task.wait(math.random(2, 4))
                    end
                end)

                local getLinkStroke = getLinkButton:FindFirstChild("UIStroke")
                if getLinkStroke then getLinkStroke.Name = "GetLinkButtonGlow" end
                local verifyStroke = verifyButton:FindFirstChild("UIStroke")
                if verifyStroke then verifyStroke.Name = "VerifyButtonGlow" end

                local function setupAnimations()
                    local elements = self.elements
                    if elements.closeButton then
                        elements.closeButton.MouseEnter:Connect(function()
                            TweenService:Create(elements.closeButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
                        end)
                        elements.closeButton.MouseLeave:Connect(function()
                            TweenService:Create(elements.closeButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
                        end)
                    end
                    if elements.getLinkButton then
                        elements.getLinkButton.MouseEnter:Connect(function()
                            TweenService:Create(elements.getLinkButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.primaryGlow, Size = UDim2.new(0.48, 2, 1, 2), Position = UDim2.new(0, -1, 0, -1)}):Play()
                            local glow = elements.getLinkButton:FindFirstChild("GetLinkButtonGlow")
                            if glow then TweenService:Create(glow, TweenInfo.new(0.2), {Thickness = 2, Transparency = 0.3}):Play() end
                        end)
                        elements.getLinkButton.MouseLeave:Connect(function()
                            TweenService:Create(elements.getLinkButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.primary, Size = UDim2.new(0.48, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}):Play()
                            local glow = elements.getLinkButton:FindFirstChild("GetLinkButtonGlow")
                            if glow then TweenService:Create(glow, TweenInfo.new(0.2), {Thickness = 0, Transparency = 0.8}):Play() end
                        end)
                        elements.getLinkButton.MouseButton1Down:Connect(function()
                            TweenService:Create(elements.getLinkButton, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(0.47, 0, 0.95, 0), Position = UDim2.new(0.005, 0, 0.025, 0)}):Play()
                        end)
                        elements.getLinkButton.MouseButton1Up:Connect(function()
                            TweenService:Create(elements.getLinkButton, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(0.48, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}):Play()
                        end)
                    end
                    if elements.verifyButton then
                        elements.verifyButton.MouseEnter:Connect(function()
                            TweenService:Create(elements.verifyButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.successGlow, Size = UDim2.new(0.48, 2, 1, 2), Position = UDim2.new(0.52, -1, 0, -1)}):Play()
                            local glow = elements.verifyButton:FindFirstChild("VerifyButtonGlow")
                            if glow then TweenService:Create(glow, TweenInfo.new(0.2), {Thickness = 2, Transparency = 0.3}):Play() end
                        end)
                        elements.verifyButton.MouseLeave:Connect(function()
                            TweenService:Create(elements.verifyButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.success, Size = UDim2.new(0.48, 0, 1, 0), Position = UDim2.new(0.52, 0, 0, 0)}):Play()
                            local glow = elements.verifyButton:FindFirstChild("VerifyButtonGlow")
                            if glow then TweenService:Create(glow, TweenInfo.new(0.2), {Thickness = 0, Transparency = 0.8}):Play() end
                        end)
                        elements.verifyButton.MouseButton1Down:Connect(function()
                            TweenService:Create(elements.verifyButton, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(0.47, 0, 0.95, 0), Position = UDim2.new(0.525, 0, 0.025, 0)}):Play()
                        end)
                        elements.verifyButton.MouseButton1Up:Connect(function()
                            TweenService:Create(elements.verifyButton, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(0.48, 0, 1, 0), Position = UDim2.new(0.52, 0, 0, 0)}):Play()
                        end)
                    end
                    if elements.keyInput and elements.inputStroke then
                        elements.keyInput.Focused:Connect(function()
                            TweenService:Create(elements.inputStroke, TweenInfo.new(0.2), {Color = Colors.primary, Thickness = 2, Transparency = 0}):Play()
                        end)
                        elements.keyInput.FocusLost:Connect(function()
                            TweenService:Create(elements.inputStroke, TweenInfo.new(0.2), {Color = Colors.border, Thickness = 1, Transparency = 0.5}):Play()
                        end)
                    end
                end

                local function animateEntrance()
                    local c = self.elements.container
                    local b = self.elements.backdrop
                    if c then
                        c.BackgroundTransparency = 1
                        TweenService:Create(c, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
                    end
                    if b then
                        b.BackgroundTransparency = 1
                        TweenService:Create(b, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.4}):Play()
                    end
                end

                self.gui.Parent = game:GetService("CoreGui")
                self.gui.AncestryChanged:Connect(function(_, parent)
                    if parent == nil then
                        local bl = Lighting:FindFirstChild("JunkieUIBlur")
                        if bl then bl:Destroy() end
                    end
                end)

                self.showSuccess = function(self, message)
                    if not self.elements then return end
                    local cont = self.elements.container
                    local loadingOverlay = cont:FindFirstChild("LoadingOverlay")
                    if loadingOverlay then
                        local mainContainer = loadingOverlay:FindFirstChild("MainContainer")
                        local spinnerContainer = mainContainer and mainContainer:FindFirstChild("SpinnerContainer")
                        local loadingText = mainContainer and mainContainer:FindFirstChild("LoadingText")
                        local hintText = mainContainer and mainContainer:FindFirstChild("HintText")
                        if spinnerContainer then
                            TweenService:Create(spinnerContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                            for _, child in ipairs(spinnerContainer:GetChildren()) do
                                if child:IsA("Frame") then
                                    TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                                    local stroke = child:FindFirstChildOfClass("UIStroke")
                                    if stroke then TweenService:Create(stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play() end
                                end
                            end
                            task.wait(0.25)
                            local checkmarkContainer = Instance.new("Frame")
                            checkmarkContainer.Name = "CheckmarkContainer"
                            checkmarkContainer.BackgroundTransparency = 1
                            checkmarkContainer.Size = UDim2.new(1, 0, 1, 0)
                            checkmarkContainer.Position = UDim2.new(0, 0, 0, 0)
                            checkmarkContainer.Parent = mainContainer
                            local successCircle = Instance.new("Frame")
                            successCircle.Name = "SuccessCircle"
                            successCircle.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
                            successCircle.BackgroundTransparency = 1
                            successCircle.Size = UDim2.new(0, 80, 0, 80)
                            successCircle.Position = UDim2.new(0.5, 0, 0, 20)
                            successCircle.AnchorPoint = Vector2.new(0.5, 0)
                            successCircle.Parent = checkmarkContainer
                            local successCorner = Instance.new("UICorner")
                            successCorner.CornerRadius = UDim.new(1, 0)
                            successCorner.Parent = successCircle
                            local checkmark = Instance.new("TextLabel")
                            checkmark.Name = "Checkmark"
                            checkmark.BackgroundTransparency = 1
                            checkmark.Size = UDim2.new(1, 0, 1, 0)
                            checkmark.Position = UDim2.new(0, 0, 0, -4)
                            checkmark.Font = Enum.Font.GothamBold
                            checkmark.Text = "✓"
                            checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
                            checkmark.TextSize = 0
                            checkmark.TextTransparency = 1
                            checkmark.Parent = successCircle
                            TweenService:Create(successCircle, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15, Size = UDim2.new(0, 90, 0, 90)}):Play()
                            task.wait(0.15)
                            TweenService:Create(checkmark, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 52, TextTransparency = 0}):Play()
                        end
                        if loadingText then
                            task.wait(0.1)
                            loadingText.Text = message or "Verified!"
                            loadingText.TextColor3 = Color3.fromRGB(34, 197, 94)
                        end
                        if hintText then
                            hintText.Text = "Starting script"
                            hintText.TextColor3 = Color3.fromRGB(34, 197, 94)
                        end
                    end
                    task.wait(0.8)
                end

                self.updateStatus = function(self, message, color, duration)
                    local st = self.elements.statusText
                    local sb = self.elements.statusBar
                    if st then
                        st.Text = message
                        st.TextColor3 = color or Colors.textSecondary
                        st.Visible = true
                        if sb then TweenService:Create(sb, TweenInfo.new(0.2), {BackgroundColor3 = color or Colors.border, Size = UDim2.new(1, -40, 0, 3)}):Play() end
                        if duration and duration > 0 then
                            task.delay(duration, function()
                                if st and st.Text == message then
                                    st.Visible = false
                                    if sb then TweenService:Create(sb, TweenInfo.new(0.2), {BackgroundColor3 = Colors.border, Size = UDim2.new(1, -40, 0, 2)}):Play() end
                                end
                            end)
                        end
                    end
                end

                self.setButtonLoading = function(self, button, text, loading)
                    local buttonText = button:FindFirstChild("ButtonText")
                    if loading then
                        if buttonText then buttonText.Text = text end
                        button.Interactable = false
                        local spinner = button:FindFirstChild("LoadingSpinner")
                        if not spinner then
                            spinner = Instance.new("Frame")
                            spinner.Name = "LoadingSpinner"
                            spinner.Size = UDim2.new(0, 14, 0, 14)
                            spinner.Position = UDim2.new(0, 12, 0.5, -7)
                            spinner.BackgroundColor3 = Colors.textPrimary
                            spinner.BackgroundTransparency = 0.7
                            spinner.BorderSizePixel = 0
                            spinner.Parent = button
                            local spinnerCorner = Instance.new("UICorner")
                            spinnerCorner.CornerRadius = UDim.new(1, 0)
                            spinnerCorner.Parent = spinner
                            TweenService:Create(spinner, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):Play()
                        end
                    else
                        if buttonText then buttonText.Text = text end
                        button.Interactable = true
                        local spinner = button:FindFirstChild("LoadingSpinner")
                        if spinner then spinner:Destroy() end
                    end
                end

                self.shakeInput = function(self)
                    local frame = self.elements.inputFrame
                    if not frame then return end
                    local orig = frame.Position
                    for i = 1, 3 do
                        TweenService:Create(frame, TweenInfo.new(0.05), {Position = UDim2.new(orig.X.Scale, orig.X.Offset - 8, orig.Y.Scale, orig.Y.Offset)}):Play()
                        task.wait(0.05)
                        TweenService:Create(frame, TweenInfo.new(0.05), {Position = UDim2.new(orig.X.Scale, orig.X.Offset + 8, orig.Y.Scale, orig.Y.Offset)}):Play()
                        task.wait(0.05)
                    end
                    frame.Position = orig
                end

                self.animateSuccess = function(self)
                    local iconF = self.elements.iconFrame
                    if iconF then
                        TweenService:Create(iconF, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 62, 0, 62), Position = UDim2.new(0.5, -31, 0, -5)}):Play()
                        task.wait(0.2)
                        TweenService:Create(iconF, TweenInfo.new(0.2), {Size = UDim2.new(0, 52, 0, 52), Position = UDim2.new(0.5, -26, 0, 0)}):Play()
                    end
                end

                self.close = function(self)
                    if not self.gui then return end
                    getgenv().UI_CLOSED = true
                    local c = self.elements.container
                    local b = self.elements.backdrop
                    local bl = Lighting:FindFirstChild("JunkieUIBlur")
                    TweenService:Create(c, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    task.wait(0.2)
                    if bl then bl:Destroy() end
                    self.gui:Destroy()
                    self.gui = nil
                end

                self.setLoadingState = function(self, isLoading, message)
                    if not self.elements then return end
                    local cont = self.elements.container
                    local inputFrame = self.elements.inputFrame
                    local vBtn = self.elements.verifyButton
                    local glBtn = self.elements.getLinkButton
                    local iconF = self.elements.iconFrame
                    local titleL = self.elements.title
                    local subtitleL = self.elements.subtitle

                    if isLoading then
                        if inputFrame then inputFrame.Visible = false end
                        if vBtn then vBtn.Visible = false end
                        if glBtn then glBtn.Visible = false end
                        if iconF then iconF.Visible = false end
                        if titleL then titleL.Visible = false end
                        if subtitleL then subtitleL.Visible = false end

                        local loadingOverlay = cont:FindFirstChild("LoadingOverlay")
                        if not loadingOverlay then
                            loadingOverlay = Instance.new("Frame")
                            loadingOverlay.Name = "LoadingOverlay"
                            loadingOverlay.BackgroundTransparency = 1
                            loadingOverlay.Size = UDim2.new(1, 0, 1, 0)
                            loadingOverlay.Position = UDim2.new(0, 0, 0, 0)
                            loadingOverlay.ZIndex = 100
                            loadingOverlay.Parent = cont

                            local mainContainer = Instance.new("CanvasGroup")
                            mainContainer.Name = "MainContainer"
                            mainContainer.BackgroundTransparency = 1
                            mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
                            mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
                            mainContainer.Size = UDim2.new(0, 280, 0, 200)
                            mainContainer.Parent = loadingOverlay

                            local spinnerContainer = Instance.new("Frame")
                            spinnerContainer.Name = "SpinnerContainer"
                            spinnerContainer.BackgroundTransparency = 1
                            spinnerContainer.AnchorPoint = Vector2.new(0.5, 0)
                            spinnerContainer.Position = UDim2.new(0.5, 0, 0, 20)
                            spinnerContainer.Size = UDim2.new(0, 80, 0, 80)
                            spinnerContainer.Parent = mainContainer

                            local bgCircle = Instance.new("Frame")
                            bgCircle.Name = "BgCircle"
                            bgCircle.BackgroundTransparency = 1
                            bgCircle.Size = UDim2.new(1, 0, 1, 0)
                            bgCircle.ZIndex = 2
                            bgCircle.Parent = spinnerContainer
                            local bgStroke = Instance.new("UIStroke")
                            bgStroke.Color = Colors.accent
                            bgStroke.Thickness = 4
                            bgStroke.Transparency = 0.85
                            bgStroke.Parent = bgCircle
                            local bgCorner = Instance.new("UICorner")
                            bgCorner.CornerRadius = UDim.new(1, 0)
                            bgCorner.Parent = bgCircle

                            local arcCircle = Instance.new("Frame")
                            arcCircle.Name = "ArcCircle"
                            arcCircle.BackgroundTransparency = 1
                            arcCircle.Size = UDim2.new(1, 0, 1, 0)
                            arcCircle.ZIndex = 3
                            arcCircle.Parent = spinnerContainer
                            local arcStroke = Instance.new("UIStroke")
                            arcStroke.Color = Colors.accent
                            arcStroke.Thickness = 4
                            arcStroke.Transparency = 0
                            arcStroke.Parent = arcCircle
                            local arcCorner = Instance.new("UICorner")
                            arcCorner.CornerRadius = UDim.new(1, 0)
                            arcCorner.Parent = arcCircle
                            local arcGradient = Instance.new("UIGradient")
                            arcGradient.Transparency = NumberSequence.new({
                                NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 0),
                                NumberSequenceKeypoint.new(0.7, 0.3), NumberSequenceKeypoint.new(0.85, 0.7),
                                NumberSequenceKeypoint.new(1, 1)
                            })
                            arcGradient.Rotation = 0
                            arcGradient.Parent = arcStroke

                            TweenService:Create(spinnerContainer, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):Play()
                            task.spawn(function()
                                while loadingOverlay and loadingOverlay.Parent do
                                    arcGradient.Rotation = (arcGradient.Rotation + 8) % 360
                                    task.wait(0.03)
                                end
                            end)

                            local loadingText = Instance.new("TextLabel")
                            loadingText.Name = "LoadingText"
                            loadingText.BackgroundTransparency = 1
                            loadingText.AnchorPoint = Vector2.new(0.5, 0)
                            loadingText.Position = UDim2.new(0.5, 0, 0, 130)
                            loadingText.Size = UDim2.new(1, 0, 0, 25)
                            loadingText.Font = Enum.Font.GothamBold
                            loadingText.Text = message or "Loading information"
                            loadingText.TextColor3 = Colors.textPrimary
                            loadingText.TextSize = 16
                            loadingText.Parent = mainContainer

                            local hintText = Instance.new("TextLabel")
                            hintText.Name = "HintText"
                            hintText.BackgroundTransparency = 1
                            hintText.AnchorPoint = Vector2.new(0.5, 0)
                            hintText.Position = UDim2.new(0.5, 0, 0, 160)
                            hintText.Size = UDim2.new(1, 0, 0, 20)
                            hintText.Font = Enum.Font.Gotham
                            hintText.Text = "Please wait a moment"
                            hintText.TextColor3 = Colors.textSecondary
                            hintText.TextSize = 12
                            hintText.TextTransparency = 0.3
                            hintText.Parent = mainContainer

                            TweenService:Create(hintText, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.6}):Play()

                            task.spawn(function()
                                local dots = 0
                                while loadingOverlay and loadingOverlay.Parent do
                                    dots = (dots % 3) + 1
                                    if loadingText and loadingText.Parent then
                                        loadingText.Text = (message or "Loading information") .. string.rep(".", dots)
                                    end
                                    task.wait(0.5)
                                end
                            end)

                            mainContainer.GroupTransparency = 1
                            TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
                        end
                        loadingOverlay.Visible = true
                    else
                        if inputFrame then inputFrame.Visible = true end
                        if vBtn then vBtn.Visible = true end
                        if glBtn then glBtn.Visible = true end
                        if iconF then iconF.Visible = true end
                        if titleL then titleL.Visible = true end
                        if subtitleL then subtitleL.Visible = true end
                        local loadingOverlay = cont:FindFirstChild("LoadingOverlay")
                        if loadingOverlay then loadingOverlay:Destroy() end
                    end
                end

                setupAnimations()
                animateEntrance()

                self.createToast = function(message, duration, toastType)
                    duration = duration or 3
                    toastType = toastType or "info"
                    local toast = Instance.new("Frame")
                    toast.Name = "Toast"
                    toast.Size = UDim2.new(0, 0, 0, 50)
                    toast.Position = UDim2.new(1, -20, 1, -20)
                    toast.AnchorPoint = Vector2.new(1, 1)
                    toast.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    toast.BorderSizePixel = 0
                    toast.ZIndex = 10000
                    toast.Parent = self.gui
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 10)
                    corner.Parent = toast
                    local icon = Instance.new("TextLabel")
                    icon.Name = "Icon"
                    icon.Size = UDim2.new(0, 40, 1, 0)
                    icon.Position = UDim2.new(0, 0, 0, 0)
                    icon.BackgroundTransparency = 1
                    icon.Font = Enum.Font.SourceSansBold
                    icon.TextSize = 20
                    icon.ZIndex = toast.ZIndex + 1
                    if toastType == "loading" then icon.Text = "⏳"
                    elseif toastType == "success" then icon.Text = "✓" icon.TextColor3 = Color3.fromRGB(76, 175, 80)
                    else icon.Text = "ℹ️" icon.TextColor3 = Color3.fromRGB(66, 165, 245) end
                    icon.Parent = toast
                    local text = Instance.new("TextLabel")
                    text.Name = "Text"
                    text.Size = UDim2.new(1, -50, 1, 0)
                    text.Position = UDim2.new(0, 40, 0, 0)
                    text.BackgroundTransparency = 1
                    text.Font = Enum.Font.GothamMedium
                    text.TextSize = 14
                    text.TextColor3 = Color3.fromRGB(230, 230, 230)
                    text.Text = message
                    text.TextXAlignment = Enum.TextXAlignment.Left
                    text.TextYAlignment = Enum.TextYAlignment.Center
                    text.TextTruncate = Enum.TextTruncate.AtEnd
                    text.ZIndex = toast.ZIndex + 1
                    text.Parent = toast
                    local textService = game:GetService("TextService")
                    local textBounds = textService:GetTextSize(message, text.TextSize, text.Font, Vector2.new(300, 50))
                    local targetWidth = math.min(math.max(textBounds.X + 60, 200), 350)
                    TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, targetWidth, 0, 50), Position = UDim2.new(1, -20, 1, -20)}):Play()
                    if toastType ~= "loading" then
                        task.delay(duration, function()
                            if toast and toast.Parent then
                                local fadeOut = TweenService:Create(toast, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 1, -20), BackgroundTransparency = 1})
                                TweenService:Create(icon, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                                TweenService:Create(text, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                                fadeOut:Play()
                                fadeOut.Completed:Connect(function() toast:Destroy() end)
                            end
                        end)
                    end
                    return toast
                end

                return self.gui
            end
        end
    end

    local UI = {}
    UI.__index = UI

    function UI.new(options)
        local self = setmetatable({}, UI)
        self.options = options or {}
        self.title = self.options.title or "Key Verification System"
        self.subtitle = self.options.subtitle or "Powered by Junkie Development"
        self.description = self.options.description or "Please complete the key verification to continue"
        self.lastRequestTime = 0
        self.requestCooldown = 15
        self.maxAttempts = 5
        self.currentAttempts = 0
        self.player = Players.LocalPlayer
        self.gui = nil
        self.hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        self._connections = {}
        return self
    end

    UI.createUI = function(self)
        local UIFactory = loadUIFactory()
        if UIFactory then
            local uiBuilder = UIFactory(Colors, Players, TweenService, UserInputService, Lighting)
            if uiBuilder then
                uiBuilder(self)
            else
                error("UI builder initialization failed")
                return
            end
        else
            error("Failed to load UI factory")
            return
        end

        if self.elements and self.elements.closeButton then
            table.insert(self._connections, self.elements.closeButton.MouseButton1Click:Connect(function()
                self:close()
            end))
        end
        if self.elements and self.elements.getLinkButton then
            table.insert(self._connections, self.elements.getLinkButton.MouseButton1Click:Connect(function()
                self:handleGetLink()
            end))
        end
        if self.elements and self.elements.verifyButton then
            table.insert(self._connections, self.elements.verifyButton.MouseButton1Click:Connect(function()
                self:handleVerifyKey()
            end))
        end
        if self.elements and self.elements.keyInput then
            table.insert(self._connections, self.elements.keyInput.FocusLost:Connect(function(enterPressed)
                if enterPressed then self:handleVerifyKey() end
            end))
        end

        return self.gui
    end

    function UI:close()
        getgenv().UI_CLOSED = true
        for _, conn in ipairs(self._connections or {}) do
            pcall(function() conn:Disconnect() end)
        end
        self._connections = {}
        if self.gui then self.gui:Destroy() end
        return getgenv().SCRIPT_KEY
    end

    function UI:handleGetLink()
        local secureGetKeyLink = Junkie.get_key_link()
        if not secureGetKeyLink then
            self:updateStatus("System not initialized", Colors.error, 3)
            return
        end
        local link = secureGetKeyLink
        if link then
            if setclipboard then
                setclipboard(link)
                self:updateStatus("Link copied to clipboard!", Colors.success, 3)
            else
                self:updateStatus("Get link: " .. link, Colors.primary, 10)
            end
        else
            self:updateStatus("Failed to get link", Colors.error, 3)
        end
    end

    function UI:handleVerifyKey()
        local key = self.elements.keyInput.Text:gsub("%s+", "")
        if key == "" then
            self:updateStatus("Please enter a key", Colors.error, 3)
            self:shakeInput()
            return
        end
        if self.setButtonLoading then
            self:setButtonLoading(self.elements.verifyButton, "Verifying", true)
        end
        self:updateStatus("Verifying...", Colors.primary, 0)
        if self.elements.keyInput.Interactable ~= nil then
            self.elements.keyInput.Interactable = false
        end
        local result = Junkie.check_key(key)
        if result and result.valid then
            saveVerifiedKey(key)
            self:updateStatus("Key verified!", Colors.success, 0)
            if self.animateSuccess then self:animateSuccess() end
            task.wait(1.5)
            getgenv().SCRIPT_KEY = key
            self:close()
            return
        else
            self:updateStatus("Invalid key", Colors.error, 3)
            if self.shakeInput then self:shakeInput() end
            if self.setButtonLoading then
                self:setButtonLoading(self.elements.verifyButton, "Verify Key", false)
            end
            if self.elements.keyInput.Interactable ~= nil then
                self.elements.keyInput.Interactable = true
            end
        end
    end

    local ui = UI.new({
        title = "Ghxst Hub",
        subtitle = "Basketball Legends | by @wrl11 & @aylonthegiant"
    })
    ui:createUI()

    if ui.setLoadingState then
        ui:setLoadingState(true, "Checking verification...")
    end

    local savedKey = loadVerifiedKey()
    local keyToCheck = savedKey
    if not keyToCheck then keyToCheck = getgenv().SCRIPT_KEY end

    local result = Junkie.check_key(keyToCheck)
    if result and result.valid then
        if result.message == "KEYLESS" then
            if ui.showSuccess then ui:showSuccess("Keyless Mode ✓") end
            getgenv().SCRIPT_KEY = "KEYLESS"
            if ui.close then ui:close() end
            return
        end
        if result.message == "KEY_VALID" then
            if not savedKey and keyToCheck then saveVerifiedKey(keyToCheck) end
            if ui.showSuccess then
                local successMsg = savedKey and "Saved Key Verified ✓" or "Key Verified ✓"
                ui:showSuccess(successMsg)
            end
            getgenv().SCRIPT_KEY = keyToCheck
            if ui.close then ui:close() end
            return
        end
        if savedKey and not result.key_valid then clearSavedKey() end
    end

    if ui.setLoadingState then ui:setLoadingState(false) end

    while not getgenv().UI_CLOSED do
        task.wait(0.1)
    end
    return getgenv().SCRIPT_KEY
end)()

-- ============================================================
-- ONLY LOADS THE MAIN SCRIPT IF KEY WAS VERIFIED
-- ============================================================
if not keyResult then
    warn("[Ghxst Hub] Key verification was cancelled or failed. Script will not load.")
    return
end

-- ============================================================
-- MAIN SCRIPT - GHXST HUB
-- ============================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local cloneref = cloneref or function(v) return v end
local player = Players.LocalPlayer
local Char = player.Character or player.CharacterAdded:Wait()
local Hum = cloneref(Char:WaitForChild("Humanoid")) or cloneref(Char:FindFirstChild("Humanoid"))
local Hrp = cloneref(Char:WaitForChild("HumanoidRootPart")) or cloneref(Char:FindFirstChild("HumanoidRootPart"))

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "Ghxst Hub",
    Footer = "by @wrl11 & @aylonthegiant | discord.gg/epNcR8Ce89",
    NotifySide = "Right",
    ShowCustomCursor = false,
})

local Tabs = {
    Main = Window:AddTab("Main", "house"),
    Player = Window:AddTab("Player", "user"),
    Misc = Window:AddTab("Misc", "settings"),
    ["UI Settings"] = Window:AddTab("UI Settings", "monitor"),
}

local function IsPark()
    if workspace:WaitForChild("Game"):FindFirstChild("Courts") then
        return true
    else
        return false
    end
end

local isPark = IsPark()
local ShootingGroup = Tabs.Main:AddLeftGroupbox("Auto Green", "target")
local GuardGroup = Tabs.Main:AddRightGroupbox("Ai Guard", "shield")
local ReboundGroup = Tabs.Main:AddLeftGroupbox("Auto Rebound & Steal", "backpack")
local PostGroup = Tabs.Main:AddRightGroupbox("Post Aimbot", "rotate-cw")
local SpeedGroup = Tabs.Player:AddLeftGroupbox("Speed Boost", "zap")
local MiscGroup = Tabs.Misc:AddLeftGroupbox("Visuals", "eye")
local AnimationGroup = Tabs.Misc:AddRightGroupbox("Animation Changer", "play")
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

local visualGui = player.PlayerGui:WaitForChild("Visual")
local shootingElement = visualGui:WaitForChild("Shooting")
local Shoot = ReplicatedStorage.Packages.Knit.Services.ControlService.RE.Shoot

local autoShootEnabled = false
local autoGuardEnabled = false
local autoGuardToggleEnabled = false
local holdingG = false
local speedBoostEnabled = false
local postAimbotEnabled = false

local desiredSpeed = 30
local predictionTime = 0.3
local guardDistance = 10
local shootPower = 0.8
local postActivationDistance = 10

local visibleConn = nil
local autoGuardConnection = nil
local speedBoostConnection = nil
local postAimbotConnection = nil
local lastPositions = {}

local postHoldActive = false
local lastPostUpdate = 0
local POST_UPDATE_INTERVAL = 0.033

ShootingGroup:AddToggle("AutoShoot", {
    Text = "Auto Time",
    Default = false,
    Tooltip = "Automatically shoots with perfect timing",
    Callback = function(value)
        autoShootEnabled = value
        if autoShootEnabled then
            if not visibleConn then
                visibleConn = shootingElement:GetPropertyChangedSignal("Visible"):Connect(function()
                    if autoShootEnabled and shootingElement.Visible == true then
                        task.wait(0.25)
                        Shoot:FireServer(shootPower)
                    end
                end)
            end
        else
            if visibleConn then
                visibleConn:Disconnect()
                visibleConn = nil
            end
        end
    end
})

ShootingGroup:AddSlider("ShootTiming", {
    Text = "Shot Timing",
    Default = 80,
    Min = 50,
    Max = 100,
    Rounding = 0,
    Tooltip = "Adjust the timing of the shot (80 = Mediocre, 90 = Good, 95 = Great, 100 = Perfect)",
    Callback = function(value)
        shootPower = value / 100
    end
})

ShootingGroup:AddLabel("Shot Timing Guide:\n80 = Mediocre\n90 = Good\n95 = Great\n100 = Perfect", true)

local function getPlayerFromModel(model)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character == model then return plr end
    end
    return nil
end

local function isOnDifferentTeam(otherModel)
    local otherPlayer = getPlayerFromModel(otherModel)
    if not otherPlayer then return false end
    if not player.Team or not otherPlayer.Team then return otherPlayer ~= player end
    return player.Team ~= otherPlayer.Team
end

local function findPlayerWithBall()
    if isPark then
        local closestPlayer = nil
        local closestDistance = math.huge
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model ~= player.Character then
                local tool = model:FindFirstChild("Basketball")
                if tool and tool:IsA("Tool") then
                    local hrp = model.HumanoidRootPart
                    local dist = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < closestDistance then
                        closestDistance = dist
                        closestPlayer = model
                    end
                end
            end
        end
        if closestPlayer then return closestPlayer, closestPlayer:FindFirstChild("HumanoidRootPart") end
        return nil, nil
    end

    local looseBall = workspace:FindFirstChild("Basketball")
    if looseBall and looseBall:IsA("BasePart") then
        local closestPlayer = nil
        local closestDistance = math.huge
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model ~= player.Character then
                if isOnDifferentTeam(model) then
                    local rootPart = model:FindFirstChild("HumanoidRootPart")
                    local distance = (looseBall.Position - rootPart.Position).Magnitude
                    if distance < closestDistance and distance < 15 then
                        closestDistance = distance
                        closestPlayer = model
                    end
                end
            end
        end
        if closestPlayer then return closestPlayer, closestPlayer:FindFirstChild("HumanoidRootPart") end
    end

    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model ~= player.Character then
            if isOnDifferentTeam(model) then
                local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
                local basketball = model:FindFirstChild("Basketball")
                if basketball and basketball:IsA("Tool") then return model, humanoidRootPart end
            end
        end
    end
    return nil, nil
end

local function getClosestOpponent()
    local char = player.Character
    if not char then return nil end
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local closest, minDist = nil, postActivationDistance
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if isOnDifferentTeam(plr.Character) then
                local enemyRoot = plr.Character.HumanoidRootPart
                local dist = (enemyRoot.Position - myRoot.Position).Magnitude
                if dist < minDist then
                    closest = enemyRoot
                    minDist = dist
                end
            end
        end
    end
    return closest
end

local function playerHasBall()
    local char = player.Character
    if not char then return false end
    local basketballTool = char:FindFirstChild("Basketball")
    return basketballTool and basketballTool:IsA("Tool")
end

local function detectBallHand()
    local char = player.Character
    if not char then return "right" end
    local basketballTool = char:FindFirstChild("Basketball")
    if basketballTool and basketballTool:IsA("Tool") then
        local handle = basketballTool:FindFirstChild("Handle")
        if handle then
            local charRoot = char:FindFirstChild("HumanoidRootPart")
            if charRoot then
                local relativePos = charRoot.CFrame:ToObjectSpace(handle.CFrame)
                if relativePos.X > 0 then return "right" else return "left" end
            end
        end
    end
    return "right"
end

local function executePostAimbot()
    local currentTime = tick()
    if currentTime - lastPostUpdate < POST_UPDATE_INTERVAL then return end
    lastPostUpdate = currentTime
    if not postHoldActive then return end
    local char = player.Character
    if not char then return end
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local hasBall = playerHasBall()
    local target = getClosestOpponent()
    if target then
        local directionToTarget = (target.Position - myRoot.Position).Unit
        local faceTarget = CFrame.new(myRoot.Position, myRoot.Position + directionToTarget)
        if hasBall then
            local ballHand = detectBallHand()
            if ballHand == "left" then
                myRoot.CFrame = faceTarget * CFrame.Angles(0, math.rad(90), 0)
            else
                myRoot.CFrame = faceTarget * CFrame.Angles(0, math.rad(-90), 0)
            end
        else
            myRoot.CFrame = faceTarget
        end
    end
end

PostGroup:AddToggle("PostAimbot", {
    Text = "Post Aimbot",
    Default = false,
    Tooltip = "Automatically face opponents when posting up (detects ball hand)",
    Callback = function(value)
        postAimbotEnabled = value
        if not value then
            postHoldActive = false
            if postAimbotConnection then
                postAimbotConnection:Disconnect()
                postAimbotConnection = nil
            end
        end
    end
}):AddKeyPicker("PostAimbotKey", {
    Default = "P",
    SyncToggleState = false,
    Mode = "Hold",
    Text = "Post Aimbot Key",
    Callback = function(active)
        if not postAimbotEnabled then return end
        postHoldActive = active
        if active and not postAimbotConnection then
            postAimbotConnection = RunService.Heartbeat:Connect(executePostAimbot)
        elseif not active and postAimbotConnection then
            postAimbotConnection:Disconnect()
            postAimbotConnection = nil
        end
    end
})

PostGroup:AddSlider("PostActivationDistance", {
    Text = "Activation Distance",
    Default = 10,
    Min = 5,
    Max = 20,
    Rounding = 0,
    Tooltip = "Maximum distance to detect opponents",
    Callback = function(value)
        postActivationDistance = value
    end
})

PostGroup:AddLabel("Automatically detects which hand\nhas the ball and posts accordingly", true)

local function autoGuard()
    if not autoGuardEnabled then return end
    if Players.LocalPlayer:FindFirstChild("Basketball") then return end
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    local ballCarrier, ballCarrierRoot = findPlayerWithBall()
    if ballCarrier and ballCarrierRoot then
        local distance = (rootPart.Position - ballCarrierRoot.Position).Magnitude
        local currentPos = ballCarrierRoot.Position
        local velocity = Vector3.new(0, 0, 0)
        if lastPositions[ballCarrier] then
            velocity = (currentPos - lastPositions[ballCarrier]) / task.wait()
        end
        lastPositions[ballCarrier] = currentPos
        local predictedPos = currentPos + (velocity * predictionTime * 60)
        local directionToOpponent = (predictedPos - rootPart.Position).Unit
        local defensiveOffset = directionToOpponent * 5
        local defensivePosition = predictedPos - defensiveOffset
        defensivePosition = Vector3.new(defensivePosition.X, rootPart.Position.Y, defensivePosition.Z)
        if distance <= guardDistance then
            humanoid:MoveTo(defensivePosition)
            local VirtualInputManager = game:GetService("VirtualInputManager")
            if distance <= 10 then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            else
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
            end
        else
            local VirtualInputManager = game:GetService("VirtualInputManager")
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end
    else
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
end

GuardGroup:AddToggle("Ai Guard", {
    Text = "Ai Guard",
    Default = false,
    Tooltip = "Enable Ai guard feature (hold G to activate)",
    Callback = function(value)
        autoGuardToggleEnabled = value
        if not value then
            autoGuardEnabled = false
            if autoGuardConnection then
                autoGuardConnection:Disconnect()
                autoGuardConnection = nil
            end
            lastPositions = {}
            local VirtualInputManager = game:GetService("VirtualInputManager")
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end
    end
})

local teleportEnabled = false
local offsetDistance = 3

RunService.RenderStepped:Connect(function()
    if not teleportEnabled then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local closestBall
    local closestDist = math.huge
    local maxDistance = isPark and 100 or math.huge
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "Basketball" then
            local part = child:IsA("BasePart") and child or child:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (part.Position - hrp.Position).Magnitude
                if dist < closestDist and dist <= maxDistance then
                    closestDist = dist
                    closestBall = part
                end
            end
        end
    end
    if closestBall then
        local targetPosition = closestBall.Position + closestBall.CFrame.LookVector * offsetDistance
        hrp.CFrame = CFrame.new(targetPosition)
    end
end)

local function toggleTeleport()
    teleportEnabled = not teleportEnabled
end

ReboundGroup:AddToggle("ReboundAutoSteal", {
    Text = "Auto Rebound & Steal",
    Default = false,
    Tooltip = "Will automatically rebound and steal the ball",
    Callback = function(enabled)
        toggleTeleport(enabled)
    end
}):AddKeyPicker("ReboundAutoStealKey", {
    Default = "T",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Auto Rebound & Steal Key",
    Callback = function(active)
        ReboundGroup:SetToggle("ReboundAutoSteal", active)
    end
})

ReboundGroup:AddSlider("Offset distance", {
    Text = "Rebound & Steal offset distance",
    Default = 0,
    Min = 0,
    Max = 6,
    Rounding = 1,
    Tooltip = "how far ahead of the basketball you will be teleported to",
    Callback = function(value)
        offsetDistance = value
    end
})

local FollowBallCarrierGroup = Tabs.Main:AddLeftGroupbox("Follow Ball Carrier", "users")

local followEnabled = false
local followConnection = nil
local followOffset = 3

local function enableFollowBallCarrier()
    if followEnabled then return end
    followEnabled = true
    followConnection = RunService.Heartbeat:Connect(function()
        if not followEnabled then return end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local ballCarrier, ballCarrierRoot = findPlayerWithBall()
        if ballCarrier and ballCarrierRoot then
            local maxDistance = isPark and 100 or math.huge
            local dist = (hrp.Position - ballCarrierRoot.Position).Magnitude
            if dist <= maxDistance then
                hrp.CFrame = ballCarrierRoot.CFrame * CFrame.new(0, 0, followOffset)
            end
        end
    end)
end

local function disableFollowBallCarrier()
    if not followEnabled then return end
    followEnabled = false
    if followConnection then
        followConnection:Disconnect()
        followConnection = nil
    end
end

FollowBallCarrierGroup:AddToggle("FollowBallCarrier", {
    Text = "Follow Ball Carrier",
    Default = false,
    Tooltip = "Instantly teleports you to whoever has the ball",
    Callback = function(value)
        if value then enableFollowBallCarrier() else disableFollowBallCarrier() end
    end
}):AddKeyPicker("FollowBallCarrierKey", {
    Default = "H",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Follow Ball Carrier Key",
    Callback = function(active)
        FollowBallCarrierGroup:SetToggle("FollowBallCarrier", active)
    end
})

FollowBallCarrierGroup:AddSlider("FollowOffset", {
    Text = "Follow Offset",
    Default = -10,
    Min = -10,
    Max = 10,
    Rounding = 0,
    Tooltip = "Distance in front of the ball carrier",
    Callback = function(value)
        followOffset = value
    end
})

local MagsDist = 30
local magnetEnabled = false
local magnetConnection = nil

local stealReachEnabled = false
local stealReachMultiplier = 1.5
local originalRightArmSize, originalLeftArmSize

local function updateHitboxSizes()
    local char = player.Character
    if not char then return end
    local rightArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand") or char:FindFirstChild("RightLowerArm")
    local leftArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand") or char:FindFirstChild("LeftLowerArm")
    if stealReachEnabled then
        if rightArm then
            if not originalRightArmSize then originalRightArmSize = rightArm.Size end
            rightArm.Size = Vector3.new(originalRightArmSize.X * stealReachMultiplier, originalRightArmSize.Y * stealReachMultiplier, originalRightArmSize.Z * stealReachMultiplier)
            rightArm.Transparency = 1
            rightArm.CanCollide = false
            rightArm.Massless = true
        end
        if leftArm then
            if not originalLeftArmSize then originalLeftArmSize = leftArm.Size end
            leftArm.Size = Vector3.new(originalLeftArmSize.X * stealReachMultiplier, originalLeftArmSize.Y * stealReachMultiplier, originalLeftArmSize.Z * stealReachMultiplier)
            leftArm.Transparency = 1
            leftArm.CanCollide = false
            leftArm.Massless = true
        end
    else
        if rightArm and originalRightArmSize then
            rightArm.Size = originalRightArmSize
            rightArm.Transparency = 0
            rightArm.CanCollide = false
            rightArm.Massless = false
            originalRightArmSize = nil
        end
        if leftArm and originalLeftArmSize then
            leftArm.Size = originalLeftArmSize
            leftArm.Transparency = 0
            leftArm.CanCollide = false
            leftArm.Massless = false
            originalLeftArmSize = nil
        end
    end
end


local Reach = Tabs.Main:AddLeftGroupbox("Reach")

Reach:AddToggle("StealReach", {
    Text = "Steal Reach",
    Default = false,
    Tooltip = "Enable or disable extended reach for stealing",
    Callback = function(value)
        stealReachEnabled = value
        updateHitboxSizes()
    end
})

Reach:AddSlider("StealReachMultiplier", {
    Text = "Steal Reach Multiplier",
    Default = 1.5,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Tooltip = "Adjust how far your reach extends",
    Callback = function(value)
        stealReachMultiplier = value
        if stealReachEnabled then updateHitboxSizes() end
    end
})

local BallMagnetGroup = Tabs.Main:AddRightGroupbox("Ball Magnet")

BallMagnetGroup:AddToggle("BallMagnet", {
    Text = "Ball Magnet",
    Default = false,
    Tooltip = "Automatically magnets you to the basketball",
    Callback = function(value)
        magnetEnabled = value
        if not value and magnetConnection then
            magnetConnection:Disconnect()
            magnetConnection = nil
        end
    end
}):AddKeyPicker("BallMagnetKey", {
    Default = "M",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Ball Magnet Key",
    Callback = function(active)
        BallMagnetGroup:SetToggle("BallMagnet", active)
    end
})

BallMagnetGroup:AddSlider("BallMagnetDistance", {
    Text = "Magnet Distance",
    Default = 30,
    Min = 10,
    Max = 85,
    Rounding = 0,
    Tooltip = "Maximum distance to magnet from",
    Callback = function(value)
        MagsDist = value
    end
})

magnetConnection = RunService.Heartbeat:Connect(function()
    if not magnetEnabled then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Basketball" then
            local dist = (hrp.Position - v.Position).Magnitude
            if dist <= MagsDist then
                local touch = v:FindFirstChildOfClass("TouchTransmitter")
                if not touch then
                    for _, d in ipairs(v:GetDescendants()) do
                        if d:IsA("TouchTransmitter") then touch = d break end
                    end
                end
                if touch then
                    firetouchinterest(hrp, v, 0)
                    firetouchinterest(hrp, v, 1)
                end
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.G and not gameProcessed then
        if autoGuardToggleEnabled then
            holdingG = true
            autoGuardEnabled = true
            lastPositions = {}
            if not autoGuardConnection then
                autoGuardConnection = RunService.Heartbeat:Connect(autoGuard)
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.G then
        holdingG = false
        autoGuardEnabled = false
        if autoGuardConnection then
            autoGuardConnection:Disconnect()
            autoGuardConnection = nil
        end
        lastPositions = {}
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
end)

GuardGroup:AddLabel("Hold G to activate Ai guard\n(toggle must be enabled)", true)

GuardGroup:AddSlider("GuardDistance", {
    Text = "Guard Distance",
    Default = 10,
    Min = 5,
    Max = 20,
    Rounding = 0,
    Tooltip = "Maximum distance to start guarding",
    Callback = function(value)
        guardDistance = value
    end
})

GuardGroup:AddSlider("PredictionTime", {
    Text = "Prediction Time",
    Default = 0.3,
    Min = 0.1,
    Max = 0.8,
    Rounding = 1,
    Tooltip = "How far ahead to predict opponent movement (seconds)",
    Callback = function(value)
        predictionTime = value
    end
})

GuardGroup:AddLabel("Auto Guard will predict opponent\nmovement and position defensively\nin front of them while holding F.", true)

local function startCFrameSpeed(speed)
    local connection
    connection = RunService.RenderStepped:Connect(function(deltaTime)
        local character = player.Character
        if not character then return end
        local root = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not root or not humanoid then return end
        local moveVec = humanoid.MoveDirection
        if moveVec.Magnitude > 0 then
            local speedDelta = math.max(speed - humanoid.WalkSpeed, 0)
            root.CFrame = root.CFrame + (moveVec.Unit * speedDelta * deltaTime)
        end
    end)
    return function()
        if connection then connection:Disconnect() end
    end
end

SpeedGroup:AddToggle("SpeedBoost", {
    Text = "Speed Boost",
    Default = false,
    Tooltip = "Enable or disable speed boost (CFrame method)",
    Callback = function(value)
        speedBoostEnabled = value
        if value then
            if speedBoostConnection then speedBoostConnection() end
            speedBoostConnection = startCFrameSpeed(desiredSpeed)
        else
            if speedBoostConnection then speedBoostConnection() end
            speedBoostConnection = nil
        end
    end
})

SpeedGroup:AddSlider("SpeedAmount", {
    Text = "Speed Amount",
    Default = 16,
    Min = 16,
    Max = 23,
    Rounding = 1,
    Tooltip = "Adjust the speed boost amount",
    Callback = function(value)
        desiredSpeed = value
        if speedBoostEnabled then
            if speedBoostConnection then speedBoostConnection() end
            speedBoostConnection = startCFrameSpeed(desiredSpeed)
        end
    end
})

local function setBGVisibleToTrue()
    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = model.HumanoidRootPart
            for _, obj in pairs(humanoidRootPart:GetDescendants()) do
                if obj.Name == "BG" and obj:IsA("BodyGyro") then
                    obj.Parent = humanoidRootPart
                    obj.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                    obj.P = 9e4
                    obj.D = 500
                    obj.CFrame = humanoidRootPart.CFrame
                end
            end
        end
    end
end

local function hideBG()
    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = model.HumanoidRootPart
            for _, obj in pairs(humanoidRootPart:GetDescendants()) do
                if obj.Name == "BG" and obj:IsA("BodyGyro") then obj.Parent = nil end
            end
        end
    end
end

MiscGroup:AddToggle("ShowBG", {
    Text = "Show BodyGyro",
    Default = false,
    Tooltip = "Makes BodyGyro visible for all players",
    Callback = function(value)
        if value then setBGVisibleToTrue() else hideBG() end
    end
})

local AnimationsFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animations_R15")
local selectedDunkAnim = "Default"
local selectedEmoteAnim = "Dance_Casual"
local animationSpoofEnabled = false
local dunkSpoofConnection = nil
local emoteSpoofConnection = nil
local charAddedConnDunk = nil
local charAddedConnEmote = nil

local EmoteAnimations = {
    Default = "Dance_Casual", Dance_Sturdy = "Dance_Sturdy", Dance_Taunt = "Dance_Taunt",
    Dance_TakeFlight = "Dance_TakeFlight", Dance_Flex = "Dance_Flex", Dance_Bat = "Dance_Bat",
    Dance_Twist = "Dance_Twist", Dance_Griddy = "Dance_Griddy", Dance_Dab = "Dance_Dab",
    Dance_Drake = "Dance_Drake", Dance_Fresh = "Dance_Fresh", Dance_Hype = "Dance_Hype",
    Dance_Spongebob = "Dance_Spongebob", Dance_Backflip = "Dance_Backflip", Dance_L = "Dance_L",
    Dance_Facepalm = "Dance_Facepalm", Dance_Bow = "Dance_Bow"
}

local emoteOptions = {}
for key, _ in pairs(EmoteAnimations) do table.insert(emoteOptions, key) end
table.sort(emoteOptions)

local function setupDunkSpoof(humanoid)
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    return animator.AnimationPlayed:Connect(function(track)
        if animationSpoofEnabled and track.Animation.Name == "Dunk_Default" and selectedDunkAnim ~= "Default" then
            track:Stop()
            local customAnim = AnimationsFolder:FindFirstChild("Dunk_" .. selectedDunkAnim)
            if customAnim then humanoid:LoadAnimation(customAnim):Play() end
        end
    end)
end

local function setupEmoteSpoof(humanoid)
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    return animator.AnimationPlayed:Connect(function(track)
        if animationSpoofEnabled and track.Animation.Name == "Dance_Casual" and selectedEmoteAnim ~= "Dance_Casual" then
            track:Stop()
            local customAnim = AnimationsFolder:FindFirstChild(selectedEmoteAnim)
            if customAnim then humanoid:LoadAnimation(customAnim):Play() end
        end
    end)
end

local function enableAnimationSpoof()
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if dunkSpoofConnection then dunkSpoofConnection:Disconnect() end
            if emoteSpoofConnection then emoteSpoofConnection:Disconnect() end
            dunkSpoofConnection = setupDunkSpoof(humanoid)
            emoteSpoofConnection = setupEmoteSpoof(humanoid)
        end
    end
    if charAddedConnDunk then charAddedConnDunk:Disconnect() end
    if charAddedConnEmote then charAddedConnEmote:Disconnect() end
    charAddedConnDunk = player.CharacterAdded:Connect(function(newChar)
        local humanoid = newChar:WaitForChild("Humanoid")
        if dunkSpoofConnection then dunkSpoofConnection:Disconnect() end
        dunkSpoofConnection = setupDunkSpoof(humanoid)
    end)
    charAddedConnEmote = player.CharacterAdded:Connect(function(newChar)
        local humanoid = newChar:WaitForChild("Humanoid")
        if emoteSpoofConnection then emoteSpoofConnection:Disconnect() end
        emoteSpoofConnection = setupEmoteSpoof(humanoid)
    end)
end

local function disableAnimationSpoof()
    if dunkSpoofConnection then dunkSpoofConnection:Disconnect() dunkSpoofConnection = nil end
    if emoteSpoofConnection then emoteSpoofConnection:Disconnect() emoteSpoofConnection = nil end
    if charAddedConnDunk then charAddedConnDunk:Disconnect() charAddedConnDunk = nil end
    if charAddedConnEmote then charAddedConnEmote:Disconnect() charAddedConnEmote = nil end
end

AnimationGroup:AddToggle("AnimationSpoof", {
    Text = "Animation Changer",
    Default = false,
    Tooltip = "Enable animation spoofing for dunks and emotes",
    Callback = function(value)
        animationSpoofEnabled = value
        if value then enableAnimationSpoof() else disableAnimationSpoof() end
    end
})

AnimationGroup:AddDropdown("DunkSpoof", {
    Values = {"Default", "Testing", "Testing2", "Reverse", "360", "Testing3", "Tomahawk", "Windmill"},
    Default = 1,
    Multi = false,
    Text = "Dunk Animation",
    Tooltip = "Change your dunk animation",
    Callback = function(value) selectedDunkAnim = value end
})

AnimationGroup:AddDropdown("EmoteSpoof", {
    Values = emoteOptions,
    Default = 1,
    Multi = false,
    Text = "Emote Animation",
    Tooltip = "Change your emote/dance animation",
    Callback = function(value) selectedEmoteAnim = EmoteAnimations[value] end
})

local Http = (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or (request) or (http_request)
local placesList = {}
local loadingPlaces = false
local TeleporterGroup = Tabs.Misc:AddLeftGroupbox("Teleporter", "move")

local PlaceDropdown = TeleporterGroup:AddDropdown("TeleportPlace", {
    Values = {"Loading places..."},
    Default = 1,
    Multi = false,
    Text = "Select Place",
    Tooltip = "Choose a place to teleport to"
})

local function loadPlaces()
    if loadingPlaces then return end
    loadingPlaces = true
    if not Http then
        PlaceDropdown:SetValues({"Current Place"})
        placesList["Current Place"] = game.PlaceId
        loadingPlaces = false
        return
    end
    local universeId = game.GameId
    local url = "https://develop.roblox.com/v1/universes/" .. universeId .. "/places?limit=100"
    local success, response = pcall(function()
        return Http({
            Url = url, Method = "GET",
            Headers = {["User-Agent"] = "Roblox/WinInet", ["Content-Type"] = "application/json"}
        })
    end)
    if success and response and response.Body then
        local decodeSuccess, data = pcall(function() return HttpService:JSONDecode(response.Body) end)
        if decodeSuccess and data and data.data then
            for _, place in ipairs(data.data) do
                if place.name and place.id then
                    local displayName = place.name
                    if place.isRootPlace then displayName = displayName .. " (Root)" end
                    placesList[displayName] = place.id
                end
            end
        end
    end
    local placeNames = {}
    for name, _ in pairs(placesList) do table.insert(placeNames, name) end
    table.sort(placeNames)
    if #placeNames > 0 then
        PlaceDropdown:SetValues(placeNames)
        PlaceDropdown:SetValue(placeNames[1])
    else
        PlaceDropdown:SetValues({"Current Place"})
        placesList["Current Place"] = game.PlaceId
    end
    loadingPlaces = false
end

task.spawn(loadPlaces)

TeleporterGroup:AddButton({
    Text = "Teleport",
    Func = function()
        local selected = Options.TeleportPlace.Value
        local placeId = placesList[selected]
        if placeId then
            Library:Notify({Title = "Teleporting", Description = "Teleporting to " .. selected .. "...", Time = 3})
            TeleportService:Teleport(placeId)
        end
    end,
    Tooltip = "Teleport to selected place"
})

TeleporterGroup:AddButton({
    Text = "Rejoin Current Server",
    Func = function()
        Library:Notify({Title = "Rejoining", Description = "Rejoining current server...", Time = 3})
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end,
    Tooltip = "Rejoin your current server"
})

TeleporterGroup:AddButton({
    Text = "Server Hop",
    Func = function()
        Library:Notify({Title = "Server Hopping", Description = "Finding best server...", Time = 3})
        local servers = {}
        local cursor = ""
        repeat
            local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. cursor
            local success, result = pcall(function() return game:HttpGet(url) end)
            if success then
                local decoded = HttpService:JSONDecode(result)
                cursor = decoded.nextPageCursor or ""
                for _, server in pairs(decoded.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server)
                    end
                end
            else break end
        until cursor == ""
        if #servers > 0 then
            table.sort(servers, function(a, b) return a.playing < b.playing end)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id, player)
        else
            Library:Notify({Title = "Server Hop Failed", Description = "No available servers found", Time = 3})
        end
    end,
    Tooltip = "Join the server with the least players"
})

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value) Library.KeybindFrame.Visible = value end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = false,
    Callback = function(Value) Library.ShowCustomCursor = Value end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",
    Text = "Notification Side",
    Callback = function(Value) Library:SetNotifySide(Value) end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "DPI Scale",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "LeftControl",
    NoUI = true,
    Text = "Menu keybind"
})

MenuGroup:AddButton("Unload", function() Library:Unload() end)

Library.ToggleKeybind = Options.MenuKeybind

MenuGroup:AddDivider()
MenuGroup:AddLabel("ThemeManager", true)
MenuGroup:AddLabel("SaveManager", true)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("GhxstHub")
SaveManager:SetFolder("GhxstHub/configs")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

Library:OnUnload(function()
    Library.Unloaded = true
    if visibleConn then visibleConn:Disconnect() end
    if autoGuardConnection then autoGuardConnection:Disconnect() end
    if speedBoostConnection then speedBoostConnection() end
    if magnetConnection then magnetConnection:Disconnect() end
    if postAimbotConnection then postAimbotConnection:Disconnect() end
    disableAnimationSpoof()
end)
