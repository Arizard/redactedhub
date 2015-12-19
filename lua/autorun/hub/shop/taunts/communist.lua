ITEM.Name = "Communist"
ITEM.Description = "detected on american soil"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/communism.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end