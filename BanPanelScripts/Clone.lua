local CloneTable = {"Skianton","TestPlayerName"}

local FirstGui = script:WaitForChild("AdminPanel")
local SecondGui = script:WaitForChild("PlayerListGui")

game.Players.PlayerAdded:Connect(function(player)
	
	local PlayerGui = player:WaitForChild("PlayerGui")
	
	for i, plr in pairs(CloneTable) do
		if player.Name == plr then
			FirstGui:Clone().Parent = PlayerGui
			SecondGui:Clone().Parent = PlayerGui
		end
	end
end)
