function OpenChangeNameFrame()
    local changeNameFrame = vgui.Create("DFrame")
    changeNameFrame:SetSize(RX(350), RY(200))
    changeNameFrame:SetPos(RX(650), RY(500))
    changeNameFrame:SetTitle("")
    changeNameFrame:MakePopup()
    changeNameFrame:ShowCloseButton(false)

    changeNameFrame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, ZLibs.ContextColorTable["grisfoncer"])
    end

    local myLabel = vgui.Create("DLabel", changeNameFrame)
    myLabel:SetPos(RX(80), RY(10))
    myLabel:SetSize(RX(250), RY(30))
    myLabel:SetText("Changer de nom")

    myLabel:SetTextColor(Color(255, 255, 255))
    myLabel:SetFont("ZLContext:Titre")

    local nameEntry = vgui.Create("DTextEntry", changeNameFrame)
    nameEntry:SetPos(RX(75), RY(60))
    nameEntry:SetSize(RX(200), RY(30))

    local closeButton = vgui.Create("DButton", changeNameFrame)
    closeButton:SetSize(RX(25), RY(25))
    closeButton:SetPos(RX(320), RY(5))
    closeButton:SetFont("ZLContext:AffichageLabels")  
    closeButton:SetText("X")

    closeButton.Paint = function(self, w, h)
    self:SetTextColor(ZLibs.ContextColorTable["blanc"])
    draw.RoundedBox(0, 0, 0, w, h, ZLibs.ContextColorTable["invisible"]) 
    end

    closeButton.DoClick = function()
        changeNameFrame:Close()  
    end

    local confirmButton = vgui.Create("DButton", changeNameFrame)
    confirmButton:SetPos(RX(95), RY(120))
    confirmButton:SetSize(RX(160), RY(30))
    confirmButton:SetFont("ZLContext:AffichageLabels")  
    confirmButton:SetText("Confirmer")

    confirmButton.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, ZLibs.ContextColorTable["grisclair"])
        self:SetTextColor(ZLibs.ContextColorTable["blanc"])
    end

    confirmButton.DoClick = function()
        local newName = nameEntry:GetValue()
        if newName and newName ~= "" then
            RunConsoleCommand("say", "/name " .. newName)
            changeNameFrame:Close()
        else
            print("Veuillez entrer un nouveau nom.")
        end
    end
end