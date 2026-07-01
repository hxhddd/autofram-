-- [[ 🛑 โซนที่ 2: Hub Index ศูนย์ควบคุมหลังบ้าน (By.HxHDDD v1.5) 🛑 ]]
local Hub = {}

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

_G.AutoFarmRunning = false -- ตัวแปรสากลคุมสถานะลูปบอท

function Hub:StartGui()
    -- สร้างหน้าต่าง GUI คลีนๆ สไตล์โมเดิร์น
    local Window = Fluent:CreateWindow({
        Title = "Auto Farm Hub",
        SubTitle = "v1.5 | By.HxHDDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = { Main = Window:AddTab({ Title = "ฟาร์มหลัก", Icon = "home" }) }

    -- แก้ปัญหาที่ 2: ผูกสวิตช์เข้ากับโมดูลลูปฟาร์มหลังบ้าน (model-1) ตรงๆ โดยใช้สถานะ True/False
    Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "เปิด Auto Collect (กวาดล้างยกแผง)",
        Default = false,
        Callback = function(Value)
            _G.AutoFarmRunning = Value
            if Value then
                -- ปลุกไฟล์โมดูลฟาร์มหลัก (model-1) ให้ตื่นขึ้นมาทำงาน
                local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hxhddd/autofram-/main/Model/model-1"))()
                task.spawn(function()
                    if type(FarmLogic) == "function" then
                        FarmLogic()
                    elseif type(FarmLogic) == "table" and FarmLogic.Start then
                        FarmLogic:Start()
                    end
                end)
            end
        end
    })
    
    return Window -- โยนสถานะหน้าต่างกลับไปให้โมเดลปุ่มลอย (model-0) ใช้คุมคำสั่งพับจอ
end

return Hub
