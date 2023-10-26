Config = {}

Config.Shops = {
    ["Sklep"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
			vector4(372.99, 326.5831, 102.6164, 251.03),
            vector4(1960.71, 3739.92, 31.34, 302.38),
            vector4(548.549, 2671.2095, 41.20, 99.45),
            vector4(24.94, -1347.05, 28.54, 266.26),
            vector4(1134.21,-982.481, 45.46, 277.1),
            vector4(-1221.847, -908.3011, 11.37, 31.6),
            vector4(-1486.2926, -377.83, 39.21, 133.14),
            vector4(-2966.35, 390.84, 14.09, 84.69),
            vector4(1166.01, 2710.94, 37.10, 178.6),
            vector4(1391.61, 3606.12, 34.03, 195.34),
            vector4(-47.16, -1758.761, 28.4707, 49.31),
            vector4(1164.871, -323.34, 68.25, 100.71),
            vector4(-706.1302, -914.2582, 18.2656, 88.71),
            vector4(-1819.75,  793.6614, 137.132, 128.66),
            vector4(1728.2945, 6415.3491, 34.0572, 238.24),
            vector4(1697.54, 4923.26, 41.11, 324.9),
            vector4(2557.1399, 381.25, 107.6729, 352.93),
            vector4(812.85, -782.18, 25.17, 270.07),
        },
        ["Blip"] = {
            ["Sprite"] = 52,
            ["Scale"] = 0.8,
            ["Colour"] = 43
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "water",
                ["label"] = "Woda",
                ["price"] = 20,
                ["desc"] = "Napój"
            },
            {
                ["name"] = "bread",
                ["label"] = "Kanapka",
                ["price"] = 25,
                ["desc"] = "Jedzenie"
            },
            {
                ["name"] = "beer",
                ["label"] = "Piwo",
                ["price"] = 50,
                ["desc"] = "Napój"
            },
            {
                ["name"] = "sprunk",
                ["label"] = "Sprite",
                ["price"] = 60,
                ["desc"] = "Napój"
            },
            {
                ["name"] = "cola",
                ["label"] = "Cola",
                ["price"] = 70,
                ["desc"] = "Napój"
            },
            {
                ["name"] = "redbull",
                ["label"] = "Redbull",
                ["price"] = 250,
                ["desc"] = "Napój"
            },
            {
                ["name"] = "chipsy",
                ["label"] = "Chipsy",
                ["price"] = 25,
                ["desc"] = "Jedzenie"
            },
            {
                ["name"] = "chocolate",
                ["label"] = "Czekolada",
                ["price"] = 30,
                ["desc"] = "Jedzenie"
            },
            {
                ["name"] = "hamburger",
                ["label"] = "Hamburger",
                ["price"] = 100,
                ["desc"] = "Jedzenie"
            },
            {
                ["name"] = "lighter",
                ["label"] = "Zapalniczka",
                ["price"] = 30,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "cigarett",
                ["label"] = "Papierosy",
                ["price"] = 50,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "bletka",
                ["label"] = "Bletka",
                ["price"] = 10,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "roza",
                ["label"] = "Róża",
                ["price"] = 300,
                ["desc"] = "Roślina"
            },
            {
                ["name"] = "durex",
                ["label"] = "Prezerwatywy",
                ["price"] = 250,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "kocyk",
                ["label"] = "Zestaw Piknikowy",
                ["price"] = 1000,
                ["desc"] = "Przedmiot"
            },
        }
    },

    ["Hurtownia"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
			vector4(2747.57, 3472.87, 54.66, 246.61),
            vector4(46.52, -1749.63, 28.63, 48.03),

        },
        ["Blip"] = {
            ["Sprite"] = 371,
            ["Scale"] = 0.8,
            ["Colour"] = 51
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "handcuffs",
                ["label"] = "Kajdanki",
                ["price"] = 10000,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "fixkit",
                ["label"] = "Zestaw Naprawczy",
                ["price"] = 1500,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "lockpick",
                ["label"] = "Wytrych",
                ["price"] = 700,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "headbag",
                ["label"] = "Worek na głowę",
                ["price"] = 2000,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "radio",
                ["label"] = "Radio",
                ["price"] = 5000,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "boombox",
                ["label"] = "Głośnik JBL",
                ["price"] = 2500,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "drill",
                ["label"] = "Wiertło",
                ["price"] = 15000,
                ["desc"] = "Przedmiot"
            },
        }
    },


    ["Weed Shop"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
            vec4(376.16116333008, -826.68371582031, 28.302248001099, 183.35130310059)

        },
        ["Blip"] = {
            ["Sprite"] = 140,
            ["Scale"] = 0.8,
            ["Colour"] = 2
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "doniczka",
                ["label"] = "Doniczka",
                ["price"] = 200,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "nawoz",
                ["label"] = "Nawoz",
                ["price"] = 40,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "butelkawody",
                ["label"] = "Konewka",
                ["price"] = 50,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "dziwneliscie",
                ["label"] = "Dziwne Liscie",
                ["price"] = 200,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "bletka",
                ["label"] = "Bletka",
                ["price"] = 10,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "joint",
                ["label"] = "Joint",
                ["price"] = 250,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "durex",
                ["label"] = "Prezerwatywy",
                ["price"] = 250,
                ["desc"] = "Przedmiot"
            },
        }
    },

    ["Operator komórkowy"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
			vector4(-1083.21, -245.78, 36.75, 201.61),

        },
        ["Blip"] = {
            ["Sprite"] = 459,
            ["Scale"] = 0.8,
            ["Colour"] = 30
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "phone",
                ["label"] = "Czarny Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "red_phone",
                ["label"] = "Czerowny Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "green_phone",
                ["label"] = "Zielony Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "purple_phone",
                ["label"] = "Fioletowy Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "blue_phone",
                ["label"] = "Niebieski Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "white_phone",
                ["label"] = "Biały Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "pink_phone",
                ["label"] = "Różowy Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "gold_phone",
                ["label"] = "Złoty Iphone",
                ["price"] = 1500,
                ["desc"] = "Urządzenie"
            },
            {
                ["name"] = "boombox",
                ["label"] = "Głośnik JBL",
                ["price"] = 2500,
                ["desc"] = "Urządzenie"
            },
        }
    },

    ["Galaxy Club"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
			vector4(357.98297119141, 280.4680480957, 93.191146850586, 245.04833984375),

        },
        ["Blip"] = {
            ["Sprite"] = 93,
            ["Scale"] = 0.6,
            ["Colour"] = 27
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "beer",
                ["label"] = "Piwo",
                ["price"] = 125,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "durex",
                ["label"] = "Prezerwatywy",
                ["price"] = 250,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "vodka",
                ["label"] = "Vodka",
                ["price"] = 200,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "whisky",
                ["label"] = "Whisky",
                ["price"] = 300,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "chipsy",
                ["label"] = "Chipsy",
                ["price"] = 75,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "redbull",
                ["label"] = "Redbull",
                ["price"] = 250,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "tequila",
                ["label"] = "Tequila 0.7L",
                ["price"] = 400,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "shot",
                ["label"] = "Shot czystej wódki 30ml",
                ["price"] = 300,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "koniak",
                ["label"] = "Koniak 200ml",
                ["price"] = 750,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "cydr",
                ["label"] = "Butelka Cydru",
                ["price"] = 475,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "burbon",
                ["label"] = "Szklanka Burbonu",
                ["price"] = 500,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "drink",
                ["label"] = "Drink Amerykański",
                ["price"] = 350,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "boombox",
                ["label"] = "BoomBox",
                ["price"] = 2500,
                ["desc"] = "Urządzenie"
            },
        }
    },

    ["Klub Nocny"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
			vector4(129.01, -1283.41, 28.26, 116.61),

        },
        ["Blip"] = {
            ["Sprite"] = 93,
            ["Scale"] = 0.6,
            ["Colour"] = 27
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "beer",
                ["label"] = "Piwo",
                ["price"] = 125,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "durex",
                ["label"] = "Prezerwatywy",
                ["price"] = 250,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "vodka",
                ["label"] = "Vodka",
                ["price"] = 200,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "whisky",
                ["label"] = "Whisky",
                ["price"] = 300,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "chipsy",
                ["label"] = "Chipsy",
                ["price"] = 75,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "redbull",
                ["label"] = "Redbull",
                ["price"] = 250,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "tequila",
                ["label"] = "Tequila 0.7L",
                ["price"] = 400,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "shot",
                ["label"] = "Shot czystej wódki 30ml",
                ["price"] = 300,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "koniak",
                ["label"] = "Koniak 200ml",
                ["price"] = 750,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "cydr",
                ["label"] = "Butelka Cydru",
                ["price"] = 475,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "burbon",
                ["label"] = "Szklanka Burbonu",
                ["price"] = 500,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "drink",
                ["label"] = "Drink Północno-Amerykański",
                ["price"] = 350,
                ["desc"] = "Alkohol"
            },
            {
                ["name"] = "boombox",
                ["label"] = "BoomBox",
                ["price"] = 2500,
                ["desc"] = "Urządzenie"
            },
        }
    },

    ["Stragan"] = {
        ["PedModel"] = "mp_m_shopkeep_01",
        ["Coords"] = {
			vector4{1476.4946, 2724.4111, 36.6284, 22},
			vector4{-1043.9531, 5327.4683, 43.6239, 22},
			vector4{1087.72, 6509.83, 20.06, 201},
			vector4{1168.7771, -426.2951, 66.1457, 240},
			vector4{-1194.39, -1543.94, 3.37, 113}
        },
        ["Blip"] = {
            ["Sprite"] = 280,
            ["Scale"] = 0.6,
            ["Colour"] = 25
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę',
        ["Items"] = {
            {
                ["name"] = "jablka",
                ["label"] = "Jabłko",
                ["price"] = 20,
                ["desc"] = "Owoc"
            },
            {
                ["name"] = "pomarancza",
                ["label"] = "Pomarańcza",
                ["price"] = 20,
                ["desc"] = "Owoc"
            },
            {
                ["name"] = "mandarynka",
                ["label"] = "Mandarynka",
                ["price"] = 15,
                ["desc"] = "Owoc"
            },
            {
                ["name"] = "winogrono",
                ["label"] = "Winogrono",
                ["price"] = 5,
                ["desc"] = "Owoc"
            },
            {
                ["name"] = "brzoskwinia",
                ["label"] = "Brzoskwinia",
                ["price"] = 25,
                ["desc"] = "Owoc"
            },
            {
                ["name"] = "cytryna",
                ["label"] = "Cytryna",
                ["price"] = 18,
                ["desc"] = "Owoc"
            }
        }
    },

    ["DarkShop - Bronie"] = {
        ["PedModel"] = "s_m_m_autoshop_01",
        ["Coords"] = {
            vector4{-2175.46, 4294.85, 48.04, 238.11},
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę',
        ["Items"] = {
            {
                ["name"] = "weapon_pistol",
                ["label"] = "Pistolet",
                ["price"] = 150000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_combatpistol",
                ["label"] = "Pistolet Bojowy",
                ["price"] = 160000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_vintagepistol",
                ["label"] = "Pistol Vintage",
                ["price"] = 180000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_machete",
                ["label"] = "Maczeta",
                ["price"] = 25000,
                ["desc"] = "Broń Biała"
            },
            {
                ["name"] = "weapon_knife",
                ["label"] = "Nóż",
                ["price"] = 8000,
                ["desc"] = "Broń Biała"
            },
            {
                ["name"] = "ammo-9",
                ["label"] = "Pistol Ammo",
                ["price"] = 50,
                ["desc"] = "Amunicja"
            }
        }
    },

    ["DarkShop"] = {
        ["PedModel"] = "s_m_m_autoshop_01",
        ["Coords"] = {
            vector4{3247.7524414063, 6263.5327148438, 1.0709805488586, 207.93020629883},
        },
        ["Marker"] = { 
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę',
        ["Items"] = {
            {
                ["name"] = "weapon_microsmg",
                ["label"] = "Micro SMG",
                ["price"] = 3800000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_combatpdw",
                ["label"] = "Combat PDW",
                ["price"] = 2500000,
                ["desc"] = "Broń"
            },
            -- {
            --     ["name"] = "weapon_dildo",
            --     ["label"] = "Dildo",
            --     ["price"] = 15000,
            --     ["desc"] = "Przedmiot"
            -- },
            {
                ["name"] = "at_flashlight",
                ["label"] = "Latarka do broni",
                ["price"] = 5000,
                ["desc"] = "Dodatek do broni"
            },
            {
                ["name"] = "at_suppressor_light",
                ["label"] = "Tłumik do pistoletu",
                ["price"] = 10000,
                ["desc"] = "Dodatek do broni"
            },
            {
                ["name"] = "kamizelka",
                ["label"] = "Kamizelka",
                ["price"] = 4500,
                ["desc"] = "Kamizelka"
            },
            {
                ["name"] = "clip_ammo-9",
                ["label"] = "Magazynek Pistol",
                ["price"] = 500,
                ["desc"] = "Amunicja"
            },
            {
                ["name"] = "clip_ammosmg",
                ["label"] = "Magazynek SMG",
                ["price"] = 1000,
                ["desc"] = "Amunicja MiniSMG"
            }
        }
    },

    ["Rybak"] = {
        ["PedModel"] = "s_m_m_autoshop_01",
        ["Coords"] = {
            vector4{-1814.84, -1212.61, 12.02, 51},
        },
        ["Blip"] = {
            ["Sprite"] = 456,
            ["Scale"] = 0.8,
            ["Colour"] = 48
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę',
        ["Items"] = {
            {
                ["name"] = "fishingrod",
                ["label"] = "Wędka",
                ["price"] = 500,
                ["desc"] = "Przedmiot"
            },
            {
                ["name"] = "kukurydza",
                ["label"] = "Kukurydza",
                ["price"] = 10,
                ["desc"] = "Przynęta"
            },
            {
                ["name"] = "robak",
                ["label"] = "Robak",
                ["price"] = 5,
                ["desc"] = "Przynęta"
            }
        }
    },

    ["Sklep z Bronią"] = {
        ["PedModel"] = "mp_m_weapexp_01",
        ["Weapon"] = true, 
        ["Coords"] = {
            vector4{-659.18, -939.78, 20.83, 88},
            vector4{1698.00,3757.54, 33.71, 151},
            vector4{-326.18, 6081.36, 30.45, 150},
            vector4{247.17, -51.46, 68.94, 357},
            vector4{17.34, -1107.59, 28.8, 162},
            vector4{2564.93, 298.74, 107.73, 281},
            vector4{-1112.73, 2697.57, 17.60, 124},
            vector4{841.19, -1028.71, 27.19, 266},
            vector4{-1310.11, -394.20, 35.7, 340},
             
        },
        ["Blip"] = {
            ["Sprite"] = 110,
            ["Scale"] = 0.8,
            ["Colour"] = 75
        },
        ["Marker"] = {
            ["Type"] = 1,
            ["Size"] = {x = 2.0, y = 2.0, z = 1.0},
            ["Color"] = {r = 106, g = 0, b = 255, a = 100}
        },
        ["HelpNotification"] = 'Naciśnij ~INPUT_CONTEXT~ aby ~o~przejrzeć ofertę sklepu',
        ["Items"] = {
            {
                ["name"] = "weapon_pistol",
                ["label"] = "Pistolet",
                ["price"] = 50000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_combatpistol",
                ["label"] = "Pistolet Bojowy",
                ["price"] = 60000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_pistol_mk2",
                ["label"] = "Pistolet MK2",
                ["price"] = 65000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_snspistol",
                ["label"] = "Pistolet SNS",
                ["price"] = 50000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_snspistol_mk2",
                ["label"] = "Pistolet SNS MK2",
                ["price"] = 55000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_vintagepistol",
                ["label"] = "Pistolet Vintage",
                ["price"] = 80000,
                ["desc"] = "Broń"
            },
            {
                ["name"] = "weapon_knife",
                ["label"] = "Nóż",
                ["price"] = 5000,
                ["desc"] = "Broń Biała"
            },
            {
                ["name"] = "weapon_machete",
                ["label"] = "Maczeta",
                ["price"] = 12000,
                ["desc"] = "Broń Biała"
            },
            {
                ["name"] = "weapon_bat",
                ["label"] = "Kij Baseballowy",
                ["price"] = 1000,
                ["desc"] = "Broń Biała"
            },
            {
                ["name"] = "ammo-9",
                ["label"] = "Pistol Ammo",
                ["price"] = 30,
                ["desc"] = "Amunicja"
            },
        }
    }
}
