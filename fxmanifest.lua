fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author '@devangelo25 on discord'
description 'Criminal Complete Scripts'
version '1.0.0'
lua54 'yes'

shared_scripts {
    "@es_extended/imports.lua",
    '@ox_lib/init.lua',
    "shared/*.lua",
}

client_scripts {
    "client/*.lua",
    "client/interaction_menu/*.lua",
}

server_scripts {
    "server/*.lua",
}

ui_page {
    "dist/index.html"
}

files {
	'dist/index.html',
	'dist/styles/*.css',
    'dist/javascript/*.js',
    'dist/assets/*.png',
}

dependencies {
    "ox_lib", 
    "lockpick", -- https://github.com/baguscodestudio/lockpick
}