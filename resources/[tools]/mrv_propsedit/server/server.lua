local accessToMenu = {
    "steam:11000010f7890dd", -- MRV
    "steam:110000112a8ab79", -- iPro,
    "steam:110000119263fbb" -- DVR
}

local function canOpenMenu(player)
    local canOpen = false

    for _, adminID in pairs(accessToMenu) do
        for _, steamID in pairs(GetPlayerIdentifiers(player)) do
            if (string.lower(steamID) == string.lower(adminID)) then
                canOpen = true

                break
            end
        end
    end

    return canOpen
end

RegisterServerEvent("mrv_propsedit:sv_open")
AddEventHandler("mrv_propsedit:sv_open", function()
    local _source = source

    if (canOpenMenu(_source)) then
        TriggerClientEvent("mrv_propsedit:cl_open", _source)
    end
end)