ITEM.Name = "Wallace Breen"
ITEM.Description = "It's safer here."
ITEM.StorePrice = 290
ITEM.PlayerModel = "models/player/breen.mdl"

function ITEM:OnEquip(ply, id)
	timer.Simple(1, function() ply:SetModel(self.PlayerModel) end)
end

function ITEM:OnHolster(ply, id)
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end