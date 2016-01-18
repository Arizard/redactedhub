ITEM.Name = "Blue Screen"
ITEM.Description = "Of Death."
ITEM.StorePrice = 210
ITEM.Material = "vhs7/bsod.vmt"
ITEM.Buyable = false

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