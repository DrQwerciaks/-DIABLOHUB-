SetPlayerRoutingBucket(3, 0)

local Instances = {
	--[[[38] = {
		name = "org48",
		players = {8, 20},
		vehs = {8,10}
	}]]
}

RegisterNetEvent("need_instance:instance:ensure-with-veh-and-other-players", function(players, name)
	local juz = false
	for _, src in pairs(players) do
		for k, v in pairs(Instances) do
			if v.name == name then
				SetPlayerRoutingBucket(src, k)
				v.players[src] = true
				juz = true
			end
		end
		if not juz then
			local tab = {name = name}

			Instances[#Instances + 1] = tab

			for k, v in pairs(Instances) do
				if v.name == name then
					SetPlayerRoutingBucket(src, k)
					v.players = {}
					v.players[src] = true
				end
			end
		end
	end

	for k, v in pairs(Instances) do
		if v.name == name then
			SetEntityRoutingBucket(GetVehiclePedIsIn(GetPlayerPed(players[1])), k)
			if v.vehs == nil then
				v.vehs = {}
			end
			v.vehs[GetVehiclePedIsIn(GetPlayerPed(players[1]))] = true
		end
	end
end)

RegisterNetEvent("need_instance:instance:exit-with-veh-and-other-players", function(players)
	for _, src in pairs(players) do
		local instanceID = GetPlayerRoutingBucket(src)
		if instanceID ~= 0 then
			SetPlayerRoutingBucket(src, 0)
			Instances[instanceID].players[src] = nil
		end
	end

	local instanceID = GetEntityRoutingBucket(GetVehiclePedIsIn(GetPlayerPed(players[1])))
	if instanceID ~= 0 then
		SetEntityRoutingBucket(GetVehiclePedIsIn(GetPlayerPed(players[1])), 0)
		Instances[instanceID].vehs[GetVehiclePedIsIn(GetPlayerPed(players[1]))] = nil
	end
end)

ESX.RegisterServerCallback("need_instance:instance:ensure", function(src, cb, name)
	for k, v in pairs(Instances) do
		if v.name == name then
			SetPlayerRoutingBucket(src, k)
			v.players[src] = true
			cb(true)
			return
		end
	end

	local tab = {name = name}

	Instances[#Instances + 1] = tab

	for k, v in pairs(Instances) do
		if v.name == name then
			SetPlayerRoutingBucket(src, k)
			v.players = {}
			v.players[src] = true
			cb(true)
			return
		end
	end

	cb(false)
end)

ESX.RegisterServerCallback("need_instance:instance:exit", function(source, cb)
	local src = source
	ExitInstance(src)
	cb(true)
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local instanceID = GetPlayerRoutingBucket(_source)
	if instanceID ~= 0 then
		if Instances[instanceID] ~= nil then
			-- if Instances[instanceID].players ~= nil then
			-- 	if Instances[instanceID].players[_source] ~= nil then
					Instances[instanceID].players[_source] = nil
			-- 	end
			-- end
		end
	end
end)

function ExitInstance(src)
	local instanceID = GetPlayerRoutingBucket(src)
	if instanceID ~= 0 then
		SetPlayerRoutingBucket(src, 0)
		Instances[instanceID].players[src] = nil
	end
end

function SourceExists(src)
	local ping = GetPlayerPing(src)
	if ping ~= nil and type(ping) == 'number' and ping > 1 then
		return true
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		for instanceID, properties in pairs(Instances) do
			local ile = 0
			for src, _ in pairs(properties.players) do
				if SourceExists(src) then
					if instanceID ~= GetPlayerRoutingBucket(src) then
						_ = nil
					end
				else
					_ = nil
				end
				ile = ile + 1
				Citizen.Wait(100)
			end

			if properties.vehs then
				for veh, _ in pairs(properties.vehs) do
					ile = ile + 1
				end
			end
			if ile == 0 then
				Instances[instanceID] = nil
			end
		end
		Citizen.Wait(5000)
	end
end)