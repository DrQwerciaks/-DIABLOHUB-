Config = {}

Config.Zones = {
    {
        Coords = {
            vector2(-1801.8732910156, -1241.6337890625),
            vector2(-1826.3638916016, -1270.8218994141),
            vector2(-1865.9295654297, -1237.6131591797),
            vector2(-1860.3348388672, -1230.9332275391),
            vector2(-1859.4436035156, -1231.6845703125),
            vector2(-1864.1732177734, -1237.341796875),
            vector2(-1826.4868164063, -1269.2692871094),
            vector2(-1803.408203125, -1241.931640625),
            vector2(-1811.1149902344, -1235.4665527344),
            vector2(-1810.3283691406, -1234.5173339844)
        }
    },
}

Config.Fishing = {
    minTime = 2500,         -- minimum fishing time
    maxTime = 5000,         -- maximum fishing time
    chanceToBreak = 3,     -- chance to break fishingrod
}

Config.Baits = {
    ['robak'] = {           --bait item name
        multiplier = 1.5,   -- reward default item multiplier (1.0 = normal)
    },
    ['kukurydza'] = {           --bait item name
        multiplier = 1.25,   -- reward default item multiplier (1.0 = normal)
    },

}

Config.Rewards = {
    --Tier1
    ['sledz'] = {            -- reward item name
        chance = 175,        -- minimum amount of chance
        baits = {
 
            ['robak'] = true,
        }
    },
    ['sardynka'] = {            -- reward item name
        chance = 175,        -- minimum amount of chance
        baits = {
 
            ['robak'] = true,
        }
    },

    --Tier2
    ['makrela'] = {            -- reward item name
        chance = 100,        -- minimum amount of chance
        baits = {

            ['robak'] = true,
        }
    },
    ['dorsz'] = {            -- reward item name
        chance = 100,        -- minimum amount of chance
        baits = {
 
            ['robak'] = true,
        }
    },
    ['halibut'] = {            -- reward item name
        chance = 100,        -- minimum amount of chance
        baits = {

            ['robak'] = true,
        }
    },

    --Tier3
    ['losos'] = {            -- reward item name
        chance = 75,        -- minimum amount of chance
        baits = {

            ['kukurydza'] = true,
            ['robak'] = true,
        }
    },
    ['jesiotr'] = {            -- reward item name
        chance = 75,        -- minimum amount of chance
        baits = {

            ['kukurydza'] = true,
            ['robak'] = true,
        }
    },

    --Tier4
    ['tunczyk'] = {            -- reward item name
        chance = 50,        -- minimum amount of chance
        baits = {
            ['kukurydza'] = true,
        }
    },
    ['osmiornica'] = {            -- reward item name
        chance = 50,        -- minimum amount of chance
        baits = {
            ['kukurydza'] = true,
        }
    },

    --Tier5
    ['malza'] = {            -- reward item name
        chance = 30,        -- minimum amount of chance
        baits = {
            ['robak'] = true,
            ['robak'] = true,
        }
    },
    ['kamien'] = {            -- reward item name
        chance = 60,        -- minimum amount of chance
        baits = {
            ['kukurydza'] = true,
            ['robak'] = true,
        }
    }
}