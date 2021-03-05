local module = {}

local Admins = {"nehoray1200","Player1"}

local BanDatabase = game:GetService("DataStoreService"):GetDataStore("BanData")

function module:CheckAdmin(player)
	for i, v in pairs(Admins) do
		if player.Name == v then
			return true
		else
			return false
		end
	end
end

function module:CheckTypeBan(Username,TypeBan)
	if TypeBan == true then
		game.ReplicatedStorage:WaitForChild("RACBan"):FireAllClients(Username,true)
	elseif not TypeBan then
		game.ReplicatedStorage:WaitForChild("RACBan"):FireAllClients(Username,false)
	end
end

function module:CheckBan(Username,TypeBan)
	if TypeBan then
		return true
	elseif not TypeBan then
		return false
	end
end

return module
