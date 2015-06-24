ITEM.Name = "Interface"
ITEM.Description = "Enhance!"
ITEM.StorePrice = 250
ITEM.Material = "models/props_combine/combine_interface_disp"

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