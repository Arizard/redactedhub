ITEM.Name = "Be Careful"
ITEM.Description = "Be careful now.."
ITEM.StorePrice = 10
ITEM.TauntSound = "vo/canals/boxcar_becareful.wav"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end