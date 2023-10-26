
exports['DiabloHub']:SpawnPed("helka", 'a_m_m_farmer_01', vec4(-1815.4, -1210.36, 12.0206, 119.417328), {
        FreezeEntityPosition = true,
        SetEntityInvincible = true,
        SetBlockingOfNonTemporaryEvents = true,
}, false, false)

-- Citizen.CreateThread(function()

-- 	while true do
-- 		Wait(5)
-- 		local player = PlayerPedId()
-- 		local playerLoc = GetEntityCoords(player)
-- 		if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, Config.LombardCoords.x, Config.LombardCoords.y, Config.LombardCoords.z, true) < 3 then
			
-- 			-- ESX.ShowHelpNotification("Naciśnij ~g~E~w~ aby sprzedać ryby")

-- 			-- if IsControlJustReleased(0, 38) then


-- 				OpenlombardMenu()
				
-- 			end

-- 		-- else	
-- 		-- 	Wait(1000)
-- 		-- end	

		
-- 	end


-- end)

function OpenlombardMenu() 
	local elements = {
		{label = 'Sprzedaj',      value = 'sell'},
	  }
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'lombard',
		{
		  title    = "Sprzedawanie ryb",
		  align    = 'center',
		  elements = elements
		},
		function(data5, menu5)
			if data5.current.value == 'buy' then
				

				local elements = {}
				for i=1, #Config.Lombard["kup"].Items, 1 do
					local item = Config.Lombard["kup"].Items[i]
			

					if item.limit == -1 then
						item.limit = 100
					end
			

					table.insert(elements, {
						label      = item.label .. ' - <span style="color: yellow;">$' .. item.price .. '</span>',
						label_real = item.label,
						item       = item.item,
						price      = item.price,
			
					})
				end
			
			
			
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
					title    = "Lombard - kup",
					align    = 'center',
					elements = elements
				}, function(data, menu)
			
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
						title    = 'Wybierz formę płatności za: '..data.current.item,
						align    = 'center',
						elements = {
							{label = 'Gotówka',  value = 'gotowka'},
							{label = 'Karta', value = 'karta'},
							{label = 'Anuluj zakupy', value = 'niechce'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'gotowka' then
							TriggerServerEvent('woro-lombard:kup', data.current.item, data.current.label_real, data.current.price, true)
						elseif data2.current.value == 'karta' then
							TriggerServerEvent('woro-lombard:kup', data.current.item, data.current.label_real, data.current.price, false)
						elseif data2.current.value == 'niechce' then
							menu2.close()
							menu.open()
						end
						menu2.close()
					end, function(data2, menu2)
						menu2.close()
					end)
					
				end, function(data, menu)
					menu.close()
				end)

			elseif data5.current.value == 'sell' then

				local elements = {}

				ESX.TriggerServerCallback('woro-lombard-sell:getitem', function(items)

					for i=1, #items, 1 do
						local item = items[i]
						table.insert(elements, {
							label      = item.label,
							item       = item.item,
							price      = item.price,
				
						})
					end
					
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
						title    = "Rybak - sprzedaj",
						align    = 'center',
						elements = elements
					}, function(data8, menu8)
				
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
							title    = 'Potwierdź sprzedaz: '..data8.current.item,
							align    = 'center',
							elements = {
								{label = 'Sprzedaj',  value = 'sell'},
								{label = 'Anuluj', value = 'niechce'},
							}
						}, function(data9, menu9)
							if data9.current.value == 'sell' then
				
								TriggerServerEvent('woro-lombard:sprzedaj', data8.current.item, data8.current.label, data8.current.price)
	
							elseif data9.current.value == 'niechce' then
								menu9.close()
								menu8.open()
							end
							menu9.close()
						end, function(data9, menu9)
							menu9.close()
						end)
						
					end, function(data8, menu8)
						menu8.close()
					end)

				end)
			end	
		menu5.close()
		end, function(menu5, menu5)
			menu5.close()
		end)
	  

end


local pedalekworoworo = 'a_m_m_farmer_01'

Citizen.CreateThread(function()
	exports.qtarget:AddTargetModel({pedalekworoworo}, {
		options = {
			{
				event = "need_client:otworzrybaksell",
				icon = "fas fa-shopping-bag",
				label = "Sprzedaj ryby",
			},
		},
		distance = 2.0
	})
end)
	
	
RegisterNetEvent('need_client:otworzrybaksell', function()
	OpenlombardMenu() 
end)
	