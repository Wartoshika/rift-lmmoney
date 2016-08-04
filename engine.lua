-- wird gerufen wenn sich etwas an den waehrungen des spielers veraendert
function LmMoney.Engine.currencyUpdate(_, currencies)

    -- nur pruefen wenn delta berechenbar ist
    if LmMoney.Misc.lastSilverValue == nil then return end

    -- nur die interessanten waehrungen nehmen
    for currency, value in pairs(currencies) do

        -- relevant?
        if currency == "coin" then

            -- es muss die differenz zwischen diesem und dem letzten wert
            -- ermittelt werden
            local delta = tonumber(value) - tonumber(LmMoney.Misc.lastSilverValue)

            -- silver wert fuer naechste pruefung anpassen
            LmMoney.Misc.lastSilverValue = value

            -- wenn das delta negativ ist und der lock aktiv ist dann 
            -- wird das event ignoriert.
            if delta < 0 and LmMoney.Options.locked then return end

            -- delta ist ok, dann dieses speichern
            LmMoney.Options.silver = LmMoney.Options.silver + delta

            -- gui updaten
            LmMoney.Ui.update()
        end
    end

end

-- setzt die aktuell gespeicherte sitzung zurueck
function LmMoney.Engine.reset()

    -- zuruecksetzen
    LmMoney.Options.silver = 0

    -- gui einmal aktuallisieren
    LmMoney.Ui.update()
end

-- toggled den lock status
function LmMoney.Engine.toggleLockState()

    -- invertieren
    LmMoney.Options.locked = not LmMoney.Options.locked

    -- gui einmal aktuallisieren
    LmMoney.Ui.update()
end

-- konvertiert eine silber menge in platin, gold und silber
function LmMoney.Engine.silverToMoneyParts(currnetSilver)

    -- silver einmal string technisch umdrehen
    local silverChk = currnetSilver
    if silverChk < 0 then silverChk = currnetSilver * -1 end
    silverChk = string.reverse(tostring(silverChk))

    -- fuenfte stelle
    local platin = silverChk:sub(5)
    if platin == "" then platin = "0" end

    -- dritte und vierte stelle
    local gold = silverChk:sub(3,4)
    if gold == "" then gold = "0" end

    -- silber, erste und zweite stelle
    local silver = silverChk:sub(1,2)
    if silver == "" then silver = "0" end

    -- alles zusammenpacken
    return platin:reverse(), gold:reverse(), silver:reverse(), tonumber(currnetSilver) < 0
end