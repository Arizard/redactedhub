ITEM.Name = "This is illegal"
ITEM.Description = "ukno"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/this_is_illegal_you_know.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end