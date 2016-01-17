ITEM.Name = "Chair"
ITEM.Description = [[For Sitting.]]
ITEM.StorePrice = 300
ITEM.PlayerModel = "models/props/cs_office/chair_office.mdl"
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
