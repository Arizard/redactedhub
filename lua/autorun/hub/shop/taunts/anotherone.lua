ITEM.Name = "Another One"
ITEM.Description = "Another One"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/another_one.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end