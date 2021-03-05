game.Players.PlayerAdded:Connect(function(player)
	wait(2)
	game.ReplicatedStorage:WaitForChild("JoinLeave"):FireAllClients(player.Name,true)
end)

game.Players.PlayerRemoving:Connect(function(player)
	wait(2)
	game.ReplicatedStorage:WaitForChild("JoinLeave"):FireAllClients(player.Name,false)
end)