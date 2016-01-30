ITEM.Name = "Stormtrooper"
ITEM.Description = "*Does not affect aim"
ITEM.StorePrice = 1200
ITEM.PlayerModel = "models/player/stormt.mdl"

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