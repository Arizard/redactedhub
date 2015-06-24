ITEM.Name = "Stasis"
ITEM.Description = "Philip J Fry."
ITEM.StorePrice = 300
ITEM.Material = "models/props_combine/stasisshield_sheet"

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