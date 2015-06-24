ITEM.Name = "Alyx"
ITEM.Description = [[Deuteragonist.]]
ITEM.StorePrice = 400
ITEM.PlayerModel = "models/player/alyx.mdl"

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