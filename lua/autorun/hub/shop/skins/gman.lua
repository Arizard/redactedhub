ITEM.Name = "G-Man"
ITEM.Description = "Rise and Shine."
ITEM.StorePrice = 220
ITEM.PlayerModel = "models/player/gman_high.mdl"

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