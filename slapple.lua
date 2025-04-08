local HttpService = game:GetService("HttpService")

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if ((game.PlaceId == 6403373529) or (game.PlaceId == 9015014224) or (game.PlaceId == 11520107397)) then
	local teleportScript = [[
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
for i, v in pairs(game:GetService("Workspace"):WaitForChild("CandyCorns"):GetChildren()) do  
	if v:FindFirstChildWhichIsA("TouchTransmitter") then  
		firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)  
		firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 1)  
	end  
end  
task.wait(0.1)
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
	firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 0) 
	firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 1) 
end
task.wait(0.1)  
for i, v in ipairs(workspace.Arena.island5.Slapples:GetDescendants()) do  
	if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Glove" and v:FindFirstChildWhichIsA("TouchTransmitter") then  
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)  
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)  
	end  
end  
task.wait(0.6)
loadstring(game:HttpGet("https://raw.githubusercontent.com/asYouShould0410/silver-disco/refs/heads/main/slapple.lua"))()
]]
	writefile("AutoTeleportFarm.lua", teleportScript)

	local teleportFunc = queueonteleport or queue_on_teleport
	if teleportFunc then
		teleportFunc("loadstring(readfile('AutoTeleportFarm.lua'))()")
	end

	local serverList = {}
	local cacheFile = "ServerCache_" .. game.PlaceId .. ".json"

	local function safeJSONDecode(data)
		local success, result = pcall(function()
			return HttpService:JSONDecode(data)
		end)
		if success and type(result) == "table" then
			return result
		end
		return nil
	end

	if isfile(cacheFile) then
		local success, content = pcall(readfile, cacheFile)
		if success then
			local decoded = safeJSONDecode(content)
			if decoded then
				serverList = decoded
			end
		end
	end

	if #serverList == 0 then
		local success, response = pcall(function()
			return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
		end)

		if success then
			local decoded = safeJSONDecode(response)
			if decoded and decoded.data then
				for _, v in ipairs(decoded.data) do
					if v and type(v) == "table" and v.playing and v.maxPlayers and v.id and v.maxPlayers > v.playing and v.id ~= game.JobId then
						table.insert(serverList, v.id)
					end
				end
				pcall(function()
					writefile(cacheFile, HttpService:JSONEncode(serverList))
				end)
			end
		end
	end

	if #serverList > 0 then
		task.wait(7)
		pcall(function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
		end)
	end
end
