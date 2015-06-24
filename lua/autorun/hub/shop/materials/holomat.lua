ITEM.Name = "Hologram"
ITEM.Description = "Holololo."
ITEM.StorePrice = 290
ITEM.Material = "models/props_combine/masterinterface01c.vmt"

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