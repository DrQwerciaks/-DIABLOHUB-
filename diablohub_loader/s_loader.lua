local rsrcName = GetCurrentResourceName()
if rsrcName ~= "diablohub_loader" then
    local Code = {}
    local Scripts = json.decode(GetResourceMetadata(rsrcName, 'my_data_extra', 0))
    for i,v in pairs(Scripts) do
        local code = LoadResourceFile(rsrcName, v)
        if code ~= nil then
            Code[v] = code
        else
            print("file ["..v.."] error")
        end
    end

    local GotSrc = {}
    RegisterNetEvent(rsrcName, function() 
        local src = source
        if not GotSrc[src] then
            if GotSrc[src] ~= rsrcName then
                TriggerClientEvent(rsrcName, src, Code)
                GotSrc[src] = rsrcName
            end
        end
    end)
end