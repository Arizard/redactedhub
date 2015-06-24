ITEM.Name = "Boiler"
ITEM.Description = "Hot Hot Hot!"
ITEM.StorePrice = 310
ITEM.Material = "models/shadertest/shader4.vmt"

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