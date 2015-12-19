ITEM.Name = "Bacon"
ITEM.Description = "is good for me"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/bacon.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end