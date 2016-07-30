local context, frame
local money, moneyPlatin, moneyGold, moneySilver, moneyPlatinTexture, moneyGoldTexture, moneySilverTexture
local aventurine, aventurineTexture
local _height, _width, _padding = 25, 250, 6

-- init funktion
function LmMoney.Ui.init(addon)

    -- context und frames zusammenbauen
    context = UI.CreateContext("LmMoneyContext")
    frame = UI.CreateFrame("Mask", "LmMoneyFrame", context)
    money = UI.CreateFrame("Mask", "LmMoneyMoneyFrame", context)

    aventurine = UI.CreateFrame("Text", "LmMoneyAventurineFrame", context)
    aventurineTexture = UI.CreateFrame("Texture", "LmMoneyAventurineTextureFrame", context)

    moneyPlatin = UI.CreateFrame("Text", "LmMoneyMoneyPlatinFrame", context)
    moneyGold = UI.CreateFrame("Text", "LmMoneyMoneyGoldFrame", context)
    moneySilver = UI.CreateFrame("Text", "LmMoneyMoneySilverFrame", context)
    moneyPlatinTexture = UI.CreateFrame("Texture", "LmMoneyMoneyPlatinTextureFrame", context)
    moneyGoldTexture = UI.CreateFrame("Texture", "LmMoneyMoneyGoldTextureFrame", context)
    moneySilverTexture = UI.CreateFrame("Texture", "LmMoneyMoneySilverTextureFrame", context)

    -- farben setzen
    frame:SetBackgroundColor(0, 0, 0, 1)
    frame:SetWidth(_width)
    frame:SetHeight(_height)
    frame:SetLayer(1)

    -- punkt setzen
    local offset = LmMoney.Options.windowPosition
    frame:SetPoint("CENTER", UIParent, "TOPLEFT", offset.x, offset.y)

    -- money frames setzen
    money:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, (_height / 2.5) * -1)
    money:SetWidth(100)
    money:SetLayer(2)

    -- money frames konfigurieren
    moneyPlatin:SetPoint("TOPRIGHT", money, "CENTERRIGHT", -105, (_height / 3.5) * -1)
    moneyPlatin:SetLayer(3)
    moneyGold:SetPoint("TOPRIGHT", money, "CENTERRIGHT", -65, (_height / 3.5) * -1)
    moneyGold:SetLayer(3)
    moneySilver:SetPoint("TOPRIGHT", money, "CENTERRIGHT", -25, (_height / 3.5) * -1)
    moneySilver:SetLayer(3)

    -- icons
    moneyPlatinTexture:SetPoint("TOPLEFT", moneyPlatin, "TOPRIGHT", 0, (-3) + _padding/2)
    moneyPlatinTexture:SetTexture("Rift", "coins_platinum.png.dds")
    moneyPlatinTexture:SetHeight(_height - _padding)
    moneyPlatinTexture:SetWidth(_height - _padding)
    moneyPlatinTexture:SetLayer(2)

    moneyGoldTexture:SetPoint("TOPLEFT", moneyGold, "TOPRIGHT", 0, (-3) + _padding/2)
    moneyGoldTexture:SetTexture("Rift", "coins_gold.png.dds")
    moneyGoldTexture:SetHeight(_height - _padding)
    moneyGoldTexture:SetWidth(_height - _padding)
    moneyGoldTexture:SetLayer(2)

    moneySilverTexture:SetPoint("TOPLEFT", moneySilver, "TOPRIGHT", 0, (-3) + _padding/2)
    moneySilverTexture:SetTexture("Rift", "coins_silver.png.dds")
    moneySilverTexture:SetHeight(_height - _padding)
    moneySilverTexture:SetWidth(_height - _padding)
    moneySilverTexture:SetLayer(2)

    moneyPlatin:SetText("0")
    moneyGold:SetText("0")
    moneySilver:SetText("0")

    -- aventurine
    aventurine:SetPoint("TOPLEFT", frame, "CENTERLEFT", _height, (_height / 2.5) * -1)
    aventurine:SetText("15")
    aventurine:SetLayer(2)

    -- aventurine icon
    aventurineTexture:SetPoint("TOPLEFT", aventurine, "TOPLEFT", (_height * -1) + _padding, (-3) + _padding/2)
    aventurineTexture:SetTexture("Rift", "Minion_I2C9.dds")
    aventurineTexture:SetHeight(_height - _padding)
    aventurineTexture:SetWidth(_height - _padding)
    aventurineTexture:SetLayer(2)

    -- events setzen
    LmMoney.Ui.addEvents()
end

-- events setzen
function LmMoney.Ui.addEvents()

    -- drag drop aktiv?
    local dragDrop = false

    -- beginnen von drag drop
    function frame.Event:RightDown()

        dragDrop = true
    end

    -- beenden von drag drop
    function frame.Event:RightUp()

        dragDrop = false
    end

    -- fuehrt den drag and drop aus
    function frame.Event:MouseMove()

        -- nur wenn dragDrop aktiv ist
        if not dragDrop then return end

        -- maus position holen
        local maus = Inspect.Mouse()

        -- position anpassen
        frame:SetPoint("CENTER", UIParent, "TOPLEFT", maus.x, maus.y)

        -- position speichern
        LmMoney.Options.windowPosition = {
            x = maus.x,
            y = maus.y
        }

    end

end

-- erneuert die gui
function LmMoney.Ui.update()

end