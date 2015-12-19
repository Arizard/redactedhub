ITEM.Name = "Chillout, dickwad"
ITEM.Description = ""
ITEM.StorePrice = 30
ITEM.TauntSound = "taunts/dickwad.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end