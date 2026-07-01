-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.7) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- ล็อกพื้นที่ความจำระดับ Global ป้องกันตัวแปรถูกทำลายระหว่างรันลูปบนมือถือ
_G.CollectorInstance = _G.CollectorInstance or nil 

function Hub:StartGui()
    -- 1. สร้างหน้าต่าง GUI โมเดิร์น
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.7 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = { Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" }) }

    -- 2. ดาวน์โหลดและสร้าง Instance ของตัวเก็บของตามระบบ OOP ของคุณล่วงหน้า
    pcall(function()
        if not _G.CollectorInstance then
            local AutoCollectorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
            if type(AutoCollectorModule) == "table" and AutoCollectorModule.new then
                _G.CollectorInstance = AutoCollectorModule.new()
            end
        end
    end)

    -- 3. ผูกสวิตช์ Toggle และสั่งกระตุ้นเอนจิ้นฟาร์มหลักผ่าน Thread อิสระไม่ให้ติดขัด
    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            task.spawn(function()
                if _G.CollectorInstance then
                    if Value then 
                        _G.CollectorInstance:Start() 
                    else 
                        _G.CollectorInstance:Stop() 
                    end
                else
                    -- กรณีหลุดจังหวะโหลด ให้พยายามสร้างตัววัตถุซ้ำอีกครั้งแบบทันที
                    local AutoCollectorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
                    if AutoCollectorModule and AutoCollectorModule.new then
                        _G.CollectorInstance = AutoCollectorModule.new()
                        if Value then _G.CollectorInstance:Start() else _G.CollectorInstance:Stop() end
                    end
                end
            end)
        end
    })
    
    return Window
end

return Hub
