ITEM.Name = "Civil Protection"
ITEM.Description = "Pick up that can."
ITEM.StorePrice = 180
ITEM.PlayerModel = "models/player/police_fem.mdl"

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