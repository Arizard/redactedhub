ITEM.Name = "1.21 Gigawatts"
ITEM.Description = "Great Scott"
ITEM.StorePrice = 70
ITEM.TauntSound = "taunts/121gigawatts.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end