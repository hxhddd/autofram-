-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.3) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- สารบัญรายชื่อโมเดลทั้งหมดในโปรเจกต์
local Modules = {
    AutoCollector = "https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"
}

function Hub:Init()
    -- 1. สร้างหน้าต่าง GUI สไตล์โมเดิร์น ขอบโค้งมน
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.3 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = { Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" }) }

    -- 2. ดึงตรรกะการฟาร์มมาจากโมดูลหลังบ้าน (model-1)
    local AutoCollectorModule = loadstring(game:HttpGet(Modules.AutoCollector))()
    local Collector = AutoCollectorModule.new()

    -- 3. ผูกสวิตช์ปุ่มกดหน้าบ้านเข้ากับระบบกวาดของหลังบ้าน
    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if Value then Collector:Start() else Collector:Stop() end
        end
    })

    -- 4. ตรรกะเสกปุ่มลอย (🔮) สไตล์โมเดิร์นวงกลม By.HxHDDD (รองรับมือถือ 100%)
    local Config = _G.ButtonConfig or { button_text = "🔮", button_size_x = 50, button_size_y = 50, default_pos_x = 0.05, default_pos_y = 0.2 }
    
    -- ลบปุ่มเก่าทิ้งหากรันซ้ำ
    if CoreGui:FindFirstChild("HxHDDD_FloatUI") then
        CoreGui["HxHDDD_FloatUI"]:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HxHDDD_FloatUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui
    
    local Button = Instance.new("TextButton")
    Button.Name = "MainButton"
    Button.Text = Config.button_text
    Button.Size = UDim2.fromOffset(Config.button_size_x, Config.button_size_y)
    Button.Position = UDim2.fromScale(Config.default_pos_x, Config.default_pos_y)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 22
    Button.Parent = ScreenGui
    
    -- ใส่ขอบโค้งมนให้กลมดิ๊กและขอบม่วงคริสตัล
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 50)
    UICorner.Parent = Button
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(138, 43, 226)
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Button

    -- ตรรกะรองรับการลากย้ายปุ่มไปมาบนจอมือถือได้อย่างอิสระ
    local dragging, dragInput, dragStart, startPos
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Button.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- เมื่อคลิกปุ่มลอย จะไปสั่งย่อ/พับหน้าต่าง Fluent UI ทันที
    Button.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)
end

return Hub
