resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX truck inventory'

version '1.0.0'

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/classes/c_truck.lua',
  'server/truck.lua',
  'server/main.lua'
}

client_scripts {
  'config.lua',
  'client/main.lua'
}
