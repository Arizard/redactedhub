ITEM.Name = "Nothing but"
ITEM.Description = "teleport bread for 3 days"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/teleport_bread.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end