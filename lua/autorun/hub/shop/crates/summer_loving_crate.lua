ITEM.Name = "Summer Lovin'"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "models/player/shared/gold_player.vmt"
ITEM.StorePrice = 100
ITEM.Col = Color(241, 196, 15)
ITEM.CrateContains = {
	["col_blue"] = 95,
	["col_red"] = 95,
	["burgerhat"] = 5,
	["chromemat"] = 2,
	["angel_white"] = 1,
	["goldmat"] = 1,
	["daftpunk_guy"] = 1,
	["daftpunk_thomas"] = 1,
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