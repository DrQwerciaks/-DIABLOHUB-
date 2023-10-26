Config                            = {}

Config.AddRemoveObjectsJobs = {
    "police",
	"fire",
}

Config.Mechanics = {
	["mechanik"] = {
		blip = {
			coords = vector3(834.14, -818.34, 26.33),
			sprite = 446,
			color = 3,
			label = "Mechanik"
		},

		tuneZone = {
			coords = vector4(830.48, -812.51, 25.2, 0.0),
			length = 28.4,
			width = 14.8,
			minZ = 24.9,
			maxZ = 31.9
		},
		employeeZone = {
			coords = vector4(842.20, -824.61, 26.33, 269.21),
            length = 0.75,
            width = 3,
            minZ = 24.41,
            maxZ = 28.0,
			options = {
				{
					event = "need_mechanics:openStash",
					icon = "fas fa-square",
					label = "Otwórz szafkę"
				},
				{
					event = "need_mechanics:openJobClothes",
					icon = "fas fa-sign-in-alt",
					label = "Ubrania frakcyjne"
				},
				{
					event = "need_mechanics:returnLastSkin",
					icon = "fas fa-sign-out-alt",
					label = "Ubranie prywatne"
				},
			}
		},
		bossMenu = {
            coords = vector4(835.37, -827.09, 26.33, 178.25),
            length = 1.25,
            width = 3.5,
            minZ = 25.88,
            maxZ = 26.58,
			options = {
				{
					event = "need_mechanics:bossMenu",
					icon = "fas fa-sign-in-alt",
					label = "Otwórz Menu Szefa"
				},
			}
        },
		crafting = {
			coords = vector4(833.49, -823.99, 26.33, 0.0),
            length = 1.0,
            width = 3.8,
            minZ = 22.87,
            maxZ = 27.03,
			options = {
				{
					event = "need_mechanics:createLockpick",
					icon = "fas fa-wrench",
					label = "Wytwórz wytrych",
                    canInteract = function()
                        return exports.ox_inventory:Search('count', 'lockpick_parts') > 5 and not lockpickTimeout
                    end
				},
			}
		},
		clothes = {
            {
                title = "Ubranie robocze",
				grades = {0, 1, 2, 3, 4, 5, 6, 7, 8},
                male = {
                    ['tshirt_1'] = 217,  ['tshirt_2'] = 0,
                    ['torso_1'] = 251,   ['torso_2'] = 3,
                    ['decals_1'] = 0,   ['decals_2'] = 0,
                    ['arms'] = 1,
                    ['pants_1'] = 97,   ['pants_2'] = 3,
                    ['shoes_1'] = 25,   ['shoes_2'] = 0,
                    ['helmet_1'] = -1,  ['helmet_2'] = 6,
                    ['chain_1'] = 0,    ['chain_2'] = 0,
                    ['ears_1'] = -0,     ['ears_2'] = 0,
                    ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    ['mask_1'] = 0,   ['mask_2'] = 0,
                    ['bags_1'] = 0,  ['bags_2'] = 0
                },
                female = {
                    ['tshirt_1'] = 258,  ['tshirt_2'] = 0,
                    ['torso_1'] = 259,   ['torso_2'] = 3,
                    ['decals_1'] = 0,   ['decals_2'] = 0,
                    ['arms'] = 135,
                    ['pants_1'] = 100,   ['pants_2'] = 3,
                    ['shoes_1'] = 25,   ['shoes_2'] = 0,
                    ['helmet_1'] = -1,  ['helmet_2'] = 6,
                    ['chain_1'] = 0,    ['chain_2'] = 0,
                    ['ears_1'] = -0,     ['ears_2'] = 0,
                    ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    ['mask_1'] = 0,   ['mask_2'] = 0,
                    ['bags_1'] = 0,  ['bags_2'] = 0
                }
            },
        },
	},
}

Config.Clothes = {
	["mechanik"] = {
		label = "Mechanik",
		grades = {0, 1, 2, 3, 4, 5, 6, 7},
		male = {

		},
		female = {

		}
	}
}


Config.Zones = {

    VehicleSpawnPoint = {
		Pos   = { x = 867.9921, y = -2118.061, z = 30.5572 },
		PosSpawnPoint = { x = 804.2376, y = -820.5905, z = 25.231 },
		Heading = 273.60,
		Size  = { x = 1.5, y = 1.5, z = 1.57 },
		Color = {r = 255, g = 255, b = 255},
		Type  = -1,
		Text  = -1,
	},

	VehicleDeleter = {
		Pos   = { x = 799.00, y = -820.6004, z = 25.231 },
		Size  = { x = 3.5, y = 3.5, z = 3.5 },
		Color = {r = 255, g = 255, b = 255},
		Type  = 6,
		Text  = 'ZWROT POJAZDU',
	},

	VehicleDelivery = {
		Pos   = { x = 863.6762, y = -2140.002, z = 30.5654 },
		Size  = { x = 1.5, y = 1.5, z = 1.57 },
		Color = {r = 255, g = 255, b = 255},
		Type = 39,
		Text  = 'PUNKT DOSTAWY',
	}
}

Config.FlipVehicle = {
    dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
    anim = "machinic_loop_mechandplayer",
    flag = 1,
    timeToFlip = 7500,
}

Config.WashVehicle = {
    scenario = "WORLD_HUMAN_MAID_CLEAN",
    timeToWash = 7500,
}

Config.FixKit = {
    dict = "mp_fm_intro_cut",
    anim = "fixing_a_ped",
    flag = 1,
    time = 7500,
}

Config.FixBodyVehicle = {
    dict = "mp_fm_intro_cut",
    anim = "fixing_a_ped",
    flag = 1,
    timeToFix = 7500,
    minimalPriceToNeedItem = 75000,
}

Config.FixEngineVehicle = {
    dict = "mp_fm_intro_cut",
    anim = "fixing_a_ped",
    flag = 1,
    timeToFix = 7500,
    minimalPriceToNeedItem = 75000,
}

Config.RemoveVehicle = {
    dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
    anim = "machinic_loop_mechandplayer",
    flag = 1,
    time = 7500,
}

Config.AuthorizedVehicles = {

	[0] = {
		{label = 'Zentorno', model = 'zentorno'},
	},

	[1] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
	},
	
	[2] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
	[3] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
	
	[4] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
	
	[5] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
	
	[6] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
	
	[7] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
	
	[8] = {
		{label = 'Holownik', model = 'flatbed'},
		{label = 'F450s', model = 'f450s'},
		{label = 'F550rgb', model = 'f550rbc'},
		{label = 'Raptor', model = 'lscraptor'},
	},
	
}