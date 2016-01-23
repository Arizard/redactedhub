ITEM.Name = "Noise"
ITEM.Description = "Developer Crate"
ITEM.StorePrice = 510
ITEM.Material = "vhs7/noise.vmt"
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