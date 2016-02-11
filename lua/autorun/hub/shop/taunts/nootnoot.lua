ITEM.Name = "NOOT NOOT"
ITEM.Description = "pingu is my favourite anime"
ITEM.StorePrice = 150
ITEM.TauntSound = "taunts/nootnoot.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end