ITEM.Name = "Hairstyle"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "models/jessev92/apb/partedmiddle1.vmt"
ITEM.StorePrice = 100
ITEM.Col = Color(241, 196, 15)
ITEM.CrateContains = {
	["apb_emo"] = 1,
	["apb_mohawk2"] = 1,
	["apb_shoulder1"] = 1,

	["apb_anime1"] = 3,
	["apb_anime2"] = 9,
	["apb_dreads"] = 3,
	["apb_ducktail1"] = 3,
	["apb_ducktail2"] = 3,
	["apb_fins"] = 6,
	["apb_frontflip"] = 3,
	["apb_loverboy"] = 3,
	["apb_mohawk1"] = 3,
	["apb_mohawk3"] = 2,
	["apb_partedleft"] = 9,
	["apb_partedright"] = 3,
	["apb_partedmiddle"] = 3,
	["apb_shoulder2"] = 3,
	["apb_slickedback"] = 3,
	["apb_afro"] = 10,

	["becareful01"] = 15,
	["wombocombo"] = 15,
	["airhorn"] = 15,
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
