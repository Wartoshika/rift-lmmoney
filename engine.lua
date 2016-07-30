-- wird gerufen wenn sich etwas an den waehrungen des spielers veraendert
function LmMoney.Engine.currencyUpdate(_, currencies)
    
    local relevantCurrencies = {
        "coin", "aventurine"
    }
dump(currencies)
    -- nur die interessanten waehrungen nehmen
    for currency, value in pairs(currencies) do

        -- relevant?
        if LmUtils.tableHasValue(relevantCurrencies, currency) then

            -- ja!
            dump(currency, value)
        end
    end

end