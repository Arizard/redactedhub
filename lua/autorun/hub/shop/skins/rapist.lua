ITEM.Name = "Pervert"
ITEM.Description = [[Come here kiddies...]]
ITEM.StorePrice = 600
ITEM.PlayerModel = "models/jessev92/player/misc/creepr.mdl"

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