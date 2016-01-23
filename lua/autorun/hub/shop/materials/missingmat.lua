ITEM.Name = "Download Failed"
ITEM.Description = "Developer Crate"
ITEM.StorePrice = 310
ITEM.Material = "debug/debugempty.vmt"
ITEM.Buyable = false
ITEM.Rarity = 3

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