print("Loaded init.lua")

include("sv_database.lua")
include("sv_commands.lua")

resource.AddFile("materials/trails/color.vmt")

function RS:Initialize()
	RS:DBInit()
	if RS.ExistingItems ~= nil and RS.ExistingItems ~= false then
		print("Printing Database")
		--PrintTable(RS.ExistingItems)
	end
end

util.AddNetworkString("BuyItem")
util.AddNetworkString("SellItem")

util.AddNetworkString("UpdateInventory")

util.AddNetworkString("ToggleItem")

util.AddNetworkString("CreateClientModel")
util.AddNetworkString("DestroyClientModel")

util.AddNetworkString("OpenHub")

util.AddNetworkString("RS_JukeboxNowPlaying")

concommand.Add("hub_open2", function(ply, cmd, args) 

	if not ply.LastHubOpen then ply.LastHubOpen = 0 end

	if ply.LastHubOpen < CurTime() then

		net.Start("OpenHub")
		local data = {}
		data.owneditems = RS:GetOwnedItems(ply)
		data.stock = {}
		data.opentab = tonumber(args[1] or 1)

		--print(type(data.opentab), data.opentab)

		if args[1] then
			data.opentab = args[1]
		end

		for k,v in pairs(RS.Items) do
			data.stock[k] = RS:GetStoreStock(v.Class)
		end

		--PrintTable(data.stock)

		net.WriteTable(data)
		net.Send(ply)

		ply.LastHubOpen = CurTime() + 3
	end
end)

net.Receive("BuyItem", function(len, ply)

	RS:BuyItem(ply, net.ReadString())

end)

hook.Add("ShowSpare1", "OpenHubStuff", function(ply)

	RS:StoreChat( ply, "Opening pointstore - You might experience a bit of lag.")
	ply:ConCommand("hub_open2")

end)

function RS:StoreMessage(ply, msg)
	ply:SendLua([[RS:StoreMessage("]]..msg..[[")]])
end

util.AddNetworkString("RS:StoreChat")

function RS:StoreChat( ply, msg )
	if IsValid( ply ) then
		net.Start( "RS:StoreChat" )
		net.WriteString( msg )
		net.Send(ply)
	else
		print( msg )
	end
end

function RS:StoreBroadcast( msg )
	net.Start("RS:StoreChat")
	net.WriteString( msg )
	net.Broadcast()
	print( msg )
end



function RS:BuyItem( ply, class )

	local item = RS.Items[class]
	local price = item.StorePrice
	local stock = self:GetStoreStock( class )
	local amt = 1
	local money = ply:GetMoney()
	--print("Buyable?",item.Buyable)
	if item.Buyable == false then
		RS:StoreMessage(ply, "You cannot buy this item.")
		return
	end

	if money < item.StorePrice then
		RS:StoreMessage(ply, "Insufficient funds.")
		return
	end
	if stock < amt then
		RS:StoreMessage(ply, "No stock for that item.")
		return
	end

	--assuming the two statements above don't trigger..
	ply:SubMoney(price)
	RS:AddStoreMoney( price )

	local storeitems = RS:GetStoreItems(class)
	local id = storeitems[1]["ID"]

	self:ChangeItemOwner(id, ply)

	--RS:PlayerEquip( ply, id )

	RS:UpdateInventory( ply )

	RS:StoreMessage(ply, "Bought Item "..tostring(id))
end

net.Receive("SellItem", function(len, ply)

	local id  = net.ReadInt(32)
	--ply:ChatPrint( "Received sale id "..tostring(id) )

	RS:SellItem( ply, id )

end)

function RS:SellItem( ply, id )
	--ply:ChatPrint("Attempting to sell item",id)
	if RS:DoesPlayerOwn( ply, id ) then
		local item = RS:GetItemTable( id )

		local saleprice = math.floor(item.StorePrice * RS.RefundRatio)


		if item.Buyable == false then
			RS:StoreMessage(ply, "You cannot sell this item.")
			return
		end

		if RS:GetStoreMoney() < saleprice then
			RS:StoreMessage(ply, "Store is too poor.")
			return false
		end

		RS:PlayerHolster( ply, id )
		ply:AddMoney( saleprice )
		RS:SubStoreMoney( saleprice )
		RS:ChangeItemOwnerManual( id, "0", "SERVER" )

		RS:UpdateInventory( ply )

		RS:StoreMessage(ply, "Sold Item "..tostring(id))
	else
		RS:StoreMessage( ply, "You don't own this." )
	end

end

