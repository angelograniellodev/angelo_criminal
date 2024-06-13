local onbag = false 

function PutHeadBagInPlayer()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ped_source = PlayerPedId()
    if not closestPlayer == -1 or closestDistance > 2.0 then 
        Notify("No hay nadie cerca")
        return
    end

    TriggerServerEvent('angelo_criminal:send_bag:sv', GetPlayerServerId(closestPlayer))
    Wait(5000)
    Config.DataVars.onbag_use = false
end

RegisterCommand("funcion", function ()
    TriggerEvent("angelo_criminal:head_bag:cl")
end)

RegisterNetEvent('angelo_criminal:head_bag:cl')
AddEventHandler('angelo_criminal:head_bag:cl', function()
    if not onbag then 
    onbag = true
    local playerPed = PlayerPedId()
    Config.DataVars.prop_bag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) 
    AttachEntityToEntity(Config.DataVars.prop_bag, playerPed, GetPedBoneIndex(playerPed, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    Notify("Te pusieron una bolsa en la cabeza")
    SendNUIMessage({
        type = "showimage",
    })
    else 
        onbag = false
        DeleteEntity(Config.DataVars.prop_bag)
        SendNUIMessage({
            type = "hideimage",
        })
        Notify("Te quitaron la bolsa de la cabeza")
    end
end)    