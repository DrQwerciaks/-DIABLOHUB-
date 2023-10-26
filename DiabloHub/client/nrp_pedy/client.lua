-------------------------------------------
---     Pedy bo MOWER      ---
-------------------------------------------
local spawnedPeds = {}

local Pedy = 
{



	wyciongaczfurems = {
      
		Name = 'a_m_y_busicas_01',	

		Pos = {
			{ x = 328.4522, y = -577.8094, z = 27.8468, heading = 339.35 },
		},
	},

	wyciongaczfurmechanic = {
      
		Name = 's_m_m_autoshop_02',	

		Pos = {
			{ x = 810.8177, y = -816.9076, z = 25.2449, heading = 101.95 },
		},
	},

	wyciongaczfursasp = {
		
		Name = 'cs_andreas',

		Pos = {
			{ x = 459.86, y = -986.70, z = 24.7606, heading = 85.0},
		},
		
	},


	helikoptrarz = {
		
		Name = 'ig_vagspeak',

		Pos = {
			{ x = 340.0233, y = -581.5012, z = 73.2118, heading = 251.27 },
			{ x = 465.0779, y = -990.9504, z = 42.7417, heading = 92.99 },
		},
		
	},

	ludkarzems = {
		
		Name = 'a_m_y_surfer_01',

		Pos = {
			{ x = -848.723, y = -1368.1288, z = 0.6552, heading = 280.70 },

		},
		
	},

	silownik = {
		
		Name = 'a_m_y_runner_02',

		Pos = {
			{ x = -32.7599, y = -1664.1497, z = 28.5374, heading = 52.40 },

		},
		
	},

	GoscUbrania = {
		
		Name = 'ig_barry',

		Pos = {
			{ x = -817.58,   y = -1073.88, z = 10.33, heading = 120.32 },
			{ x = -1197.40,   y = -779.15, z = 16.32, heading = 31.67 },
			{ x = -1447.42,   y = -239.67, z = 48.81, heading = 50.05 },
			{ x = -706.90,   y = -150.88, z = 36.42, heading = 127.32 },
			{ x = -166.87,   y = -301.97, z = 38.73, heading = 258.79 },
			{ x = 123.04,   y = -212.58, z = 53.56, heading = 248.11 },
			{ x = 423.42,   y = -810.32, z = 28.49, heading = 357.08 },
			{ x = 77.78,   y = -1388.88, z = 28.38, heading = 189.15 },
			{ x = -3172.43,   y = 1055.18, z = 19.86, heading = 247.28 },
			{ x = -1097.00,   y = 2711.61, z = 18.11, heading = 133.79 },
			{ x = 621.26,   y = 2753.18, z = 41.09, heading = 88.95 },
			{ x = 1200.73,   y = 2707.67, z = 37.22, heading = 87.79 },
			{ x = 1692.32,   y = 4818.47, z = 41.06, heading = 5.49 },
			{ x = 0.14,   y = 6511.46, z = 30.88, heading = 324.9 }, 
		},
		
	},

	Banki = {
		
		Name = 'a_f_y_business_01',

		Pos = {
			{ x = 149.52,   y = -1042.09, z = 28.37, heading = 337.0 },
			{ x = -1211.82,   y = -331.96, z = 36.78, heading = 27.69 },
			{ x = -2961.17,   y = 482.91, z = 14.7, heading = 89.34 },
			{ x = 313.72,   y = -280.42, z = 53.16, heading = 344.57 },
			{ x = 1175.06,   y = 2708.22, z = 37.09, heading = 179.23 },
			{ x = -351.42,   y = -51.27, z = 48.04, heading = 331.9 },
			{ x = -111.15,   y = 6470.05, z = 30.63, heading = 131.5 },
			{ x = 263.26, y = 225.90, z =105.33, heading = 159.14 }
		},
		
	},

	
}



CreateThread(function()

	for k,v in pairs(Pedy) do
	RequestModel(GetHashKey(v.Name))
	while not HasModelLoaded(GetHashKey(v.Name)) do
		Citizen.Wait(100)
	end
	for i = 1, #v.Pos, 1 do
	local ped = Citizen.InvokeNative(0xD49F9B0955C367DE, 4, GetHashKey(v.Name), v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, v.Pos[i].heading, false, true)

		FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	if v.anim then
	TaskStartScenarioInPlace(ped, v.anim, 0, true)
	end
	spawnedPeds[i] = ped
		end
	end
end)




AddEventHandler("onResourceStop", function(r)
	if r == GetCurrentResourceName() then
		for i,v in ipairs(spawnedPeds) do
			DeleteEntity(v)
		end
	end
end)