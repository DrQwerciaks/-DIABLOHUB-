local DensityMultiplier = {
    ['parked'] = 0.2, -- zaparkowane
    ['vehicle'] = 0.2,
    ['multiplier'] = 0.3,--
    ['peds'] = 0.8, -- 
    ['scenario'] = 0.8, -- 
}

CreateThread(function()
	while true do
		SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier['parked'])
		SetVehicleDensityMultiplierThisFrame(DensityMultiplier['vehicle'])
		SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier['multiplier'])
		SetPedDensityMultiplierThisFrame(DensityMultiplier['peds'])
		SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier['scenario'], DensityMultiplier['scenario'])
		Wait(0)
	end
end)