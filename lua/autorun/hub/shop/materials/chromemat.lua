ITEM.Name = "Chrome"
ITEM.Description = "Summer Lovin' Crate"
ITEM.StorePrice = 99999
ITEM.Material = "debug/env_cubemap_model.vmt"
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