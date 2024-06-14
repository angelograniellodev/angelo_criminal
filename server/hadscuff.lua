RegisterNetEvent('angelo_criminal:handcuff')
AddEventHandler('angelo_criminal:handcuff', function(target)
	TriggerClientEvent('angelo_criminal:handcuff', target)
end)