local BanDatabase = game:GetService("DataStoreService"):GetDataStore("BanData")

local module = require(script:WaitForChild("ModuleScript"))

local TimebanModule = require(script:WaitForChild("ModuleTimeban"))

game.ReplicatedStorage:WaitForChild("RACBan").OnServerEvent:Connect(function(player,Username,Reason,BanType,Time)
	if module:CheckAdmin(player) and player ~= nil and Username ~= nil and Reason ~= nil and Time == nil then
		print(player.Name.." Banning ".. Username.. " For Reason: ".. Reason)
		local data
		local ReasonData
		local playerBanned = game.Players:GetUserIdFromNameAsync(Username)
		if playerBanned then
			local success, errormessage = pcall(function()
				data = BanDatabase:SetAsync(playerBanned,BanType)
				ReasonData = BanDatabase:SetAsync(playerBanned.."-reason",tostring(Reason))
			end)
			module:CheckTypeBan(Username,BanType)
			if success and game.Players:FindFirstChild(Username) and BanType then
				print("Saved")
				game.Players:FindFirstChild(Username):Kick("You're Banned Reason: "..Reason)
			elseif not success and game.Players:FindFirstChild(Username) and BanType then
				print("Could'nt Saved")
				game.Players:FindFirstChild(Username):Kick("You're Banned Reason: "..Reason)
			end
		end
	elseif Time ~= nil then
		local playerBan = game.Players:GetUserIdFromNameAsync(Username)
		TimebanModule.TimeBan(Username,Time,"days")
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	local data
	local ReasonData
	local success, errormessage = pcall(function()
		data = BanDatabase:GetAsync(player.UserId)
	end)
	if success then
		if data then
			local succe, errmss = pcall(function()
				ReasonData = BanDatabase:GetAsync(player.UserId.."-reason")
			end)
			if succe then
				player:Kick("You're Banned Reason: ".. ReasonData)
			end
		end
	end
end)

