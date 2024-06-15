local onbag = false 

function PutHeadBagInPlayer()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ped_source = PlayerPedId()
    if not closestPlayer == -1 or closestDistance > 2.0 then 
        Notify("No hay nadie cerca")
        return
    else 
        if not Config.DataVars.on_cuff_use then 
        Config.DataVars.on_cuff_use = true
        ESX.TriggerServerCallback('angelo_criminal:check_item', function(cb)

            if not cb then 
                Notify("No tienes una bolsa para colocar")
                Config.DataVars.onbag_use = false
            else
                TriggerServerEvent('angelo_criminal:send_bag:sv', GetPlayerServerId(closestPlayer))
                Wait(5000)
                Config.DataVars.onbag_use = false
            end
            end, Config.Items.item_bag_head, Config.Items.item_bag_head_count)
        else
            Config.DataVars.on_cuff_use = false
            TriggerServerEvent('angelo_criminal:send_bag:sv', GetPlayerServerId(closestPlayer)) 
            ESX.TriggerServerCallback('angelo_criminal:add_item', function() end, Config.Items.item_bag_head, Config.Items.item_bag_head_count)
        end
    end
    Debugger("FUNCION DE BAG USADA")
end

RegisterNetEvent('angelo_criminal:head_bag:cl')
AddEventHandler('angelo_criminal:head_bag:cl', function()
    if not onbag then 
    onbag = true
    local playerPed = PlayerPedId()
    Config.DataVars.prop_bag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) 
    AttachEntityToEntity(Config.DataVars.prop_bag, playerPed, GetPedBoneIndex(playerPed, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    Notify("Te pusieron una bolsa en la cabeza")
    if not handcuffed then 
        TakeOffHeadBag()
    end
    else 
        onbag = false
        DeleteEntity(Config.DataVars.prop_bag)
        SendNUIMessage({
            type = "hideimage",
        })
        Notify("Te quitaron la bolsa de la cabeza")
    end
end)

function TakeOffHeadBag()
    SendNUIMessage({
        type = "showimage",
    })
    while onbag and not Config.DataVars.ishandcuffed do
        Wait(1)
        ESX.ShowHelpNotification('INTENTAR QUITAR BOLSA', 'G')
        ESX.ShowHelpNotification('NO HACER NADA', 'H')
        if IsControlJustPressed(0, 47) then
                local success = lib.skillCheck({ 'easy', 'easy', 'easy', 'medium', 'medium' }, { 'w', 'a' })
                if success then
                    onbag = false
                    DeleteEntity(Config.DataVars.prop_bag)
                    SendNUIMessage({
                        type = "hideimage",
                    })
                    Notify("te quitaste la bolsa de la cabeza")
                else
                    Notify("No lograste quitarte la bolsa de la cabeza")
                    Debugger("fallaste")
                end
                break
        end
        if IsControlJustPressed(0, 74) then
            Notify("Decidiste no hacer nada, gran eleccion")
            break
        end
    end
end
