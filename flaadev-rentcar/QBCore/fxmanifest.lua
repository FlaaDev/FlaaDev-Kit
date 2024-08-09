fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'FlaaSh'
company 'FlaaDev Kit'
description 'Renting system allows players to rent car/bike'
version '1.0.0'

escrow_ignore {
    'config.lua',
    'locales/empty.lua',
}

shared_scripts {
    '@qb-core/shared/locale.lua',
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
    'qb-core',
    'qb-target',
    'qb-inventory',
    'qb-menu'
}
