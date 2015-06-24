ITEM.Name = "Triple"
ITEM.Description = "Oh Baby!"
ITEM.StorePrice = 50
ITEM.TauntSound = "mlg/triple.mp3"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end