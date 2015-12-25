ITEM.Name = "Gold!"
ITEM.Description = "Summer Lovin' Crate"
ITEM.StorePrice = 1000
ITEM.Material = "models/player/shared/gold_player.vmt"
ITEM.Buyable = false
ITEM.Rarity = 4

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