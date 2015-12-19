ITEM.Name = "Hey Boss"
ITEM.Description = "can i have a pizza"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/pizza.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end