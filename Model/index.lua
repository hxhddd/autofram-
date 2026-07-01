-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v2.0) 🛑 ]]
local Hub = {}

-- ตัวแปรระดับ Global ป้องกันตัววัตถุหลุดจากหน่วยความจำบนอุปกรณ์มือถือ
_G.CollectorInstance = _G.CollectorInstance or nil

function Hub:BuildTabs(WindowInstance)
    -- 1. แตกแท็บฟาร์มหลักจากตัวแปรหน้าต่างที่ส่งมาจากหน้าบ้าน
    local MainTab = WindowInstance:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" })

    -- 2. สร้างออบเจกต์บอทจากคลาส OOP ของโมเดล 1 มารอรับคำสั่งใช้งาน
    pcall(function()
        if not _G.CollectorInstance then
            local AutoCollectorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
            if type(AutoCollectorModule) == "table" and AutoCollectorModule.new then
                _G.CollectorInstance = AutoCollectorModule.new() -- เรียกใช้ .new() ตามโครงสร้างจริงของคุณ
            end
        end
    end)

    -- 3. [แก้ปัญหาบอทเงียบ] เชื่อมสวิตช์ Toggle เข้าหา Method :Start() และ :Stop() ของวัตถุฟาร์มหลักตรงๆ
    MainTab:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if _G.CollectorInstance then
                if Value then
                    _G.CollectorInstance:Start() -- สั่งเริ่มลูปฟาร์มของคุณ
                else
                    _G.CollectorInstance:Stop() -- สั่งหยุดลูปฟาร์มของคุณ
                end
            else
                -- หากเกิดกรณีหลุดจังหวะโหลด ให้สร้างออบเจกต์ใหม่แบบทันทีแล้วสั่งเปิด/ปิด
                local AutoCollectorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
                if AutoCollectorModule and AutoCollectorModule.new then
                    _G.CollectorInstance = AutoCollectorModule.new()
                    if Value then _G.CollectorInstance:Start() else _G.CollectorInstance:Stop() end
                end
            end
        end
    })
end

return Hub
