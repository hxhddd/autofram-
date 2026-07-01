-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.6) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- ตัวแปร Global เพื่อเก็บ Object บอทไว้ไม่ให้ถูกลบจากหน่วยความจำ
_G.CollectorInstance = _G.CollectorInstance or nil 

function Hub:StartGui()
    -- 1. สร้างหน้าต่าง GUI โมเดิร์น
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.6 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = { Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" }) }

    -- 2. ดึงตรรกะและสร้าง Object บอทจาก model-1 มารองรับระบบ OOP ของคุณ
    if not _G.CollectorInstance then
        local AutoCollectorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
        if AutoCollectorModule and AutoCollectorModule.new then
            _G.CollectorInstance = AutoCollectorModule.new() -- สร้างตัววัตถุสำเร็จรูปตามโค้ดของคุณ
        end
    end

    -- 3. แก้ปัญหาบอทเงียบ: ผูกปุ่มสวิตช์ Toggle เข้าหา Start/Stop ของเครื่องบอทตรงๆ
    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if _G.CollectorInstance then
                if Value then 
                    _G.CollectorInstance:Start() 
                else 
                    _G.CollectorInstance:Stop() 
                end
            end
        end
    })
    
    return Window -- โยนตัวแปรหน้าต่างที่สร้างเสร็จสมบูรณ์กลับไปให้ปุ่มลอย
end

return Hub
