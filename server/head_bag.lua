RegisterServerEvent('angelo_criminal:send_bag:sv')
AddEventHandler('angelo_criminal:send_bag:sv', function(closestPlayer)
    TriggerClientEvent("angelo_criminal:head_bag:cl", closestPlayer)
end)