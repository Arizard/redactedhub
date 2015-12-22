ITEM.Name = "Obsolete"
ITEM.Description = "Developer Crate"
ITEM.StorePrice = 310
ITEM.Material = "root/materials/editor/obsolete"
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