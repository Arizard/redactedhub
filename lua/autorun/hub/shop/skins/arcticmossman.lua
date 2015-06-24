ITEM.Name = "Arctic Mossman"
ITEM.Description = [[Dammit, Mossman.]]
ITEM.StorePrice = 650
ITEM.PlayerModel = "models/player/mossman_arctic.mdl"

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
