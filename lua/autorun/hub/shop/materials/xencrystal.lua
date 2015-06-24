ITEM.Name = "Xen Crystal"
ITEM.Description = "Alien Rocks."
ITEM.StorePrice = 305
ITEM.Material = "models/props_lab/xencrystal_sheet"

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