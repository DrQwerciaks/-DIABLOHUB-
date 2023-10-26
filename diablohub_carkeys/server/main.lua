RegisterNetEvent("need_carkeys:addKey", function(plate)
    local _source = source
    print(plate)
    exports.ox_inventory:AddItem(_source, 'carkey', 1, plate)
end)

RegisterNetEvent("need_carkeys:removeKey", function(plate)
    local _source = source
    exports.ox_inventory:RemoveItem(_source, 'carkey', 1, plate)
end)