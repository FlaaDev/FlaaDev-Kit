fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'FlaaSh'
company 'FlaaDev Kit'
description 'Renting system allows players to rent car/bike'
version '2.0.0'

escrow_ignore {
    'config.lua',
    'locales/*.lua',
}

shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

dependency {
    'es_extended',
}
