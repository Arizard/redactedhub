ITEM.Name = "Airhorn"
ITEM.Description = "BEEOWWW"
ITEM.StorePrice = 30
ITEM.TauntSound = "mlg/airhorn.mp3"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end