local function DrawPlayerNames()
    for _, ply in pairs(player.GetAll()) do
        if IsValid(ply) and ply:Alive() then
            local pos = ply:GetPos() + Vector(0, 0, 100) 
            local ang = LocalPlayer():EyeAngles()
            ang:RotateAroundAxis(ang:Forward(), 90)
            ang:RotateAroundAxis(ang:Right(), 90)

            cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1) 
                draw.SimpleText(ply:Nick(), "ZLContext:Affichages", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
    end
end

local function DrawPlayerJobs()
    for _, ply in pairs(player.GetAll()) do
        if IsValid(ply) and ply:Alive() then
            local jobName = team.GetName(ply:Team())
            local pos = ply:GetPos() + Vector(0, 0, 80)
            local ang = LocalPlayer():EyeAngles()
            ang:RotateAroundAxis(ang:Forward(), 90)
            ang:RotateAroundAxis(ang:Right(), 90)

            cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1)
                draw.SimpleText(jobName, "ZLContext:Affichages", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
    end
end

local function DrawPlayerStats()
    for _, ply in pairs(player.GetAll()) do
        if IsValid(ply) and ply:Alive() then
            local statsText = "Morts: " .. ply:Deaths() .. "  |  Kills: " .. ply:Frags()
            local pos = ply:GetPos() + Vector(0, 0, 90)
            local ang = LocalPlayer():EyeAngles()
            ang:RotateAroundAxis(ang:Forward(), 90)
            ang:RotateAroundAxis(ang:Right(), 90)

            cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1)
                draw.SimpleText(statsText, "ZLContext:Affichages", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
    end
end


local showPlayerNames = false
local showPlayerJobs = false
local showPlayerStats = false

function AdminsPanel()
    local AdminsPanels = vgui.Create("DFrame")
    AdminsPanels:SetSize(RX(750), RY(380))
    AdminsPanels:SetPos(RX(300), RY(150))
    AdminsPanels:SetTitle("")
    AdminsPanels:MakePopup()
    AdminsPanels:ShowCloseButton(false)

    AdminsPanels.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(33, 33, 33, 255))
        draw.RoundedBox(0, RX(580), RY(75), RX(5), RY(325), Color(50, 50, 50, 255))
        draw.RoundedBox(0, RX(10), RY(70), RX(730), RY(5), Color(50, 50, 50, 255))
    end

    local myLabel = vgui.Create("DLabel", AdminsPanels)
    myLabel:SetPos(RX(275), RY(10))
    myLabel:SetSize(RX(250), RY(30))
    myLabel:SetText("Menu administatif")

    myLabel:SetTextColor(Color(255, 255, 255))
    myLabel:SetFont("ZLContext:Titre")

    local ScrollPanel = vgui.Create("DScrollPanel", AdminsPanels)
    ScrollPanel:SetPos(RX(10), RY(80))
    ScrollPanel:SetSize(RX(160), RY(290))

    local ScrollBar = ScrollPanel:GetVBar()
    ScrollBar:SetWide(RX(13))

    ScrollBar.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(33, 33, 33, 0))
    end

    ScrollBar.btnGrip.Paint = function(self, w, h)
        draw.RoundedBox(4, 5, 0, 5, h, Color(50, 50, 50, 255))
    end

    ScrollBar.btnUp.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 0))
    end

    ScrollBar.btnDown.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 0))
    end

    local ButtonStats = CreateToggleButtonWithLabel(AdminsPanels, RX(600), RY(120), RX(40), RY(20), "Stats", function(activated)
        if activated then
            hook.Add("PostDrawTranslucentRenderables", "DrawPlayerStats", DrawPlayerStats)
        else
            hook.Remove("PostDrawTranslucentRenderables", "DrawPlayerStats")
            render.ClearStencil()
        end
    end, "Commande1")

    local ButtonName = CreateToggleButtonWithLabel(AdminsPanels, RX(600), RY(80), RX(40), RY(20), "Name", function(activated)
        if activated then
            hook.Add("PostDrawTranslucentRenderables", "DrawPlayerNames", DrawPlayerNames)
        else
            hook.Remove("PostDrawTranslucentRenderables", "DrawPlayerNames")
            render.ClearStencil()
        end
    end, "Commande2")

    local ButtonJobs = CreateToggleButtonWithLabel(AdminsPanels, RX(600), RY(160), RX(40), RY(20), "Jobs", function(activated)
        if activated then
            hook.Add("PostDrawTranslucentRenderables", "DrawPlayerJobs", DrawPlayerJobs)    
        else
            hook.Remove("PostDrawTranslucentRenderables", "DrawPlayerJobs")
            render.ClearStencil()
        end
    end, "Commande3")

    local ButtonAdministrations = CreateToggleButtonWithLabel(AdminsPanels, RX(600), RY(200), RX(40), RY(20), "Mode Admins", function(activated)
        if activated then
            RunConsoleCommand("ulx", "noclip")
            RunConsoleCommand("ulx", "cloak")
            RunConsoleCommand("ulx", "god")    
        else
            RunConsoleCommand("ulx", "noclip")
            RunConsoleCommand("ulx", "uncloak")
            RunConsoleCommand("ulx", "ungod")
        end
    end, "Commande4")
    
    
    local closeButton = vgui.Create("DButton", AdminsPanels)
    closeButton:SetSize(RX(25), RY(25))
    closeButton:SetPos(RX(720), RY(5))
    closeButton:SetFont("ZLContext:AffichageLabels") 
    closeButton:SetText("X")

    closeButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(33, 33, 33))
        self:SetTextColor(Color(255, 255, 255))
    end


    closeButton.DoClick = function()
        AdminsPanels:Close()  
    end

    for _, ply in pairs(player.GetAll()) do
        local PlayerButton = vgui.Create("DButton", ScrollPanel)
        PlayerButton:SetText(ply:Nick())
        PlayerButton:SetFont("ZLContext:AffichageLabels") 
        PlayerButton:SetSize(RX(160), RY(30))
        PlayerButton:SetPos(0, (ply:EntIndex() - 1) * 40)

        PlayerButton.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
            self:SetTextColor(Color(255, 255, 255))
        end

        PlayerButton.DoClick = function()
            local Teleporter = vgui.Create("DButton", AdminsPanels)
            Teleporter:SetText("Teleporter")
            Teleporter:SetFont("ZLContext:AffichageLabels")
            Teleporter:SetSize(RX(160), RY(30))
            Teleporter:SetPos(RX(200), RY(80))

            Teleporter.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end

            Teleporter.DoClick = function()
                RunConsoleCommand("ulx", "Teleport", ply:Nick())
            end

            local Goto = vgui.Create("DButton", AdminsPanels)
            Goto:SetText("Goto")
            Goto:SetFont("ZLContext:AffichageLabels")
            Goto:SetSize(RX(160), RY(30))
            Goto:SetPos(RX(400), RY(80))

            Goto.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end

            Goto.DoClick = function()
                RunConsoleCommand("ulx", "goto", ply:Nick())
            end

            local Freeze = vgui.Create("DButton", AdminsPanels)
            Freeze:SetText("Freeze")
            Freeze:SetFont("ZLContext:AffichageLabels")
            Freeze:SetSize(RX(160), RY(30))
            Freeze:SetPos(RX(400), RY(120))
            
            Freeze.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end
            
            local isFrozen = false 
            
            Freeze.DoClick = function()
                local playerName = ply:Nick()
                
                if isFrozen then
                    RunConsoleCommand("ulx", "UnFreeze", playerName)
                    Freeze:SetText("Freeze")
                else
                    RunConsoleCommand("ulx", "Freeze", playerName)
                    Freeze:SetText("Unfreeze")
                end
            
                isFrozen = not isFrozen  
            end
            

            local Spectate = vgui.Create("DButton", AdminsPanels)
            Spectate:SetText("Spectateur")
            Spectate:SetFont("ZLContext:AffichageLabels")
            Spectate:SetSize(RX(160), RY(30))
            Spectate:SetPos(RX(200), RY(120))

            Spectate.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end

            Spectate.DoClick = function()
                RunConsoleCommand("ulx", "Spectate", ply:Nick())
            end

            local Ban = vgui.Create("DButton", AdminsPanels)
            Ban:SetText("Bannir")
            Ban:SetFont("ZLContext:AffichageLabels")
            Ban:SetSize(RX(160), RY(30))
            Ban:SetPos(RX(200), RY(160))

            Ban.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end

            Ban.DoClick = function()
                local steamID = ply:SteamID()
                OpenAdminsBanneFrame(steamID)
            end
            
            local Kick = vgui.Create("DButton", AdminsPanels)
            Kick:SetText("Exclur")
            Kick:SetFont("ZLContext:AffichageLabels")
            Kick:SetSize(RX(160), RY(30))
            Kick:SetPos(RX(400), RY(160))

            Kick.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end

            Kick.DoClick = function()
                RunConsoleCommand("ulx", "Kick", ply:Nick())
            end

            local ZLWarn = vgui.Create("DButton", AdminsPanels)
            ZLWarn:SetText("Warn")
            ZLWarn:SetFont("ZLContext:AffichageLabels")
            ZLWarn:SetSize(RX(160), RY(30))
            ZLWarn:SetPos(RX(400), RY(200))

            ZLWarn.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
                self:SetTextColor(Color(255, 255, 255))
            end

            ZLWarn.DoClick = function()
                if ZLibs.WarnEx then
                    RunConsoleCommand("ulx", ZLibs.WarnEx, ply:Nick())
                    RunConsoleCommand(ZLibs.WarnEx, ply:Nick())
                else
                    print("ZLibs.WarnEx is nil or false.")
                end
            end        
        end
    end
end