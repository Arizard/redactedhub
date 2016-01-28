ITEM.Name = "X-Files"
ITEM.Description = "Theme"
ITEM.StorePrice = 140
ITEM.TauntSound = "taunts/xfiles.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end