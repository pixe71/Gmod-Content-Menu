local frame = nil

local function openmenu()
    frame = vgui.Create("DFrame")
    frame:SetSize(RX(1920), RY(180))
    frame:SetPos(RX(0), RY(0))
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)

    frame.Paint = function(self, w, h)
        ZLBoxBas(RX(0), RY(0), w, h, ZLibs.ContextColorTable["grisfoncer"], ZLibs.ContextColorTable["grisclair"], 10)
    end

    local buttonPanel = vgui.Create("DPanel", frame)
    buttonPanel:Dock(FILL)

    buttonPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, ZLibs.ContextColorTable["invisible"])
    end
    
    local options = {
        {text = "Ticket", command = function() RunConsoleCommand("ticket") end, icon = "materials/images/ticket.png"}, --Remplacer "materials/images/ticket.png" par le chemins de votre images
        {text = "Jeter son arme", command = function() RunConsoleCommand("say", "/drop") end, icon = "materials/images/dropweapons.png"},
        {text = "Changer de nom", command = function() OpenChangeNameFrame() end, icon = "materials/images/name.png"},
        {text = "Stopsound", command = function() RunConsoleCommand("stopsound") end, icon = "materials/images/stopsounds.png"},
        {text = "Discord", command = function() gui.OpenURL("https://www.youtube.com/watch?v=6pOsFzcZi0k") end, icon = "materials/images/discord.png"},
        {text = "Boutique", command = function() gui.OpenURL("https://www.youtube.com/watch?v=6pOsFzcZi0k") end, icon = "materials/images/boutique.png"},
        {text = "Workshop", command = function() gui.OpenURL("https://www.youtube.com/watch?v=6pOsFzcZi0k") end, icon = "materials/images/admins.png"}
    }
    
    local playerRank = LocalPlayer():GetUserGroup()
    
    if ZLibs.AllowedRanks[playerRank] then
        table.insert(options, { text = "Mode Admins", command = function() AdminsPanel() end, icon = "materials/images/admins.png" }) 
    end
    
    local posY = RY(0)
    local posX = RX(270) 
    
    for i, option in ipairs(options) do
        local button = vgui.Create("DButton", buttonPanel)
        button:SetSize(RX(320), RY(40))
        button:SetFont("ZLContext:Buttons")
        button:SetText(option.text)
        button.DoClick = option.command
    
        local iconSize = RY(40)  -- Overall icon size all icons will have this size
        local icon = vgui.Create("DImage", button)
        icon:SetPos(RX(10), RY(2)) -- Positions of icons relative to buttons
        icon:SetSize(iconSize, iconSize)
        icon:SetImage(option.icon) 
    
        button.Paint = function(self, w, h)
            if button:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, ZLibs.ContextColorTable["grisclair"])
                DrawCorners(0, 0, 319, 38, 5)
                button:SetTextColor(ZLibs.ContextColorTable["Bleu"])
            else
                draw.RoundedBox(8, 0, 0, w, h, ZLibs.ContextColorTable["grisclair"])
                button:SetTextColor(ZLibs.ContextColorTable["blanc"])
            end
        end
    
        local label = vgui.Create("DLabel", button)
        label:Dock(FILL)
        label:SetText("")
        label:SetContentAlignment(5) 
        label:SetTextColor(ZLibs.ContextColorTable["blanc"])
    
        button:SetPos(posX, posY)
    
        posY = posY + RY(75)
    
        if i % 2 == 0 then
            posX = posX + RX(350) 
            posY = RY(0) 
        end
    end
end

hook.Add("OnContextMenuOpen", "ZLContextOpen", function()
    openmenu()
    return false
end)

hook.Add("OnContextMenuClose", "ZLContextClose", function ()
    if IsValid(frame) then
        frame:Remove()
    end
    return false
end)