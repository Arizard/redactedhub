ITEM.Name = "Frosted Glass"
ITEM.Description = "Windows has frozen."
ITEM.StorePrice = 300
ITEM.Material = "models/props_c17/frostedglass_01a"

function ITEM:OnEquip(ply, id)
	ply:SetMaterial( self.Material )
end

function ITEM:OnHolster(ply, id)
	ply:SetMaterial( "" )
end

if engine.ActiveGamemode() == "murder" then
     ITEM.Buyable = false
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end