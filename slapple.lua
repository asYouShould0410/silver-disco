if not game:IsLoaded() then
    game.Loaded:Wait()
end
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
    if v.Glove:FindFirstChild("TouchInterest") then
        if not game.Players.LocalPlayer.Character:FindFirstChild("entered") then
            repeat task.wait()
                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), workspace.Lobby.Teleport2, 0)
                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), workspace.Lobby.Teleport2, 1)
            until game.Players.LocalPlayer.Character:FindFirstChild("entered")
        end
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Glove, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Glove, 1)
    end
end

local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")

local function getServerList()
    local serverList = {}
    local success, result = pcall(function()
        return httpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    
    if success then
        for _, v in ipairs(result.data) do
            if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                table.insert(serverList, v.id)
            end
        end
    end
    return serverList
end

local serverList = getServerList()
if #serverList == 0 then
    error("No servers found")
end

while true do
    local selectedServer = serverList[math.random(1, #serverList)]
    local success, errorMessage = pcall(function()
        teleportService:TeleportToPlaceInstance(game.PlaceId, selectedServer)
    end)
    
    if success then
        break
    else
        if string.find(errorMessage:lower(), "rate limit") then
            warn("Rate limit hit. Retrying in 2 seconds...")
            task.wait(2)
        else
            warn("Teleport error (" .. errorMessage .. "). Retrying...")
            task.wait(2)
        end
    end
end
