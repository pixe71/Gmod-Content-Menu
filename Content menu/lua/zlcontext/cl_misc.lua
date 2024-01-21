--[[------------------------------
    FONTS GENERAL
--------------------------------]]
surface.CreateFont("ZLContext:Buttons", {
    font = "Inria Sans Light",
    size = RX(30),  
    weight = RX(500),
    antialias = true,
    shadow = false
})

surface.CreateFont("ZLContext:Affichages", {
    font = "Inria Sans Light",
    size = RX(120),  
    weight = RX(1000),
    antialias = true,
    shadow = false
})

surface.CreateFont("ZLContext:Labels", {
    font = "Inria Sans Light",
    size = RX(30),  
    weight = RX(1000),
    antialias = true,
    shadow = false
})

surface.CreateFont("ZLContext:Ban", {
    font = "Inria Sans Light",
    size = RX(20),  
    weight = RX(1000),
    antialias = true,
    shadow = false
})

surface.CreateFont("ZLContext:BanInfo", {
    font = "Inria Sans Light",
    size = RX(15),  
    weight = RX(1000),
    antialias = true,
    shadow = false
})

surface.CreateFont("ZLContext:AffichageLabels", {
    font = "Inria Sans Light",
    size = RX(15),  
    weight = RX(1000),
    antialias = true,
    shadow = false
})

surface.CreateFont("ZLContext:Titre", {
    font = "Inria Sans Light",
    size = RX(30),  
    weight = RX(1000),
    antialias = true,
    shadow = false
})

--[[------------------------------
    ROUNDED LEFT BORDER
--------------------------------]]
function ZLBoxGauche(x, y, largeur, hauteur, couleurBarre, couleurBordure, epaisseurBordure)

    surface.SetDrawColor(couleurBarre.r, couleurBarre.g, couleurBarre.b, couleurBarre.a)
    surface.DrawRect(x, y, largeur, hauteur)
    surface.SetDrawColor(couleurBordure.r, couleurBordure.g, couleurBordure.b, couleurBordure.a)
    surface.DrawRect(x, y, epaisseurBordure, hauteur)
end
--[[------------------------------
    ROUNDED BORDURE BAS
--------------------------------]]
function ZLBoxBas(x, y, largeur, hauteur, couleurBarre, couleurBordure, epaisseurBordure)
    
    surface.SetDrawColor(couleurBarre.r, couleurBarre.g, couleurBarre.b, couleurBarre.a)
    surface.DrawRect(x, y, largeur, hauteur)
    surface.SetDrawColor(couleurBordure.r, couleurBordure.g, couleurBordure.b, couleurBordure.a)
    surface.DrawRect(x, y + hauteur - epaisseurBordure, largeur, epaisseurBordure)
end

--[[------------------------------
    CORNERS 
--------------------------------]]

local COLORS = {
    White_Corners = Color(255, 255, 255, 255)
}

function DrawCorners(x, y, w, h, size)
    surface.SetDrawColor(COLORS["White_Corners"])

   
    surface.DrawLine(x, y, x, y + size)
    surface.DrawLine(x, y, x + size, y)

    
    surface.DrawLine(x + w, y, x + w - size, y)
    surface.DrawLine(x + w, y, x + w, y + size)

    
    surface.DrawLine(x, y + h, x, y + h - size)
    surface.DrawLine(x, y + h, x + size, y + h)

    
    surface.DrawLine(x + w, y + h, x + w - size, y + h)
    surface.DrawLine(x + w, y + h, x + w, y + h - size)
end

--[[--------------------------------------------------
    TOGGLE BUTTON WITH COOKIE SAVE
------------------------------------------------------]]
function CreateToggleButtonWithLabel(parent, x, y, width, height, labelText, onToggle, commandName)
    local isButtonActivated = cookie.GetNumber("ToggleButtonState_" .. commandName, false) == 1

    local Panel = vgui.Create("DPanel", parent)
    Panel:SetPos(x, y)
    Panel:SetSize(RX(140), RY(30))

    local Label = vgui.Create("DLabel", Panel)
    Label:SetPos(10, 5)
    Label:SetFont("ZLContext:AffichageLabels")
    Label:SetSize(RX(85), height)
    Label:SetText(labelText)

    local ToggleButton = vgui.Create("DButton", Panel)
    ToggleButton:SetText("")
    ToggleButton:SetSize(RX(40), height)
    ToggleButton:SetPos(Label:GetWide() + 10, 5)

    ToggleButton.Paint = function(self, w, h)
        local bgColor = isButtonActivated and Color(88, 151, 51, 255) or Color(151, 60, 51, 255)
        draw.RoundedBox(w / 2, 0, 0, w, h, bgColor)

        local sliderWidth = w / 2
        local sliderX = isButtonActivated and w - sliderWidth or 0

        draw.RoundedBox(w / 2, sliderX, 0, sliderWidth, h, Color(60, 60, 60, 255))
    end

    Panel.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 255))
    end

    ToggleButton.DoClick = function()
        isButtonActivated = not isButtonActivated
        cookie.Set("ToggleButtonState_" .. commandName, isButtonActivated and 1 or 0)
        if onToggle then
            onToggle(isButtonActivated)
        end
    end

    return Panel
end