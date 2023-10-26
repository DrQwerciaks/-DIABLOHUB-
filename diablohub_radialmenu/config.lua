Config = {}

Config.MenuItems = {
    {
        id = 'general',
        tip = 'Menu Główne Postaci',
        displayName = 'Menu Główne',
        key = 'F1',
        enableMenu = function()
            return true
        end,
        items = {}
    },
}

Config.MenuAdd = {
    -- TELEFON
    {
        id = "general",
        addElement = function()
            return true
        end,
        item ="phone",
        items = {
            {
                id = "telefon",
                title = "Telefon",
                icon = "#phone",
                type = "client",
                event = "gcPhone:forceOpenPhone",
                shouldClose = true,
            },
        }
    },
    -- MENU POJAZDU
    {
        id = "general",
        addElement = function()
            return IsPedSittingInAnyVehicle(PlayerPedId())
        end,
        items = {
            {
                id = "pojazd",
                title = "Menu Pojazdu",
                icon = "#car",
                items = {
                    {
                        id = "sterowaniepojazdem",
                        title = "Sterowanie Pojazdem",
                        icon = "#car",
                        items = {
                            {
                                id = "menupojazdu-maska",
                                title = "Maska",
                                icon = "#car_door",
                                type = "client",
                                event = "need_radialmenu:toggleDoor",
                                eventData = {what = 4},
                                shouldClose = false,
                            },
                            {
                                id = "menupojazdu-przednielewedrzwi",
                                title = "Lewe Przednie Drzwi",
                                icon = "#car_door",
                                type = "client",
                                event = "need_radialmenu:toggleDoor",
                                eventData = {what = 0},
                                shouldClose = false,
                            },
                            {
                                id = "menupojazdu-przednieprawedrzwi",
                                title = "Prawe Przednie Drzwi",
                                icon = "#car_door",
                                type = "client",
                                event = "need_radialmenu:toggleDoor",
                                eventData = {what = 1},
                                shouldClose = false,
                            },
                            {
                                id = "menupojazdu-tylnielewedrzwi",
                                title = "Lewe Tylnie Drzwi",
                                icon = "#car_door",
                                type = "client",
                                event = "need_radialmenu:toggleDoor",
                                eventData = {what = 2},
                                shouldClose = false,
                            },
                            {
                                id = "menupojazdu-tylnieprawedrzwi",
                                title = "Prawe Tylnie Drzwi",
                                icon = "#car_door",
                                type = "client",
                                event = "need_radialmenu:toggleDoor",
                                eventData = {what = 3},
                                shouldClose = false,
                            },
                            {
                                id = "menupojazdu-bagaznik",
                                title = "Bagażnik",
                                icon = "#car_door",
                                type = "client",
                                event = "need_radialmenu:toggleDoor",
                                eventData = {what = 5},
                                shouldClose = false,
                            },
                        }
                    },
                    {
                        id = "menupojazdu-przesiadanie",
                        title = "Zmień miejsce",
                        icon = "#car_seat",
                        items = {

                            {
                                id = "menupojazdu-bagaznik",
                                title = "Siedzenie kierowcy",
                                icon = "#car_seat",
                                type = "client",
                                event = "need_radialmenu:seat1",
                                eventData = {what = 1},
                                shouldClose = true,
                            }, 
                            {
                                id = "menupojazdu-bagaznik",
                                title = "Siedzenie pasażera",
                                icon = "#car_seat",
                                type = "client",
                                event = "need_radialmenu:seat2",
                                eventData = {what = 2},
                                shouldClose = true,
                            }, 
                            {
                                id = "menupojazdu-bagaznik",
                                title = "Siedzenie z tyłu lewa strona",
                                icon = "#car_seat",
                                type = "client",
                                event = "need_radialmenu:seat3",
                                eventData = {what = 3},
                                shouldClose = true,
                            }, 
                            {
                                id = "menupojazdu-bagaznik",
                                title = "Siedzenie z tyłu prawa strona",
                                icon = "#car_seat",
                                type = "client",
                                event = "need_radialmenu:seat4",
                                eventData = {what = 4},
                                shouldClose = true,
                            }, 
                        }
                    },
                    {
                        id = "menupojazdu-schowek",
                        title = "Radio Samochodowe",
                        icon = "#carradio",
                        type = "client",
                        event = "need_radialmenu:radiocar",
                        shouldClose = true,
                    },
                }
            },
        }
    },
    -- MENU UBRAŃ
    -- ANIMACJE
    {
        id = "general",
        addElement = function()
            return true
        end,
        items = {
            {
                id = "animacje",
                title = "Animacje",
                icon = "#animations",
                type = "client",
                event = 'needrp:otworzanimajce',
                shouldClose = true,
            },
        }
    },

    {
        id = "general",
        addElement = function()
            return true
        end,
        items = {
            {
                id = "menuubran",
                title = "Menu Ubrań",
                icon = "#tshirt",
                type = "client",
                event = 'niff_clothes:menu',
                shouldClose = true,
            },
        }
    },

    {
        id = "general",
        addElement = function()
            return true
        end,
        items = {
            {
                id = "monety",
                title = "ItemShop",
                icon = "#monety",
                type = "client",
                event = "need_radialmenu:playtime",
                shouldClose = true,
            },
        }
    },
    -- DOKUMENTY
    {
        id = "general",
        addElement = function()
            return true
        end,
        items = {
            {
                id = "dokumenty",
                title = "Dokumenty",
                icon = "#document",
                items = {
                    {
                        id = "dowod",
                        title = "Dowód",
                        icon = "#dowod",
                        type = "client",
                        event = 'needrp:pokazdowod',
                        shouldClose = true,
                    },
                    {
                        id = "wizytowka",
                        title = "Wizytówka",
                        icon = "#wizytowka",
                        type = "client",
                        event = 'needrp:pokazwiz',
                        shouldClose = true,
                    },
                }
            },
        }
    },

    -- MENU TUNINGU
    {
        id = "general",
        addElement = function()
            return exports.diablohub_mechanics.checkTuningZone()
        end,
        items = {
            {
                id = "tuningmenu-ottos",
                type = "client",
                title = "Menu Tuningowania",
                icon = "#tuning",
                event = "rey_tuning:TuningMenu",
                shouldClose = true,
            },
        }
    },
    -- MENU PRACY LST
    {
        id = "general",
        addElement = function()
            return ESX.PlayerData.job.name == "mechanik" or ESX.PlayerData.job.name == "mechanik2" or ESX.PlayerData.job.name == "mechanik3"
        end,
        items = {
            {
                id = "menupracy-lst",
                title = "Menu Pracy LST",
                icon = "#job",
                items = {
                    {
                        id = "tablet-lst",
                        title = "Tablet LST",
                        icon = "#tablet",
                        type = "client",
                        event = "esx_lscmdt:OpenMDT",
                        shouldClose = true,
                    },
                    {
                        id = "przedmiotydopostawienia-lst",
                        title = "Przedmioty do postawienia",
                        icon = "#przedmiotydopostawienia",
                        items = {
                            {
                                id = "przedmiotydopostawienia-pacholek-lst",
                                title = "Pachołek",
                                icon = "#pacholek",
                                type = "client",
                                event = "need_mechanics:SpawnObject",
                                eventData = {entity = 'prop_roadcone02a'},
                                shouldClose = true,
                            },
                            {
                                id = "przedmiotydopostawienia-skrzynkaznarzedziami-lst",
                                title = "Skrzynka Z Narzędziami",
                                icon = "#skrzynkaznarzedziami",
                                type = "client",
                                event = "need_mechanics:SpawnObject",
                                eventData = {entity = 'prop_toolchest_01'},
                                shouldClose = true,
                            },
                            {
                                id = "przedmiotydopostawienia-barierka-lst",
                                title = "Barierka",
                                icon = "#barierka",
                                type = "client",
                                event = "need_mechanics:SpawnObject",
                                eventData = {entity = 'prop_barrier_work06a'},
                                shouldClose = true,
                            },
                        }
                    },
                    {
                        id = "radio-lst",
                        title = "Radio",
                        icon = "#radio_person",
                        items = {
                            {
                                id = "radio-5-lst",
                                title = "Radio EMS (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 5},
                                shouldClose = true,
                            },
                            {
                                id = "radio-6-lst",
                                title = "Radio EMS (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 6},
                                shouldClose = true,
                            },
                            {
                                id = "radio-7-lst",
                                title = "LSCM (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 7},
                                shouldClose = true,
                            },
                            {
                                id = "radio-8-lst",
                                title = "LSCM (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 8},
                                shouldClose = true,
                            },
                        }
                    },
                }
            },
        }
    },
        -- MENU PRACY LSFD
        {
            id = "general",
            addElement = function()
                return ESX.PlayerData.job.name == "fire"
            end,
            items = {
                {
                    id = "menupracy-lsfd",
                    title = "Menu Pracy LSFD",
                    icon = "#job",
                    items = {
                        -- {
                        --     id = "tablet-lsfd",
                        --     title = "Tablet LST",
                        --     icon = "#tablet",
                        --     type = "client",
                        --     event = "esx_lscmdt:OpenMDT",
                        --     shouldClose = true,
                        -- },
                        {
                            id = "przedmiotydopostawienia-lsfd",
                            title = "Przedmioty do postawienia",
                            icon = "#przedmiotydopostawienia",
                            items = {
                                {
                                    id = "przedmiotydopostawienia-pacholek-lsfd",
                                    title = "Pachołek",
                                    icon = "#pacholek",
                                    type = "client",
                                    event = "need_mechanics:SpawnObject",
                                    eventData = {entity = 'prop_roadcone02a'},
                                    shouldClose = true,
                                },
                                {
                                    id = "przedmiotydopostawienia-skrzynkaznarzedziami-lsfd",
                                    title = "Skrzynka Z Narzędziami",
                                    icon = "#skrzynkaznarzedziami",
                                    type = "client",
                                    event = "need_mechanics:SpawnObject",
                                    eventData = {entity = 'prop_toolchest_01'},
                                    shouldClose = true,
                                },
                                {
                                    id = "przedmiotydopostawienia-barierka-lsfd",
                                    title = "Barierka",
                                    icon = "#barierka",
                                    type = "client",
                                    event = "need_mechanics:SpawnObject",
                                    eventData = {entity = 'prop_barrier_work06a'},
                                    shouldClose = true,
                                },
                            }
                        },
                        {
                            id = "radio-lsfd",
                            title = "Radio",
                            icon = "#radio_person",
                            items = {
                                {
                                    id = "radio-132-lsfd",
                                    title = "Radio LSFD (#1)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 9},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-5-lsfd",
                                    title = "Radio LSFD (#2)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 10},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-5-lsfd",
                                    title = "Radio EMS (#1)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 5},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-6-lsfd",
                                    title = "Radio EMS (#2)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 6},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-7-lsfd",
                                    title = "LSCM (#1)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 7},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-8-lsfd",
                                    title = "LSCM (#2)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 8},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-9-lsfd",
                                    title = "LSPD (#1)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 1},
                                    shouldClose = true,
                                },
                                {
                                    id = "radio-10-lsfd",
                                    title = "LSPD (#2)",
                                    icon = "#radio_person",
                                    type = "client",
                                    event = "need_radialmenu:setRadioChannel",
                                    eventData = {channel = 2},
                                    shouldClose = true,
                                },
                            }
                        },
                    }
                },
            }
        },
    -- MENU PRACY EMS
    {
        id = "general",
        addElement = function()
            return ESX.PlayerData.job.name == "ambulance"
        end,
        items = {
            {
                id = "menupracy-ems",
                title = "Menu Pracy EMS",
                icon = "#job",
                items = {
                    {
                        id = "tablet-ems",
                        title = "Tablet EMS",
                        icon = "#tablet",
                        type = "client",
                        event = "esx_emsmdt:OpenMDT",
                        shouldClose = true,
                    },
                    {
                        id = "radio-lst",
                        title = "Radio",
                        icon = "#radio_person",
                        items = {
                            {
                                id = "radio-3-ems",
                                title = "Radio EMS (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 5},
                                shouldClose = true,
                            },
                            {
                                id = "radio-4-ems",
                                title = "Radio EMS (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 6},
                                shouldClose = true,
                            },
                            {
                                id = "radio-1-ems",
                                title = "Radio LSPD (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 1},
                                shouldClose = true,
                            },
                            {
                                id = "radio-2-ems",
                                title = "Radio LSPD (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 2},
                                shouldClose = trsue,
                            },
                            {
                                id = "radio-2-ems",
                                title = "Radio LSPD (#3)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 3},
                                shouldClose = trsue,
                            },
                            {
                                id = "radio-2-ems",
                                title = "Radio LSPD (#4)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 4},
                                shouldClose = trsue,
                            },
                            {
                                id = "radio-5-ems",
                                title = "LSCM (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 7},
                                shouldClose = true,
                            },
                            {
                                id = "radio-6-ems",
                                title = "LSCM (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 8},
                                shouldClose = true,
                            },
                        }
                    },
                }
            },
        }
    },

    -- MENU PRACY DOJ
    {
        id = "general",
        addElement = function()
            return ESX.PlayerData.job.name == "doj"
        end,
        items = {
            {
                id = "menupracy-doj",
                title = "Menu Pracy DOJ",
                icon = "#job",
                items = {
                    {
                        id = "tablet-doj",
                        title = "Tablet DOJ",
                        icon = "#tablet",
                        type = "client",
                        event = "esx_dojmdt:OpenMDT",
                        shouldClose = true,
                    },
                }
            },
        }
    },
    -- MENU PRACY LSPD
    {
        id = "general",
        addElement = function()
            return ESX.PlayerData.job.name == "police"
        end,
        items = {
            {
                id = "menupracy-lspd",
                title = "Menu Pracy LSPD",
                icon = "#job",
                items = {
                    {
                        id = "odznaka-lspd",
                        title = "Odznaka",
                        icon = "#odznaka",
                        type = "server",
                        event = "need_odznaka:odznaka",
                        shouldClose = true,
                    },
                    {
                        id = "kod-zagrozenia",
                        title = "Kod Zagrożenia",
                        icon = "#blips",
                        type = "client",
                        event = "otworzkodzagrozenia",
                        shouldClose = true,
                    },
                    {
                        id = "lornetka",
                        title = "Lornetka",
                        icon = "#okulary",
                        type = "client",
                        event = "jumelles:Active",
                        shouldClose = true,
                    },
                    {
                        id = "tablet-lspd",
                        title = "Tablet LSPD",
                        icon = "#tablet",
                        type = "client",
                        event = "esx_lspdmdt:OpenMDT",
                        shouldClose = true,
                    },
                    {
                        id = "przedmiotydopostawienia-lspd",
                        title = "Przedmioty do postawienia",
                        icon = "#przedmiotydopostawienia",
                        items = {
                            {
                                id = "przedmiotydopostawienia-pacholek-lspd",
                                title = "Pachołek",
                                icon = "#pacholek",
                                type = "client",
                                event = "need_mechanics:SpawnObject",
                                eventData = {entity = 'prop_roadcone02a'},
                                shouldClose = true,
                            },
                            -- {
                            --     id = "przedmiotydopostawienia-kolczatka-lspd",
                            --     title = "Kolczatka",
                            --     icon = "#spike",
                            --     type = "client",
                            --     event = "need_mechanics:SpawnObject",
                            --     eventData = {entity = 'p_ld_stinger_s'},
                            --     shouldClose = true,
                            -- },
                            {
                                id = "przedmiotydopostawienia-barierka-lst",
                                title = "Barierka",
                                icon = "#barierka",
                                type = "client",
                                event = "need_mechanics:SpawnObject",
                                eventData = {entity = 'prop_barrier_work06a'},
                                shouldClose = true,
                            },
                        }
                    },
                    {
                        id = "radio-lspd",
                        title = "Radio",
                        icon = "#radio_person",
                        items = {
                            {
                                id = "radio-1-lspd",
                                title = "Radio LSPD (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 1},
                                shouldClose = true,
                            },
                            {
                                id = "radio-2-ems",
                                title = "Radio LSPD (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 2},
                                shouldClose = true,
                            },
                            {
                                id = "radio-3-lspd",
                                title = "Radio LSPD (#3)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 3},
                                shouldClose = true,
                            },
                            {
                                id = "radio-4-lspd",
                                title = "Radio LSPD (#4)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 4},
                                shouldClose = true,
                            },
                            {
                                id = "radio-5-lspd",
                                title = "Radio EMS (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 5},
                                shouldClose = true,
                            },
                            {
                                id = "radio-6-lspd",
                                title = "Radio EMS (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 6},
                                shouldClose = true,
                            },
                            {
                                id = "radio-7-lspd",
                                title = "LSCM (#1)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 7},
                                shouldClose = true,
                            },
                            {
                                id = "radio-8-lspd",
                                title = "LSCM (#2)",
                                icon = "#radio_person",
                                type = "client",
                                event = "need_radialmenu:setRadioChannel",
                                eventData = {channel = 8},
                                shouldClose = true,
                            },
                        }
                    },
                }
            },
        }
    },
}