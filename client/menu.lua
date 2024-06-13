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
                -- Añadir las opciones del menú según interactions_menu
                if data.interactions_menu.cuff then
                    table.insert(menuElements, { label = 'Esposar', value = 'cuff' })
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
                    -- Añade la funcionalidad de esposar
                elseif action == 'bag_on_head' then
                    -- Añade la funcionalidad de poner bolsa en la cabeza
                elseif action == 'vehicle_info' then
                    -- Añade la funcionalidad de información del vehículo
                elseif action == 'vehicle_steal' then
                    StealVehicle()
                elseif action == 'take_hostage' then
                    -- Añade la funcionalidad de tomar de rehén
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
