local function ishandcuffed()
    while Config.DataVars.ishandcuffed do
        Wait(1)
        if Config.DataVars.ishandcuffed then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 236, true)
            EnableControlAction(0, 249, true)

            if not IsEntityPlayingAnim(cache.ped, 'mp_arresting', 'idle', 3) then
                lib.requestAnimDict('mp_arresting', 100)
                TaskPlayAnim(cache.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            end
            if not Config.DataVars.prop_cuffs or not DoesEntityExist(Config.DataVars.prop_cuffs) then
                lib.requestModel('p_cs_cuffs_02_s', 100)
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 3.0, 0.5))
                Config.DataVars.prop_cuffs = CreateObjectNoOffset(`p_cs_cuffs_02_s`, x, y, z, true, false)
                SetModelAsNoLongerNeeded(`p_cs_cuffs_02_s`)
                AttachEntityToEntity(Config.DataVars.prop_cuffs, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.04, 0.06, 0.0, -85.24, 4.2,
                    -106.6, true, true, false, true, 1, true)
            end
        else
            break
        end
    end
end

RegisterNetEvent('angelo_criminal:handcuff')
AddEventHandler('angelo_criminal:handcuff', function()
    local playerPed = PlayerPedId()

    if not Config.DataVars.ishandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end

        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        RemoveAnimDict('mp_arresting')

        lib.requestModel('p_cs_cuffs_02_s', 100)
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 3.0, 0.5))
        Config.DataVars.prop_cuffs = CreateObjectNoOffset(`p_cs_cuffs_02_s`, x, y, z, true, false)
        SetModelAsNoLongerNeeded(`p_cs_cuffs_02_s`)
        AttachEntityToEntity(Config.DataVars.prop_cuffs, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.04, 0.06, 0.0, -85.24, 4.2,
            -106.6, true, true, false, true, 1, true)

        SetEnableHandcuffs(playerPed, true)
        DisablePlayerFiring(playerPed, true)
        SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
        SetPedCanPlayGestureAnims(playerPed, false)
        Config.DataVars.ishandcuffed = true
        ishandcuffed()
    else
        if Config.DataVars.prop_cuffs then
            DeleteEntity(Config.DataVars.prop_cuffs)
            Config.DataVars.prop_cuffs = nil
        end
        ClearPedSecondaryTask(playerPed)
        ClearPedTasks(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        SetPedCanPlayGestureAnims(playerPed, true)
        Config.DataVars.ishandcuffed = false
    end
end)

function CuffPlayer()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ped_source = PlayerPedId()
    if closestPlayer == -1 or closestDistance > 2.0 then
        Notify("No hay nadie cerca")
        return
    end

    TriggerServerEvent('angelo_criminal:handcuff', GetPlayerServerId(closestPlayer))
end


RegisterCommand("cuff", function ()
    TriggerEvent("angelo_criminal:handcuff")
end)