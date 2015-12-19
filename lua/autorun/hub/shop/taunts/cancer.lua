ITEM.Name = "Boss I"
ITEM.Description = "have a cancer"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/cancer.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end