ITEM.Name = "Heist"
ITEM.IsCrate = true
ITEM.Buyable = false
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/BoxMRounds.mdl"
ITEM.CrateMat = "models/props_pipes/GutterMetal01a"
ITEM.StorePrice = 200
ITEM.Col = Color(241, 196, 15)
ITEM.Rarity = 4
ITEM.CrateContains = {
	["pd2_arnold_bulldog"] = 1,
	["pd2_babyrhino"] = 1,
	["pd2_chuck_eagle"] = 1,
	["pd2_dolph_ram"] = 1,
	["pd2_jeanclaude_panda"] = 1,
	["pd2_mark_bear"] = 1,
	["pd2_monkeybusiness"] = 1,
	["pd2_the_hog"] = 1,
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
