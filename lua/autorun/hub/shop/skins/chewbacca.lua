ITEM.Name = "Chewbacca"
ITEM.Description = "\"Chewie\""
ITEM.StorePrice = 1500
ITEM.PlayerModel = "models/player/b4p/b4p_chewbacca.mdl"

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