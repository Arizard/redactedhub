ITEM.Name = "info_player_start"
ITEM.Description = [[Fuck hammer, dude.]]
ITEM.StorePrice = 800
ITEM.PlayerModel = "models/player/infoplayerstart.mdl"
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	timer.Simple(1, function() 
		ply:SetModel(self.PlayerModel)
		ply:SetupHands( ply )
	end)
end

function ITEM:OnHolster(ply, id)
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end