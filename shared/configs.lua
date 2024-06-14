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
    onbag_use = false,
}