ESX.RegisterServerCallback('angelo_criminal:check_item', function(source, cb, itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source) 
    Debugger("ItemName: " .. itemname .. " Count: " .. count)
    if xPlayer.getInventoryItem(itemname).count >= count then 
        xPlayer.removeInventoryItem(itemname, count)
        cb(true) 
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('angelo_criminal:add_item', function(source, cb, itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source) 
    Debugger("Add ItemName: " .. itemname .. " Count: " .. count)
    xPlayer.addInventoryItem(itemname, count)
end)

