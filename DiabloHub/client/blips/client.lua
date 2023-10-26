local Blipsy                     = {}

local blips = {
	-- Więzienie
	{title="Więzienie", info = 'jail', colour=75, id=188, x=1845.73, y=2585.8, z=45.66, job = false},
	
	{title="Zbiórka jabłek", info = 'apple', colour=1, id=515, x = 408.2787, y = 6497.4033, z = 26.8468, job = false},
	--Kościół
	{title = "Kościół", info = 'church', colour= 66, id = 305, x = -1691.7036, y = -292.7282, z = 40.1296, job = false},
	
	{title="Taxi", info = 'taxi', colour=24, id=410, x = 909.07, y = -166.37, z = 74.3094, job = false},

	
	-- Ubrania
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=72.254,    y=-1399.102, z=28.476, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-703.776,  y=-152.258,  z=36.515, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-167.863,  y=-298.969,  z=38.833, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=428.694,   y=-800.106,  z=28.591, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-829.413,  y=-1073.710, z=10.428, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-1447.797, y=-242.461,  z=48.920, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=11.632,    y=6514.224,  z=30.977, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=123.646,   y=-219.440,  z=53.657, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=1696.291,  y=4829.312,  z=41.163, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=618.093,   y=2759.629,  z=41.188, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=1190.550,  y=2713.441,  z=37.322, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-1193.429, y=-772.262,  z=16.424, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-3172.496, y=1048.133,  z=19.963, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=-1108.441, y=2708.923,  z=18.207, job = false},
	{title="Sklep Odzieżowy", info = 'clothes', colour=47, id=73, size = 0.6, x=1929.3, y=3733.46,  z=32.34, job = false},

	-- Warsztaty													
	{title="Mechanik", info = 'lscustoms', colour=5, id=446, size = 0.6, x = 829.2817, y = -813.0905, z = 25.3826, job = false},

	--Sklepy
	{title = "24/7 Sklep", info = 'shop247', colour=2, id=52, size = 0.6, x = 1962.2119, y = 3741.2075, z = 32.393, job = false},
	{title = "24/7 Sklep", info = 'shop247', colour=2, id=52, size = 0.6, x = 546.6686, y = 2671.1624, z = 42.206, job = false},
	{title = "24/7 Sklep", info = 'shop247', colour=2, id=52, size = 0.6, x = 26.8468, y = -1346.989, z = 29.547, job = false},
	{title = "24/7 Sklep", info = 'shop247', colour=2, id=52, size = 0.6, x = 373.79,  y = 325.87, z = 104.57, job = false},
	{title = "24/7 Sklep", info = 'shop247', colour=2, id=52, size = 0.6, x = 374.8337, y = 325.807, z = 103.616, job = false},

	--Stacje BenzynoweS
    {title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = -48.519,   y = -1757.514, z = 29.521, job = false},
	{title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = 1163.373,  y = -323.801,  z = 69.305, job = false},
	{title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = -707.501,  y = -914.260,  z = 19.315, job = false},
	{title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = -1820.523, y = 792.518,   z = 138.218, job = false},
	{title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = 1698.388,  y = 4924.404,  z = 42.163, job = false},
	{title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = 1728.94,  y = 6414.27,  z = 35.04, job = false},
	{title = "Stacja benzynowa", info = 'stacja', colour=5, id=52, size = 0.6, x = 2557.77,  y = 382.19,  z = 108.62, job = false},

	--Monopolowy
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = 1135.808,  y = -982.281,  z = 46.415, job = false},
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = -1222.915, y = -906.983,  z = 12.326, job = false},
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = -1487.553, y = -379.107,  z = 40.163, job = false},
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = -2968.243, y = 390.910,   z = 15.043, job = false},
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = 1166.024,  y = 2708.930,  z = 38.157, job = false},
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = 1392.562,  y = 3604.684,  z = 34.980, job = false},
	{title = "Monopolowy", info = 'robsliquor', colour=1, id=52, size = 0.6, x = 4493.0278,  y = -4526.0391,  z = 4.5976, job = false},

	--hurtownia
	{title = "Hurtownia", info = 'hurtownia', colour = 6, id = 371, x = 871.3068, y = -1145.8934, z = 25.0395, job = false},
	{title = "Hurtownia", info = 'hurtownia', colour = 6, id = 371, x = 2748.1577, y = 3472.6843, z = 54.7244, job = false},
	{title = "Hurtownia", info = 'hurtownia', colour = 6, id = 371, x = 55.2337, y = -1739.3328, z = 29.6417, job = false},
	{title = "Hurtownia", info = 'hurtownia', colour = 6, id = 371, x = -11.2109, y = 6499.4194, z = 31.4532, job = false},

	--Multimedialny
	-- {title="Multimedialny",	info = 'phone', colour=44, id=52, size = 0.6, x = -1082.0969, y = -247.8591, z = 36.8133, job = false},

	--Boats
	
	{title = 'Łodki LSPD', colour = 63, id = 427, x = -845.7063, y = -1367.4717, z = 0.6552, job = true, praca = 'police'},
	{title = 'Łodki SHERIFF', colour = 63, id = 427, x = -845.7063, y = -1367.4717, z = 0.6552, job = true, praca = 'sheriff'},
	{title = 'Łodki EMS', colour = 63, id = 427, x = -845.7063, y = -1367.4717, z = 0.6552, job = true, praca = 'ambulance'},

	-- {title = 'Łodki LSPD', colour = 63, id = 427, x = 3822.8098, y = 4466.875, z = 2.2463, job = true, praca = 'police'},
	-- {title = 'Łodki SHERIFF', colour = 63, id = 427, x = 3822.8098, y = 4466.875, z = 2.2463, job = true, praca = 'sheriff'},
	-- {title = 'Łodki EMS', colour = 63, id = 427, x = 3822.8098, y = 4466.875, z = 2.2463, job = true, praca = 'ambulance'},
	
	-- {title = 'Łodki LSPD', colour = 63, id = 427, x = -1604.7921, y = 5257.1211, z = 1.1269, job = true, praca = 'police'},
	-- {title = 'Łodki SHERIFF', colour = 63, id = 427, x = -1604.7921, y = 5257.1211, z = 1.1269, job = true, praca = 'sheriff'},
	-- {title = 'Łodki EMS', colour = 63, id = 427, x = -1604.7921, y = 5257.1211, z = 1.1269, job = true, praca = 'ambulance'},

	-- Hurtownia
	-- {title = "Muzeum", 	info = 'museum', colour = 11, id = 78, size = 0.9, x = -555.5, y = -619.0, z = 34.8, job = false},
	-- Kawiarnia
	{title = "Kawiarnia", 	info = 'kawiarnia2', size = 1.5,  id = 105,  x = 120.078, y = -1037.5214, z = 28.3279, job = false},

}


