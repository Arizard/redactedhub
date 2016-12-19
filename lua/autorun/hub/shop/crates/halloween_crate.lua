ITEM.Name = "Halloween"
ITEM.IsCrate = true
ITEM.Description = "Crate"
ITEM.CrateModel = "models/Items/item_item_crate_dynamic.mdl"
ITEM.CrateMat = "models/props_combine/com_shield001a"
ITEM.StorePrice = 5000
ITEM.Col = Color(241, 196, 15)
ITEM.Buyable = false
ITEM.CrateContains = {
	["antlionhat"] = 10,
	["skullhat_shiny"] = 2,
	["pumpkin_01"] = 5,
	["pumpkin_02"] = 5,
	["pumpkin_03"] = 5,
	["broomstick"] = 10,
	["skeleton_runescape"] = 1,
	["heist_crate"] = 1,
	["apb_ponytail"] = 1, --Because you can't get it otherwise
	["chestbaby"] = 15,
	["headcrab"] = 15,
	["witchhat"] = 15,
	["charple"] = 8,
	["fastzombie"] = 8,
	["soldier_stripped"] = 4,
	["corpse"] = 10,
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
