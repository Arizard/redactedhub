ITEM.Name = "You S.O.B"
ITEM.Description = ""
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/you_sob.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end