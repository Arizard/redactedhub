ITEM.Name = "Oh fiddlesticks"
ITEM.Description = "what now?"
ITEM.StorePrice = 450
ITEM.TauntSound = "common/bugreporter_failed.wav"
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end
