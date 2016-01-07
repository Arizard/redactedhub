ITEM.Name = "Ex-Human"
ITEM.Description = [[Super Soldier]]
ITEM.StorePrice = 170
ITEM.PlayerModel = "models/player/soldier_stripped.mdl"

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
