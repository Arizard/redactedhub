ITEM.Name = "Sci-Fi"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "vhs7/nebula4.vmt"
ITEM.StorePrice = 100
ITEM.Col = Color(241, 196, 15)
ITEM.CrateContains = {
	["col_spaceblue"] = 40,
	["col_stardustpink"] = 40,
	["col_emeraldgreen"] = 40, -- 120 paints

	["antlionhat"] = 15,
	["astronauthelmet"] = 15,
	["cakehat"] = 15,
	["cpmask"] = 20, -- 95 normal hats
	["headcrab"] = 10,
	["gmanmask"] = 10,
	["starglasses"] = 10,

	["bsodmat"] = 5,
	["matrixmat"] = 1,
	["nebula1mat"] = 5,
	["nebula2mat"] = 5,
	["nebula3mat"] = 5,
	["nebula4mat"] = 5,
	["nebula5mat"] = 5, -- 41 materials
	["noisemat"] = 5,
	["xencrystal"] = 5,

	["dalek_black"] = 2,
	["dalek_brass"] = 2, -- 4 skins LOL

	["astronauthelmet_shiny"] = 1,
	["antlionhat_shiny"] = 1,
	["skullhat_shiny"] = 1,
}

if engine.ActiveGamemode() == "terrortown" then
	ITEM.CrateContains["dalek_black"] = 0
	ITEM.CrateContains["dalek_brass"] = 0
end


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