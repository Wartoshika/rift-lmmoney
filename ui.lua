local context, frame
local money, moneyPlatin, moneyGold, moneySilver, moneyPlatinTexture, moneyGoldTexture, moneySilverTexture
local backgroundTexture, btnReset, btnLock
local _height, _width, _padding = 60, 280, 6

-- init funktion
function LmMoney.Ui.init(addon)

    -- context und frames zusammenbauen
    context = UI.CreateContext("LmMoneyContext")
    frame = UI.CreateFrame("Mask", "LmMoneyFrame", context)
    money = UI.CreateFrame("Mask", "LmMoneyMoneyFrame", context)

    moneyPlatin = UI.CreateFrame("Text", "LmMoneyMoneyPlatinFrame", context)
    moneyGold = UI.CreateFrame("Text", "LmMoneyMoneyGoldFrame", context)
    moneySilver = UI.CreateFrame("Text", "LmMoneyMoneySilverFrame", context)
    moneyPlatinTexture = UI.CreateFrame("Texture", "LmMoneyMoneyPlatinTextureFrame", context)
    moneyGoldTexture = UI.CreateFrame("Texture", "LmMoneyMoneyGoldTextureFrame", context)
    moneySilverTexture = UI.CreateFrame("Texture", "LmMoneyMoneySilverTextureFrame", context)

    -- textures
    backgroundTexture = UI.CreateFrame("Texture", "LmMoneyBackgroundFrame", context)
    btnReset = UI.CreateFrame("Texture", "LmMoneyBtnResetFrame", context)
    btnLock = UI.CreateFrame("Texture", "LmMoneyBtnLockFrame", context)

    -- farben setzen
    frame:SetWidth(_width)
    frame:SetHeight(_height)
    frame:SetLayer(1)
    frame:SetParent(backgroundTexture)
    frame:SetPoint("CENTER", backgroundTexture, "CENTER")

    -- punkt setzen
    local offset = LmMoney.Options.windowPosition
    backgroundTexture:SetPoint("CENTER", UIParent, "TOPLEFT", offset.x, offset.y)
    backgroundTexture:SetWidth(_width)
    backgroundTexture:SetHeight(_height)

    btnReset:SetPoint("CENTERLEFT", backgroundTexture, "CENTERLEFT", 5, 0)
    btnReset:SetHeight(35)
    btnReset:SetWidth(35)
    btnReset:SetParent(backgroundTexture)
    
    btnLock:SetPoint("CENTERLEFT", backgroundTexture, "CENTERLEFT", 45, -2)
    btnLock:SetParent(backgroundTexture)
    btnLock:SetHeight(23)
    btnLock:SetWidth(20)


    -- money frames setzen
    money:SetPoint("CENTER", frame, "CENTER", -10, 6)
    money:SetWidth(_width)
    money:SetLayer(2)
    money:SetParent(frame)

    -- money frames konfigurieren
    moneyPlatin:SetPoint("TOPRIGHT", money, "CENTERRIGHT", -105, (_height / 3.5) * -1)
    moneyPlatin:SetLayer(3)
    moneyPlatin:SetParent(money)
    moneyGold:SetPoint("TOPRIGHT", money, "CENTERRIGHT", -65, (_height / 3.5) * -1)
    moneyGold:SetLayer(3)
    moneyGold:SetParent(money)
    moneySilver:SetPoint("TOPRIGHT", money, "CENTERRIGHT", -25, (_height / 3.5) * -1)
    moneySilver:SetLayer(3)
    moneySilver:SetParent(money)

    -- icons
    moneyPlatinTexture:SetPoint("TOPLEFT", moneyPlatin, "TOPRIGHT", 0, (-3) + _padding/2)
    moneyPlatinTexture:SetTexture("Rift", "coins_platinum.png.dds")
    moneyPlatinTexture:SetHeight(20)
    moneyPlatinTexture:SetWidth(20)
    moneyPlatinTexture:SetLayer(2)
    moneyPlatinTexture:SetParent(moneyPlatin)

    moneyGoldTexture:SetPoint("TOPLEFT", moneyGold, "TOPRIGHT", 0, (-3) + _padding/2)
    moneyGoldTexture:SetTexture("Rift", "coins_gold.png.dds")
    moneyGoldTexture:SetHeight(20)
    moneyGoldTexture:SetWidth(20)
    moneyGoldTexture:SetLayer(2)
    moneyGoldTexture:SetParent(moneyGold)

    moneySilverTexture:SetPoint("TOPLEFT", moneySilver, "TOPRIGHT", 0, (-3) + _padding/2)
    moneySilverTexture:SetTexture("Rift", "coins_silver.png.dds")
    moneySilverTexture:SetHeight(20)
    moneySilverTexture:SetWidth(20)
    moneySilverTexture:SetLayer(2)
    moneySilverTexture:SetParent(moneySilver)

    -- texturen
    backgroundTexture:SetTexture("Rift", "petbar_bg.png.dds")
    btnReset:SetTexture("Rift", "btn_DeleteMail_(normal).png.dds")
    btnLock:SetTexture("Rift", "lock_on.png.dds")

    moneyPlatin:SetText("0")
    moneyGold:SetText("0")
    moneySilver:SetText("0")

    -- events setzen
    LmMoney.Ui.addEvents()
end

-- events setzen
function LmMoney.Ui.addEvents()

    -- drag drop aktiv?
    local dragDrop = false

    -- beginnen von drag drop
    function backgroundTexture.Event:RightDown()

        dragDrop = true
    end

    -- beenden von drag drop
    function backgroundTexture.Event:RightUp()

        dragDrop = false
    end

    -- fuehrt den drag and drop aus
    function backgroundTexture.Event:MouseMove()

        -- nur wenn dragDrop aktiv ist
        if not dragDrop then return end

        -- maus position holen
        local maus = Inspect.Mouse()

        -- position anpassen
        backgroundTexture:SetPoint("CENTER", UIParent, "TOPLEFT", maus.x, maus.y)

        -- position speichern
        LmMoney.Options.windowPosition = {
            x = maus.x,
            y = maus.y
        }

    end

    -- hover events icons
    function btnReset.Event:MouseIn() btnReset:SetTexture("Rift", "btn_DeleteMail_(over).png.dds") end
    function btnReset.Event:MouseOut() btnReset:SetTexture("Rift", "btn_DeleteMail_(normal).png.dds") end
    function btnReset.Event:LeftDown() btnReset:SetTexture("Rift", "btn_DeleteMail_(click).png.dds") end
    function btnReset.Event:LeftUp() btnReset:SetTexture("Rift", "btn_DeleteMail_(over).png.dds") end
    function btnReset.Event:LeftUpoutside() btnReset:SetTexture("Rift", "btn_DeleteMail_(normal).png.dds") end
    function btnReset.Event:LeftClick() LmMoney.Engine.reset() end

    -- lock
    function btnLock.Event:LeftClick() LmMoney.Engine.toggleLockState() end
    
end

-- erneuert die gui
function LmMoney.Ui.update()

    -- lock state?
    local lockTexture = "lock_on.png.dds"
    if not LmMoney.Options.locked then
        lockTexture = "lock_off.png.dds"
    end

    -- textur setzen
    btnLock:SetTexture("Rift", lockTexture)

    -- geld holen
    local platin, gold, silver, negativeIndicator = LmMoney.Engine.silverToMoneyParts(LmMoney.Options.silver)

    -- geld anzeigen
    if negativeIndicator then platin = "- " .. tostring(platin) end

    moneyPlatin:SetText(platin or "0")
    moneyGold:SetText(gold or "0")
    moneySilver:SetText(silver or "0")

end