concommand.Add("moneyhack", function(ply)
	if not ply:IsSuperAdmin() then return end

	ply:AddMoney(1000)
end)

net.Receive("ToggleItem", function(len, ply)

	local n = net.ReadInt( 32 )
	print("Toggling item",n,"for",ply:Nick())
	--print("Is Item Equipped?",RS:ItemEquipped( n ))
	RS:ToggleItem( ply, n )
	ItemEquipAll( ply ) -- re-equip all
	RS:UpdateInventory( ply )
	RS:StoreMessage(ply, "Toggled item "..tostring(n) )
end)

function RS:UpdateInventory( ply )
	local data = self:GetOwnedItems( ply )
	if data == nil then data = {} end

	net.Start("UpdateInventory")
	net.WriteTable(data)
	net.Send( ply )

end

--/ Now handle equipped and unequipped items.

function ItemEquipAll( ply )
	if ply:Team() == TEAM_SPECTATOR or not ply:Alive() then  return end
	local eq = RS:GetEquippedItems( ply )
	if eq ~= nil then
		for k,v in ipairs(eq) do
			if RS.Items[v["class"]] then
				if RS.Items[v["class"]].Category == "hats" or RS.Items[v["class"]].Category == "tokens" then
					RS:PlayerHolster( ply, tonumber(v["ID"]) )
				end
				RS:PlayerEquip( ply, tonumber(v["ID"]) )
			end
		end
	end
end

function ItemPlayerSpawn( ply )
	ply:SetRenderMode( RENDERMODE_TRANSALPHA )
	--print(ply:SteamID64())
	--get equipped items
	ItemEquipAll( ply )

	if ply:Team() == TEAM_SPECTATOR then return end
	local eq = RS:GetEquippedItems( ply )
	if eq ~= nil then
		for k,v in ipairs(eq) do
			if RS.Items[ v["class"] ] then
				RS.Items[v["class"]]:OnSpawn( ply, tonumber(v["ID"]) )
			end
		end
	end

end
hook.Add("PlayerLoadout", "RS:PlayerSpawn", ItemPlayerSpawn)
--hook.Remove("PlayerLoadout","RS:PlayerSpawn")
function ItemHolsterAll( ply )
	local eq = RS:GetEquippedItems( ply )
	if eq ~= nil then
		for k,v in ipairs(eq) do
			RS:PlayerHolster( ply, tonumber(v["ID"]) )
		end
	end
end
function ItemPlayerDeath( ply )
	ItemHolsterAll( ply )
	if ply:Team() == TEAM_SPECTATOR then return end
	local eq = RS:GetEquippedItems( ply )
	if eq ~= nil then
		for k,v in ipairs(eq) do
			if RS.Items[v["class"]] then
				RS.Items[v["class"]]:OnDeath( ply, tonumber(v["ID"]) )
			end
		end
	end
end
hook.Add("PlayerDeath", "RS:PlayerDeath", ItemPlayerDeath)


RS.CachedClientModels = {}

function RS:CreateClientModel( mdl, att, posoff, angoff, scl, mat, col, ply, id )

	local cmod = {}
	cmod.mdl = mdl
	cmod.att = att
	cmod.posoff = posoff
	cmod.angoff = angoff
	cmod.scl = scl
	cmod.mat = mat
	cmod.col = col
	cmod.ply = ply
	cmod.id = id
	cmod.isToken = false
	cmod.id64 = ply:SteamID64()


	table.insert(RS.CachedClientModels, cmod)

	net.Start("CreateClientModel")
	net.WriteTable( cmod )
	net.Broadcast()

end

function RS:CreateClientToken( ply, id, class )

	local cmod = {}
	cmod.mdl = "models/dav0r/thruster.mdl"
	cmod.att = "chest"
	cmod.posoff = Vector(2,2,2)
	cmod.angoff = Angle(-90,-10,20)
	cmod.scl = 0.6
	cmod.mat = ""
	cmod.col = Color(255,255,255)
	cmod.ply = ply
	cmod.id = id
	cmod.isToken = true
	cmod.class = class
	cmod.id64 = ply:SteamID64()

	table.insert(RS.CachedClientModels, cmod)

	net.Start("CreateClientModel")
	net.WriteTable( cmod )
	net.Broadcast()

end

function RS:DestroyClientModel( id )

	for k,v in ipairs(RS.CachedClientModels) do
		if v.id == id then
			table.remove(RS.CachedClientModels, k)
		end
	end

	net.Start("DestroyClientModel")
	net.WriteInt( id, 32 )
	net.Broadcast()
end

