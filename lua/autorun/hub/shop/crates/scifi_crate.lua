ITEM.Name = "Sci-Fi"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "vhs7/nebula4.vmt"
ITEM.StorePrice = 100
ITEM.Col = Color(241, 196, 15)
ITEM.CrateContains = {
	["col_spaceblue"] = 50,
	["col_stardustpink"] = 50,
	["col_emeraldgreen"] = 50, -- 150 paints

	["antlionhat"] = 15,
	["astronauthelmet"] = 15,
	["cakehat"] = 15,
	["cpmask"] = 15, -- 60 normal hats

	["bsodmat"] = 5,
	["matrixmat"] = 1,
	["nebula1mat"] = 5,
	["nebula2mat"] = 5,
	["nebula3mat"] = 5,
	["nebula4mat"] = 5,
	["nebula5mat"] = 5, -- 41 materials
	["noisemat"] = 5,
	["xencrystal"] = 5,

	["astronauthelmet_shiny"] = 1,
	["antlionhat_shiny"] = 1,
	["skullhat_shiny"] = 1,
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