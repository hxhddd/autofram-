-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.2) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local CoreGui = game:GetService("CoreGui")

-- ลงทะเบียน Path ของโมเดลฟาร์ม
local Modules = {
    AutoCollector = "https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"
}

function Hub:Init()
    -- 1. สร้างหน้าต่าง GUI โมเดิร์นขอบโค้ง
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.2 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = { Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" }) }
    
    -- 2. เรียกโหลดโมดูลกวาดของจาก model-1
    local AutoCollectorModule = loadstring(game:HttpGet(Modules.AutoCollector))()
    local Collector = AutoCollectorModule.new()

    -- 3. สวิตช์ Toggle ควบคุมระบบฟาร์ม
    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if Value then Collector:Start() else Collector:Stop() end
        end
    })

    -- 4. ระบบย่อพับและเรียกใช้ปุ่มลอยอัตโนมัติของ Fluent UI
    -- วิ่งดึงข้อมูลขนาดและข้อความ (🔮) จากตารางหน้าบ้านมาเสกปุ่มร่วมกับระบบย่อพับทันที
    local Config = _G.ButtonConfig or { button_text = "🔮" }
    Window:MinimizeSettings({
        ChangesText = Config.button_text,
        Color = Color3.fromRGB(30, 30, 35),
        CornerRadius = UDim.new(0, 50) -- ใส่ขอบโค้งมนวงกลม By.HxHDDD
    })
    
    -- ล็อกตำแหน่งปุ่มลอยนิ่งๆ บนหน้าจอมือถือตามพิกัดคอนฟิก
    local MinimizeButton = CoreGui:FindFirstChild("MinimizeButton", true)
    if MinimizeButton then
        MinimizeButton.Position = UDim2.fromScale(Config.default_pos_x or 0.05, Config.default_pos_y or 0.2)
    end
end

return Hub
