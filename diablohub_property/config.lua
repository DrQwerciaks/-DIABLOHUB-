Config = {}

Config.Targets = {
    {
        coords = vector4(-272.12, -958.4, 31.22, 25.0),
        length = 3.6,
        width = 2.8,
        name = "freeproperty_enter",
        minZ = 30.22,
        maxZ = 32.22,
        options = {
            {
                event = "need_property:enter",
                icon = "fas fa-sign-in-alt",
                label = "Wejdź",
            },
        }
    },
    {
        coords = vector4(-821.4434, 3467.549, -160.1532, 10.0),
        length = 1.0,
        width = 1.0,
        name = "freeproperty_exit",
        minZ = -160.1532,
        maxZ = -158.1532,
        options = {
            {
                event = "need_property:exit",
                icon = "fas fa-sign-out-alt",
                label = "Wyjdź",
            },
        }
    },
    {
        coords = vector4(-816.56, 3469.93, -159.15, 0.0),
        length = 1.4,
        width = 1.0,
        name = "freeproperty_stash",
        minZ = -160.1532,
        maxZ = -158.1532,
        options = {
            {
                event = "need_property:stash",
                icon = "fas fa-box-open",
                label = "Otwórz szafkę",
            },
            {
                event = "need_property:getClothes",
                icon = "fas fa-shirt",
                label = "Przebierz się",
            },
            {
                event = "need_property:removeClothes",
                icon = "fas fa-shirt",
                label = "Usuń ubranie",
            },
            {
                event = "need_property:addClothes",
                icon = "fas fa-shirt",
                label = "Dodaj ubranie",
            },
        }
    },
}


Config.Enter = vector4(-821.4434, 3467.549, -160.1532, 10.0)

Config.Exit = vector4(-271.0315, -957.9062, 30.223, 300.0)
