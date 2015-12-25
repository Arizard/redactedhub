ITEM.Name = "Ice"
ITEM.Description = "Summer Lovin' Crate"
ITEM.StorePrice = 99999
ITEM.Material = "models/player/shared/ice_player.vmt"
ITEM.Buyable = false
ITEM.Rarity = 5

function ITEM:OnEquip(ply, id)
	ply:SetMaterial( self.Material )
end

function ITEM:OnHolster(ply, id)
	ply:SetMaterial( "" )
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end