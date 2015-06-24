ITEM.Name = "Wow"
ITEM.Description = "Wow!"
ITEM.StorePrice = 40
ITEM.TauntSound = "mlg/wow.wav"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end