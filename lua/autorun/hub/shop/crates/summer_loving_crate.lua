ITEM.Name = "Summer Lovin'"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "models/player/shared/gold_player.vmt"
ITEM.StorePrice = 250
ITEM.Col = Color(241, 196, 15)
ITEM.CrateContains = {
	["col_blue"] = 20,
	["col_red"] = 20,
	["burgerhat"] = 10,
	["antlionhat"] = 10,
	["cpmask"] = 10,
	["duncehat"] = 10,
	["trail_green"] = 10,
	["trail_red"] = 10,
	["trail_white"] = 10,
	["trail_yellow"] = 10,
	["white"] = 10,
	["xencrystal"] = 10,
	["zebramat"] = 5,
	["greenlight"] = 5,
	["barney"] = 5,
	["breen"] = 5,
	["eli"] = 5,
	["chromemat"] = 2,
	["icemat"] = 2,
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