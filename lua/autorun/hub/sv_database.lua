print("Loaded sv_database.lua")
include("shared.lua")

function RS:DBInit()

	--sql.Query("DROP TABLE shop_items")
	sql.Query("CREATE TABLE IF NOT EXISTS shop_items (ID INTEGER PRIMARY KEY, category string, class string, equipped int, owner_id64 string, owner_name string)")
	local res = sql.Query("SELECT * FROM shop_items WHERE 1")
	if res == false then print(sql.LastError()) end

	self.ExistingItems = res
 
 	--sql.Query("DROP TABLE shop_money")
	sql.Query("CREATE TABLE shop_money (money int, owner_id64 string)" )
	--print(sql.LastError(), "Creating new table shop_money")
	sql.Query("INSERT INTO shop_money (money, owner_id64) VALUES (10000, '0')")

	--RS:CreateItemManual( RS.Items["test_material"], "00000", "SERVER" )
	--RS:ChangeItemOwner(7, player.GetByID(1))
end


function RS:DropTables()

	sql.Query("DROP TABLE shop_items")
	sql.Query("DROP TABLE shop_money")

	RS:DBInit()

	for k,v in ipairs(player.GetAll()) do 
		v:SyncMoney()
	end

	RS:SyncStoreMoney()
end

concommand.Add("shop_drop", function(ply)
	if ply:IsSuperAdmin() then
		RS:DropTables()
	end
end)

function RS:CreateItem( item, ply ) -- item is a table, loaded from the item file

	print("Attempting to create new item...")
	local res = sql.Query("INSERT INTO shop_items (category, class, equipped, owner_id64, owner_name) VALUES ('"..item.Category.."', '"..item.Class.."',0,'"..ply:SteamID64().."','"..Base64Encode(ply:Nick()).."')")
	if res == false then print(sql.LastError()) end

end

function RS:CreateItemManual( item, id64, name )
	print("Attempting to manually create new item...")
	local res = sql.Query("INSERT INTO shop_items (category, class, equipped, owner_id64, owner_name) VALUES ('"..item.Category.."', '"..item.Class.."',0,'"..id64.."','"..Base64Encode(name).."')")
	if res == false then print(sql.LastError()) end
end

function RS:DestroyItem( itemid )

	print("Destroying item...")
	local res = sql.Query("DELETE FROM shop_items WHERE ID = "..tostring(itemid))
	if res == false then print(sql.LastError()) end

end

function RS:RemoveItemsFromPlayer( id64, class ) -- give the item back to the store
	local res = sql.Query( "SELECT ID FROM shop_items WHERE ( class = '"..class.."' AND owner_id64 = '"..id64.."' )")
	if res then
		for k,v in pairs( res ) do
			RS:ChangeItemOwnerManual( v["ID"], "0", "SERVER" )
		end
	end
end

function RS:HasInventorySpace( ply )
	local id64 = ply:SteamID64()
	local res = sql.Query( "SELECT ID FROM shop_items WHERE ( owner_id64 = '"..id64.."' )")
	if not res then
		return false
	end
	if #res < RS.InventoryLimit then
		return true
	else
		return false
	end
end

function RS:ChangeItemOwner( itemid, ply )

	print("changing item",itemid,"to owner",ply:Nick())
	local res = sql.Query("UPDATE shop_items SET owner_id64='"..ply:SteamID64().."', owner_name='"..Base64Encode(ply:Nick()).."' WHERE ID="..tostring(itemid))
	if res == false then print(sql.LastError()) end

end

function RS:ChangeItemOwnerManual( itemid, id64, nick )

	print("changing item",itemid,"to owner",nick)
	local res = sql.Query("UPDATE shop_items SET owner_id64='"..id64.."', owner_name='"..Base64Encode(nick).."' WHERE ID="..tostring(itemid))
	if res == false then print(sql.LastError()) end

end

function RS:GetDatabase()
	print("retrieving database")
	local res = sql.Query("SELECT * FROM shop_items")
	return res
end

function RS:GetOwnedItems(ply)
	print("retrieving owned items for",ply:Nick())
	local res = sql.Query("SELECT * FROM shop_items WHERE owner_id64='"..ply:SteamID64().."'")
	if res == false then print(sql.LastError()) return end
	return res
