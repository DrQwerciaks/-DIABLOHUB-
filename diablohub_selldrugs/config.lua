Config = {}

Config.Drugs = {
    ['weed_pooch'] = {
        min = 850,
        max = 1225                                
    },
    ['coke_pooch'] = {
        min = 850,
        max = 1225
    },
    ['opium_pooch'] = {
        min = 950,
        max = 1425
    },
}

Config.ItemsToSell = {}

for k, v in pairs(Config.Drugs) do
    Config.ItemsToSell[#Config.ItemsToSell + 1] = k
end