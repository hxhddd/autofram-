-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.1) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- สารบัญรายชื่อโมเดลทั้งหมดในโปรเจกต์ (ในอนาคตถ้ามี model-2, model-3 ก็มาเติมบรรทัดต่อตรงนี้ได้เลย)
local Modules = {
    AutoCollector = "https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"
}

function Hub:Init()
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.1 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" })
    }

    -- โหลดตรรกะการฟาร์มจากโมดูลกวาดของ (Model-1)
    local AutoCollectorModule = loadstring(game:HttpGet(Modules.AutoCollector))()
    local Collector = AutoCollectorModule.new()

    -- ผูกสวิตช์ปุ่มกดหน้าบ้านเข้ากับระบบกวาดของหลังบ้าน
    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if Value then Collector:Start() else Collector:Stop() end
        end
    })
end

return Hub
