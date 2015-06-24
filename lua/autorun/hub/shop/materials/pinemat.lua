ITEM.Name = "Pine"
ITEM.Description = "Smells nice."
ITEM.StorePrice = 235
ITEM.Material = "phoenix_storms/white_brushes"

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