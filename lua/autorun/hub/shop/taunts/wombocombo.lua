ITEM.Name = "Wombo Combo"
ITEM.Description = "WOMBO COMBO!"
ITEM.StorePrice = 40
ITEM.TauntSound = "mlg/wombocombo.wav"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end