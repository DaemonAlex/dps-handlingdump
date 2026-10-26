fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps-handlingdump'
author 'Del Perro Sands'
description 'ONE-OFF DEV TOOL: /handlingdump spawns every vanilla vehicle locally, reads its handling from the game and writes out/vanilla-handling.json on the server. Remove after use.'
version '0.1.0'

shared_script 'shared/fields.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'data/models.json',
}
