-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.4) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- สารบัญรายชื่อโมเดลทั้งหมดในโฟลเดอร์หลังบ้าน
local Modules = {
    FloatingButton = "https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-0", -- 👈 ย้ายเข้ามาเรียกในนี้แล้ว!
    AutoCollector = "https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"
}

function Hub:Init()
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.4 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = { Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" }) }

    -- 1. เรียกใช้งานโมเดลฟาร์ม (model-1)
    local AutoCollectorModule = loadstring(game:HttpGet(Modules.AutoCollector))()
    local Collector = AutoCollectorModule.new()

    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if Value then Collector:Start() else Collector:Stop() end
        end
    })

    -- 2. ส่งไม้ต่อให้โมเดลปุ่มลอย (model-0) ทำการสร้างปุ่มและควบคุมระบบย่อพับ
    local FloatingModule = loadstring(game:HttpGet(Modules.FloatingButton))()
    FloatingModule:Create(Window) -- ส่งตัวหน้าต่าง Window ไปให้โมเดลปุ่มใช้สั่งพับหน้าจอ
end

return Hub
