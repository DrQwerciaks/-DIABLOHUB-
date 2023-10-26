RegisterNetEvent('needrp_urzad:zatrudnijSie')
AddEventHandler('needrp_urzad:zatrudnijSie', function(job) 
    if job == 'unemployed' or job == 'sadownik' or job == 'taxi' or job == 'magazynier' then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            xPlayer.setJob(job, 0)
            TriggerClientEvent('esx:showNotification', _source, 'Zatrudniłeś się w nowej pracy!')
        end
    else
        DropPlayer(source, '(needrp_urzad) Wypierdalaj')
    end
end)