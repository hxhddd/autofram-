-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.2) 🛑 ]]
local Hub = {}

-- โลาดไลบรารี Fluent UI ของจริงมาสแตนด์บายที่ไฟล์นี้
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local CoreGui = game:GetService("CoreGui")

-- สารบัญรายชื่อโมเดลทั้งหมดในโปรเจกต์ (อนาคตมี model-2, model-3 ก็มาเติมตรงนี้)
local Modules = {
    AutoCollector = "https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"
}

function Hub:Init()
    -- 1. สร้างหน้าต่าง GUI สไตล์โมเดิร์น ขอบโค้งมน ใส่เครดิต By.HxHDDD และเวอร์ชัน
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.2 | By.HxHDDD",
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

    -- 4. ดึงค่าคอนฟิกจากหน้าบ้านมาเสกปุ่มลอยย่อพับอัตโนมัติร่วมกับ Fluent UI
    local Config = _G.ButtonConfig or { button_text = "🔮" }
    Window:MinimizeSettings({
        ChangesText = Config.button_text,
        Color = Color3.fromRGB(30, 30, 35),
        CornerRadius = UDim.new(0, 50) -- ขอบโค้งมนวงกลม
    })
    
    -- ล็อกพิกัดตำแหน่งปุ่มลอยบนหน้าจอมือถือตามที่ตั้งค่าไว้
    local MinimizeButton = CoreGui:FindFirstChild("MinimizeButton", true)
    if MinimizeButton then
        MinimizeButton.Position = UDim2.fromScale(Config.default_pos_x or 0.05, Config.default_pos_y or 0.2)
    end
end

return Hub
