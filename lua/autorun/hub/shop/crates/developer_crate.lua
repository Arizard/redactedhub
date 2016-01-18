ITEM.Name = "Developer"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "debug/debugempty.vmt"
ITEM.StorePrice = 100
ITEM.Col = Color(241, 196, 15)
ITEM.CrateContains = {
	["col_yellow"] = 95,
	["col_purple"] = 90,
	["3dglasses"] = 5,
	["trail_missing"] = 2,
	["noisemat"] = 1,
	["missingmat"] = 1,
	["obsoletemat"] = 1,
	["wireframe"] = 1,
	["fiddlesticks"] = 1,
	["3dglasses_shiny"] = 1,
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
