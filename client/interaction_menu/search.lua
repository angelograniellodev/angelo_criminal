function SearchPlayerInventory()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local ped_source = PlayerPedId()
    if not closestPlayer == -1 or closestDistance > 2.0 then 
        Notify("No hay nadie cerca")
        return
    end

    exports.ox_inventory:openNearbyInventory() --Ox inventory supports
end