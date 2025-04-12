local teleportService = game:GetService("TeleportService")

local function getServerList()
    local serverList = {}
    local success, result = pcall(function()
        return teleportService:GetPlayerPlaceInstanceAsync(game.PlaceId)
    end)
    
    if success then
        for _, v in ipairs(result) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(serverList, v.id)
            end
        end
    end
    return serverList
end
