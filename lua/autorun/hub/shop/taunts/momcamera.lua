ITEM.Name = "Camera"
ITEM.Description = "MOM GET THE CAMERA"
ITEM.StorePrice = 50
ITEM.TauntSound = "mlg/momgetthecamera.wav"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end