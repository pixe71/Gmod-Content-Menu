ZLibs = ZLibs or {}

RX = RX or function(x) return x / 1920 * ScrW() end
RY = RY or function(y) return y / 1080 * ScrH() end

-- List of ranks authorized to see the "Admins Mode" button
ZLibs.AllowedRanks = {
    ["superadmin"] = true,
    ["admin"] = true,
    -- Add other ranks if necessary
}

ZLibs.ContextColorTable = {
    ["grisclair"] = Color(50, 50, 50, 255),
    ["grisfoncer"] = Color(33, 33, 33, 255),
    ["grisfoncer2"] = Color(33, 33, 33, 253),
    ["gristresclair"] = Color(60, 60, 60, 255),
    ["invisible"] = Color(0, 0, 0, 0),
    ["blanc"] = Color(255, 255, 255, 255),
    ["noir"] = Color(0, 0, 0, 255),
    ["Bleu"] = Color(63, 207, 185, 255),
}

ZLibs.WarnEx = "!warns" -- Place your order for the warns menu