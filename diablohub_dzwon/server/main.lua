-- 
-- ESX = nil

-- TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)

-- RegisterServerEvent('inter:dzwon')
-- AddEventHandler('inter:dzwon', function(list, damage)	
-- 	local _source = source
-- 	for k,v in pairs(list) do
-- 		TriggerClientEvent('inter:dzwon', v, damage)
-- 	end
	
-- 	TriggerClientEvent('inter:dzwon', _source, damage)
-- end)

RegisterServerEvent('inter:impact')
AddEventHandler('inter:impact', function(list, speedBuffer, velocityBuffer)
	local _source = source
	for k,v in pairs(list) do
		TriggerClientEvent('inter:impact', v, speedBuffer, velocityBuffer)
	end
	
	TriggerClientEvent('inter:impact', _source, speedBuffer, velocityBuffer)
end)