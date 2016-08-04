local addon = ...

-- initialisierung
local function init()

    -- variablen laden
    if LmMoneyGlobal then

        -- variablen laden wenn definiert
        for k,v in pairs(LmMoneyGlobal) do

            -- einzelnd updaten
            LmMoney.Options[k] = v;
        end
    end

    -- fuer die delta berechnung den aktuellen silber wert speichern
    LmMoney.Misc.lastSilverValue = Inspect.Currency.Detail("coin").stack

    -- gui bauen
    LmMoney.Ui.init(addon)

    -- einmal die gui updaten damit die aktuelle silber zahl angezeigt wird
    LmMoney.Ui.update()

    -- events erstellen
    Command.Event.Attach(Event.Currency, LmMoney.Engine.currencyUpdate, "LmMoney.Engine.currencyUpdate")

    -- erfolgreichen start ausgeben
    print("erfolgreich geladen (v " .. addon.toc.Version .. ")")

end

-- wartet bis rift das geldsystem initialisiert hat
function waitForRiftMoneySystem()

    -- geldsystem da?
    if type(Inspect.Currency.Detail("coin")) == "table" and Inspect.Currency.Detail("coin").stack ~= nil then

        -- event entfernen
        Command.Event.Detach(Event.System.Update.End, waitForRiftMoneySystem, "waitForRiftMoneySystem")

        -- initialisieren
        init()        
    end
end

-- speichert die gesetzten optionen
local function saveOptionVariables()

    -- ueberschreiben
    LmMoneyGlobal = LmMoney.Options
end

-- init event binden
Command.Event.Attach(Event.System.Update.End, waitForRiftMoneySystem, "waitForRiftMoneySystem")
Command.Event.Attach(Event.Addon.Shutdown.Begin, saveOptionVariables, "saveOptionVariables")