end

function RS:GetEquippedItems( ply )
	local res = sql.Query("SELECT * FROM shop_items WHERE owner_id64='"..ply:SteamID64().."' AND equipped=1")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		return res
	end
end

function RS:GetStoreItems( class )
	print("retrieving owned items for SERVER")
	local res
	if not class then
		res = sql.Query("SELECT * FROM shop_items WHERE owner_id64='0'")
	else
		res = sql.Query("SELECT * FROM shop_items WHERE owner_id64='0' AND class='"..class.."'")
	end
	if res == false then print(sql.LastError()) return end
	return res
end

function RS:GetStoreStock( class )
	--print("retrieving stock for item "..tostring(class))
	local res = sql.Query("SELECT ID FROM shop_items WHERE class='"..class.."' AND owner_id64 = '0'")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		return #res
	else
		return 0
	end
end

function RS:ToggleItem( ply, id )
	if self:ItemEquipped( id ) == true then
		self:HolsterItem( ply, id )
		self:PlayerHolster(ply, id)
	else
		self:EquipItem( ply, id )
		self:PlayerEquip( ply, id )
	end
end

function RS:EquipItem( ply, id ) 
	local res = sql.Query( "UPDATE shop_items SET equipped=1 WHERE ID="..tostring(id).."")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		--return res
	end

	--RS:PlayerEquip( ply, id)
end

function RS:PlayerEquip( ply, id)
	--do the necessary thingos
	--get class
	local res = sql.Query( "SELECT class FROM shop_items WHERE ID="..tostring(id))
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		local class = res[1]["class"]
		local item = RS.Items[class]
		if item then
			item:OnEquip( ply, id )
		end
	end
end
function RS:HolsterItem( ply, id )
	local res = sql.Query( "UPDATE shop_items SET equipped=0 WHERE ID="..tostring(id).."")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		return res
	end

	--RS:PlayerHolster(ply, id)
end
function RS:PlayerHolster( ply, id)
	--do the necessary thingos
	--get class
	local res = sql.Query( "SELECT class FROM shop_items WHERE ID="..tostring(id))
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		local class = res[1]["class"]
		local item = RS.Items[class]
		if item then
			item:OnHolster( ply, id )
		end
		
	end
end
function RS:ItemEquipped( id )
	local res = sql.Query( "SELECT equipped FROM shop_items WHERE ID="..tostring(id) )
	if res == false then print(sql.LastError()) return end

	if res ~= nil then
		--PrintTable(res)
		return tobool(res[1]["equipped"])
	end
end

function RS:DoesPlayerOwn( ply, id )
	local res = sql.Query( "SELECT class FROM shop_items WHERE ID="..tostring(id).." AND owner_id64='"..ply:SteamID64().."'" )
	if res == false then print(sql.LastError()) return end

	if res ~= nil then
		--PrintTable(res)
		return true
	else
		return false
	end
end

function RS:DoesPlayerOwnClass( ply, class )
	local res = sql.Query( "SELECT equipped FROM shop_items WHERE class='"..tostring(class).."' AND owner_id64='"..ply:SteamID64().."'" )
	if res == false then print(sql.LastError()) return end

	if res ~= nil then
		--PrintTable(res)
		local equipped = false
		for k,v in ipairs(res) do
			if tobool(v["equipped"]) ==  true then
				equipped = true
			end
		end
		return true, equipped
	else
		return false, false
	end
end

function RS:GetItemTable( id )
	local res = sql.Query( "SELECT class FROM shop_items WHERE ID="..tostring(id) )
	if res == false then print(sql.LastError()) return end

	if res ~= nil then
		return RS.Items[res[1]["class"]], res[1]["class"]
	end


end
-- concommand.Add("shop_spawnself", function(ply, cmd, args)
-- 	if ply:IsSuperAdmin() then
-- 		RS:CreateItem( RS.Items[args[1]], ply )
-- 	end


-- end)

