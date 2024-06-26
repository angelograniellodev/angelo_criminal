local function StealVehicle()
    local vehicle = ESX.Game.GetVehicleInDirection()
    
    if not vehicle or not DoesEntityExist(vehicle) then
        Notify("No hay ningún carro enfrente de ti")
        return
    end

    ESX.TriggerServerCallback('angelo_criminal:check_item', function(hasItem)
        if not hasItem then
            Notify("No tienes un lockpick")
            return
        end

        local result = exports['lockpick']:startLockpick()
        if result then
            SetVehicleDoorsLocked(vehicle, 1)
            Notify("Abriste las puertas del vehículo")
            DispatchPoliceAlert("Entorno: Una persona acaba de robar un vehículo enfrente de mí, la placa es: " .. GetVehicleNumberPlateText(vehicle))
        else
            Notify("No lograste abrir el carro")
        end
    end, "lockpick", 1) 
end

local function OpenActionsMenu()
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job.name

    local canOpenMenu = false
    local menuElements = {}

    for gang, data in pairs(Config.Criminals) do
        for _, job in ipairs(data.jobs) do
            if job == playerJob then
                canOpenMenu = true
                Debugger("MENU CRIMINAL ABIERTO PERFECTAMENTE")
                if data.interactions_menu.cuff then
                    table.insert(menuElements, { label = 'Esposar', value = 'cuff' })
                    table.insert(menuElements, { label = 'LLevar Esposado', value = 'drag' })
                end
                if data.interactions_menu.search then
                    table.insert(menuElements, { label = 'Cachear', value = 'search' })
                end
                if data.interactions_menu.bag_on_head then
                    table.insert(menuElements, { label = 'Bolsa en la cabeza', value = 'bag_on_head' })
                end
                if data.interactions_menu.vehicle_info then
                    table.insert(menuElements, { label = 'Información del vehículo', value = 'vehicle_info' })
                end
                if data.interactions_menu.vehicle_steal then
                    table.insert(menuElements, { label = 'Robar vehículo', value = 'vehicle_steal' })
                end
                if data.interactions_menu.take_hostage then
                    table.insert(menuElements, { label = 'Tomar de rehén', value = 'take_hostage' })
                end
                break
            end
        end
        if canOpenMenu then
            break
        end
    end

    if canOpenMenu and #menuElements > 0 then
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'actions_menu',
            {
                title    = 'Acciones Criminales',
                align    = 'bottom-right',
                elements = menuElements
            },
            function(data, menu)
                local action = data.current.value

                if action == 'cuff' then
                    CuffPlayer()
                    menu.close()
                elseif action == 'drag' then
                    UnCuffPlayer()
                    menu.close()
                elseif action == 'bag_on_head' then
                    if Config.DataVars.onbag_use then 
                        Notify("Tienes que esperar 5 segundos para volver a usar esto")
                        return
                    end
                    Config.DataVars.onbag_use = true
                    menu.close()
                    PutHeadBagInPlayer()
                elseif action == 'vehicle_steal' then
                    StealVehicle()
                    menu.close()
                elseif action == 'take_hostage' then
                    TakeHostage()
                    menu.close()
                elseif action == 'search' then 
                    SearchPlayerInventory()
                    menu.close()
                end
            end,
            function(data, menu)
                menu.close()
            end
        )
    end
end



RegisterCommand("openmenuilegal", function()
    OpenActionsMenu()
end, false)


RegisterKeyMapping('openmenuilegal', 'Menu Criminal', 'keyboard', 'F6')
