ITEM.Name = "Combine Shield"
ITEM.Description = "Impenetrable."
ITEM.StorePrice = 300
ITEM.Material = "models/props_combine/com_shield001a"

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