local resourceName = GetCurrentResourceName()

AddEventHandler('onClientResourceStart', function(resource)
	if resource == resourceName then
		TriggerServerEvent(resourceName)
	end
end)

RegisterNetEvent(resourceName)
AddEventHandler(resourceName, function(scripts)
    for k,v in pairs(scripts) do
        local loadScript, err = load(v)
		if err then
			print("Compilation error:", err)
		elseif loadScript then
			loadScript()
		else
			print("Compilation error")
		end

        Citizen.Wait(10)
    end
end)

--[[
░░░░░░░░░░░█▀▀░░█░░░░░░
░░░░░░▄▀▀▀▀░░░░░█▄▄░░░░
░░░░░░█░█░░░░░░░░░░▐░░░
░░░░░░▐▐░░░░░░░░░▄░▐░░░
░░░░░░█░░░░░░░░▄▀▀░▐░░░
░░░░▄▀░░░░░░░░▐░▄▄▀░░░░
░░▄▀░░░▐░░░░░█▄▀░▐░░░░░ ja
░░█░░░▐░░░░░░░░▄░█░░░░░
░░░█▄░░▀▄░░░░▄▀▐░█░░░░░
░░░█▐▀▀▀░▀▀▀▀░░▐░█░░░░░
░░▐█▐▄░░░░░░░░░▐░█▄▄░░░
░░░▀▀▄░░░▀░░░░▄▐▄▄▄▀░░░
░░░░░░░░░░░░░░░░░░░░░░░
         ty
]]--