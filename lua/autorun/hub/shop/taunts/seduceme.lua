ITEM.Name = "Seduce Me"
ITEM.Description = "wat"
ITEM.StorePrice = 30
ITEM.TauntSound = "taunts/seduce_me.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end