util.AddNetworkString("SendClientModelsOnSpawn")

function ShopInitialSpawn( ply )
	
	ply.ShopFirstSpawn = true
end
hook.Add("PlayerInitialSpawn","RS:InitialSpawn",ShopInitialSpawn)

function ShopFirstSpawn( ply )

	if ply.ShopFirstSpawn == true then
		if not ply:Alive() or ply:GetObserverMode() ~= OBS_MODE_NONE then
			ItemHolsterAll( ply )
		end


		print("Sending client models to "..ply:Nick())

		net.Start("SendClientModelsOnSpawn")
		net.WriteTable(RS.CachedClientModels)
		net.Send(ply)

		ply.ShopFirstSpawn = false
	end


end
hook.Add("PlayerSpawn","RS:FirstSpawn", ShopFirstSpawn)

function ShopLoadout( ply )

	if not ply:Alive() or ply:GetObserverMode() ~= OBS_MODE_NONE then
		ItemHolsterAll( ply )
	else
		ply.HasLoadedOutAndNeedsEquip = true
	end

end
hook.Add("PlayerLoadout", "RS:Loadout", ShopLoadout)



--do stuff on team changed
function RS:PlyTeamChanged(ply, ot, nt)

	if nt == TEAM_SPECTATOR then
		ItemHolsterAll(ply)
	end

end
hook.Add("OnPlayerChangedTeam","RS:PlyTeamChanged",RS.PlyTeamChanged)

timer.Create("CheckForSpectators", 5,0, function()

	for k, ply in ipairs(player.GetAll()) do
		if ply:GetObserverMode() ~= OBS_MODE_NONE or ply:Team() == TEAM_SPECTATOR or not ply:Alive() then
			ItemHolsterAll( ply )
		else
			if ply.HasLoadedOutAndNeedsEquip == true then
				ItemPlayerSpawn( ply )
				ply.HasLoadedOutAndNeedsEquip = false
			end
		end
	end

end)

function ShopPlayerDisconnect(ply)

	for k,v in ipairs(RS.CachedClientModels) do
		if v.id64 == ply:SteamID64() then
			table.remove(RS.CachedClientModels, k)
		end
	end

end
hook.Add("PlayerDisconnect","RS:PlayerDisconnect",ShopPlayerDisconnect)

concommand.Add("shop_taunt", function(ply, cmd, args) -- handle taunts
	if ply:Alive() and ply:GetObserverMode() == OBS_MODE_NONE and ply:Team() ~= TEAM_SPECTATOR then
		if not ply.NextTaunt then ply.NextTaunt = 0 end
		if ply.ChoiceTaunt and ply.NextTaunt then
			if ply.NextTaunt < CurTime() then
				ply:EmitSound( ply.ChoiceTaunt )
				ply.NextTaunt = CurTime() + 35
			end
		end
	end
end)

local PLAYER = FindMetaTable('Player')


function PLAYER:IsVip()
	local ug = self:GetNWString("usergroup", "user")

	if ug == "owner" or ug == "superadmin" or string.sub(ug,1, 7) == "donator" or string.sub(ug,1,3) == "vip" or string.sub(ug,1,7) == "founder" or self:IsSuperAdmin() then
		return true
	end

	local has_vip = tobool( self:GetPData("has_vip", false) )

	return has_vip
end

function PLAYER:GiveVip()
	self:SetPData("has_vip", true)
	self:SendLua("RS:ReceiveVip()")
	RS:StoreChat( self, "You were awarded VIP access!" )
	UpdateDonatorStatus(self)
end
function PLAYER:TakeVip()
	self:SetPData("has_vip", false)
	UpdateDonatorStatus(self)
end

function UpdateDonatorStatus(ply)
	ply:SetNWBool("has_vip", tobool(ply:GetPData("has_vip", false)))
end

hook.Add("PlayerInitialSpawn", "UpdateDonatorStatus", UpdateDonatorStatus)
hook.Add("PlayerLoadout", "UpdateDonatorStatus", UpdateDonatorStatus)


-- jukebox notification functionality
local lastJukeboxUpdate = 0
local jukeUpdateInterval = 60
net.Receive("RS_JukeboxNowPlaying", function(len, ply)
	local current = util.JSONToTable( net.ReadString() )

	if not ( lastJukeboxUpdate+jukeUpdateInterval > CurTime() ) then

		lastJukeboxUpdate = CurTime()
		RS:StoreBroadcast(ply:Nick().." is now listening to "..current[2].." by "..current[1].."! Type /juke to listen to more music!")

	end
end)
