-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.8) 🛑 ]]
local Hub = {}

_G.CollectorInstance = _G.CollectorInstance or nil 

function Hub:BuildTabs(WindowInstance, FluentInstance)
    -- 1. สร้างแท็บฟาร์มจากหน้าต่างที่ส่งมาจากหน้าบ้าน
    local MainTab = WindowInstance:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" })

    -- 2. เตรียมสร้างออบเจกต์บอทจากโมดูลฟาร์ม (model-1) มารอไว้เลย
    pcall(function()
        if not _G.CollectorInstance then
            local AutoCollectorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
            if type(AutoCollectorModule) == "table" and AutoCollectorModule.new then
                _G.CollectorInstance = AutoCollectorModule.new()
            end
        end
    end)

    -- 3. ผูกสวิตช์ปุ่มหน้าบ้านเข้ากับคำสั่งฟาร์ม OOP ของคุณตรงๆ ปลอดภัย ไร้ดีเลย์หลุดข้ามสาย
    MainTab:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            if _G.CollectorInstance then
                if Value then 
                    _G.CollectorInstance:Start() 
                else 
                    _G.CollectorInstance:Stop() 
                end
            else
                -- เผื่อกรณีจังหวะโหลดคลาดเคลื่อน ให้ดึงมาสร้างซ้ำทันที
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
