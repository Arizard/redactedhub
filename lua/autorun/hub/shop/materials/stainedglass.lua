ITEM.Name = "Stained Glass"
ITEM.Description = "Old Habits Shine Hard."
ITEM.StorePrice = 300
ITEM.Material = "models/shadertest/shader5.vmt"

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