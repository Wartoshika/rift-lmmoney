local addon = ...

-- initialisierung
local function init()

    -- nur einmal initialisieren
    Command.Event.Detach(Event.Addon.Load.End, init, "init")

    -- variablen laden
    if LmMoneyGlobal then

        -- variablen laden wenn definiert
        for k,v in pairs(LmMoneyGlobal) do

            -- einzelnd updaten
            LmMoney.Options[k] = v;
        end
    end

    -- gui bauen
    LmMoney.Ui.init(addon)

    -- erfolgreichen start ausgeben
    print("erfolgreich geladen (v " .. addon.toc.Version .. ")")

end

-- init event binden
Command.Event.Attach(Event.Addon.Load.End, init, "init")