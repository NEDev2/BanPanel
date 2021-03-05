local EZban = {}

local DS = game:GetService("DataStoreService")
local MS = game:GetService("MessagingService")
local store = game:GetService("DataStoreService"):GetDataStore("TimeBanInfo")
local Timenow = os.time()
local plrs = game:GetService("Players")

local updatetime = coroutine.create(function()
	while wait(1) do
		Timenow = os.time()
	end
end)
coroutine.resume(updatetime)

local function round(n)
	return math.floor(n+.5)
end

game.Players.PlayerAdded:Connect(function(player)
	
	local data
	local success, errormessage = pcall(function()
		data = store:GetAsync(player.UserId.."-Timeban")
	end)
	if success and data ~= nil then
		local Mode = data[2]
		local TLIS = os.difftime(data[1],Timenow)
		local timeleft = 0
		local finaltime = nil
		if TLIS > 0 then
			if Mode == "minutes" then timeleft = TLIS/60	elseif Mode == "hours" then timeleft = TLIS/3600	elseif Mode == "days" then timeleft = TLIS/86400	elseif Mode == "weeks" then timeleft = TLIS/604800 end
			if timeleft > 1 then
				finaltime = round(timeleft)
			end
			if finaltime ~= nil then
				player:Kick("You were banned from the game. You will be unbanned in "..tostring(finaltime).." "..data[2])
			else	
				player:Kick("You were banned from the game. You will be unbanned in "..tostring(timeleft).." "..data[2])
			end
		end
	end
end)


function EZban.TimeBan(User,Length,Mode)
	--Mode = "minutes"
	local UserId = plrs:GetUserIdFromNameAsync(User)
	local LIS = 0
	Mode = string.lower(Mode)
	if Mode == "minutes" then LIS = Length*60	elseif Mode == "hours" then LIS = Length*3600	elseif Mode == "days" then LIS = Length*86400	elseif Mode == "weeks" then LIS = Length*604800 end	
	local endE = Timenow + LIS
	local info = {endE,Mode,UserId}
	store:SetAsync(UserId.."-Timeban",info)
	if plrs:GetPlayerByUserId(UserId) then
		plrs:GetPlayerByUserId(UserId):Kick("You were banned for "..Length.." "..Mode)
	end
end

return EZban