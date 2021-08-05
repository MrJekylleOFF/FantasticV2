ESX = nil 
TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterUsableItem('jumelles', function(source)
	TriggerClientEvent('binoculars:Activate', source)
end)