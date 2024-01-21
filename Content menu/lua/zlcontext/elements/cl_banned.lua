function OpenAdminsBanneFrame(playerSteamID)
    local Bannedoptions = vgui.Create("DFrame")
    Bannedoptions:SetSize(RX(600), RY(300))
    Bannedoptions:SetPos(RX(650), RY(500))
    Bannedoptions:SetTitle("")
    Bannedoptions:MakePopup()
    Bannedoptions:ShowCloseButton(false)

    Bannedoptions.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, ZLibs.ContextColorTable["grisfoncer"])
        draw.RoundedBox(6, RX(10), RY(70), RX(581), RY(50), ZLibs.ContextColorTable["grisclair"])
        draw.RoundedBox(6, RX(10), RY(169), RX(581), RY(40), ZLibs.ContextColorTable["grisclair"])
    end

    local myLabel = vgui.Create("DLabel", Bannedoptions)
    myLabel:SetPos(RX(230), RY(10))
    myLabel:SetSize(RX(250), RY(30))
    myLabel:SetText("Temps du Ban")

    myLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])
    myLabel:SetFont("ZLContext:Titre")

    local durationLabel = vgui.Create("DLabel", Bannedoptions)
    durationLabel:SetPos(RX(20), RY(90))
    durationLabel:SetSize(RX(150), RY(20))
    durationLabel:SetFont("ZLContext:Ban")
    durationLabel:SetText("Durée du ban :")
    durationLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])
    
    local yearsEntry = vgui.Create("DTextEntry", Bannedoptions)
    yearsEntry:SetPos(RX(140), RY(90))
    yearsEntry:SetSize(RX(50), RY(20))
    local yearsLabel = vgui.Create("DLabel", Bannedoptions)
    yearsLabel:SetPos(RX(140), RY(70))
    yearsLabel:SetSize(RX(50), RY(20))
    yearsLabel:SetFont("ZLContext:BanInfo")
    yearsLabel:SetText("Années")
    yearsLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])

    local weeksEntry = vgui.Create("DTextEntry", Bannedoptions)
    weeksEntry:SetPos(RX(230), RY(90))
    weeksEntry:SetSize(RX(50), RY(20))
    local weeksLabel = vgui.Create("DLabel", Bannedoptions)
    weeksLabel:SetPos(RX(225), RY(70))
    weeksLabel:SetSize(RX(70), RY(20))
    weeksLabel:SetFont("ZLContext:BanInfo")
    weeksLabel:SetText("Semaines")
    weeksLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])

    local daysEntry = vgui.Create("DTextEntry", Bannedoptions)
    daysEntry:SetPos(RX(320), RY(90))
    daysEntry:SetSize(RX(50), RY(20))
    local daysLabel = vgui.Create("DLabel", Bannedoptions)
    daysLabel:SetPos(RX(325), RY(70))
    daysLabel:SetSize(RX(50), RY(20))
    daysLabel:SetFont("ZLContext:BanInfo")
    daysLabel:SetText("Jours")
    daysLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])

    local hoursEntry = vgui.Create("DTextEntry", Bannedoptions)
    hoursEntry:SetPos(RX(410), RY(90))
    hoursEntry:SetSize(RX(50), RY(20))
    local hoursLabel = vgui.Create("DLabel", Bannedoptions)
    hoursLabel:SetPos(RX(410), RY(70))
    hoursLabel:SetSize(RX(50), RY(20))
    hoursLabel:SetFont("ZLContext:BanInfo")
    hoursLabel:SetText("Heures")
    hoursLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])

    local minutesEntry = vgui.Create("DTextEntry", Bannedoptions)
    minutesEntry:SetPos(RX(500), RY(90))
    minutesEntry:SetSize(RX(50), RY(20))
    local minutesLabel = vgui.Create("DLabel", Bannedoptions)
    minutesLabel:SetPos(RX(498), RY(70))
    minutesLabel:SetSize(RX(70), RY(20))
    minutesLabel:SetFont("ZLContext:BanInfo")
    minutesLabel:SetText("Minutes")
    minutesLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])

    local reasonLabel = vgui.Create("DLabel", Bannedoptions)
    reasonLabel:SetPos(RX(20), RY(180))
    reasonLabel:SetSize(RX(150), RY(20))
    reasonLabel:SetFont("ZLContext:Ban")
    reasonLabel:SetText("Raison du ban :")
    reasonLabel:SetTextColor( ZLibs.ContextColorTable["blanc"])

    local reasonEntry = vgui.Create("DTextEntry", Bannedoptions)
    reasonEntry:SetPos(RX(150), RY(180))
    reasonEntry:SetSize(RX(400), RY(20))

    local confirmButton = vgui.Create("DButton", Bannedoptions)
    confirmButton:SetPos(RX(150), RY(250))
    confirmButton:SetSize(RX(280), RY(30))
    confirmButton:SetText("Confirmer")

    confirmButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h,  ZLibs.ContextColorTable["grisclair"])
    end

    confirmButton.DoClick = function()
        local duration = {
            years = tonumber(yearsEntry:GetValue()) or 0,
            weeks = tonumber(weeksEntry:GetValue()) or 0,
            days = tonumber(daysEntry:GetValue()) or 0,
            hours = tonumber(hoursEntry:GetValue()) or 0,
            minutes = tonumber(minutesEntry:GetValue()) or 0
        }

        local totalSeconds = duration.years * 525600 + duration.weeks * 10080 +
        duration.days * 1440 + duration.hours * 60 +
        duration.minutes * 1

        local reason = reasonEntry:GetValue()

        RunConsoleCommand("ulx", "banid", playerSteamID, totalSeconds, reason)
        Bannedoptions:Close()
    end

    local closeButton = vgui.Create("DButton", Bannedoptions)
    closeButton:SetSize(RX(25), RY(25))
    closeButton:SetPos(RX(575), RY(5)) 
    closeButton:SetFont("ZLContext:AffichageLabels") 
    closeButton:SetText("X")

    closeButton.Paint = function(self, w, h)
    draw.RoundedBox(20, 0, 0, w, h, ZLibs.ContextColorTable["grisfoncer"]) 
    self:SetTextColor(ZLibs.ContextColorTable["blanc"])
    end

    closeButton.DoClick = function()
        Bannedoptions:Close()  
    end
end