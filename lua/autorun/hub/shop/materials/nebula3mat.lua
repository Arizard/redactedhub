ITEM.Name = "Nebula 3"
ITEM.Description = "Spaceee"
ITEM.StorePrice = 510
ITEM.Material = "vhs7/nebula3.vmt"
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