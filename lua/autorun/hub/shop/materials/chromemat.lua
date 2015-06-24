ITEM.Name = "Chrome"
ITEM.Description = "Shiny!"
ITEM.StorePrice = 360
ITEM.Material = "debug/env_cubemap_model.vmt"

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