concommand.Add("shop_createstock", function(ply, cmd, args)
	if ply:IsSuperAdmin() then
		for i = 1, args[2] do
			RS:CreateItemManual( RS.Items[args[1]], "0", "SERVER")
		end	
	end
end)
concommand.Add("shop_destroy", function(ply, cmd, args)
	if ply:IsSuperAdmin() then
		--for i = 1, args[2] do
			RS:DestroyItem( tonumber(args[1]) )
		--end
	end
end)
concommand.Add("shop_viewdb", function(ply, cmd, args)
	if ply:IsSuperAdmin() then
		PrintTable(RS:GetDatabase())
	end
end)

concommand.Add("shop_changeowner", function(ply, cmd, args)
	if ply:IsSuperAdmin() then
		RS:ChangeItemOwnerManual(args[1], args[2], args[3])
	end
end)

concommand.Add("shop_transfer_store2player", function(ply, cmd, args)
	if ply:IsSuperAdmin() then
		local amt = tonumber(args[2])
		local id = args[1]

		local found = false
		local fply = nil

		for k,v in ipairs(player.GetAll()) do
			if v:SteamID64() == id then
				found = true
				fply = v
			end
		end

		if found == true then
			fply:AddMoney(amt)
			RS:SubStoreMoney(amt)
		else
			ply:ChatPrint("Couldn't find player.")
		end
	end
end)



-- player money

local PLAYER = FindMetaTable("Player")

function PLAYER:GetMoney()
	local res = sql.Query("SELECT * FROM shop_money WHERE owner_id64='"..self:SteamID64().."'")
	if res == false then print(sql.LastError()) return end

	if res ~= nil then
		local money = tonumber(res[1]["money"])
		return money
	else
		sql.Query("INSERT INTO shop_money (money, owner_id64) VALUES (0, '"..self:SteamID64().."')")
		--print(sql.LastError())
		print("No Money Found for",self:Nick())
		return 0
	end
	return -1
	
end

function PLAYER:SetMoney( amt )
	local cur = self:GetMoney()

	local res = sql.Query("UPDATE shop_money SET money="..amt.." WHERE owner_id64='"..self:SteamID64().."'")
	--print(sql.LastError(), "MEMEMEMEMEME")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		--local money = tonumber(res[1]["money"])
		--return money
	end

	self:SyncMoney()
end

function PLAYER:AddMoney( amt )
	self:SetMoney( self:GetMoney() + amt )
end
function PLAYER:SubMoney( amt )
	self:SetMoney( self:GetMoney() - amt )
end
function PLAYER:SyncMoney()
	self:SetNWInt(RS.PDataMoney, self:GetMoney())
end

function RS:GetStoreMoney()
	local res = sql.Query("SELECT money FROM shop_money WHERE owner_id64='0'")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
		local money = tonumber(res[1]["money"])
		return money
	end
end

function RS:SetStoreMoney( amt )
	local res = sql.Query("UPDATE shop_money SET money="..amt.." WHERE owner_id64='0'")
	if res == false then print(sql.LastError()) return end
	if res ~= nil then
	end
	RS:SyncStoreMoney()
end

function RS:AddStoreMoney( amt )
	RS:SetStoreMoney( RS:GetStoreMoney() + amt )
end
function RS:SubStoreMoney( amt )
	RS:SetStoreMoney( RS:GetStoreMoney() - amt )
end

function RS:SyncStoreMoney()
	SetGlobalInt("StoreMoney",RS:GetStoreMoney())
end

RS:SyncStoreMoney()

-- timer.Create("UpdateStoreMoneyTimer",10,0,function() 
-- 	--print("sending money data to clients...", sql.LastError())

-- 	RS:SyncStoreMoney()
-- 	--print("Store:",RS:GetStoreMoney())
-- 	for k,ply in ipairs(player.GetAll()) do
-- 		ply:SyncMoney()
-- 		--print(ply:Nick(), ply:GetMoney())
-- 	end
	
--end)

hook.Add("PlayerInitialSpawn","SyncMoney",function( ply )
	RS:SyncStoreMoney()
	ply:SyncMoney()
end)

-- NEW PARADIGM -- Marketplace, not "shop"
-- behaves like the steam marketplace
-- players find items in crates or in random drops and create listings on the marketplace to buy and sell
-- needs a database to store all the listings

--sql.Query("CREATE TABLE IF NOT EXISTS shop_listings (id int, price int, ")