ITEM.Name = "The One"
ITEM.Description = "Stay in Wonderland."
ITEM.StorePrice = 1210
ITEM.Material = "vhs7/matrix.vmt"
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