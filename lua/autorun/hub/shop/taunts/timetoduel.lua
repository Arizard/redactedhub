ITEM.Name = "IT'S TIME"
ITEM.Description = "TO D-D-D-DUEL"
ITEM.StorePrice = 110
ITEM.TauntSound = "taunts/timetoduel.ogg"

-- thanks zelpa

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end