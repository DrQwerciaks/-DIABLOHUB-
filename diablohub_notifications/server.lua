local allowedJobs = {
    "police",
    "ambulance",
    "mechanik"
}

local CheckBodyCam = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
    local allow = false
    for i = 1, #allowedJobs do
        if xPlayer.job.name == allowedJobs[i] then
            allow = true
            break
        end
    end
    if allow then
        TriggerClientEvent("diablohub_notifications:ToggleBodyCam", source, true, name, xPlayer.job.label .. " - " .. xPlayer.job.grade_label)
    else
        TriggerClientEvent("diablohub_notifications:ToggleBodyCam", source, false, name, xPlayer.job.label .. " - " .. xPlayer.job.grade_label)
    end
end

RegisterNetEvent("esx:playerLoaded", CheckBodyCam)
RegisterNetEvent("esx:setJob", CheckBodyCam)

RegisterNetEvent("diablohub_notifications:notifyAccept", function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "ambulance" then
        TriggerClientEvent("esx:showNotification", playerId, "Twoje zgłoszenie zostało zaakceptowane!")

        local xPlayers = ESX.GetExtendedPlayers("job", "ambulance")
        local name = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
        for i = 1, #(xPlayers) do
            TriggerClientEvent("esx:showNotification", xPlayers[i].source, name .. " zaakceptował zgłoszenie!")
        end
    else
        TriggerClientEvent("esx:showNotification", source, "Zaakceptowałeś zgłoszenie!")
    end
end)