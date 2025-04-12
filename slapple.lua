repeat task.wait(0.1) until game:IsLoaded() == true
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

if game.PlaceId == 11520107397 then
    game:GetService("TeleportService"):Teleport(9015014224)
elseif game.PlaceId == 9015014224 or game.Placeid == 6403373529 then
    game:GetService("TeleportService"):Teleport(11520107397)
end
