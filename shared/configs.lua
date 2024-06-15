Config = {}

Config.Debug = true 

function Debugger(msg)
    if Config.Debug then 
        print("[^6Angelo Criminal^0] " .. msg)
    end
end

Config.Criminals = {
    Ballas = {
        jobs = {
            "mechanic",
        },
        stash = {
            stash_coords = vector3(85.292313, -1958.822021, 21.107666),
            stash_name = "ballas",
        },
        interactions_menu = {
            cuff = true, --Esposas
            search = true, --Cachear persona
            bag_on_head = true, --Bolsa en la cabeza
            vehicle_steal = true, --Quitar seguro de las puertas
            take_hostage = true, --Tomar de reheen (th)
        },
    },
}

Config.DataVars = {
    prop_bag = nil,
    prop_cuffs = nil,
    onbag_use = false,
    on_cuff_use = false,
    ishandcuffed = false,
}

Config.Items = {
    item_bag_head = "bolsa",
    item_bag_head_count = 1,
}