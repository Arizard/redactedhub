ITEM.Name = "Spartan"
ITEM.Description = [[Master Chef.]]
ITEM.StorePrice = 1400
ITEM.PlayerModel = "models/player/lordvipes/h3_spartans_mps/h3spartan_mps_cvp.mdl"

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