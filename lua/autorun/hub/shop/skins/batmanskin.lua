ITEM.Name = "Batman"
ITEM.Description = [[WHERE IS SHE?!?!]]
ITEM.StorePrice = 700
ITEM.PlayerModel = "models/batman/slow/jamis/mkvsdcu/batman/slow_pub_v2.mdl"

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