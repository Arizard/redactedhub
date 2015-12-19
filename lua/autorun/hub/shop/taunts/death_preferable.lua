ITEM.Name = "Death is"
ITEM.Description = "preferable to communism"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/death_alternative.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end