ITEM.Name = "Stormtrooper"
ITEM.Description = [[Decreases accuracy.]]
ITEM.StorePrice = 850
ITEM.PlayerModel = "models/player/b4p/b4p_stormt.mdl"

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