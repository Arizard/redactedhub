ITEM.Name = "Redlight"
ITEM.Description = "Roooxanne!"
ITEM.StorePrice = 275
ITEM.Material = "models/weapons/v_slam/new light1"

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