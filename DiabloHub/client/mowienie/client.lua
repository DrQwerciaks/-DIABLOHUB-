local fontId
Citizen.CreateThread(function()
    RegisterFontFile('Poppins-Medium') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('Poppins-Medium') -- the name from the .xml
end)

function displayText(text, justification, red, green, blue, alpha, posx, posy)
    SetTextFont(4)
    SetTextWrap(0.0, 1.0)
    SetTextScale(0.6, 0.3)
    SetTextJustification(justification)
    SetTextColour(red, green, blue, alpha)
    SetTextOutline()

    BeginTextCommandDisplayText("STRING") -- old: SetTextEntry()
    -- AddTextComponentSubstringPlayerName(text) -- old: AddTextComponentString
    AddTextComponentSubstringPlayerName("<font face='Poppins-Medium' size= '11'>".. text .."</font>" )
    EndTextCommandDisplayText(posx, posy) -- old: DrawText()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playersTalking = {'empty'}
            local count = 1
            for _, i in ipairs(GetActivePlayers()) do
                if NetworkIsPlayerTalking(i) then
                    playersTalking[count] = GetPlayerServerId(i)
                    count = count + 1
                end
            end
            if playersTalking[1] ~= "empty" then
                --displayText("Mówią:", 0, 255, 255, 255, 255, 0.98, 0.905)
                count = 0
                for k,v in pairs(playersTalking) do
                    displayText("~f~" .. v, 0, 255, 255, 255, 255, 0.98, 0.955 - (0.014*(count)))
                    count = count + 1
                end
            end
    end
end)