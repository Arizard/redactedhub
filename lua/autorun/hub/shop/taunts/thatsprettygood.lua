ITEM.Name = "That's Pretty Good"
ITEM.Description = "Heyyy"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/thatsprettygood.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end