ITEM.Name = "Stimulus Package"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = ""
ITEM.StorePrice = 0
ITEM.Col = Color(255,255,255)
ITEM.Buyable = false
ITEM.CrateContains = {
	["points_10"] = 50,
	["points_25"] = 50,
	["points_50"] = 50,
	["points_100"] = 50,
}

function ITEM:OnEquip(ply, id)
	
end

function ITEM:OnHolster(ply, id)
	
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end
