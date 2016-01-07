ITEM.Name = "I can't believe"
ITEM.Description = "you've done this"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/cantbelieveyouvedonethis.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end