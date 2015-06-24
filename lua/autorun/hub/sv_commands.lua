print("loaded shop commands file")

local function FindPlayersByName( nick ) -- returns a table of players with name matching nick

	if not nick then return {} end

	if nick == "*" then return player.GetAll() end
	if nick == "^" then return {} end

	local foundplayers = {}

	for _,ply in ipairs(player.GetAll()) do
		if string.find( string.lower(ply:Nick()), string.lower(nick) ) then
			table.insert( foundplayers, ply )
		end
	end

	return foundplayers

end

local function AdminAccess( ply )
	if IsValid(ply) then
		return ply:IsSuperAdmin()
	else
		return true
	end
end

concommand.Add("shop_sendpoints",function(ply, cmd, args)

	if args[1] and args[2] and IsValid( ply ) then
		local targets = FindPlayersByName( args[1] )
		local amount = tonumber( args[2] )

		if #targets > 1 then
			RS:StoreChat( ply, "Too many targets! Try using a more specific name." )
			return false
		end

		if #targets < 1 then
			RS:StoreChat( ply, "No players found with that name." )
			return false
		end

		local targ = targets[1]

		if ply:GetMoney() >= amount then
			ply:SubMoney( amount )
			targ:AddMoney( amount )
			RS:StoreChat( ply, "You gave "..targ:Nick().." "..tostring(amount).." RD")
			RS:StoreChat( targ, "You received "..tostring(amount).." RD from "..ply:Nick() )
		end
	else
		RS:StoreChat(ply, "An Error Occured.")
	end

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_spawnpoints",function(ply, cmd, args)
	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	if args[1] and args[2] then
		local targets = FindPlayersByName( args[1] )
		local amount = tonumber( args[2] )

		if #targets > 1 then
			RS:StoreChat( ply, "Too many targets! Try using a more specific name." )
			return false
		end

		if #targets < 1 then
			RS:StoreChat( ply, "No players found with that name." )
			return false
		end

		local targ = targets[1]

		--if ply:GetMoney() >= amount then
			--ply:SubMoney( amount )
			targ:AddMoney( amount )
			RS:StoreChat( ply, "You spawned "..targ:Nick().." "..tostring(amount).." RD")
			RS:StoreChat( targ, "You received "..tostring(amount).." RD from the aether!" )
		--end
	else
		RS:StoreChat(ply, "An Error Occured.")
	end

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_setpoints",function(ply, cmd, args)
	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	if args[1] and args[2] then
		local targets = FindPlayersByName( args[1] )
		local amount = tonumber( args[2] )

		if #targets > 1 then
			RS:StoreChat( ply, "Too many targets! Try using a more specific name." )
			return false
		end

		if #targets < 1 then
			RS:StoreChat( ply, "No players found with that name." )
			return false
		end

		local targ = targets[1]

		--if ply:GetMoney() >= amount then
			--ply:SubMoney( amount )
			targ:SetMoney( amount )
			RS:StoreChat( ply, "You set "..targ:Nick().."'s money to "..tostring(amount).." RD")
			RS:StoreChat( targ, "Your money was set to "..tostring(amount).." RD by "..ply:Nick() )
		--end
	else
		RS:StoreChat(ply, "An Error Occured.")
	end

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_spawnitem", function(ply, cmd, args)

	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	if args[1] and args[2] then
		local targets = FindPlayersByName( args[1] )
		--local amount = tonumber( args[2] )

		if #targets > 1 then
			RS:StoreChat( ply, "Too many targets! Try using a more specific name." )
			return false
		end

		if #targets < 1 then
			RS:StoreChat( ply, "No players found with that name." )
			return false
		end

		local targ = targets[1]

		--if ply:GetMoney() >= amount then
			--ply:SubMoney( amount )

			if RS.Items[args[2]] then

				RS:CreateItemManual( RS.Items[args[2]], targ:SteamID64(), targ:Nick() )
				RS:StoreChat( ply, "You spawned "..args[2].." for "..targ:Nick())
				RS:StoreChat( targ, ply:Nick().." spawned you a "..args[2]..". Check your inventory!" )

			else
				RS:StoreChat( ply, "Item not found.")
			end
		--end
	else
		RS:StoreChat(ply, "An Error Occured.")
	end


end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_restock_if_empty", function(ply, cmd, args)

	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	if args[1] == nil then RS:StoreChat(ply, "Please specify amount.") return end
	RS:StoreChat(ply, "Restocking..." )
	for class, item in pairs(RS.Items) do
		local stock = RS:GetStoreStock( class )

		if stock == 0 then
			for i = 1, args[1] do
				print("Restocking "..class)
				RS:CreateItemManual(item, "0","SERVER")
			end
			
		end	
	end
	RS:StoreChat(ply, "Restocked all empty items by "..tostring(args[1]).."." )

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_clearstock", function(ply, cmd, args)

	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	local res = sql.Query("DELETE FROM shop_items WHERE owner_id64 = '0'")
	if res == false then print(sql.LastError()) return end
	if res != nil then
		return #res
	else
		return 0
	end
	RS:StoreChat(ply, "Cleared all stock." )

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_givevip",function(ply, cmd, args)
	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	if args[1] then
		local targets = FindPlayersByName( args[1] )
		local amount = tonumber( args[2] )

		if #targets > 1 then
			RS:StoreChat( ply, "Too many targets! Try using a more specific name." )
			return false
		end

		if #targets < 1 then
			RS:StoreChat( ply, "No players found with that name." )
			return false
		end

		local targ = targets[1]


		targ:GiveVip()
		RS:StoreChat( ply, "You gave VIP to "..targ:Nick())
		

	else
		RS:StoreChat(ply, "An Error Occured.")
	end

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_takevip",function(ply, cmd, args)
	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	if args[1] then
		local targets = FindPlayersByName( args[1] )

		if #targets > 1 then
			RS:StoreChat( ply, "Too many targets! Try using a more specific name." )
			return false
		end

		if #targets < 1 then
			RS:StoreChat( ply, "No players found with that name." )
			return false
		end

		local targ = targets[1]


		targ:TakeVip()
		RS:StoreChat( ply, "You took VIP from "..targ:Nick())
		RS:StoreChat( targ, "You were relieved of your VIP access." )

	else
		RS:StoreChat(ply, "An Error Occured.")
	end

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_addstorepoints",function(ply, cmd, args)
	if AdminAccess( ply ) == false then 
		RS:StoreChat( ply, "No Access." )
		return false
	end

	local amt = tonumber(args[1])
	if amt then
		RS:AddStoreMoney( amt )
		RS:StoreChat(ply, "Added "..tostring(amt).." RD to the store's reserves." )
	else
		RS:StoreChat(ply, "An Error Occured.")
	end

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

concommand.Add("shop_checkvip", function(ply, cmd, args)

	local message = "Listing all donators currently online...\n"

	for k, p in ipairs(player.GetAll()) do
		if p:IsVip() then
			message = message..p:Nick().." is VIP.\n"
		end
	end

	RS:StoreChat( ply, message )

end, nil, nil, FCVAR_SERVER_CAN_EXECUTE )

-- chat commands

RS.ChatCommands = {}

function RS:AddChatCommand(cmd, func)
	RS.ChatCommands[cmd] = func
	print("[HUB] Added chat command "..cmd)
end

function RS:AddChatCommandAlias(cmd, cmd2)
	RS.ChatCommands[cmd2] = RS.ChatCommands[cmd]
	print("[HUB] Added chat command alias "..cmd.." -> "..cmd2)
end

local function ProcessChat( ply, text, public )

	local args = string.Split(text, " ")
	local prefix = string.sub(args[1],1,1)
	local cmd = string.sub(args[1], 2,-1)

	print(prefix, cmd)

	if ((prefix == "!") or (prefix == "/")) and RS.ChatCommands[ cmd ] then
		local cmdfunc = RS.ChatCommands[ cmd ]
		local args2 = {}
		for i = 2, #args do
			args2[i-1] = args[i]
		end

		cmdfunc( ply, args2 )
		if prefix == "/" then return false end
	end

end
hook.Add("PlayerSay","ProcessStoreChat",ProcessChat)

RS:AddChatCommand("test", function(ply, args)
	RS:StoreChat(ply, "The commands work!") 
end)

RS:AddChatCommand("sendrd", function(ply, args)

	ply:ConCommand("shop_sendpoints "..args[1].." "..args[2])

end)

RS:AddChatCommand("spawnrd", function(ply, args)

	ply:ConCommand("shop_spawnpoints "..args[1].." "..args[2])

end)

RS:AddChatCommand("setrd", function(ply, args)

	ply:ConCommand("shop_setpoints "..args[1].." "..args[2])

end)

RS:AddChatCommand("spawnitem", function(ply, args)

	ply:ConCommand("shop_spawnitem "..args[1].." "..args[2])

end)

RS:AddChatCommand("hub", function( ply, args )
	ply:ConCommand("hub_open2")
end)

RS:AddChatCommandAlias("hub","shop")
RS:AddChatCommandAlias("hub","store")

RS:AddChatCommand("restockempty", function(ply, args)
	ply:ConCommand("shop_restock_if_empty "..(args[1] or ""))
end)

RS:AddChatCommand("addstorerd", function(ply, args)
	ply:ConCommand("shop_addstorepoints "..(args[1] or "") )
end)

RS:AddChatCommand("setallstock", function(ply, args)
	ply:ConCommand("shop_setstock_all "..(args[1] or ""))
end)

RS:AddChatCommand("givevip", function(ply, args)
	ply:ConCommand("shop_givevip "..(args[1] or ""))
end)

RS:AddChatCommand("takevip", function(ply, args)
	ply:ConCommand("shop_takevip "..(args[1] or ""))
end)

RS:AddChatCommand("listvip", function(ply)
	ply:ConCommand("shop_checkvip")
end)

RS:AddChatCommand("checkvip", function(ply)
	ply:ConCommand("shop_checkvip")
end)