function blipy()
	for _, blip in ipairs(Blipsy) do
		exports['DiabloHub']:ResetBlipUni(blip)
		RemoveBlip(blip)
	end
	
	local company = exports['esx_company']:CompanyBlips()
	
	if company ~= nil then
		for _, info in pairs(company) do
			if info.job == true then
				if ESX.PlayerData.job and (ESX.PlayerData.job.name == info.praca) and ESX.PlayerData.job.grade >= 1 then
					local blip = AddBlipForCoord(info.x, info.y, info.z)
					SetBlipSprite(blip, info.id)
					SetBlipDisplay(blip, 4)
					SetBlipColour(blip, info.colour)
					SetBlipScale (blip, 0.7)
					SetBlipAsShortRange(blip, true)
					
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(info.title)
					EndTextCommandSetBlipName(blip)
					table.insert(Blipsy, blip)
					if info.info then
						exports['DiabloHub']:SetBlip(blip, info.info)
					end
				end
			elseif info.job == false then
				local blip = AddBlipForCoord(info.x, info.y, info.z)
				SetBlipSprite(blip, info.id)
				SetBlipDisplay(blip, 4)
				SetBlipColour(blip, info.colour)
				SetBlipScale (blip, 0.7)
				SetBlipAsShortRange(blip, true)
				
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(info.title)
				EndTextCommandSetBlipName(blip)
				table.insert(Blipsy, blip)		
				if info.info then
					exports['DiabloHub']:SetBlip(blip, info.info)
				end
			end
		end	
	end
	
	for _, info in pairs(blips) do
		if info.job == true then
			if ESX.PlayerData.job and (ESX.PlayerData.job.name == info.praca) then
				local blip = AddBlipForCoord(info.x, info.y, info.z)
				SetBlipSprite(blip, info.id)
				SetBlipDisplay(blip, 4)
				SetBlipColour(blip, info.colour)
				SetBlipScale (blip, 0.7)
				SetBlipAsShortRange(blip, true)
				
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(info.title)
				EndTextCommandSetBlipName(blip)
				table.insert(Blipsy, blip)
				if info.blip then
					exports['DiabloHub']:SetBlip(blip, info.info)
				end
			end
		elseif info.job == false then
			local blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(blip, info.id)
			SetBlipDisplay(blip, 4)
			SetBlipColour(blip, info.colour)
			SetBlipScale (blip, 0.7)
			SetBlipAsShortRange(blip, true)
			
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(blip)
			table.insert(Blipsy, blip)		
			if info.info then
				exports['DiabloHub']:SetBlip(blip, info.info)
			end
		end
	end
end
