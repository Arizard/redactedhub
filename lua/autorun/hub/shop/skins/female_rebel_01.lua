ITEM.Name = "Female Rebel 1"
ITEM.Description = "Resistance."
ITEM.StorePrice = 100
ITEM.PlayerModel = "models/player/group03/female_01.mdl"

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