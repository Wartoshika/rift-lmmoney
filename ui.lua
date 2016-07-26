local context, frame

-- init funktion
function LmMoney.Ui.init(addon)

    -- context und frames zusammenbauen
    context = UI.CreateContext("LmMoneyContext")
    frame = UI.CreateFrame("Mask", "LmMoneyFrame", context)

    -- farben setzen
    frame:SetBackgroundColor(0, 0, 0, .7)
    frame:SetWidth(115)
    frame:SetHeight(25)

    -- punkt setzen
    local offset = LmMoney.Options.windowPosition
    frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", offset.x, offset.y)

    -- events setzen
    LmMoney.Ui.addEvents()
end

-- events setzen
function LmMoney.Ui.addEvents()

    -- drag drop aktiv?
    local dragDrop = false

    -- beginnen von drag drop
    function frame:RightDown()

        dragDrop = true
    end

    -- beenden von drag drop
    function frame:RightUp()

        dragDrop = false
    end

    -- fuehrt den drag and drop aus
    function frame:MouseMove()

        -- nur wenn dragDrop aktiv ist
        if not dragDrop then return end

        -- maus position holen
        local maus = Inspect.Mouse()

        -- position anpassen
        frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", maus.x, maus.y)

        -- position speichern
        LmMoney.Options.windowPosition = {
            x = maus.x,
            y = maus.y
        }

    end

end