local elevator = {}

function CreateElevator(index, elevatorData)

    if index == nil then
        print('exports "CreateElevator" empty variable index!')
        return
    end
    if elevatorData == nil then
        print('exports "CreateElevator" empty table elevatorData!')
        return
    end

    elevatorTableId = #elevator + 1

    elevator[elevatorTableId] = {
        index = index,
        data = {},
    }

    for i=1, #elevatorData do
        local elevatorId = index.."-"..i

        CreateActionKey(elevatorId, elevatorData[i].coords, 2, {}, {
            eventName = "Akira-Base:client:elevator",
            args = {elevatorId},
        }, {
            label = "Kliknik ~o~E~s~ aby skorzystać z windy",
        })

        elevator[elevatorTableId].data[i] = {
            index = elevatorId,
            label = elevatorData[i].label,
            coords = elevatorData[i].coords,
        }
    end
end

RegisterNetEvent('Akira-Base:client:elevator', function(data)
    useElevator(data[1])
end)


function useElevator(index)
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    for i=1, #elevator do 
        for i2=1, #elevator[i].data do
            if elevator[i].data[i2].index == index then
                local dist = #(pCoords - elevator[i].data[i2].coords)
                if dist < 2 then 
                    useElevatorMenu(elevator[i].data)
                end
            end
        end
    end
end

function useElevatorMenu(data)
	local elements = {
		{unselectable = true, title = "Winda"}
	}

    for i=1, #data do
        elements[#elements+1] = {
            title = data[i].label,
            value = data[i].index,
            coords = data[i].coords
        }
    end

	ESX.OpenContext("right", elements, function(menu, element)
        ESX.CloseContext(menu)
        
        DoScreenFadeOut(100)
        Citizen.Wait(750)
        ESX.Game.Teleport(PlayerPedId(), element.coords)
        DoScreenFadeIn(100)
	end)
end


