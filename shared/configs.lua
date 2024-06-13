Config = {}

Config.Debug = true 

function Debugger(msg)
    if Config.Debug then 
        print("[ANGELO CRIMINAL] ".. msg)
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
            bag_on_head = true, --Bolsa en la cabeza
            vehicle_info = true, --Info de la placa a nombre de quien esta
            vehicle_steal = true, --Quitar seguro de las puertas
            take_hostage = true, --Tomar de reheen (th)
        },
    },
}